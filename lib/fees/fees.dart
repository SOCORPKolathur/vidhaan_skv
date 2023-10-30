import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:pdf/widgets.dart' as p;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:vidhaan/demopdf.dart';
import 'package:get/get.dart';
import 'package:vidhaan/modules/home/controllers/home_controller.dart';

import '../print/fees_print.dart';

class FeesReg extends StatefulWidget {
  const FeesReg({Key? key}) : super(key: key);

  @override
  State<FeesReg> createState() => _FeesRegState();
}

class _FeesRegState extends State<FeesReg> {

  String schoolname="";
  String schooladdress="";
  String schoolphone="";
  String schoollogo="";

  final homecontroller = Get.put(HomeController());

  String? _selectedCity;
  final TextEditingController _typeAheadControllerregno = TextEditingController();
  final TextEditingController _typeAheadControllerstudent = TextEditingController();
  final TextEditingController payAmount = TextEditingController();
  final TextEditingController balanceAmount = TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  static final List<String> regno = [];
  static final List<String> student = [];


  static List<String> getSuggestionsregno(String query) {
    List<String> matches = <String>[];
    matches.addAll(regno);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionsstudent(String query) {
    List<String> matches = <String>[];
    matches.addAll(student);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  getadmin() async {
    var document = await FirebaseFirestore.instance.collection("Admin").get();
    setState(() {
      schoolname=document.docs[0]["schoolname"];
      schooladdress="${document.docs[0]["area"]} ${document.docs[0]["city"]} ${document.docs[0]["pincode"]}";
      schoollogo=document.docs[0]["logo"];
      schoolphone=document.docs[0]["phone"];
    });
  }

  feesdrop() async {
    setState(() {
      fees.clear();
    });
    var document2 = await  FirebaseFirestore.instance.collection("Students").doc(studentid).collection("Fees").where("status",isEqualTo: false).get();
    for(int i=0;i<document2.docs.length;i++) {
      setState(() {
        fees.add(document2.docs[i]["feesname"]);
      });

    }

  }


  adddropdownvalue() async {
    setState(() {
      regno.clear();
      student.clear();
    });
    var document = await  FirebaseFirestore.instance.collection("Students").orderBy("timestamp").get();
    var document2 = await  FirebaseFirestore.instance.collection("Students").orderBy("stname").get();
    for(int i=0;i<document.docs.length;i++) {
      setState(() {
        regno.add(document.docs[i]["regno"]);
      });

    }
    for(int i=0;i<document2.docs.length;i++) {
      setState(() {
        student.add(document2.docs[i]["stname"]);
      });

    }

  }

  getstaffbyid() async {
    print("fdgggggggggg");
    print(_typeAheadControllerregno.text);
    var document = await FirebaseFirestore.instance.collection("Students").get();
    for(int i=0;i<document.docs.length;i++){
      if(_typeAheadControllerregno.text==document.docs[i]["regno"]){
        setState(() {
          _typeAheadControllerstudent.text=document.docs[i]["stname"];
          studentid= document.docs[i].id;
        }
        );
      }
    }
    print("fdgggggggggg");


  }
  getstaffbyid2() async {
    print("fdgggggggggg");
    print(_typeAheadControllerregno.text);
    var document = await FirebaseFirestore.instance.collection("Students").get();
    for(int i=0;i<document.docs.length;i++){
      if(_typeAheadControllerstudent.text==document.docs[i]["stname"]){
        setState(() {
          _typeAheadControllerregno.text= document.docs[i]["regno"];
        }
        );
      }
    }
    print("fdgggggggggg");


  }
  getfeesid() async {
    print("fdgggggggggg");

    var document = await FirebaseFirestore.instance.collection("Students").doc(studentid).collection("Fees").get();
    for(int i=0;i<document.docs.length;i++){
      if(_typeAheadControllerfees.text==document.docs[i]["feesname"]){
        setState(() {
          feesid= document.docs[i].id;
        }
        );
      }
    }
    print("fdgggggggggg");


  }
  String feesid = "";

  final TextEditingController _typeAheadControllerfees = TextEditingController();
  static final List<String> fees = [];
  static List<String> getSuggestionsfees(String query) {
    List<String> matches = <String>[];
    matches.addAll(fees);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }


  @override
  void initState() {
    getadmin();
    adddropdownvalue();
    // TODO: implement initState
    super.initState();
  }

  String studentid="";
  updatefees({required String feesAmount,required String feesName, required String payAmount, required String balanceAmount}){
  if(double.parse(balanceAmount.toString()) == 0.0){
    FirebaseFirestore.instance.collection("Students").doc(studentid).collection("Fees").doc(feesid).update({
      "status":true,
      "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "time": "${DateTime.now().hour}:${DateTime.now().minute}",
      "timestamp": DateTime.now().microsecondsSinceEpoch,
    });
  }else{
    FirebaseFirestore.instance.collection("Students").doc(studentid).collection("Fees").doc(feesid).update({
      "payedamount": double.parse(feesAmount.toString()) - double.parse(payAmount),
      "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "time": "${DateTime.now().hour}:${DateTime.now().minute}",
      "timestamp": DateTime.now().microsecondsSinceEpoch,
    });
  }
  if(double.parse(balanceAmount.toString()) == 0.0){
    FirebaseFirestore.instance.collection("FeesCollection").doc("$studentid:$feesid").update({
      "status":true,
      "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "time": "${DateTime.now().hour}:${DateTime.now().minute}",
      "timestamp": DateTime.now().microsecondsSinceEpoch,
    });
  }else{
    FirebaseFirestore.instance.collection("FeesCollection").doc("$studentid:$feesid").update({
      "payedamount": double.parse(feesAmount.toString()) - double.parse(payAmount),
      "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "time": "${DateTime.now().hour}:${DateTime.now().minute}",
      "timestamp": DateTime.now().microsecondsSinceEpoch,
    });
  }
  FirebaseFirestore.instance.collection('Accounts').doc().set({
    "amount" : payAmount,
    "date" : "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
    "payee" : feesName,
    "receivedBy" : "Admin",
    "time" : DateFormat('hh:mm aa').format(DateTime.now()),
    "timestamp" : DateTime.now().millisecondsSinceEpoch,
    "title" : "Fees Received",
    "type" : "credit",
  });
}
  Successdialog(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Fees paid Sucessfully',
      desc: '',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {


      },
    )..show();
  }
  bool isloading=false;
  @override
  Widget build(BuildContext context) {

    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;

    return Stack(

      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  width: width/1.050,
                  height: height/8.212,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 38.0,top: 30),
                    child: Text("Fees Register",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,top: 20),
                child: Container(
                  width:  width/1.050,

                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                  child:  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,top:20,bottom: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right:0.0),
                                  child: Text("Register Number",style: GoogleFonts.poppins(fontSize: 15,)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0,right: 25),
                                  child: Container(child:
                                  TypeAheadFormField(


                                    suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                                        color: Color(0xffDDDEEE),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        )
                                    ),

                                    textFieldConfiguration: TextFieldConfiguration(
                                      style:  GoogleFonts.poppins(
                                          fontSize: 15
                                      ),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                        border: InputBorder.none,
                                      ),
                                      controller: this._typeAheadControllerregno,
                                    ),
                                    suggestionsCallback: (pattern) {
                                      return getSuggestionsregno(pattern);
                                    },
                                    itemBuilder: (context, String suggestion) {
                                      return ListTile(
                                        title: Text(suggestion),
                                      );
                                    },

                                    transitionBuilder: (context, suggestionsBox, controller) {
                                      return suggestionsBox;
                                    },
                                    onSuggestionSelected: (String suggestion) {
                                      setState(() {
                                        this._typeAheadControllerregno.text = suggestion;
                                      });

                                       getstaffbyid();
                                      // getorderno();



                                    },
                                    suggestionsBoxController: suggestionBoxController,
                                    validator: (value) =>
                                    value!.isEmpty ? 'Please select a class' : null,
                                    onSaved: (value) => this._selectedCity = value,
                                  ),
                                    width: width/3.902,
                                    height: height/16.425,
                                    //color: Color(0xffDDDEEE),
                                    decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                  ),
                                ),

                              ],

                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right:0.0),
                                  child: Text("Student Name",style: GoogleFonts.poppins(fontSize: 15,)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0,right: 25),
                                  child: Container(
                                    width: width/3.902,
                                    height: height/16.425,
                                    //color: Color(0xffDDDEEE),
                                    decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                    child:
                                    TypeAheadFormField(


                                      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                                          color: Color(0xffDDDEEE),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          )
                                      ),

                                      textFieldConfiguration: TextFieldConfiguration(
                                        style:  GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,
                                        ),
                                        controller: this._typeAheadControllerstudent,
                                      ),
                                      suggestionsCallback: (pattern) {
                                        return getSuggestionsstudent(pattern);
                                      },
                                      itemBuilder: (context, String suggestion) {
                                        return ListTile(
                                          title: Text(suggestion),
                                        );
                                      },

                                      transitionBuilder: (context, suggestionsBox, controller) {
                                        return suggestionsBox;
                                      },
                                      onSuggestionSelected: (String suggestion) {
                                        setState(() {
                                          this._typeAheadControllerstudent.text = suggestion;
                                        });

                                        getstaffbyid2();




                                      },
                                      suggestionsBoxController: suggestionBoxController,
                                      validator: (value) =>
                                      value!.isEmpty ? 'Please select a class' : null,
                                      onSaved: (value) => this._selectedCity = value,
                                    ),

                                  ),
                                ),

                              ],

                            ),
                            InkWell(
                              onTap: (){
                                getstaffbyid();
                                feesdrop();
                              },
                              child: Container(child: Center(child: Text("Search",style: GoogleFonts.poppins(color:Colors.white),)),
                                width: width/10.507,
                                height: height/16.425,
                                // color:Color(0xff00A0E3),
                                decoration: BoxDecoration(color: const Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:25.0),
                              child: InkWell(
                                onTap: (){
                                 setState(() {
                                   _typeAheadControllerstudent.text="";
                                   _typeAheadControllerregno.text="";
                                   studentid="";
                                 });
                                },
                                child: Container(child: Center(child: Text("Clear",style: GoogleFonts.poppins(color:Colors.white),)),
                                  width: width/10.507,
                                  height: height/16.425,
                                  // color:Color(0xff00A0E3),
                                  decoration: BoxDecoration(color:  Colors.red,borderRadius: BorderRadius.circular(5)),

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      studentid==""?Container():
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: SingleChildScrollView(
                          child: ShowUpAnimation(
                            curve: Curves.fastOutSlowIn,
                            direction: Direction.horizontal,
                            delayStart: Duration(milliseconds: 200),
                            child:
                            FutureBuilder<dynamic>(
                              future: FirebaseFirestore.instance.collection('Students').doc(studentid).get(),
                              builder: (context, snapshot) {
                                if(snapshot.hasData==null)
                                {
                                  return Container(
                                      width: width/17.075,
                                      height: height/8.212,
                                      child: Center(child:CircularProgressIndicator(),));
                                }
                                Map<String,dynamic>?value = snapshot.data!.data();
                                return
                                  Padding(
                                    padding:EdgeInsets.only(left: width/93.3,top:0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Material(
                                              elevation: 15,
                                              borderRadius: BorderRadius.circular(15),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color:Colors.white,
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                width: width/4.44,
                                                height: height/1.600,
                                                child: Column(
                                                  children: [
                                                    SizedBox(height:height/30,),
                                                    GestureDetector(
                                                      onTap: (){
                                                        print(width);
                                                      },
                                                      child: CircleAvatar(
                                                        radius: width/26.6666,
                                                        backgroundImage: NetworkImage(value!['imgurl']),

                                                      ),
                                                    ),

                                                    SizedBox(height:height/52.15,),
                                                    Center(
                                                      child:Text('${value!['stname']}',style: GoogleFonts.montserrat(
                                                          fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                      ),),
                                                    ),
                                                    SizedBox(height:height/130.3,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text('Student ID :',style: GoogleFonts.montserrat(
                                                            fontWeight:FontWeight.w500,color: Colors.black,fontSize: width/124.4
                                                        ),),
                                                        Text(value['regno'],style: GoogleFonts.montserrat(
                                                            fontWeight:FontWeight.w500,color: Colors.black,fontSize: width/124.4
                                                        ),),
                                                      ],
                                                    ),


                                                    SizedBox(height:height/52.15),
                                                    Divider(),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height:height/20.86),
                                                        SizedBox(width:width/62.2),
                                                        Text('Current Class',style: GoogleFonts.montserrat(
                                                            fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                        ),),
                                                      ],
                                                    ),
                                                    SizedBox(height: height/65.7,),
                                                    Row(
                                                      children: [
                                                        SizedBox(width:width/62.2),
                                                        Material(
                                                          elevation: 7,
                                                          borderRadius: BorderRadius.circular(12),
                                                          shadowColor:  Color(0xff53B175),
                                                          child: Container(
                                                            height: height/8.212,
                                                            width: width/7.588,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(12),
                                                                border:Border.all(color: Color(0xff53B175))
                                                            ),
                                                            child:  Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text("Class / Section",style:GoogleFonts.montserrat(
                                                                    fontWeight:FontWeight.w600,color: Colors.black,fontSize:width/98.13
                                                                ),),
                                                                SizedBox(height: height/65.7,),
                                                                ChoiceChip(

                                                                  label: Text("    ${value["admitclass"]} / ${value["section"]}    ",style: TextStyle(color: Colors.white),),


                                                                  onSelected: (bool selected) {

                                                                    setState(() {

                                                                    });
                                                                  },
                                                                  selectedColor: Color(0xff53B175),
                                                                  shape: StadiumBorder(
                                                                      side: BorderSide(
                                                                          color: Color(0xff53B175))),
                                                                  backgroundColor: Colors.white,
                                                                  labelStyle: TextStyle(color: Colors.black),

                                                                  elevation: 1.5, selected: true,),
                                                              ],
                                                            ),

                                                          ),


                                                        ),
                                                      ],
                                                    ),
                                                    Divider(),
                                                    SizedBox(height:height/32.85,),
                                                    Row(children: [
                                                      SizedBox(width:width/62.2),
                                                      Icon(Icons.call,),
                                                      SizedBox(width:width/373.2),
                                                      GestureDetector(onTap: (){

                                                      },
                                                        child: Text('${value["mobile"]}',style: GoogleFonts.montserrat(
                                                            fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/124.4
                                                        ),),
                                                      ),
                                                    ],),
                                                    SizedBox(height:height/34.76,),





                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(width:width/62.2,),
                                        Column(
                                          children: [
                                            Material(
                                              elevation: 15,
                                              borderRadius: BorderRadius.circular(15 ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color:Colors.white
                                                ),
                                                width:width/1.86,
                                                height:  height/1.600,
                                                child: Padding(
                                                  padding: EdgeInsets.only(left:width/62.2,right:width/62.2),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(height:height/30,),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              width:130,
                                                              child: Row(
                                                                children: [
                                                                  Text('Select Fees',style: GoogleFonts.montserrat(
                                                                      fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                                  ),),

                                                                  InkWell(
                                                                    onTap: (){
                                                                      feesdrop();
                                                                    },
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.only(left: 4.0),
                                                                      child: Icon(Icons.refresh),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 50.0,right: 25),
                                                              child: Container(width: width/4.83,
                                                                height: height/16.42,
                                                                //color: Color(0xffDDDEEE),
                                                                decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                                                child:

                                                                TypeAheadFormField(

                                                                  suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                                                                      color: Color(0xffDDDEEE),
                                                                      borderRadius: BorderRadius.only(
                                                                        bottomLeft: Radius.circular(5),
                                                                        bottomRight: Radius.circular(5),
                                                                      )
                                                                  ),

                                                                  textFieldConfiguration: TextFieldConfiguration(
                                                                    style:  GoogleFonts.poppins(
                                                                        fontSize: 15
                                                                    ),
                                                                    decoration: const InputDecoration(
                                                                      contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                                                      border: InputBorder.none,
                                                                    ),
                                                                    controller: this._typeAheadControllerfees,
                                                                  ),
                                                                  suggestionsCallback: (pattern) {
                                                                    return getSuggestionsfees(pattern);
                                                                  },
                                                                  itemBuilder: (context, String suggestion) {
                                                                    return ListTile(
                                                                      title: Text(suggestion),
                                                                    );
                                                                  },

                                                                  transitionBuilder: (context, suggestionsBox, controller) {
                                                                    return suggestionsBox;
                                                                  },
                                                                  onSuggestionSelected: (String suggestion) {
                                                                    this._typeAheadControllerfees.text = suggestion;
                                                                    getfeesid();

                                                                  },
                                                                  suggestionsBoxController: suggestionBoxController,
                                                                  validator: (value) =>
                                                                  value!.isEmpty ? 'Please select a fees': null,
                                                                  onSaved: (value) => this._selectedCity = value,
                                                                ),

                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height:height/27,),
                                                        feesid!=""?    FutureBuilder<dynamic>(
                                                            future: FirebaseFirestore.instance.collection('Students').doc(studentid).collection("Fees").doc(feesid).get(),
                                                            builder: (context, snapshot) {
                                                              if (snapshot.hasData == null) {
                                                                return Container(
                                                                    width: width / 17.075,
                                                                    height: height / 8.212,
                                                                    child: Center(child: CircularProgressIndicator(),));
                                                              }
                                                              Map<String, dynamic>?value2 = snapshot.data!.data();
                                                              return Column(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Container(
                                                                        width:130,

                                                                        child: Text('Fees Name',style: GoogleFonts.montserrat(
                                                                            fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                                        ),),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left: 50.0,right: 25),
                                                                        child: Container(width: width/4.83,
                                                                          height: height/16.42,
                                                                          //color: Color(0xffDDDEEE),
                                                                          decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(8.0),
                                                                            child: Text(value2!["feesname"],style: GoogleFonts.montserrat(
                                                                                fontWeight:FontWeight.w600,color: Colors.black,fontSize:width/85.13
                                                                            ),),
                                                                          )

                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(height:height/37,),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Container(
                                                                        width:130,
                                                                        child: Text('Fees Amount',style: GoogleFonts.montserrat(
                                                                            fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                                        ),),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left: 50.0,right: 25),
                                                                        child: Container(width: width/4.83,
                                                                          height: height/16.42,
                                                                          //color: Color(0xffDDDEEE),
                                                                          decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(8.0),
                                                                            child: Text(
                                                                              value2["amount"].toString(),
                                                                              style: GoogleFonts.montserrat(
                                                                                fontWeight:FontWeight.w600,color: Colors.red,fontSize:width/85.13
                                                                            ),),
                                                                          )

                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(height:height/37,),
                                                                  Visibility(
                                                                    visible: double.parse(value2["payedamount"].toString()) != 0.0,
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      children: [
                                                                        Container(
                                                                          width:130,
                                                                          child: Text('Altready Payed Amount',style: GoogleFonts.montserrat(
                                                                              fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                                          ),),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(left: 50.0,right: 25),
                                                                          child: Container(width: width/4.83,
                                                                              height: height/16.42,
                                                                              //color: Color(0xffDDDEEE),
                                                                              decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(
                                                                                  value2["payedamount"].toString(),
                                                                                  style: GoogleFonts.montserrat(
                                                                                      fontWeight:FontWeight.w600,color: Colors.red,fontSize:width/85.13
                                                                                  ),),
                                                                              )

                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(height:height/37,),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Container(
                                                                        width:130,
                                                                        child: Text('Payment',style: GoogleFonts.montserrat(
                                                                            fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                                        ),),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left: 50.0,right: 25),
                                                                        child: Container(width: width/4.83,
                                                                            height: height/16.42,
                                                                            //color: Color(0xffDDDEEE),
                                                                            decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                                                            child: Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: TextFormField(
                                                                                onChanged: (val){
                                                                                  setState(() {
                                                                                    balanceAmount.text = (double.parse(value2["amount"].toString())-double.parse(value2["payedamount"].toString()) - double.parse(val.toString())).toString();
                                                                                  });
                                                                                },
                                                                                controller: payAmount,
                                                                                decoration: InputDecoration(
                                                                                  border: InputBorder.none,
                                                                                ),
                                                                              )
                                                                            )

                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(height:height/37,),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Container(
                                                                        width:130,
                                                                        child: Text('Balance Amount',style: GoogleFonts.montserrat(
                                                                            fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                                        ),),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left: 50.0,right: 25),
                                                                        child: Container(width: width/4.83,
                                                                            height: height/16.42,
                                                                            //color: Color(0xffDDDEEE),
                                                                            decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: TextFormField(
                                                                                readOnly: true,
                                                                                controller: balanceAmount,
                                                                                decoration: InputDecoration(
                                                                                  border: InputBorder.none,
                                                                                ),
                                                                              ),
                                                                            )

                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(height:height/25,),
                                                                  Row(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap: () async {
                                                                          updatefees(
                                                                              feesAmount: value2["amount"].toString(),
                                                                              feesName: value2!["feesname"].toString(),
                                                                            payAmount: payAmount.text,
                                                                            balanceAmount: balanceAmount.text,
                                                                          );
                                                                          var userdoc= await FirebaseFirestore.instance.collection('Students').doc(studentid).get();
                                                                          Map<String,dynamic> ? val = userdoc.data();
                                                                          homecontroller.sendPushMessage(val!["token"],"Your payment of RS${value2["amount"].toString()} has been successfully processed. Thank you for your prompt settlement of the school fees. We appreciate your cooperation", "Successful Payment of School Fees");
                                                                          Successdialog();
                                                                          setState(() {
                                                                            payAmount.clear();
                                                                            balanceAmount.clear();
                                                                          });
                                                                        },
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: Container(child: Center(child: Text("Payment Received",style: GoogleFonts.poppins(color:Colors.white,fontWeight: FontWeight.w600),)),
                                                                            width: width/5.464,
                                                                            height: height/16.425,
                                                                            // color:Color(0xff00A0E3),
                                                                            decoration: BoxDecoration(color: Color(0xff53B175),borderRadius: BorderRadius.circular(5)),

                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(width:20),
                                                                      GestureDetector(
                                                                        onTap: () async {
                                                                          StudentFeesPdfModel feesDetails = StudentFeesPdfModel(
                                                                            date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
                                                                            time: DateFormat('hh:mm aa').format(DateTime.now()),
                                                                            amount: value2["amount"].toString(),
                                                                            feesName: value2["feesname"].toString(),
                                                                            schoolAdderss: schooladdress,
                                                                            schoolName: schoolname,
                                                                            schoolLogo: schoollogo,
                                                                            schoolPhone: schoolphone,
                                                                            studentAddress: value['address'].toString(),
                                                                            studentName: value['stname'].toString(),
                                                                          );
                                                                          setState(() {
                                                                            isloading = true;
                                                                          });
                                                                          await generateInvoice(PdfPageFormat.a4,feesDetails);
                                                                          setState(() {
                                                                            isloading = false;
                                                                          });
                                                                          },
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: Container(child: Center(child: Text("Print Receipt",style: GoogleFonts.poppins(color:Colors.white,fontWeight: FontWeight.w600),)),
                                                                            width: width/5.464,
                                                                            height: height/16.425,
                                                                            // color:Color(0xff00A0E3),
                                                                            decoration: BoxDecoration(color: Color(0xff53B175),borderRadius: BorderRadius.circular(5)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                              ],

                                                              );
                                                            }
                                                        ) : Container(),
                                                        Row(
                                                          children: [
                                                            Container(

                                                              child: Text('Previous Payments,',style: GoogleFonts.montserrat(
                                                                  fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                              ),),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 15,),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Container(
                                                              width:130,
                                                              child: Text('Fees Name',style: GoogleFonts.montserrat(
                                                                  fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                              ),),
                                                            ),
                                                            Container(
                                                              width:130,
                                                              child: Text('Amount',style: GoogleFonts.montserrat(
                                                                  fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                              ),),
                                                            ),
                                                            Container(
                                                              width:130,
                                                              child: Text('Status',style: GoogleFonts.montserrat(
                                                                  fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                              ),),
                                                            ),
                                                            Container(
                                                              width:130,
                                                              child: Text('Date',style: GoogleFonts.montserrat(
                                                                  fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                              ),),
                                                            ),
                                                            Container(
                                                              width:130,
                                                              child: Text('Time',style: GoogleFonts.montserrat(
                                                                  fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                              ),),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Divider(),
                                                        ),
                                                        StreamBuilder(
                                                            stream: FirebaseFirestore.instance.collection("Students").doc(studentid).collection("Fees").orderBy("timestamp").snapshots(),
                                                            builder: (context,snapshot){
                                                              return ListView.builder(
                                                                shrinkWrap: true,
                                                                  physics: NeverScrollableScrollPhysics(),
                                                                  itemCount: snapshot.data!.docs.length,
                                                                  itemBuilder: (context,index){

                                                                return
                                                                  snapshot.data!.docs[index]["status"]==true?
                                                                  Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                  children: [
                                                                    Container(
                                                                      width:130,
                                                                      child: Text(snapshot.data!.docs[index]["feesname"],style: GoogleFonts.montserrat(
                                                                          fontWeight:FontWeight.w600,color: Colors.black,fontSize:width/91.13
                                                                      ),),
                                                                    ),
                                                                    Container(
                                                                      width:130,
                                                                      child: Text(snapshot.data!.docs[index]["amount"].toString(),style: GoogleFonts.montserrat(
                                                                          fontWeight:FontWeight.w600,color: Colors.black,fontSize:width/91.13
                                                                      ),),
                                                                    ),
                                                                    Container(
                                                                      width:130,
                                                                      child: Text(snapshot.data!.docs[index]["status"]==true?"Paid": "Unpaid",style: GoogleFonts.montserrat(
                                                                          fontWeight:FontWeight.bold,color:snapshot.data!.docs[index]["status"]==true? Color(0xff53B175):Colors.red,fontSize:width/91.13
                                                                      ),),
                                                                    ),
                                                                    Container(
                                                                      width:130,
                                                                      child: Text(snapshot.data!.docs[index]["date"],style: GoogleFonts.montserrat(
                                                                          fontWeight:FontWeight.w600,color: Colors.black,fontSize:width/91.13
                                                                      ),),
                                                                    ),
                                                                    Container(
                                                                      width:130,
                                                                      child: Text(snapshot.data!.docs[index]["time"],style: GoogleFonts.montserrat(
                                                                          fontWeight:FontWeight.w600,color: Colors.black,fontSize:width/91.13
                                                                      ),),
                                                                    ),
                                                                  ],
                                                                )  : Container();
                                                              });

                                                        })



                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],)
                                      ],),
                                  );
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                ),
              ),


            ],
          ),
        ),
       Visibility(
         visible: isloading,
         child: Center(
           child: Container(
             width: 400,
             height: 300,
             decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(20)
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 SizedBox(
                   height: 20,
                 ),
                 Text("Printing is getting ready...",style: GoogleFonts.poppins(
                     color: Colors.black, fontSize:18,fontWeight: FontWeight.w600),),
                 SizedBox(
                   height: 20,
                 ),
                 Container(
                     width:200,child: Lottie.asset("assets/printing3.json")),
               ],
             ),
           ),
         ),
       ),
       isloading==true? Center(
         child: Container(
            width: 400,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text("Printing is getting ready...",style: GoogleFonts.poppins(
                    color: Colors.black, fontSize:18,fontWeight: FontWeight.w600),),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width:200,child: Lottie.asset("assets/printing3.json")),
              ],
            ),
          ),
       ): Container()
      ],
    );
  }

  getvalue() async {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<p.Widget> widgets = [];
    //container for profile image decoration
    final container = p.Center(
      child: p.Container(
          child: p.Padding(
            padding: p.EdgeInsets.only(top: 5),
            child: p.Row(mainAxisAlignment: p.MainAxisAlignment.start, children: [
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("Si.No".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),
              p.Container(
                  width: 80,
                  child: p.Center(
                    child: p.Text("Descriptions".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),

              p.SizedBox(width: width / 273.2),

              p.SizedBox(width: 200),
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("Rate".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),

              p.SizedBox(width: width / 273.2),
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("Total".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  ))
            ]),
          )),
    );
    final container2 = p.Center(
      child: p.Container(
          child: p.Padding(
            padding: p.EdgeInsets.only(top: 5),
            child: p.Row(mainAxisAlignment: p.MainAxisAlignment.start, children: [
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("001".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),
              p.Container(
                  width: 80,
                  child: p.Center(
                    child: p.Text("First Mid Term Fees".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),

              p.SizedBox(width: width / 273.2),

              p.SizedBox(width: 200),
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("15000".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),

              p.SizedBox(width: width / 273.2),
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("1500".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  ))
            ]),
          )),
    );

    final container3 = p.Center(
      child: p.Container(
          child: p.Padding(
            padding: p.EdgeInsets.only(top: 5),
            child: p.Row(mainAxisAlignment: p.MainAxisAlignment.start, children: [
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("   ".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),
              p.Container(
                  width: 80,
                  child: p.Center(
                    child: p.Text("               ".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),

              p.SizedBox(width: width / 273.2),

              p.SizedBox(width: 200),
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("Total:".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),

              p.SizedBox(width: width / 273.2),
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("1500".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  ))
            ]),
          )),
    );
    final container4 = p.Center(
      //child:
    );

    final profileImage = p.MemoryImage((await rootBundle.load('assets/schoollogo.png')).buffer.asUint8List(),);
    final paid = p.MemoryImage((await rootBundle.load('assets/paid.png')).buffer.asUint8List(),);


    widgets.add(p.SizedBox(height: 5));
    widgets.add(
        p.Stack(children: [
      /*p.Container(
          height: 700,
          child: p.Image(await imageFromAssetBundle('assets/7728804.png'),
              fit: p.BoxFit.fill)),*/

      /*p.Padding(
          padding: p.EdgeInsets.only(top: 260),
     child: container,
        ),*/
      p.Padding(
          padding: p.EdgeInsets.only(top: 0),
          child: p.Container(
              height: 600,

              child: p.Column(children: [
                p.Row(mainAxisAlignment: p.MainAxisAlignment.start, children: [
                  p.Container(
                    width:100,
                      height: 100,
                      child: p.Image(profileImage)),
                  p.SizedBox(width: width / 273.2),
                  p.Column(
                    crossAxisAlignment: p.CrossAxisAlignment.start,
                    children: [
                      p.Text("Vidhaan Edu Care International School",style: p.TextStyle(fontSize: 20,fontWeight: p.FontWeight.bold,)),
                      p.Text("Kolathur,Padi Chennai - 600062",style: p.TextStyle(fontSize: 15)),
                      p.Text("Call: +91 770880963",style: p.TextStyle(fontSize: 15)),
                    ]
                  ),



                ]),
                p.Row(
                  mainAxisAlignment: p.MainAxisAlignment.center,
                  children: [
                    p.Container(
                        width:400,
                        child: p.Divider()
                    )
                  ]
                ),

                p.SizedBox(height: 5),
                container,
                p.Row(
                    mainAxisAlignment: p.MainAxisAlignment.center,
                    children: [
                      p.Container(
                          width:600,
                          child: p.Divider(thickness: 0.5)
                      )
                    ]
                ),
                container2,
                p.SizedBox(height: 100),
              p.Row(mainAxisAlignment: p.MainAxisAlignment.start, children: [
                p.Container(
                    width:100,
                    height: 100,
                    child: p.Image(paid)),
                ]),
                p.Row(
                    mainAxisAlignment: p.MainAxisAlignment.center,
                    children: [
                      p.Container(
                          width:600,
                          child: p.Divider(thickness: 0.5)
                      )
                    ]
                ),
                container3,
                p.Row(
                    mainAxisAlignment: p.MainAxisAlignment.center,
                    children: [
                      p.Container(
                          width:600,
                          child: p.Divider(thickness: 0.5)
                      )
                    ]
                ),


              ]))),
    ]));

    final pdf = p.Document();
    pdf.addPage(
      p.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => widgets, //here goes the widgets list
      ),
    );
    Printing.layoutPdf(

      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

    setState(() {
      isloading=false;
    });
  }


}


class StudentFeesPdfModel {
  StudentFeesPdfModel(
  {
    required this.schoolName,
    required this.schoolAdderss,
    required this.schoolPhone,
    required this.studentName,
    required this.schoolLogo,
    required this.studentAddress,
    required this.feesName,
    required this.amount,
    required this.date,
    required this.time
    }
      );

  String schoolName;
  String schoolAdderss;
  String schoolPhone;
  String studentName;
  String schoolLogo;
  String studentAddress;
  String feesName;
  String amount;
  String date;
  String time;
}