import 'dart:html';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
  TextEditingController stnamefirst=new TextEditingController();
  TextEditingController stnamemiddle=new TextEditingController();
  TextEditingController stnamelast=new TextEditingController();
  TextEditingController fathername=new TextEditingController();

  TextEditingController bloodgroup=new TextEditingController();
  TextEditingController dob=new TextEditingController();
  TextEditingController community=new TextEditingController();
  TextEditingController religion=new TextEditingController();
  TextEditingController mobile=new TextEditingController();
  TextEditingController email=new TextEditingController();
  TextEditingController address=new TextEditingController();

  TextEditingController spousename=new TextEditingController();
  TextEditingController sphone=new TextEditingController();
  TextEditingController soffice=new TextEditingController();
  TextEditingController semail=new TextEditingController();
  TextEditingController saadhaar=new TextEditingController();


  TextEditingController workexp=new TextEditingController();
  TextEditingController lang=new TextEditingController();
  TextEditingController special=new TextEditingController();
  TextEditingController lastschool=new TextEditingController();
  TextEditingController subject=new TextEditingController();
  TextEditingController salary=new TextEditingController();
  TextEditingController expectedsalary=new TextEditingController();
  TextEditingController workshop=new TextEditingController();



  TextEditingController maritalmark=new TextEditingController();
  TextEditingController family=new TextEditingController();
  TextEditingController income=new TextEditingController();
  TextEditingController aadhaarno=new TextEditingController();
  TextEditingController identificationmark=new TextEditingController();

  bool single= false;
  bool married= true;

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
    setState(() {
      _typeAheadControllerdesignation.text="Select Option";
    });
    adddropdownvalue();
    getorderno();

    // TODO: implement initState
    super.initState();
  }
  adddropdownvalue() async {
    setState(() {
      designation.clear();
    });
    var document = await  FirebaseFirestore.instance.collection("DesignationMaster").orderBy("order").get();
    setState(() {
      designation.add("Select Option");
    });
    for(int i=0;i<document.docs.length;i++) {
      setState(() {
        designation.add(document.docs[i]["name"]);
      });

    }


  }
  getorderno() async {
    var document = await  FirebaseFirestore.instance.collection("Staffs").get();


      setState(() {
        regno.text="VDRES${(document.docs.length+1).toString().padLeft(2, '0')}";
      });

  }
  final  _formkey = GlobalKey<FormState>();
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
              child: Text("Staff Entry",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),),
            ),
              //color: Colors.white,
              width: width/1.050,
              height: height/8.212,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20.0,top: 10),
            child: Container(
              width: width/1.050,

              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),child: Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Form(
                key:_formkey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: width/136.6,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right:0.0),
                              child: Text("Staff First Name *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0,right: 25),
                              child: Container(
                                child: TextFormField(
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                  ],
                                  controller: stnamefirst,
                                  style: GoogleFonts.poppins(
                                      fontSize: width/91.066666667
                                  ),
                                  validator: (value) =>
                                  value!.isEmpty ? 'Field Cannot be Empty' : null,

                                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                    border: InputBorder.none,
                                  ),

                                ),
                                width: width/5.106,
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
                              child: Text("Middle Name",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0,right: 25),
                              child: Container(child: TextFormField(
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                  ],
                                controller: stnamemiddle,
                                style: GoogleFonts.poppins(
                                    fontSize: width/91.066666667
                                ),
                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                  border: InputBorder.none,
                                ),
                              ),
                                width: width/5.106,
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
                              child: Text("Last Name *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0,right: 25),
                              child: Container(child: TextFormField(
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                  ],
                                controller: stnamelast,
                                style: GoogleFonts.poppins(
                                    fontSize: width/91.066666667
                                ),
                                validator: (value) =>
                                value!.isEmpty ? 'Field Cannot be Empty' : null,
                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                  border: InputBorder.none,
                                ),
                              ),
                                width: width/5.106,
                                height: height/16.42,
                                //color: Color(0xffDDDEEE),
                                decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                              ),
                            ),

                          ],

                        ),
                      ],
                    ),
                    SizedBox(
                      height:height/32.55,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0,bottom: 10),
                                child: Text("Staff Details",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Reg Number * :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0,right: 25),
                                    child: Container(child: TextFormField(
                                      controller: regno,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                        border: InputBorder.none,

                                      ),
                                      validator: (value) =>
                                      value!.isEmpty ? 'Field Cannot be Empty' : null,
                                      style: GoogleFonts.poppins(
                                          fontSize: width/91.066666667
                                      ),

                                    ),
                                      width: width/5.464,
                                      height: height/16.42,
                                      //color: Color(0xffDDDEEE),
                                      decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(
                                height:height/65.1,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Joining Date * :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0,right: 25),
                                    child: Container(child: TextFormField(
                                      controller:  entrydate,
                                      style: GoogleFonts.poppins(
                                          fontSize: width/91.066666667
                                      ),
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context, initialDate: DateTime.now(),
                                            firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime(2101)
                                        );

                                        if(pickedDate != null ){
                                          print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                          String formattedDate = DateFormat('dd / M / yyyy').format(pickedDate);
                                          print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                          //you can implement different kind of Date Format here according to your requirement

                                          setState(() {

                                            entrydate.text = formattedDate;

                                            //set output date to TextField value.
                                          });




                                        }else{
                                          print("Date is not selected");
                                        }
                                      },
                                      validator: (value) =>
                                      value!.isEmpty ? 'Field Cannot be Empty' : null,
                                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                        border: InputBorder.none,


                                      ),

                                    ),
                                      width: width/5.464,
                                      height: height/16.42,
                                      //color: Color(0xffDDDEEE),
                                      decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height:height/65.1,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Designation * :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0,right: 25),
                                    child: Container(child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        isExpanded: true,
                                        hint:  Row(
                                          children: [
                                            Icon(
                                              Icons.list,
                                              size: 16,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: width/341.5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Select Option',
                                                style: GoogleFonts.poppins(
                                                    fontSize: width/91.066666667
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: designation
                                            .map((String item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style:  GoogleFonts.poppins(
                                                fontSize: width/91.066666667
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                            .toList(),
                                        value:  _typeAheadControllerdesignation.text,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _typeAheadControllerdesignation.text = value!;
                                          });
                                        },
                                        buttonStyleData: ButtonStyleData(
                                          height:height/13.02,
                                          width: width/8.5375,
                                          padding: const EdgeInsets.only(left: 14, right: 14),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),

                                            color: Color(0xffDDDEEE),
                                          ),

                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                          ),
                                          iconSize: 14,
                                          iconEnabledColor: Colors.black,
                                          iconDisabledColor: Colors.grey,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight:height/3.255,
                                          width: width/5.464,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14),
                                            color: Color(0xffDDDEEE),
                                          ),

                                          scrollbarTheme: ScrollbarThemeData(
                                            radius: const Radius.circular(7),
                                            thickness: MaterialStateProperty.all<double>(6),
                                            thumbVisibility: MaterialStateProperty.all<bool>(true),
                                          ),
                                        ),
                                        menuItemStyleData:  MenuItemStyleData(
                                          height:height/16.275,
                                          padding: EdgeInsets.only(left: 14, right: 14),
                                        ),
                                      ),
                                    ),
                                      width: width/5.464,
                                      height: height/16.42,
                                      //color: Color(0xffDDDEEE),
                                      decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height:height/65.1,
                              ),


                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Blood Group * :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: Container(child: TextFormField(
                                      controller: bloodgroup,
                                      style: GoogleFonts.poppins(
                                          fontSize: width/91.066666667
                                      ),
                                      validator: (value) =>
                                      value!.isEmpty ? 'Field Cannot be Empty' : null,
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
                              SizedBox(
                                height:height/65.1,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Date of Birth * :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: Container(child: TextFormField(
                                      controller: dob,
                                      style: GoogleFonts.poppins(
                                          fontSize: width/91.066666667
                                      ),
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context, initialDate: DateTime.now(),
                                            firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime(2101)
                                        );

                                        if(pickedDate != null ){
                                          print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                          String formattedDate = DateFormat('dd / M / yyyy').format(pickedDate);
                                          print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                          //you can implement different kind of Date Format here according to your requirement

                                          setState(() {

                                            dob.text = formattedDate;

                                            //set output date to TextField value.
                                          });




                                        }else{
                                          print("Date is not selected");
                                        }
                                      },
                                      validator: (value) =>
                                      value!.isEmpty ? 'Field Cannot be Empty' : null,
                                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                        border: InputBorder.none,



                                      ),
                                    ),
                                      width: width/5.464,
                                      height: height/16.425,


                                      decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(
                                height:height/65.1,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Gender * :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
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
                                            fontSize: width/91.066666667
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
                                      width: width/5.464,
                                      height: height/16.425,
                                      //color: Color(0xffDDDEEE),
                                      decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:height/65.1,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                                          child: Text("Residential Address * :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: Container(child:
                                    Padding(
                                      padding: const EdgeInsets.only(top:8.0),
                                      child: TextFormField(
                                        maxLines: 5,
                                        controller: address,
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot be Empty' : null,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,

                                        ),

                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
                                        ),

                                      ),
                                    ),
                                      width: width/5.464,
                                      height: height/7.425,
                                      //color: Color(0xffDDDEEE),
                                      decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:height/65.1,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Community * :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: Container(child: TextFormField(
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                  ],
                                      controller: community,
                                      style: GoogleFonts.poppins(
                                          fontSize: width/91.066666667
                                      ),
                                      validator: (value) =>
                                      value!.isEmpty ? 'Field Cannot be Empty' : null,
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
                              SizedBox(
                                height:height/65.1,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Contact No * :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: Container(child: TextFormField(
                                      controller: mobile,
                                      style: GoogleFonts.poppins(
                                          fontSize: width/91.066666667
                                      ),
                                      validator: (value) {
                                        if(value!.isEmpty){
                                          return 'Field Cannot Be Empty';
                                        }
                                        else if(value.characters.length!=10){
                                          return 'Enter the phone number correctly';
                                        }
                                        else{
                                          return null;
                                        }
                                      },
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
                              SizedBox(
                                height:height/65.1,
                              ),

                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Religion * :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: Container(child: TextFormField(
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                  ],
                                      controller: religion,
                                      style: GoogleFonts.poppins(
                                          fontSize: width/91.066666667
                                      ),
                                      validator: (value) =>
                                      value!.isEmpty ? 'Field Cannot be Empty' : null,
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
                              SizedBox(
                                height:height/65.1,
                              ),

                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Email * :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: Container(child: TextFormField(
                                      controller: email,
                                      style: GoogleFonts.poppins(
                                          fontSize: width/91.066666667
                                      ),
                                      validator: (value) =>
                                      value!.isEmpty ? 'Field Cannot be Empty' : null,
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
                              SizedBox(
                                height:height/65.1,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Aadhaar No * :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: Container(child: TextFormField(
                                      controller: aadhaarno,
                                      style: GoogleFonts.poppins(
                                          fontSize: width/91.066666667
                                      ),
                                      validator: (value) {
                                        if(value!.isEmpty){
                                          return 'Field Cannot Be Empty';
                                        }
                                         if(value.characters.length!=12){
                                          return 'Enter the Aadhaar number correctly';
                                        }
                                        else{
                                          return null;
                                        }
                                      },
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
                              SizedBox(
                                height:height/65.1,
                              ),


                            ],
                          ),
                        ),
                        SizedBox(width: width/39.02857142857143,),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0,bottom: 10),
                                child: Text("Marital Status",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Single :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0,right: 10),
                                    child: Checkbox(
                                      value: single,
                                      onChanged: (value){
                                        setState(() {
                                          single=value!;
                                          if(single==true){
                                            married=false;
                                          }
                                        });
                                      },
                                    )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:45.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Married :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 10),
                                      child: Checkbox(
                                        value: married,
                                        onChanged: (value){
                                          setState(() {
                                            married=value!;
                                            if(married==true){
                                              single=false;
                                            }
                                          });
                                        },
                                      )
                                  ),

                                ],
                              ),
                              SizedBox(
                                height:height/65.1,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text(single==true? "Parent Name  :":"Spouse Name  :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0,right: 25),
                                    child: Container(child: TextFormField(
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                  ],
                                       controller: spousename,
                                      style: GoogleFonts.poppins(
                                          fontSize: width/91.066666667
                                      ),
                                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                      width: width/5.464,
                                      height: height/16.42,
                                      //color: Color(0xffDDDEEE),
                                      decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(
                                height:height/65.1,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Phone No  :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0,right: 25),
                                    child: Container(child: TextFormField(
                                      controller:  sphone,
                                      style: GoogleFonts.poppins(
                                          fontSize: width/91.066666667
                                      ),

                                      validator: (value) {

                                        if(value!.characters.length!=10){
                                          return 'Enter the phone number correctly';
                                        }
                                        else{
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,top: 8),
                                        border: InputBorder.none,
                                        hintText: "",

                                        //suffixIcon: Icon(Icons.calendar_month),
                                      ),

                                    ),
                                      width: width/5.464,
                                      height: height/16.42,
                                      //color: Color(0xffDDDEEE),
                                      decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:height/65.1,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Office Address :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0,right: 25),
                                    child: Container(
                                   child:   TextFormField(
                                        controller: soffice,

                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,

                                        ),

                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
                                        ),

                                      ),

                                      width: width/5.464,
                                      height: height/16.42,
                                      //color: Color(0xffDDDEEE),
                                      decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:height/65.1,
                              ),

                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Email  :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0,right: 25),
                                    child: Container(
                                      child:TextFormField(
                                        controller: semail,

                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,

                                        ),

                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
                                        ),

                                      ),


                                      width:  width/5.464,
                                      height: height/16.42,
                                      //color: Color(0xffDDDEEE),
                                      decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:height/65.1,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Aadhaar No :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0,right:25),
                                    child: Container(child: TextFormField(
                                       controller: saadhaar,
                                      style: GoogleFonts.poppins(
                                          fontSize: width/91.066666667
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
                              SizedBox(
                                height:height/21.7,
                              ),


                              Padding(
                                padding: const EdgeInsets.only(left: 10.0,bottom: 10),
                                child: Text("Work Experience",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),),
                              ),

                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                                          child: Text("Total No of Experience :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: Container(child: TextFormField(
                                  inputFormatters: <TextInputFormatter>[
                                   // FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                  ],
                                      controller: workexp,
                                      style: GoogleFonts.poppins(
                                          fontSize: width/91.066666667
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
                              SizedBox(
                                height:height/65.1,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Language Known :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: Container(child: TextFormField(
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                  ],
                                      controller: lang,
                                      style: GoogleFonts.poppins(
                                          fontSize: width/91.066666667
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
                              SizedBox(
                                height:height/65.1,
                              ),

                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Specialisation :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: Container(child: TextFormField(
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                  ],
                                      controller: special,
                                      style: GoogleFonts.poppins(
                                          fontSize: width/91.066666667
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
                              SizedBox(
                                height:height/65.1,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                                          child: Text("Last School :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: Container(child: TextFormField(
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                  ],
                                      controller: lastschool,
                                      style: GoogleFonts.poppins(
                                          fontSize: width/91.066666667
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
                              SizedBox(
                                height:height/65.1,
                              ),

                              SizedBox(
                                height:height/65.1,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/15.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                                          child: Text("Subject/Class Taught * :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: Container(child: TextFormField(
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                  ],
                                      controller: subject,
                                      style: GoogleFonts.poppins(
                                          fontSize: width/91.066666667
                                      ),
                                      validator: (value) {
                                        if(value!.isEmpty){
                                          return 'Field Cannot Be Empty';
                                        }
                                        else{
                                          return null;
                                        }
                                      },
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


                              SizedBox(
                                height:height/65.1,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Container(
                                        width: width/10.106,
                                        height: height/16.42,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                                          child: Text("Seminar/Workshop attended :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: Container(child: TextFormField(
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                  ],
                                      controller: workshop,
                                      style: GoogleFonts.poppins(
                                          fontSize: width/91.066666667
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
                              SizedBox(
                                height:height/65.1,
                              ),

                            ],
                          ),
                        ),
                      ],
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
                              child: Text("Upload Staff Photo(150pxX150px)",style: GoogleFonts.poppins(fontSize: width/91.066666667),),
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
                                  child: Container(child: Center(child: Text("Choose file",style: GoogleFonts.poppins(fontSize: width/85.375))),
                                    width: width/10.507,
                                    height: height/16.425,
                                    // color: Color(0xffDDDEEE),
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black),color: Color(0xffDDDEEE)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("No file chosen",style: GoogleFonts.poppins(fontSize: width/105.076923077),),
                                )
                              ],
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left:28.0,right:20),
                          child: GestureDetector(
                            onTap: (){

                              if(_typeAheadControllerdesignation.text=="Select Option"){
                                Successdialog3();
                              }
                              else {
                                final isvalid = _formkey.currentState!
                                    .validate();
                                print(isvalid);
                                if (_formkey.currentState!.validate()) {
                                  print("fghdddddddddddddd");
                                  uploadstudent();
                                  Successdialog();
                                }
                              }

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
                    ),
                    SizedBox(height:height/13.02)
                  ],
                ),
              ),
            ),

            ),
          ),
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
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555555555556,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Staff Added Successfully',
      desc: 'Staff - ${stnamefirst.text} is been added',


      btnOkText: "Ok",
      btnOkOnPress: () {
        clearall();

      },
    )..show();
  }
  uploadstudent(){
    FirebaseFirestore.instance.collection("Staffs").doc().set({
      "stname": stnamefirst.text,
      "stmiddlename": stnamemiddle.text,
      "stlastname": stnamelast.text,

      "regno": regno.text,

      "entrydate": entrydate.text,


      "designation": _typeAheadControllerdesignation.text,


      "fathername": fathername.text,
      "bloodgroup": bloodgroup.text,
      "dob": dob.text,
      "gender": _typeAheadControllergender.text,
      "address": address.text,
      "community": community.text,
      "mobile": mobile.text,
      "religion": religion.text,
      "email": email.text,
      "aadhaarno": aadhaarno.text,

      "Maritalstatus": single==true?"Single":"Married",

      "Spousename": spousename.text,
      "Spousephone": sphone.text,
      "Spouseoffice": soffice.text,
      "Spouseemail": semail.text,
      "Spouseaadhaar": saadhaar.text,

      "Work Experience": workexp.text,
      "Language Known": lang.text,
      "Specialisation": special.text,
      "School Last": lastschool.text,
      "Subject": subject.text,
      "Seminar/Workshop": workshop.text,

      "imgurl":imgUrl,

      "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "time": "${DateTime.now().hour}:${DateTime.now().minute}",
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      "absent":false,
      "classasigned":false,
      "absentdays":0,
      "incharge":"",
      "inchargesec":"",
      "userid":"",


    });
  }
  Successdialog3(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555555555556,
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Enter the details correctly',


      btnCancelOnPress: () {

      },

      btnOkText: "Ok",
      btnOkOnPress: () {

      },
    )..show();
  }
  
  clearall(){
setState(() {


     regno.clear();
     entryno.clear();
     entrydate.clear();
     stnamefirst.clear();
     stnamemiddle.clear();
     stnamelast.clear();
     fathername.clear();

     bloodgroup.clear();
     dob.clear();
     community.clear();
     religion.clear();
     mobile.clear();
     email.clear();
     address.clear();

     spousename.clear();
     sphone.clear();
     soffice.clear();
     semail.clear();
     saadhaar.clear();


     workexp.clear();
     lang.clear();
     special.clear();
     lastschool.clear();
     subject.clear();
     salary.clear();
     expectedsalary.clear();
     workshop.clear();



     maritalmark.clear();
     family.clear();
     income.clear();
     aadhaarno.clear();
     identificationmark.clear();
     _typeAheadControllergender.text="";
     _typeAheadControllerdesignation.text="Select Option";
     imgUrl="";
});
  }
}
