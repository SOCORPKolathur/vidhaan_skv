import 'dart:html';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:random_string/random_string.dart';


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
  String studentid="";
  String? _selectedCity;
  final TextEditingController _typeAheadControllerclass = TextEditingController();
  final TextEditingController _typeAheadControllerfees = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController paytype = TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  final TextEditingController _typeAheadControllerregno = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController _typeAheadControllerstudent = TextEditingController();

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
  static final List<String> classes = ["Select Option"];
  static final List<String> fees = ["Select Option"];
  static final List<String> typeclass = ["Select Option","Class","Student","General"];
  static final List<String> paytypelist = ["Select Option","Monthly","Admission Time","Custom",];
  static final List<String> paytypelist1 = ["Select Option","Monthly","Custom"];


  static List<String> getSuggestionsclass(String query) {
    List<String> matches = <String>[];
    matches.addAll(classes);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionstype(String query) {
    List<String> matches = <String>[];
    matches.addAll(typeclass);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionstypepay(String query) {
    List<String> matches = <String>[];
    matches.addAll(paytypelist);

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
    setState(() {
      classes.clear();
      fees.clear();
      regno.clear();
      student.clear();
    });
    var document = await  FirebaseFirestore.instance.collection("ClassMaster").get();
    var document2 = await  FirebaseFirestore.instance.collection("FeesMaster").get();
    setState(() {
      classes.add("Select Option");
      fees.add("Select Option");
    });
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
    var document3 = await  FirebaseFirestore.instance.collection("Students").orderBy("timestamp").get();
    var document4 = await  FirebaseFirestore.instance.collection("Students").orderBy("stname").get();
    for(int i=0;i<document3.docs.length;i++) {
      setState(() {
        regno.add(document3.docs[i]["regno"]);
      });

    }
    for(int i=0;i<document4.docs.length;i++) {
      setState(() {
        student.add(document4.docs[i]["stname"]);
      });

    }
  }

  firsttimecall() async {
    var document = await  FirebaseFirestore.instance.collection("ClassMaster").get();
    var document2 = await  FirebaseFirestore.instance.collection("Students").get();
    setState(() {
      classid=document.docs[0].id;
      studentid=document2.docs[0].id;
      _typeAheadControllerclass.text=document.docs[0]["name"];
      _typeAheadControllerregno.text=document2.docs[0]["regno"];
    });

  }

  getorderno() async {
    var document = await  FirebaseFirestore.instance.collection("ClassMaster").doc(classid).collection("Fees").get();
    setState(() {
      orderno.text="00${document.docs.length+1}";
    });
  }

  addclass() async {
    String docId = randomAlphaNumeric(16);
    //"Admission Time"
    if(paytype.text == "Admission Time"){
      FirebaseFirestore.instance.collection("AdmissionTimeFees").doc(docId).set({
        "feesname": _typeAheadControllerfees.text,
        "amount": int.parse(amount.text),
        "timestamp": DateTime.now().microsecondsSinceEpoch,
        "paytype": paytype.text,
        "class": _typeAheadControllerclass.text,
        //"status": false,
        // "date": "",
        // "time": "",
        // "duedate": paytype.text.toLowerCase() == 'monthly'
        //     ? '01/01/2023'
        //     : paytype.text.toLowerCase() == 'custom' ? date.text : ''
      });
    }
    else{
      FirebaseFirestore.instance.collection("ClassMaster").doc(classid).collection("Fees").doc(docId).set({
        "feesname": _typeAheadControllerfees.text,
        "amount": int.parse(amount.text),
        "timestamp": DateTime.now().microsecondsSinceEpoch,
        "paytype": paytype.text,
      });
      var document = await FirebaseFirestore.instance.collection("Students").where("admitclass",isEqualTo: _typeAheadControllerclass.text).get();
      for(int i=0;i<document.docs.length;i++) {
        FirebaseFirestore.instance.collection("FeesCollection").doc("${document.docs[i].id}:$docId").set({
          "feesname":  _typeAheadControllerfees.text,
          "amount": int.parse(amount.text),
          "payedamount": 0.0,
          "timestamp": DateTime.now().millisecondsSinceEpoch,
          "paytype": paytype.text,
          "status":false,
          "date" : "",
          "time" : "",
          "class" : document.docs[i].get("admitclass"),
          "section" : document.docs[i].get("section"),
          "stRegNo" : document.docs[i].get("regno"),
          "stName" : document.docs[i].get("stname"),
          "email" : document.docs[i].get("email"),
          "duedate" : paytype.text.toLowerCase() == 'monthly' ? '01/01/2023' : paytype.text.toLowerCase() == 'custom' ? date.text : ''
        });
        FirebaseFirestore.instance.collection("Students").doc(document.docs[i].id).collection("Fees").doc(docId).set({
          "feesname":  _typeAheadControllerfees.text,
          "amount": int.parse(amount.text),
          "payedamount": 0.0,
          "timestamp": DateTime.now().millisecondsSinceEpoch,
          "paytype": paytype.text,
          "status":false,
          "date" : "",
          "time" : "",
          "class" : document.docs[i].get("admitclass"),
          "section" : document.docs[i].get("section"),
          "stRegNo" : document.docs[i].get("regno"),
          "stName" : document.docs[i].get("stname"),
          "duedate" : paytype.text.toLowerCase() == 'monthly' ? '01/01/2023' : paytype.text.toLowerCase() == 'custom' ? date.text : ''
        });
      }
    }
  }

  addstudent() async {
    String docId = randomAlphaNumeric(16);
    if(paytype.text == "Admission Time"){
      FirebaseFirestore.instance.collection("AdmissionTimeFees").doc(docId).set({
        "feesname": _typeAheadControllerfees.text,
        "amount": int.parse(amount.text),
        "timestamp": DateTime.now().millisecondsSinceEpoch,
        "paytype": paytype.text,
        "class": _typeAheadControllerclass.text,
        //"status": false,
        // "date": "",
        // "time": "",
        // "duedate": paytype.text.toLowerCase() == 'monthly'
        //     ? '01/01/2023'
        //     : paytype.text.toLowerCase() == 'custom' ? date.text : ''
      });
    }else {
      var student = await FirebaseFirestore.instance.collection("Students").doc(studentid).get();
      FirebaseFirestore.instance.collection("FeesCollection").doc("$studentid:$docId").set({
        "feesname": _typeAheadControllerfees.text,
        "amount": int.parse(amount.text),
        "payedamount": 0.0,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
        "paytype": paytype.text,
        "status": false,
        "date": "",
        "time": "",
        "class" : student.get("admitclass"),
        "section" : student.get("section"),
        "stRegNo" : student.get("regno"),
        "stName" : student.get("stname"),
        "email" : student.get("email"),
        "duedate": paytype.text.toLowerCase() == 'monthly'
            ? '01/01/2023'
            : paytype.text.toLowerCase() == 'custom' ? date.text : ''
      });
      FirebaseFirestore.instance.collection("Students").doc(studentid).collection("Fees").doc(docId).set({
        "feesname": _typeAheadControllerfees.text,
        "amount": int.parse(amount.text),
        "payedamount": 0.0,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
        "paytype": paytype.text,
        "status": false,
        "date": "",
        "time": "",
        "class" : student.get("admitclass"),
        "section" : student.get("section"),
        "stRegNo" : student.get("regno"),
        "stName" : student.get("stname"),
        "duedate": paytype.text.toLowerCase() == 'monthly'
            ? '01/01/2023'
            : paytype.text.toLowerCase() == 'custom' ? date.text : ''
      });
    }
  }

  addgen() async {
    String docId = randomAlphaNumeric(16);
    if(paytype.text == "Admission Time"){
      FirebaseFirestore.instance.collection("AdmissionTimeFees").doc(docId).set({
        "feesname": _typeAheadControllerfees.text,
        "amount": int.parse(amount.text),
        "timestamp": DateTime.now().microsecondsSinceEpoch,
        "paytype": paytype.text,
        "class": 'All',
        // "date": "",
        // "time": "",
        // "duedate": paytype.text.toLowerCase() == 'monthly'
        //     ? '01/01/2023'
        //     : paytype.text.toLowerCase() == 'custom' ? date.text : ''
      });
    }else {
      var document = await FirebaseFirestore.instance.collection("Students").get();
      for(int i=0;i<document.docs.length;i++) {
        FirebaseFirestore.instance.collection("FeesCollection").doc("${document.docs[i].id}:$docId").set({
          "feesname":  _typeAheadControllerfees.text,
          "amount": double.parse(amount.text),
          "payedamount": 0.0,
          "timestamp": DateTime.now().millisecondsSinceEpoch,
          "paytype": paytype.text,
          "status":false,
          "date" : "",
          "time" : "",
          "class" : document.docs[i].get("admitclass"),
          "section" : document.docs[i].get("section"),
          "stRegNo" : document.docs[i].get("regno"),
          "stName" : document.docs[i].get("stname"),
          "email" : document.docs[i].get("email"),
          "duedate" : paytype.text.toLowerCase() == 'monthly' ? '01/01/2023' : paytype.text.toLowerCase() == 'custom' ? date.text : ''
        });
        FirebaseFirestore.instance.collection("Students").doc(document.docs[i].id).collection("Fees").doc(docId).set({
          "feesname":  _typeAheadControllerfees.text,
          "amount": double.parse(amount.text),
          "payedamount": 0.0,
          "timestamp": DateTime.now().millisecondsSinceEpoch,
          "paytype": paytype.text,
          "status":false,
          "date" : "",
          "time" : "",
          "class" : document.docs[i].get("admitclass"),
          "section" : document.docs[i].get("section"),
          "stRegNo" : document.docs[i].get("regno"),
          "stName" : document.docs[i].get("stname"),
          "duedate" : paytype.text.toLowerCase() == 'monthly' ? '01/01/2023' : paytype.text.toLowerCase() == 'custom' ? date.text : ''
        });
      }
      // FirebaseFirestore.instance.collection("Fees").doc(docId).set({
      //   "feesname": _typeAheadControllerfees.text,
      //   "amount": int.parse(amount.text),
      //   "timestamp": DateTime
      //       .now()
      //       .microsecondsSinceEpoch,
      //   "paytype": paytype.text,
      // });
    }
  }

  deleteClassFees(String classId,String docId) async {
    FirebaseFirestore.instance.collection("AdmissionTimeFees").doc(docId).delete();
    FirebaseFirestore.instance.collection("ClassMaster").doc(classid).collection("Fees").doc(docId).delete();
    var studentDocument = await FirebaseFirestore.instance.collection("Students").get();
    studentDocument.docs.forEach((student) {
      FirebaseFirestore.instance.collection("FeesCollection").doc("${student.id}:$docId").delete();
      FirebaseFirestore.instance.collection("Students").doc(student.id).collection("Fees").doc(docId).delete();
    });
  }

  deleteStudentFees(String studentRegNo, String docId) async {
    FirebaseFirestore.instance.collection("AdmissionTimeFees").doc(docId).delete();
    var studentDoc = await FirebaseFirestore.instance.collection("Students").get();
    studentDoc.docs.forEach((student) {
      if(student.get("regno") == studentRegNo){
        FirebaseFirestore.instance.collection("FeesCollection").doc("${student.id}:$docId").delete();
        FirebaseFirestore.instance.collection("Students").doc(student.id).collection("Fees").doc(docId).delete();
      }
    });
  }

  deleteAllFees(String docId) async {
    print('----------------------- $docId ---------------------------------------');
    FirebaseFirestore.instance.collection("AdmissionTimeFees").doc(docId).delete();
    var studentDoc = await FirebaseFirestore.instance.collection("Students").get();
    studentDoc.docs.forEach((student) {
        FirebaseFirestore.instance.collection("FeesCollection").doc("${student.id}:$docId").delete();
        FirebaseFirestore.instance.collection("Students").doc(student.id).collection("Fees").doc(docId).delete();
    });
  }

  Successdialog(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Fees Assign Successfully',
      desc: 'Fees - ${_typeAheadControllerfees.text} is been added',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {
        name.clear();
        amount.clear();
        orderno.clear();
        getorderno();
        gettotal1();
        gettotal2();
      },
    )..show();
  }
  Errordialog(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Please select all the option',


      btnOkOnPress: () {
        name.clear();
        amount.clear();
        orderno.clear();
        getorderno();
        gettotal1();
        gettotal2();


      },
    )..show();
  }

  getstudentbyregno(value) async {
    print("fdgggggggggg");

    var document = await FirebaseFirestore.instance.collection("Students").get();
    for(int i=0;i<document.docs.length;i++){
      if(value==document.docs[i]["regno"]){
        setState(() {
          _typeAheadControllerstudent.text= document.docs[i]["stname"];
        }
        );
      }
    }
    print("fdgggggggggg");


  }
  getstudentbyname(value) async {
    print("fdgggggggggg");

    var document = await FirebaseFirestore.instance.collection("Students").get();
    for(int i=0;i<document.docs.length;i++){
      if(value==document.docs[i]["stname"]){
        setState(() {
          _typeAheadControllerregno.text= document.docs[i]["regno"];
        }
        );
      }
    }
    print("fdgggggggggg");


  }



  DateTime? _selected;
  Future<void> _monthpick({
    required BuildContext context,
    String? locale,
  })
  async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _selected ?? DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
      locale: localeObj,
    );
    // final selected = await showDatePicker(
    //   context: context,
    //   initialDate: _selected ?? DateTime.now(),
    //   firstDate: DateTime(2019),
    //   lastDate: DateTime(2022),
    //   locale: localeObj,
    // );
    if (selected != null) {
      setState(() {
        _selected = selected;
        paytype.text="${_selected!.month} / ${_selected!.year}";
      });
    }
  }


  @override
  void initState() {
    firsttimecall();
    adddropdownvalue();
    setState(() {
      _typeAheadControllerfees.text="Select Option";
      _typeAheadControllerclass.text="Select Option";
      type.text="Select Option";
      paytype.text="Select Option";
    });
    // TODO: implement initState
    super.initState();
  }
  getstaffbyid2() async {
    print("fdgggggggggg");
    print(_typeAheadControllerregno.text);
    var document = await FirebaseFirestore.instance.collection("Students").get();
    for(int i=0;i<document.docs.length;i++){
      if(_typeAheadControllerstudent.text==document.docs[i]["stname"]){
        setState(() {
          _typeAheadControllerregno.text= document.docs[i]["regno"];
          studentid= document.docs[i].id;
        }
        );
      }
    }
    gettotal2();
    print("fdgggggggggg");


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
    gettotal1();


  }
  getstaffbyid3() async {
    print("fdgggggggggg");

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
    gettotal2();


  }
  final  _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Container(width: width/1.050,
              height: height/8.212,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),child: Padding(
              padding: const EdgeInsets.only(left: 38.0,top: 30),
              child: Text("Assign Fees Master",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
            ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0,top: 20),
            child: Form(
              key:_formkey,
              child: Container(
                width: width/1.050,
               
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width/1.050,

                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Assign Fee For :",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 25),
                                child: Container(width: width/6.83,
                                  height: height/16.42,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),child:
                                  DropdownButtonHideUnderline(
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
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Select Option',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items:
                                      typeclass.map((String item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style:  GoogleFonts.poppins(
                                              fontSize: 15
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value:  type.text,
                                      onChanged: (String? value) {
                                        setState(() {
                                         type.text = value!;
                                        });
                                        if(type.text=="Class") {
                                          gettotal1();
                                        }
                                        if(type.text=="Student") {
                                          gettotal2();
                                        }
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 50,
                                        width: 160,
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
                                        maxHeight: 200,
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
                                      menuItemStyleData: const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(left: 14, right: 14),
                                      ),
                                    ),
                                  ),

                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0,top:8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                              type.text=="Class"?  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Select Class *",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(width: width/6.83,
                                        height: height/16.42,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),child:
                                        DropdownButtonHideUnderline(
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
                                                  width: 4,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'Select Option',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            items: classes
                                                .map((String item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style:  GoogleFonts.poppins(
                                                    fontSize: 15
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                                .toList(),
                                            value:  _typeAheadControllerclass.text,
                                            onChanged: (String? value) {
                                              setState(() {
                                                _typeAheadControllerclass.text = value!;
                                              });
                                              getstaffbyid();

                                            },
                                            buttonStyleData: ButtonStyleData(
                                              height: 50,
                                              width: 160,
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
                                              maxHeight: 200,
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
                                            menuItemStyleData: const MenuItemStyleData(
                                              height: 40,
                                              padding: EdgeInsets.only(left: 14, right: 14),
                                            ),
                                          ),
                                        ),

                                      ),
                                    ),

                                  ],

                                ) :
                              type.text=="Student"? Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right:0.0),
                                          child: Text("Register Number *",style: GoogleFonts.poppins(fontSize: 15,)),
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

                                              getstaffbyid3();
                                              getstudentbyregno(_typeAheadControllerregno.text);

                                              // getorderno();



                                            },
                                            suggestionsBoxController: suggestionBoxController,
                                            validator: (value) {
                                              if(type.text=="Student") {
                                                if (value!.isEmpty) {
                                                  return 'Please select a student';
                                                } else {
                                                  return null;
                                                }
                                              }
                                              else {
                                                return null;
                                              }
                                            },
                                            onSaved: (value) => this._selectedCity = value,
                                          ),
                                            width: width/8.902,
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
                                          child: Text("Student Name *",style: GoogleFonts.poppins(fontSize: 15,)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 0.0,right: 10),
                                          child: Container(
                                            width: width/6.902,
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
                                                getstudentbyname(_typeAheadControllerstudent.text);




                                              },
                                              suggestionsBoxController: suggestionBoxController,
                                              validator: (value) {
                                                if(type.text=="Student") {
                                                  if(_typeAheadControllerregno.text==""){
                                                  if (value!.isEmpty) {
                                                    return 'Please select a student';
                                                  } else {
                                                    return null;
                                                  }
                                                }
                                                  else {
                                                    return null;
                                                  }
                                              }
                                                else {
                                                  return null;
                                                }
                                              },
                                              onSaved: (value) => this._selectedCity = value,
                                            ),

                                          ),
                                        ),

                                      ],

                                    ),
                                  ],
                                ) :
                              Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width/1.050,
                      height: height/5.212,
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Select Fees Details",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0,top:8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Fees *",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(width: width/6.83,
                                        height: height/16.42,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                        child:

                                        DropdownButtonHideUnderline(
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
                                                  width: 4,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'Select Option',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            items: fees
                                                .map((String item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style:  GoogleFonts.poppins(
                                                    fontSize: 15
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                                .toList(),
                                            value:  _typeAheadControllerfees.text,
                                            onChanged: (String? value) {
                                              setState(() {
                                                _typeAheadControllerfees.text = value!;
                                              });
                                            },
                                            buttonStyleData: ButtonStyleData(
                                              height: 50,
                                              width: 160,
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
                                              maxHeight: 200,
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
                                            menuItemStyleData: const MenuItemStyleData(
                                              height: 40,
                                              padding: EdgeInsets.only(left: 14, right: 14),
                                            ),
                                          ),
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
                                      child: Text("Amount *",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: amount,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot be Empty' : null,
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Collect payment on *",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(width: width/6.83,
                                        height: height/16.42,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),child:
                                        DropdownButtonHideUnderline(
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
                                                  width: 4,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'Select Option',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            items: type.text == 'Student' ? paytypelist1.map((String item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style:  GoogleFonts.poppins(
                                                    fontSize: 15
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                                .toList() : paytypelist
                                                .map((String item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style:  GoogleFonts.poppins(
                                                    fontSize: 15
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                                .toList(),
                                            value:  paytype.text,
                                            onChanged: (String? value) async {
                                              setState(() {
                                                paytype.text = value!;
                                              });
                                              if(value=="Custom"){

                                                  DateTime? pickedDate = await showDatePicker(
                                                      context: context, initialDate: DateTime.now(),
                                                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                                      lastDate: DateTime(2101)
                                                  );

                                                  if(pickedDate != null ){
                                                    print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                                    String formattedDate = DateFormat('dd/M/yyyy').format(pickedDate);
                                                    print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                                    //you can implement different kind of Date Format here according to your requirement
                                                    setState(() {

                                                      date.text = formattedDate;

                                                      //set output date to TextField value.
                                                    });




                                                  }else{
                                                    print("Date is not selected");
                                                  }

                                              }
                                            },
                                            buttonStyleData: ButtonStyleData(
                                              height: 50,
                                              width: 160,
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
                                              maxHeight: 200,
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
                                            menuItemStyleData: const MenuItemStyleData(
                                              height: 40,
                                              padding: EdgeInsets.only(left: 14, right: 14),
                                            ),
                                          ),
                                        ),

                                      ),
                                    ),

                                  ],

                                ),
                                paytype.text=="Custom"?
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Custom Date *",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: date,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot be Empty' : null,
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

                                ): Container(),
                                GestureDetector(
                                  onTap: (){
                                    print("fkjsidhfakshdf");
                                    final isvalid= _formkey.currentState!.validate();
                                    print(isvalid);
                                    if(_typeAheadControllerfees.text!="Select Option"||paytype.text!="Select Option") {
                                      if (_formkey.currentState!.validate()) {
                                        if (type.text == "Class") {
                                          addclass();
                                          Successdialog();
                                        }
                                        else if (type.text == "Student") {
                                          addstudent();
                                          Successdialog();
                                        }
                                        else if (type.text == "General") {
                                          addgen();
                                          Successdialog();
                                        }
                                      }
                                    }
                                    else {
                                      Errordialog();
                                    }
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
                        ],
                      ),
                    ),



                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:Container(
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
                            Padding(
                              padding: const EdgeInsets.only(left: 88.0,right: 8.0),
                              child: Text("Collect Payment On",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                            ),
                          ],
                        ),

                      ),
                    ),
                    type.text=="Class"?   StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection("ClassMaster").doc(classid).collection("Fees").orderBy("timestamp").snapshots(),
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
                                          child: Container(child: Text("00${(index+1).toString()}",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),)),
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
                                        Padding(
                                          padding: const EdgeInsets.only(left: 130.0,right: 8.0),
                                          child: Text(value["paytype"].toString(),style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                        ),

                                        InkWell(
                                          onTap: (){
                                            deleteClassFees(classid,value.id);
                                            //deletestudent(value.id);
                                          },
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.only(left: 15.0),
                                              child: Container(
                                                  width: 30,
                                                  child: Image.asset("assets/delete.png"))
                                          ),
                                        ),
                                      ],
                                    ),

                                  ),
                                );
                              });
                        }):
                    type.text=="Student"? StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection("Students").doc(studentid).collection("Fees").snapshots(),
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
                                          child: Container(child: Text("00${(index+1).toString()}",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),)),
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
                                        Padding(
                                          padding: const EdgeInsets.only(left: 130.0,right: 8.0),
                                          child: Text(value["paytype"].toString(),style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            deleteStudentFees(_typeAheadControllerregno.text,value.id);
                                          },
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.only(left: 15.0),
                                              child: Container(
                                                  width: 30,

                                                  child: Image.asset("assets/delete.png"))
                                          ),
                                        ),
                                      ],
                                    ),


                                  ),
                                );
                              });

                        })
                        : StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection("FeesCollection").snapshots(),
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
                                          child: Container(child: Text("00${(index+1).toString()}",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),)),
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
                                        Padding(
                                          padding: const EdgeInsets.only(left: 130.0,right: 8.0),
                                          child: Text(value["paytype"].toString(),style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            deleteAllFees(value.id.split(":").last);
                                            //deletestudent3(value.id);
                                          },
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.only(left: 15.0),
                                              child: Container(
                                                  width: 30,

                                                  child: Image.asset("assets/delete.png"))
                                          ),
                                        ),
                                      ],
                                    ),

                                  ),
                                );
                              });

                        }),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 300.0),
                      child: Text("Total: ${total}",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),),
                    )


                  ],
                ),

              ),
            ),
          )
        ],
      ),
    );
  }

  double total= 0;

  Future<void> deletestudent(id) async {
    return showDialog<void>(
      context: context,

      builder: (BuildContext context) {

        double width=MediaQuery.of(context).size.width;
        double height=MediaQuery.of(context).size.height;
        return StatefulBuilder(
            builder: (context,setState) {
              return AlertDialog(
                title:  Text('Are you Sure of Deleting Fees',style: GoogleFonts.poppins(
                    color: Colors.black, fontSize:18,fontWeight: FontWeight.w600),),
                content:  Container(
                    width: 350,
                    height: 250,
                    child: Lottie.asset("assets/delete file.json")),
                //child:  Lottie.asset("assets/file choosing.json")),
                actions: <Widget>[
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 7,
                      child: Container(child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.cancel,color: Colors.white,),
                          ),
                          Text("Cancel",style: GoogleFonts.poppins(color:Colors.white),),
                        ],
                      )),
                        width: width/10.507,
                        height: height/20.425,
                        // color:Color(0xff00A0E3),
                        decoration: BoxDecoration(color:  Colors.red,borderRadius: BorderRadius.circular(5)),

                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      FirebaseFirestore.instance.collection("ClassMaster").doc(classid).collection("Fees").doc(id).delete();
                      Navigator.of(context).pop();
                    },

                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 7,
                      child: Container(child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text("Ok",style: GoogleFonts.poppins(color:Colors.white),),
                        ],
                      )),
                        width: width/10.507,
                        height: height/20.425,
                        // color:Color(0xff00A0E3),
                        decoration: BoxDecoration(color:  Colors.green,borderRadius: BorderRadius.circular(5)),

                      ),
                    ),
                  )
                ],
              );
            }
        );
      },
    );
  }
  Future<void> deletestudent2(id) async {
    return showDialog<void>(
      context: context,

      builder: (BuildContext context) {

        double width=MediaQuery.of(context).size.width;
        double height=MediaQuery.of(context).size.height;
        return StatefulBuilder(
            builder: (context,setState) {
              return AlertDialog(
                title:  Text('Are you Sure of Deleting Fees',style: GoogleFonts.poppins(
                    color: Colors.black, fontSize:18,fontWeight: FontWeight.w600),),
                content:  Container(
                    width: 350,
                    height: 250,

                    child: Lottie.asset("assets/delete file.json")),
                //child:  Lottie.asset("assets/file choosing.json")),
                actions: <Widget>[
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 7,
                      child: Container(child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.cancel,color: Colors.white,),
                          ),
                          Text("Cancel",style: GoogleFonts.poppins(color:Colors.white),),
                        ],
                      )),
                        width: width/10.507,
                        height: height/20.425,
                        // color:Color(0xff00A0E3),
                        decoration: BoxDecoration(color:  Colors.red,borderRadius: BorderRadius.circular(5)),

                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      FirebaseFirestore.instance.collection("Students").doc(studentid).collection("Fees").doc(id).delete();
                      Navigator.of(context).pop();
                    },

                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 7,
                      child: Container(child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text("Ok",style: GoogleFonts.poppins(color:Colors.white),),
                        ],
                      )),
                        width: width/10.507,
                        height: height/20.425,
                        // color:Color(0xff00A0E3),
                        decoration: BoxDecoration(color:  Colors.green,borderRadius: BorderRadius.circular(5)),

                      ),
                    ),
                  )
                ],
              );
            }
        );
      },
    );
  }
  Future<void> deletestudent3(id) async {
    return showDialog<void>(
      context: context,

      builder: (BuildContext context) {

        double width=MediaQuery.of(context).size.width;
        double height=MediaQuery.of(context).size.height;
        return StatefulBuilder(
            builder: (context,setState) {
              return AlertDialog(
                title:  Text('Are you Sure of Deleting Fees',style: GoogleFonts.poppins(
                    color: Colors.black, fontSize:18,fontWeight: FontWeight.w600),),
                content:  Container(
                    width: 350,
                    height: 250,

                    child: Lottie.asset("assets/delete file.json")),
                //child:  Lottie.asset("assets/file choosing.json")),
                actions: <Widget>[
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 7,
                      child: Container(child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.cancel,color: Colors.white,),
                          ),
                          Text("Cancel",style: GoogleFonts.poppins(color:Colors.white),),
                        ],
                      )),
                        width: width/10.507,
                        height: height/20.425,
                        // color:Color(0xff00A0E3),
                        decoration: BoxDecoration(color:  Colors.red,borderRadius: BorderRadius.circular(5)),

                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      FirebaseFirestore.instance.collection("Fees").doc(id).delete();
                      Navigator.of(context).pop();
                    },

                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 7,
                      child: Container(child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text("Ok",style: GoogleFonts.poppins(color:Colors.white),),
                        ],
                      )),
                        width: width/10.507,
                        height: height/20.425,
                        // color:Color(0xff00A0E3),
                        decoration: BoxDecoration(color:  Colors.green,borderRadius: BorderRadius.circular(5)),

                      ),
                    ),
                  )
                ],
              );
            }
        );
      },
    );
  }
  gettotal1() async {
    setState(() {
      total=0;
    });
    var document=await FirebaseFirestore.instance.collection("ClassMaster").doc(classid).collection("Fees").get();
    for(int i=0;i<document.docs.length;i++){
      setState(() {
        total=total+document.docs[i]["amount"];
      });
    }
  }
  gettotal2() async {
    setState(() {
      total=0;
    });
    var document=await FirebaseFirestore.instance.collection("Students").doc(studentid).collection("Fees").get();
    for(int i=0;i<document.docs.length;i++){
      setState(() {
        total=total+document.docs[i]["amount"];
      });
    }
  }
}

