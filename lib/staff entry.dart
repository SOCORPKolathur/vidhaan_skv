import 'dart:html';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class StaffEntry extends StatefulWidget {
  const StaffEntry({Key? key}) : super(key: key);

  @override
  State<StaffEntry> createState() => _StaffEntryState();
}

class _StaffEntryState extends State<StaffEntry> {

  TextEditingController regno=new TextEditingController();
  TextEditingController entryno=new TextEditingController();
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
  TextEditingController maritalmark=new TextEditingController();
  TextEditingController family=new TextEditingController();
  TextEditingController income=new TextEditingController();
  TextEditingController aadhaarno=new TextEditingController();



  //contrillers for dropdown--------------------------------------
  String? _selectedCity;
  final TextEditingController _typeAheadControllercategory = TextEditingController();
  final TextEditingController _typeAheadControllerdesignation = TextEditingController();
  final TextEditingController _typeAheadControllergender = TextEditingController();

  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  static final List<String> category = ["Full Time"," Part Time"];
  static final List<String> designation = [];
  static final List<String> genderlist = ["Male","Female","Others"];

  static List<String> getSuggestionscategory(String query) {
    List<String> matches = <String>[];
    matches.addAll(category);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionsdesignation(String query) {
    List<String> matches = <String>[];
    matches.addAll(designation);

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
    var document = await  FirebaseFirestore.instance.collection("DesignationMaster").orderBy("order").get();
    for(int i=0;i<document.docs.length;i++) {
      setState(() {
        designation.add(document.docs[i]["name"]);
      });

    }


  }
  getorderno() async {
    var document = await  FirebaseFirestore.instance.collection("Staffs").get();
    setState(() {
      regno.text="VBSB00${document.docs.length+1}";
      entryno.text="00${document.docs.length+1}";
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
              child: Text("Staff Entry",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
            ),
              //color: Colors.white,
              width: width/1.050,
              height: height/8.212,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20.0,top: 20),
            child: Container(
              width: width/1.050,
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
                                child: Text("Entry Number",style: GoogleFonts.poppins(fontSize: 15,)),
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
                                  controller: entrydate,
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
                                child: Text("Category *",style: GoogleFonts.poppins(fontSize: 15,)),
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
                                    controller: this._typeAheadControllercategory,
                                  ),
                                  suggestionsCallback: (pattern) {
                                    return getSuggestionscategory(pattern);
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

                                    this._typeAheadControllercategory.text = suggestion;


                                  },
                                  suggestionsBoxController: suggestionBoxController,
                                  validator: (value) =>
                                  value!.isEmpty ? 'Please select a category' : null,
                                  onSaved: (value) => this._selectedCity = value,
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
                                child: Text("Designation",style: GoogleFonts.poppins(fontSize: 15,)),
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
                                    controller: this._typeAheadControllerdesignation,
                                  ),
                                  suggestionsCallback: (pattern) {
                                    return getSuggestionsdesignation(pattern);
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

                                    this._typeAheadControllerdesignation.text = suggestion;


                                  },
                                  suggestionsBoxController: suggestionBoxController,
                                  validator: (value) =>
                                  value!.isEmpty ? 'Please select a Designation' : null,
                                  onSaved: (value) => this._selectedCity = value,
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
                                child: Text("Staff ID",style: GoogleFonts.poppins(fontSize: 15,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 25),
                                child: Container(child: TextField(
                                    controller:regno,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                    border: InputBorder.none,
                                    hintText: "SBT005",
                                  
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
                                child: Text("Staff Name",style: GoogleFonts.poppins(fontSize: 15,)),
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

                                    controller: mothername,
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
                                          controller: bloodgroup,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                        width: width/9.106,
                                        height: height/16.42,
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
                                        value!.isEmpty ? 'Please select a gender' : null,
                                        onSaved: (value) => this._selectedCity = value,
                                      ),
                                        width: width/9.106,
                                        height: height/16.42,
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
                                        height: height/16.42,
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
                                        height: height/16.42,
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
                                        height: height/16.42,
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
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0,top:20),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:0.0),
                                      child: Text("Marital Mark",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right:25.0),
                                      child: Container(child: TextField(
                                          controller: maritalmark,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                        width: width/9.106,
                                        height: height/16.42,
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
                                      child: Text("Family Details",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextField(
                                          controller:family,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
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
                                        height: height/16.42,
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
                                    child: Text("Upload Staff Photo(150pxX150px",style: GoogleFonts.poppins(fontSize: 15),),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          uploadToStorage();
                                        },
                                        child: Container(child: Center(child: Text("Choose file",style: GoogleFonts.poppins(fontSize: 16))),
                                          width: width/10.507,
                                          height: height/16.42,
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
                                    height: height/16.42,
                                    //color:Color(0xffD60A0B),
                                    decoration: BoxDecoration(color: Color(0xffD60A0B),borderRadius: BorderRadius.circular(5)),

                                  ),
                                ),
                              ),
                              Container(child: Center(child: Text("Reset ",style: GoogleFonts.poppins(color:Colors.white),)),
                                width: width/10.507,
                                height: height/16.42,
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
      title: 'Staff Added Successfully',
      desc: 'Staff - ${stname.text} is been added',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {


      },
    )..show();
  }
  uploadstudent(){
    FirebaseFirestore.instance.collection("Staffs").doc().set({
      "regno": regno.text,
      "entryno": int.parse(entryno.text),
      "entrydate": entrydate.text,
      "category": _typeAheadControllercategory.text,
      "designation": _typeAheadControllerdesignation.text,
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
      "maritalmark": maritalmark.text,
      "family": family.text,
      "income": income.text,
      "aadhaarno": aadhaarno.text,
      "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "time": "${DateTime.now().hour}:${DateTime.now().minute}",
      "timestamp": DateTime.now().microsecondsSinceEpoch,


    });
  }
}
