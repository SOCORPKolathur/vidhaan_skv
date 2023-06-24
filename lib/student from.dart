import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_string/random_string.dart';
import 'package:uuid/uuid.dart';

class StudentFrom extends StatefulWidget {
  const StudentFrom({Key? key}) : super(key: key);

  @override
  State<StudentFrom> createState() => _StudentFromState();
}

class _StudentFromState extends State<StudentFrom> {


  TextEditingController regno=new TextEditingController();
  TextEditingController entrydate=new TextEditingController();
  TextEditingController stname=new TextEditingController();
  TextEditingController fathername=new TextEditingController();
  TextEditingController mothername=new TextEditingController();
  TextEditingController bloodgroup=new TextEditingController();
  TextEditingController dob=new TextEditingController();
  TextEditingController community=new TextEditingController();
  TextEditingController subcaste=new TextEditingController();
  TextEditingController religion=new TextEditingController();
  TextEditingController mobile=new TextEditingController();
  TextEditingController email=new TextEditingController();
  TextEditingController address=new TextEditingController();
  TextEditingController identificationmark=new TextEditingController();
  TextEditingController occupation=new TextEditingController();
  TextEditingController income=new TextEditingController();
  TextEditingController aadhaarno=new TextEditingController();



  //contrillers for dropdown--------------------------------------
  String? _selectedCity;
  final TextEditingController _typeAheadControllerclass = TextEditingController();
  final TextEditingController _typeAheadControllersection = TextEditingController();
  final TextEditingController _typeAheadControlleracidemic = TextEditingController();
  final TextEditingController _typeAheadControllergender = TextEditingController();

  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  static final List<String> classes = [];
  static final List<String> section = [];
  static final List<String> acidemic = [];
  static final List<String> genderlist = ["Male","Female","Others"];

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
  static List<String> getSuggestionsacidemic(String query) {
    List<String> matches = <String>[];
    matches.addAll(acidemic);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionsgender(String query) {
    List<String> matches = <String>[];
    matches.addAll(genderlist);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  //------------------Dropdown-------------------------------
  @override
  void initState() {
    adddropdownvalue();
    getorderno();
    // TODO: implement initState
    super.initState();
  }
  adddropdownvalue() async {
    var document = await  FirebaseFirestore.instance.collection("ClassMaster").orderBy("order").get();
    var document2 = await  FirebaseFirestore.instance.collection("SectionMaster").orderBy("order").get();
    var document3 = await  FirebaseFirestore.instance.collection("AcademicMaster").orderBy("order").get();
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
        acidemic.add(document3.docs[i]["name"]);
      });

    }
  }
  getorderno() async {
    var document = await  FirebaseFirestore.instance.collection("Students").get();
    setState(() {
      regno.text="VBSB00${document.docs.length+1}";
    });
  }

  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(

        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Container(child: Padding(
              padding: const EdgeInsets.only(left: 38.0,top: 30),
              child: Text("Add New Students",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
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
              height:height/1.194,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),child: Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right:0.0),
                                child: Text("Reg Number",style: GoogleFonts.poppins(fontSize: 15,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 25),
                                child: Container(child: TextField(
                                  controller: regno,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15
                                  ),
                                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                    border: InputBorder.none,
                                  ),
                                ),
                                  width: width/9.106,
                                  height: height/16.42,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                ),
                              ),

                            ],

                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right:0.0),
                                child: Text("Entry Date",style: GoogleFonts.poppins(fontSize: 15,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 25),
                                child: Container(child: TextField(
                                  controller:  entrydate,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15
                                  ),
                                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,top: 8),
                                    border: InputBorder.none,
                                    hintText: "12/12/2023",

                                    suffixIcon: Icon(Icons.calendar_month),
                                  ),

                                ),
                                  width: width/9.106,
                                  height: height/16.42,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(right:0.0),
                                child: Text("Admit Class *",style: GoogleFonts.poppins(fontSize: 15,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 25),
                                child: Container(child:
                                TypeAheadFormField(


                                  suggestionsBoxDecoration: SuggestionsBoxDecoration(
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
                                    decoration: InputDecoration(
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

                                      this._typeAheadControllerclass.text = suggestion;


                                  },
                                  suggestionsBoxController: suggestionBoxController,
                                  validator: (value) =>
                                  value!.isEmpty ? 'Please select a class' : null,
                                  onSaved: (value) => this._selectedCity = value,
                                ),
                                  width: width/9.106,
                                  height: height/16.42,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right:0.0),
                                child: Text("Section",style: GoogleFonts.poppins(fontSize: 15,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 25.0),
                                child: Container(child:
                                TypeAheadFormField(

                                  suggestionsBoxDecoration: SuggestionsBoxDecoration(
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
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                      border: InputBorder.none,
                                    ),
                                    controller: this._typeAheadControllersection,
                                  ),
                                  suggestionsCallback: (pattern) {
                                    return getSuggestionssection(pattern);
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
                                    this._typeAheadControllersection.text = suggestion;
                                  },
                                  suggestionsBoxController: suggestionBoxController,
                                  validator: (value) =>
                                  value!.isEmpty ? 'Please select a section' : null,
                                  onSaved: (value) => this._selectedCity = value,
                                ),
                                  width: width/9.106,
                                  height: height/16.42,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(right:0.0),
                                child: Text("Academic Year",style: GoogleFonts.poppins(fontSize: 15,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 25),
                                child: Container(child:
                                TypeAheadFormField(

                                  suggestionsBoxDecoration: SuggestionsBoxDecoration(
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
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                      border: InputBorder.none,
                                    ),
                                    controller: this._typeAheadControlleracidemic,
                                  ),
                                  suggestionsCallback: (pattern) {
                                    return getSuggestionsacidemic(pattern);
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
                                    this._typeAheadControlleracidemic.text = suggestion;
                                  },
                                  suggestionsBoxController: suggestionBoxController,
                                  validator: (value) =>
                                  value!.isEmpty ? 'Please select a academic year' : null,
                                  onSaved: (value) => this._selectedCity = value,
                                ),
                                  width: width/9.106,
                                  height: height/16.42,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0,top: 20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 0,right:0),
                                child: Text("Student Name",style: GoogleFonts.poppins(fontSize: 15,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0,right:25),
                                child: Container(child: TextField(
                                  controller: stname,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15
                                  ),
                                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom:8),
                                    border: InputBorder.none,
                                  ),
                                ),
                                  width: width/5.464,
                                  height: height/16.425,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 0.0,right:0),
                                child: Text("Father Name",style: GoogleFonts.poppins(fontSize: 15,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 25.0),
                                child: Container(child: TextField(
                                    controller: fathername,
                                    style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                    border: InputBorder.none,



                                  ),
                                ),
                                  width: width/5.464,
                                  height: height/16.425,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 0,left: 0),
                                child: Text("Mother Name",style: GoogleFonts.poppins(fontSize: 15,)),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 25.0),
                                child: Container(child: TextField(
                                    controller:mothername,
                                    style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                    border: InputBorder.none,
                                    hintText: "",



                                  ),
                                ),
                                  width: width/5.464,
                                  height: height/16.425,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),





                    Padding(
                      padding: const EdgeInsets.only(top: 18.0,right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*Padding(
                            padding: const EdgeInsets.only(left:10.0,bottom:10),
                            child: Text("Add New Parent",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 18),),
                          ),*/
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:0.0),
                                      child: Text("Blood Group",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right:25.0),
                                      child: Container(child: TextField(
                                          controller:bloodgroup,
                                          decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                        width: width/9.106,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ]
                                  ,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:0.0),
                                      child: Text("Date of Birth ",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextField(
                                          controller: dob,
                                          decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                        width: width/9.106,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Gender",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(right:25.0),
                                      child: Container(child:
                                      TypeAheadFormField(

                                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
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
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                            border: InputBorder.none,
                                          ),
                                          controller: this._typeAheadControllergender,
                                        ),
                                        suggestionsCallback: (pattern) {
                                          return getSuggestionsgender(pattern);
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
                                          this._typeAheadControllergender.text = suggestion;
                                        },
                                        suggestionsBoxController: suggestionBoxController,
                                        validator: (value) =>
                                        value!.isEmpty ? 'Please select a academic year' : null,
                                        onSaved: (value) => this._selectedCity = value,
                                      ),
                                        width: width/9.106,
                                        height: height/16.425,
                                        // color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Community",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right:25.0),
                                      child: Container(child: TextField(
                                        controller: community,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                        width: width/9.106,
                                        height: height/16.425,
                                        // color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Sub Caste",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right:25.0),
                                      child: Container(child: TextField(
                                        controller: subcaste,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                        width: width/9.106,
                                        height: height/16.425,
                                        // color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0,top:20),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:0.0),
                                      child: Text("Religion",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right:25.0),
                                      child: Container(child: TextField(
                                        controller: religion,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                        width: width/9.106,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ]
                                  ,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:0.0),
                                      child: Text("Mobile No",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextField(
                                        controller: mobile,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                        width: width/9.106,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Email",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(right:25.0),
                                      child: Container(child: TextField(
                                        controller: email,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                        width: width/9.106,
                                        height: height/16.425,
                                        // color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Address",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right:25.0),
                                      child: Container(child: TextField(
                                        controller: address,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                        width: width/3.415,
                                        height: height/16.425,
                                        // color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),


                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0,top:20),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:0.0),
                                      child: Text("Identification Mark",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right:25.0),
                                      child: Container(child: TextField(
                                        controller: identificationmark,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                        width: width/9.106,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ]
                                  ,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:0.0),
                                      child: Text("Parent Occupation",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextField(
                                        controller: occupation,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                        width: width/9.106,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Annual Income",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(right:25.0),
                                      child: Container(child: TextField(
                                        controller: income,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                        width: width/9.106,
                                        height: height/16.425,
                                        // color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Aadhaar No",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right:25.0),
                                      child: Container(child: TextField(
                                        controller: aadhaarno,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                        width: width/6.83,
                                        height: height/16.42,
                                        // color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),


                              ],
                            ),
                          ),


                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:8.0,left:50,right:10),
                                child: Container(

                                  child: isloading==false ?imgUrl==""?   Center(
                                    child: Icon(Icons.upload,size: 40,),
                                  )
                                      :
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(52),
                                      child: Image.network(imgUrl,fit: BoxFit.cover,)) : Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  width: width/13.66,
                                  height: height/6.57,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(52)),

                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:48.0),
                                    child: Text("Upload Student Photo(150pxX150px",style: GoogleFonts.poppins(fontSize: 15),),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            isloading=true;
                                          });
                                          uploadToStorage();
                                        },
                                        child: Container(child: Center(child: Text("Choose file",style: GoogleFonts.poppins(fontSize: 16))),
                                          width: width/10.507,
                                          height: height/16.425,
                                          // color: Color(0xffDDDEEE),
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black),color: Color(0xffDDDEEE)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("No file chosen",style: GoogleFonts.poppins(fontSize: 13),),
                                      )
                                    ],
                                  ),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left:28.0,right:20),
                                child: GestureDetector(
                                  onTap: (){
                                    uploadstudent();
                                    Successdialog();
                                  },
                                  child: Container(child: Center(child: Text("Save ",style: GoogleFonts.poppins(color:Colors.white),)),
                                    width: width/10.507,
                                    height: height/16.425,
                                    //color:Color(0xffD60A0B),
                                    decoration: BoxDecoration(color: Color(0xffD60A0B),borderRadius: BorderRadius.circular(5)),

                                  ),
                                ),
                              ),
                              Container(child: Center(child: Text("Reset ",style: GoogleFonts.poppins(color:Colors.white),)),
                                width: width/10.507,
                                height: height/16.425,
                                // color:Color(0xff00A0E3),
                                decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),

            ),
          )
        ],
      ),
    );
  }
  String imgUrl="";
  String fileName = Uuid().v1();
  bool  isloading = false;

  uploadToStorage() async{

    InputElement input = FileUploadInputElement()as InputElement ..accept = 'image/*';
    FirebaseStorage fs = FirebaseStorage.instance;
    input.click();
    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) async {
        var snapshot = await fs.ref().child('studentsimages').child("${file.name}").putBlob(file);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imgUrl = downloadUrl;
          isloading=false;
        });

        print(imgUrl);
      });
    });

    print(imgUrl);

  }
  Successdialog(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Student Added Successfully',
      desc: 'Student - ${stname.text} is been added',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {


      },
    )..show();
  }

  String studentid = "";
  uploadstudent(){

    setState(() {
      studentid=randomAlphaNumeric(16);
    });
    FirebaseFirestore.instance.collection("Students").doc(studentid).set({
      "regno": regno.text,
      "studentid": studentid,
      "entrydate": entrydate.text,
      "admitclass": _typeAheadControllerclass.text,
      "section": _typeAheadControllersection.text,
      "academic": _typeAheadControlleracidemic.text,
      "stname": stname.text,
      "fathername": fathername.text,
      "mothername": mothername.text,
      "bloodgroup": bloodgroup.text,
      "dob": dob.text,
      "gender": _typeAheadControllergender.text,
      "community": community.text,
      "subcaste": subcaste.text,
      "religion": religion.text,
      "mobile": mobile.text,
      "email": email.text,
      "address": address.text,
      "identificatiolmark": identificationmark.text,
      "occupation": occupation.text,
      "income": income.text,
      "aadhaarno": aadhaarno.text,
      "imgurl":imgUrl,
      "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "time": "${DateTime.now().hour}:${DateTime.now().minute}",
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      "absentdays":0,
      "behaviour":0,
    });
    FirebaseFirestore.instance.collection("Classstudents").doc("${_typeAheadControllerclass.text}${_typeAheadControllersection.text}").set({
      "name":"${_typeAheadControllerclass.text}${_typeAheadControllersection.text}",
    });
    FirebaseFirestore.instance.collection("Classstudents").doc("${_typeAheadControllerclass.text}${_typeAheadControllersection.text}").collection("Students").doc(studentid).set({
      "regno": regno.text,
      "studentid": studentid,
      "admitclass": _typeAheadControllerclass.text,
      "section": _typeAheadControllerclass.text,
      "stname": stname.text,
      "absentdays":0,
      "behaviour":0,
    });


  }


  }
  uploadclassstudents(){



}
