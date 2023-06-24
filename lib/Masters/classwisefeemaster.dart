import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';

class ClasswiseFees extends StatefulWidget {
  const ClasswiseFees({Key? key}) : super(key: key);

  @override
  State<ClasswiseFees> createState() => _ClasswiseFeesState();
}

class _ClasswiseFeesState extends State<ClasswiseFees> {
  TextEditingController name = new TextEditingController();
  TextEditingController amount = new TextEditingController();
  TextEditingController orderno = new TextEditingController();


  String classid="";
  String? _selectedCity;
  final TextEditingController _typeAheadControllerclass = TextEditingController();
  final TextEditingController _typeAheadControllerfees = TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  static final List<String> classes = [];
  static final List<String> fees = [];


  static List<String> getSuggestionsclass(String query) {
    List<String> matches = <String>[];
    matches.addAll(classes);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionsfees(String query) {
    List<String> matches = <String>[];
    matches.addAll(fees);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  adddropdownvalue() async {
    var document = await  FirebaseFirestore.instance.collection("ClassMaster").orderBy("order").get();
    var document2 = await  FirebaseFirestore.instance.collection("FeesMaster").orderBy("order").get();
    for(int i=0;i<document.docs.length;i++) {
      setState(() {
        classes.add(document.docs[i]["name"]);
      });

    }
    for(int i=0;i<document2.docs.length;i++) {
      setState(() {
        fees.add(document2.docs[i]["name"]);
      });

    }

  }
  firsttimecall() async {
    var document = await  FirebaseFirestore.instance.collection("ClassMaster").get();
    setState(() {
      classid=document.docs[0].id;
      _typeAheadControllerclass.text=document.docs[0]["name"];
    });
  }

  getorderno() async {
    var document = await  FirebaseFirestore.instance.collection("ClassMaster").doc(classid).collection("Fees").get();
    setState(() {
      orderno.text="00${document.docs.length+1}";
    });
  }

  addclass(){
    FirebaseFirestore.instance.collection("ClassMaster").doc(classid).collection("Fees").doc().set({
      "feesname": _typeAheadControllerfees.text,
      "amount": int.parse(amount.text),
      "order": int.parse(orderno.text),
    });
  }
  Successdialog(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Class Fees Added Successfully',
      desc: 'Class Fees - ${name.text} is been added',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {
        name.clear();
        amount.clear();
        orderno.clear();
        getorderno();

      },
    )..show();
  }

  @override
  void initState() {
    firsttimecall();
    adddropdownvalue();
    // TODO: implement initState
    super.initState();
  }
  getstaffbyid() async {
    print("fdgggggggggg");
    print(_typeAheadControllerclass.text);
    var document = await FirebaseFirestore.instance.collection("ClassMaster").get();
    for(int i=0;i<document.docs.length;i++){
      if(_typeAheadControllerclass.text==document.docs[i]["name"]){
        setState(() {
          classid= document.docs[i].id;
        }
        );
      }
    }
    print("fdgggggggggg");


  }

  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(width: width/1.050,
            height: height/8.212,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),child: Padding(
            padding: const EdgeInsets.only(left: 38.0,top: 30),
            child: Text("Class Wise Fees Master",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
          ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0,top: 20),
          child: Container(
            width: width/1.050,
            height:height/1.263,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                            child: Text("Class",style: GoogleFonts.poppins(fontSize: 15,)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0,right: 25),
                            child: Container(width: width/6.83,
                              height: height/16.42,
                              //color: Color(0xffDDDEEE),
                              decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),child:
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
                                controller: this._typeAheadControllerclass,
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsclass(pattern);
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
                                  this._typeAheadControllerclass.text = suggestion;
                                });

                               getstaffbyid();
                                getorderno();



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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:0.0),
                            child: Text("Fees",style: GoogleFonts.poppins(fontSize: 15,)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0,right: 25),
                            child: Container(width: width/6.83,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:0.0),
                            child: Text("Amount",style: GoogleFonts.poppins(fontSize: 15,)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0,right: 25),
                            child: Container(child: TextField(
                              controller: amount,
                              style: GoogleFonts.poppins(
                                  fontSize: 15
                              ),
                              decoration: const InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                border: InputBorder.none,
                              ),
                            ),

                              width: width/6.83,
                              height: height/16.425,
                              //color: Color(0xffDDDEEE),
                              decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                            ),
                          ),

                        ],

                      ),
                      GestureDetector(
                        onTap: (){
                          addclass();
                          Successdialog();
                        },
                        child: Container(child: Center(child: Text("Save",style: GoogleFonts.poppins(color:Colors.white),)),
                          width: width/10.507,
                          height: height/16.425,
                          // color:Color(0xff00A0E3),
                          decoration: BoxDecoration(color: const Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: height/13.14,
                    width: width/ 1.241,

                    decoration: BoxDecoration(color:const Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 20.0),
                          child: Text("Order Si.no",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 56.0,right: 8.0),
                          child: Text("Fees",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 88.0,right: 8.0),
                          child: Text("Amount",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                        ),
                      ],
                    ),

                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("ClassMaster").doc(classid).collection("Fees").orderBy("order").snapshots(),

                    builder: (context,snapshot){
                      if(!snapshot.hasData)
                      {
                        return   const Center(
                          child:  CircularProgressIndicator(),
                        );}
                      if(snapshot.hasData==null)
                      {
                        return   const Center(
                          child:  CircularProgressIndicator(),
                        );}
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index){
                            var value = snapshot.data!.docs[index];
                            return  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: height/ 21.9,
                                width: width/ 1.241,

                                decoration: BoxDecoration(color:Colors.white60,borderRadius: BorderRadius.circular(12)

                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30.0,right: 70.0),
                                      child: Container(child: Text("00${value["order"].toString()}",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                      child: Container(
                                          width: 170,

                                          child: Text(value["feesname"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                      child: Text(value["amount"].toString(),style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                    ),
                                  ],
                                ),

                              ),
                            );
                          });

                    }),


              ],
            ),

          ),
        )
      ],
    );
  }
}

