import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StaffAttendance extends StatefulWidget {
  const StaffAttendance({Key? key}) : super(key: key);

  @override
  State<StaffAttendance> createState() => _StaffAttendanceState();
}

class _StaffAttendanceState extends State<StaffAttendance> {


  String? _selectedCity;
  final TextEditingController _typeAheadControllerclass = TextEditingController();
  final TextEditingController _typeAheadControllersection = TextEditingController();
  final TextEditingController _typeAheadControllerstaffid = TextEditingController();
  TextEditingController date = new TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  static final List<String> classes = [];
  static final List<String> section = [];
  static final List<String> staffid = [];

  static List<String> getSuggestionsclass(String query) {
    List<String> matches = <String>[];
    matches.addAll(classes);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionssection(String query) {
    List<String> matches = <String>[];
    matches.addAll(section);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionsstaffid(String query) {
    List<String> matches = <String>[];
    matches.addAll(staffid);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  @override
  void initState() {
    adddropdownvalue();

    // TODO: implement initState
    super.initState();
  }
  adddropdownvalue() async {
    var document = await  FirebaseFirestore.instance.collection("Staffs").orderBy("entryno").get();
    var document2 = await  FirebaseFirestore.instance.collection("SectionMaster").orderBy("order").get();
    var document3 = await  FirebaseFirestore.instance.collection("Staffs").orderBy("entryno").get();
    for(int i=0;i<document.docs.length;i++) {
      setState(() {
        classes.add(document.docs[i]["name"]);
      });

    }
    for(int i=0;i<document2.docs.length;i++) {
      setState(() {
        section.add(document2.docs[i]["name"]);
      });

    }
    for(int i=0;i<document3.docs.length;i++) {
      setState(() {
        staffid.add(document3.docs[i]["regno"]);
      });

    }
  }

  String staffdocid="";
  String staffname="";
  getstaffbyid() async {
    print("fdgggggggggg");
    print(_typeAheadControllerstaffid.text);
    var document = await FirebaseFirestore.instance.collection("Staffs").get();
    for(int i=0;i<document.docs.length;i++){
      if(_typeAheadControllerstaffid.text==document.docs[i]["regno"]){
        setState(() {
          staffdocid= document.docs[i].id;
        }
        );
      }
    }
    print("fdgggggggggg");
    print(staffdocid);
    var staffdocument = await FirebaseFirestore.instance.collection("Staffs").doc(staffdocid).get();
    Map<String, dynamic>? value = staffdocument.data();
    setState(() {
      staffname=value!["stname"];
    });
    print("fdgggggggggg");
    print(staffname);

  }




  saveincharge() async {


    var document = await FirebaseFirestore.instance.collection("Incharge").get();

    FirebaseFirestore.instance.collection("Incharge").doc().set({
      "class":_typeAheadControllerclass.text,
      "section":_typeAheadControllersection.text,
      "staffid":_typeAheadControllerstaffid.text,
      "staffname": staffname,
      "orderno":document.docs.length+1,
    });
  }
  Successdialog(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'In-charge Staff Added Successfully',
      desc: 'For class - ${_typeAheadControllerclass.text} ${_typeAheadControllersection.text} is been added',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {


      },
    )..show();
  }

  final DateFormat formatter = DateFormat('dd.MM.yyy');

  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(child: Padding(
            padding: const EdgeInsets.only(left: 38.0,top: 30),
            child: Text("Staff Attendance Register",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
          ),
            //color: Colors.white,
            width: width/1.050,
            height: height/8.212,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0,top: 20),
          child: Container(width: width/1.050,
            height:height/1.263,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,top:20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:0.0),
                            child: Text("Date",style: GoogleFonts.poppins(fontSize: 15,)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0,right: 25),
                            child: Container(child:
                            TextField(
                              style:  GoogleFonts.poppins(
                                  fontSize: 15
                              ),
                              controller: date,
                              decoration: InputDecoration(


                                prefixIcon: Icon(Icons.calendar_today,size: 17,),
                                hintText: 'Date',


                                contentPadding: EdgeInsets.only(left: 10,top: 8),
                                border: InputBorder.none,
                                //editing controller of this TextField
                              ),
                              readOnly: true,  //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context, initialDate: DateTime.now(),
                                    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime.now()
                                );

                                if(pickedDate != null ){
                                  print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate = DateFormat('dd.MM.yyyy').format(pickedDate);
                                  print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                  //you can implement different kind of Date Format here according to your requirement

                                  setState(() {
                                    date.text = formattedDate;
                                    //set output date to TextField value.
                                  });
                                }else{
                                  print("Date is not selected");
                                }
                              },
                            ),
                              width: width/6.83,
                              height: height/16.425,
                              //color: Color(0xffDDDEEE),
                              decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                            ),
                          ),

                        ],

                      ),
                      GestureDetector(
                        onTap: (){
                          saveincharge();
                          Successdialog();
                        },
                        child: Container(child: Center(child: Text("View All",style: GoogleFonts.poppins(color:Colors.white),)),
                          width: width/10.507,
                          height:height/16.425,
                          // color:Color(0xff00A0E3),
                          decoration: BoxDecoration(color: Color(0xff53B175),borderRadius: BorderRadius.circular(5)),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:25.0),
                        child: GestureDetector(
                          onTap: (){
                            saveincharge();
                            Successdialog();
                          },
                          child: Container(child: Center(child: Text("Absent only",style: GoogleFonts.poppins(color:Colors.white),)),
                            width: width/10.507,
                            height:height/16.425,
                            // color:Color(0xff00A0E3),
                            decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(5)),

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: height/13.14,
                            width: width/2.101,

                            decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 20.0),
                                  child: Text("Reg No",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40.0,right: 8.0),
                                  child: Text("Student Name",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 80.0,right: 8.0),
                                  child: Text("Attendance",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 80.0,right: 8.0),
                                  child: Text("Mobile No",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                ),
                              ],
                            ),

                          ),
                        ),
                        Container(
                          width: width/2.101,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection("Incharge").orderBy("orderno").snapshots(),

                              builder: (context,snapshot){
                                if(!snapshot.hasData)
                                {
                                  return   Center(
                                    child:  CircularProgressIndicator(),
                                  );}
                                if(snapshot.hasData==null)
                                {
                                  return   Center(
                                    child:  CircularProgressIndicator(),
                                  );}
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context,index){
                                      var value = snapshot.data!.docs[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: height/21.9,
                                          width:width/2.101,

                                          decoration: BoxDecoration(color:Colors.white60,borderRadius: BorderRadius.circular(12)

                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5.0,right: 0.0),
                                                child: Container(
                                                    width: width/11.38,

                                                    child: Text("SBVD001",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                                                child: Container(

                                                    width: width/2.986,
                                                    child: Text("Sam Jeba",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                                                child: Container(

                                                    width: width/8.035,
                                                    child: Text("Present",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.green),)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                                                child: Container(

                                                    width: width/13.66,
                                                    child: Text("7894561237",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),)),
                                              ),
                                            ],
                                          ),

                                        ),
                                      );
                                    });

                              }),
                        ),
                      ],
                    ),
                    Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,top:8.0),
                          child: Container(
                            height: height/13.14,
                            width: width/4.553,

                            decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                            ),
                            child: Center(child: Text("Reports",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),)),

                          ),
                        ),
                        SizedBox(height: height/32.85,),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  Column(
                                children: [
                                  CircularPercentIndicator(
                                    circularStrokeCap: CircularStrokeCap.round,
                                    radius: 45.0,
                                    lineWidth: 10.0,
                                    percent: 0.70,
                                    center:  Text("70%",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500)),
                                    progressColor: Colors.green,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all( 8.0),
                                    child:  ChoiceChip(

                                      label: Text("  Present  ",style: TextStyle(color: Colors.white),),


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

                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  Column(
                                children: [
                                  CircularPercentIndicator(
                                    circularStrokeCap: CircularStrokeCap.round,
                                    radius: 45.0,
                                    lineWidth: 10.0,
                                    percent: 0.30,
                                    center:  Text("30%",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500)),
                                    progressColor: Colors.red,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all( 8.0),
                                    child: ChoiceChip(

                                      label: Text("  Absent  ",style: TextStyle(color: Colors.white),),


                                      onSelected: (bool selected) {

                                        setState(() {

                                        });
                                      },
                                      selectedColor: Colors.red,
                                      shape: StadiumBorder(
                                          side: BorderSide(
                                              color: Colors.red)),
                                      backgroundColor: Colors.white,
                                      labelStyle: TextStyle(color: Colors.black),

                                      elevation: 1.5, selected: true,),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height/32.85,),
                        Material(
                          elevation: 7,
                          borderRadius: BorderRadius.circular(12),
                          shadowColor:  Color(0xff53B175),
                          child: Container(
                            height: height/7.3,
                            width: width/5.464,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border:Border.all(color: Color(0xff53B175))
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Total No.of Students",style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),),
                                ChoiceChip(

                                  label: Text("25 Students",style: TextStyle(color: Colors.white),),


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
                  ],
                ),



              ],
            ),

          ),
        )
      ],
    );
  }
}
