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
  static final List<String> typeclass = ["Select Option","Class","Student"];
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
        //     ? ''
        //     : paytype.text.toLowerCase() == 'custom' ? date.text : ''
      });
      FirebaseFirestore.instance.collection("ClassMaster").doc(classid).collection("Fees").doc(docId).set({
        "feesname": _typeAheadControllerfees.text,
        "amount": int.parse(amount.text),
        "timestamp": DateTime.now().microsecondsSinceEpoch,
        "paytype": paytype.text,
        "duedate" : paytype.text.toLowerCase() == 'custom' ? date.text : paytype.text.toLowerCase() == 'monthly' ? includingThisMonth == true ? DateTime.now().day <= 5 ? DateFormat("dd/MM/yyyy").parse("05/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}") : DateFormat("dd/MM/yyyy").format(DateTime.now()) : DateFormat("dd/MM/yyyy").format(DateTime.now().add(Duration(days: 31-DateTime.now().day))) :  '-'
      });
    }
    else{
      FirebaseFirestore.instance.collection("ClassMaster").doc(classid).collection("Fees").doc(docId).set({
        "feesname": _typeAheadControllerfees.text,
        "amount": int.parse(amount.text),
        "timestamp": DateTime.now().microsecondsSinceEpoch,
        "paytype": paytype.text,
        "duedate" : paytype.text.toLowerCase() == 'custom' ? date.text : paytype.text.toLowerCase() == 'monthly' ? includingThisMonth == true ? DateTime.now().day <= 5 ? DateFormat("dd/MM/yyyy").parse("05/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}") : DateFormat("dd/MM/yyyy").format(DateTime.now()) : DateFormat("dd/MM/yyyy").format(DateTime.now().add(Duration(days: 31-DateTime.now().day))) :  '-'
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
          "stId" : document.docs[i].id,
          "email" : document.docs[i].get("email"),
          "duedate" : paytype.text.toLowerCase() == 'custom' ? date.text : paytype.text.toLowerCase() == 'monthly' ? includingThisMonth == true ? DateTime.now().day <= 5 ? DateFormat("dd/MM/yyyy").parse("05/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}") : DateFormat("dd/MM/yyyy").format(DateTime.now()) : DateFormat("dd/MM/yyyy").format(DateTime.now().add(Duration(days: 31-DateTime.now().day))) :  '-'
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
          "stId" : document.docs[i].id,
          "duedate" : paytype.text.toLowerCase() == 'custom' ? date.text : paytype.text.toLowerCase() == 'monthly' ? includingThisMonth == true ? DateTime.now().day <= 5 ? DateFormat("dd/MM/yyyy").parse("05/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}") : DateFormat("dd/MM/yyyy").format(DateTime.now()) : DateFormat("dd/MM/yyyy").format(DateTime.now().add(Duration(days: 31-DateTime.now().day))) :  '-'
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
        "stId" : student.id,
        "email" : student.get("email"),
        "duedate": paytype.text.toLowerCase() == 'custom' ? date.text : paytype.text.toLowerCase() == 'monthly' ? includingThisMonth == true ? DateTime.now().day <= 5 ? DateFormat("dd/MM/yyyy").parse("05/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}") : DateFormat("dd/MM/yyyy").format(DateTime.now()) : DateFormat("dd/MM/yyyy").format(DateTime.now().add(Duration(days: 31-DateTime.now().day))) :  '-'
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
        "stId" : student.id,
        "duedate": paytype.text.toLowerCase() == 'custom' ? date.text : paytype.text.toLowerCase() == 'monthly' ? includingThisMonth == true ? DateTime.now().day <= 5 ? DateFormat("dd/MM/yyyy").parse("05/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}") : DateFormat("dd/MM/yyyy").format(DateTime.now()) : DateFormat("dd/MM/yyyy").format(DateTime.now().add(Duration(days: 31-DateTime.now().day))) :  '-'
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
        //     ? ''
        //     : paytype.text.toLowerCase() == 'custom' ? date.text : ''
      });
    }else {
      var document1 = await FirebaseFirestore.instance.collection("ClassMaster").get();

      for(int d = 0; d < document1.docs.length; d++){
        FirebaseFirestore.instance.collection("ClassMaster").doc(document1.docs[d].id).collection("Fees").doc(docId).set({
          "feesname": _typeAheadControllerfees.text,
          "amount": int.parse(amount.text),
          "timestamp": DateTime.now().microsecondsSinceEpoch,
          "paytype": paytype.text,
          "duedate" : paytype.text.toLowerCase() == 'custom' ? date.text : paytype.text.toLowerCase() == 'monthly' ? includingThisMonth == true ? DateTime.now().day <= 5 ? DateFormat("dd/MM/yyyy").parse("05/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}") : DateFormat("dd/MM/yyyy").format(DateTime.now()) : DateFormat("dd/MM/yyyy").format(DateTime.now().add(Duration(days: 31-DateTime.now().day))) :  '-'

        });
      }
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
          "stId" : document.docs[i].id,
          "duedate" : paytype.text.toLowerCase() == 'custom' ? date.text : paytype.text.toLowerCase() == 'monthly' ? includingThisMonth == true ? DateTime.now().day <= 5 ? DateFormat("dd/MM/yyyy").parse("05/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}") : DateFormat("dd/MM/yyyy").format(DateTime.now()) : DateFormat("dd/MM/yyyy").format(DateTime.now().add(Duration(days: 31-DateTime.now().day))) :  '-'
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
          "stId" : document.docs[i].id,
          "duedate" : paytype.text.toLowerCase() == 'custom' ? date.text : paytype.text.toLowerCase() == 'monthly' ? includingThisMonth == true ? DateTime.now().day <= 5 ? DateFormat("dd/MM/yyyy").parse("05/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}") : DateFormat("dd/MM/yyyy").format(DateTime.now()) : DateFormat("dd/MM/yyyy").format(DateTime.now().add(Duration(days: 31-DateTime.now().day))) :  '-'
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
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555556,
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
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555556,
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

  bool includingThisMonth = true;
  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: width/68.3),
            child: Container(width: width/1.050,
              height: height/8.212,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),child: Padding(
              padding: EdgeInsets.only(left: width/35.947368421,top: height/21.7),
              child: Text("Assign Fees Master",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),),
            ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width/68.3,top: height/32.55),
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
                          SizedBox(height: height/65.1),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Assign Fee For :",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700),),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 0.0,right: width/54.64),
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
                                            size: width/85.375,
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
                                      items:
                                      typeclass.map((String item) => DropdownMenuItem<String>(
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
                                        height: height/13.02,
                                        width: width/8.5375,
                                        padding: EdgeInsets.only(left: width/97.571428571, right: width/97.571428571),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),

                                          color: Color(0xffDDDEEE),
                                        ),

                                      ),
                                      iconStyleData: IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                        ),
                                        iconSize: width/97.571428571,
                                        iconEnabledColor: Colors.black,
                                        iconDisabledColor: Colors.grey,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: height/3.255,
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
                                      menuItemStyleData: MenuItemStyleData(
                                        height: height/16.275,
                                        padding: EdgeInsets.only(left: width/97.571428571, right: width/97.571428571),
                                      ),
                                    ),
                                  ),

                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width/136.6,top:height/81.375),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                              type.text=="Class"?  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Select Class *",style: GoogleFonts.poppins(fontSize: width/91.066666667)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 0.0,right: width/54.64),
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
                                                  size: width/85.375,
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
                                            items: classes
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
                                            value:  _typeAheadControllerclass.text,
                                            onChanged: (String? value) {
                                              setState(() {
                                                _typeAheadControllerclass.text = value!;
                                              });
                                              getstaffbyid();

                                            },
                                            buttonStyleData: ButtonStyleData(
                                              height: height/13.02,
                                              width: width/8.5375,
                                              padding: EdgeInsets.only(left: width/97.571428571, right: width/97.571428571),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),

                                                color: Color(0xffDDDEEE),
                                              ),

                                            ),
                                            iconStyleData:  IconStyleData(
                                              icon: Icon(
                                                Icons.arrow_forward_ios_outlined,
                                              ),
                                              iconSize: width/97.571428571,
                                              iconEnabledColor: Colors.black,
                                              iconDisabledColor: Colors.grey,
                                            ),
                                            dropdownStyleData: DropdownStyleData(
                                              maxHeight: height/3.255,
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
                                              height: height/16.275,
                                              padding: EdgeInsets.only(left: width/97.571428571, right: width/97.571428571),
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
                                          child: Text("Register Number *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 0.0,right: width/54.64),
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
                                                  fontSize: width/91.066666667
                                              ),
                                              decoration:  InputDecoration(
                                                contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/81.375),
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
                                          child: Text("Student Name *",style: GoogleFonts.poppins(fontSize: width/91.066666667)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 0.0,right: width/136.6),
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
                                                    fontSize: width/91.066666667
                                                ),
                                                decoration:  InputDecoration(
                                                  contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/81.375),
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
                            child: Text("Select Fees Details",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width/136.6,top:height/81.375),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Fees *",style: GoogleFonts.poppins(fontSize: width/91.066666667)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 0.0,right: width/54.64),
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
                                                  size: width/85.375,
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
                                            items: fees
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
                                            value:  _typeAheadControllerfees.text,
                                            onChanged: (String? value) {
                                              setState(() {
                                                _typeAheadControllerfees.text = value!;
                                              });
                                            },
                                            buttonStyleData: ButtonStyleData(
                                              height: height/13.02,
                                              width: width/8.5375,
                                              padding: EdgeInsets.only(left: width/97.571428571, right: width/97.571428571),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),

                                                color: Color(0xffDDDEEE),
                                              ),

                                            ),
                                            iconStyleData:  IconStyleData(
                                              icon: Icon(
                                                Icons.arrow_forward_ios_outlined,
                                              ),
                                              iconSize: width/97.571428571,
                                              iconEnabledColor: Colors.black,
                                              iconDisabledColor: Colors.grey,
                                            ),
                                            dropdownStyleData: DropdownStyleData(
                                              maxHeight: height/3.255,
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
                                              height: height/16.275,
                                              padding: EdgeInsets.only(left: width/97.571428571, right: width/97.571428571),
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
                                      child: Text("Amount *",style: GoogleFonts.poppins(fontSize: width/91.066666667)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 0.0,right: width/54.64),
                                      child: Container(child: TextFormField(
                                        controller: amount,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot be Empty' : null,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/81.375),
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
                                      child: Text("Collect payment on *",style: GoogleFonts.poppins(fontSize: width/91.066666667)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 0.0,right: width/54.64),
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
                                                  size: width/85.375,
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
                                            items: type.text == 'Student' ? paytypelist1.map((String item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style:  GoogleFonts.poppins(
                                                    fontSize: width/91.066666667
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
                                                    fontSize: width/91.066666667
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
                                                    String formattedDate = DateFormat("dd/MM/yyyy").format(pickedDate);
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
                                              height: height/13.02,
                                              width: width/8.5375,
                                              padding:  EdgeInsets.only(left: width/97.571428571, right: width/97.571428571),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),

                                                color: Color(0xffDDDEEE),
                                              ),

                                            ),
                                            iconStyleData: IconStyleData(
                                              icon: Icon(
                                                Icons.arrow_forward_ios_outlined,
                                              ),
                                              iconSize: width/97.571428571,
                                              iconEnabledColor: Colors.black,
                                              iconDisabledColor: Colors.grey,
                                            ),
                                            dropdownStyleData: DropdownStyleData(
                                              maxHeight: height/3.255,
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
                                            menuItemStyleData: MenuItemStyleData(
                                              height: height/16.275,
                                              padding: EdgeInsets.only(left: width/97.571428571, right: width/97.571428571),
                                            ),
                                          ),
                                        ),

                                      ),
                                    ),

                                  ],

                                ),
                                paytype.text=="Custom"
                                    ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Custom Date *",style: GoogleFonts.poppins(fontSize: width/91.066666667)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 0.0,right: width/54.64),
                                      child: Container(child: TextFormField(
                                        controller: date,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot be Empty' : null,
                                        decoration:  InputDecoration(contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/81.375),
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

                                )
                                    : paytype.text== "Monthly"
                                    ? Row(
                                  children: [
                                    Checkbox(
                                        value: includingThisMonth,
                                        onChanged: (val){
                                          setState(() {
                                            includingThisMonth = val!;
                                          });
                                        },
                                    ),
                                    SizedBox(width: width/136.6),
                                    Text("Including this month",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                  ],
                                )
                                    : Container(),
                                SizedBox(width: width/136.6),
                                GestureDetector(
                                  onTap: (){
                                    print("fkjsidhfakshdf");
                                    final isvalid= _formkey.currentState!.validate();
                                    print(isvalid);
                                    if(_typeAheadControllerfees.text!="Select Option"&&paytype.text!="Select Option") {
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
                              padding: EdgeInsets.only(left: width/170.75,right: width/68.3),
                              child: Text("Order Si.no",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width/20.696969697,right: width/170.75),
                              child: Text("Fees",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width/15.522727273,right: width/170.75),
                              child: Text("Amount",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width/15.522727273,right: width/170.75),
                              child: Text("Payment Type",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: width/15.522727273,right: width/170.75),
                              child: Text("Due Date",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                            ),
                          ],
                        ),

                      ),
                    ),
                    type.text=="Class"
                        ? StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection("ClassMaster").doc(classid).collection("Fees").orderBy("timestamp").snapshots(),
                        builder: (context,snapshot){
                          if(!snapshot.hasData)
                          {
                            return   const Center(
                              child:  CircularProgressIndicator(),
                            );
                          }
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
                                          padding: EdgeInsets.only(left: width/45.533333333,right: width/22.766666667),
                                          child: Container(child: Text("00${(index+1).toString()}",style: GoogleFonts.poppins(
                                              fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),)),
                                        ),
                                        Container(
                                            width: width/9.106666667,
                                            alignment: Alignment.center,
                                            child: Text(value["feesname"],style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),)),
                                        Container(
                                            width:width/6.83,
                                            alignment: Alignment.center,
                                            child: Text(value["amount"].toString(),style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),)),
                                        Container(
                                            width:width/9.106666667,
                                            alignment: Alignment.center,
                                            child: Text(value["paytype"].toString(),style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),)),
                                        Padding(
                                          padding: EdgeInsets.only(left: width/17.075,right: width/170.75),
                                          child: Text(value["duedate"].toString(),style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),),
                                        ),

                                        InkWell(
                                          onTap: (){
                                            deleteClassFees(classid,value.id);
                                            //deletestudent(value.id);
                                          },
                                          child: Padding(
                                              padding:
                                               EdgeInsets.only(left: width/91.066666667),
                                              child: Container(
                                                  width: width/45.533333333,
                                                  child: Image.asset("assets/delete.png"))
                                          ),
                                        ),
                                      ],
                                    ),

                                  ),
                                );
                              });
                        },
                    )
                        : type.text=="Student"
                        ? StreamBuilder<QuerySnapshot>(
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
                                          padding: EdgeInsets.only(left: width/45.533333333,right: width/19.514285714),
                                          child: Container(child: Text("00${(index+1).toString()}",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),)),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left: width/170.75,right: width/170.75),
                                          child: Container(
                                              width: width/8.035294118,

                                              child: Text(value["feesname"],style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: width/170.75,right: width/170.75),
                                          child: Text(value["amount"].toString(),style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: width/10.507692308,right: width/170.75),
                                          child: Text(value["paytype"].toString(),style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: width/10.507692308,right: width/170.75),
                                          child: Text(value["duedate"].toString(),style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            deleteStudentFees(_typeAheadControllerregno.text,value.id);
                                          },
                                          child: Padding(
                                              padding:
                                              EdgeInsets.only(left: width/91.066666667),
                                              child: Container(
                                                  width: width/45.533333333,

                                                  child: Image.asset("assets/delete.png"))
                                          ),
                                        ),
                                      ],
                                    ),


                                  ),
                                );
                              });

                        })
                        : FutureBuilder<List<DocumentSnapshot>>(
                        //future: FirebaseFirestore.instance.collection("FeesCollection").snapshots(),
                        future: getGeneralFeeses(),
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
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context,index){
                                var value = snapshot.data![index];
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
                                          padding:  EdgeInsets.only(left: width/45.533333333,right: width/19.514285714),
                                          child: Container(child: Text("00${(index+1).toString()}",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: width/170.75,right: width/170.75),
                                          child: Container(
                                              width: width/8.035294118,

                                              child: Text(value["feesname"],style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: width/170.75,right: width/170.75),
                                          child: Text(value["amount"].toString(),style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: width/10.507692308,right: width/170.75),
                                          child: Text(value["paytype"].toString(),style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            //deleteAllFees(value.id.split(":").last);
                                            //deletestudent3(value.id);
                                          },
                                          child: Padding(
                                              padding: EdgeInsets.only(left: width/91.066666667),
                                              child: Container(
                                                  width: width/45.533333333,

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
                      padding:  EdgeInsets.only(left: width/4.553333333),
                      child: Text("Total: ${total}",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.w600,color: Colors.black),),
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


  Future<List<DocumentSnapshot<Object?>>> getGeneralFeeses() async {
    List<DocumentSnapshot> result = [];
    List<String> result1 = [];

    var document = await  FirebaseFirestore.instance.collection("ClassMaster").get();

    for(int i = 0; i < document.docs.length; i++){
      var document1 = await  FirebaseFirestore.instance.collection("ClassMaster").doc(document.docs[i].id).collection('Fees').get();
      for(int j = 0; j < document1.docs.length; j++){
        if(!result1.contains(document1.docs[j].id)){
          result1.add(document1.docs[j].id);
        }
      }
    }
    return result;
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
                    color: Colors.black, fontSize:width/75.888888889,fontWeight: FontWeight.w600),),
                content:  Container(
                    width: width/3.902857143,
                    height: height/2.604,
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
                            padding:  EdgeInsets.only(right: width/170.75),
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
                    color: Colors.black, fontSize:width/75.888888889,fontWeight: FontWeight.w600),),
                content:  Container(
                    width: width/3.902857143,
                    height: height/2.604,

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
                            padding:  EdgeInsets.only(right: width/170.75),
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
                    color: Colors.black, fontSize:width/75.888888889,fontWeight: FontWeight.w600),),
                content:  Container(
                    width: width/3.902857143,
                    height: height/2.604,

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
                            padding: EdgeInsets.only(right: width/170.75),
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
    if(type.text == "Class") {
      setState(() {
        total = 0;
      });
      var document = await FirebaseFirestore.instance.collection("ClassMaster")
          .doc(classid).collection("Fees")
          .get();
      for (int i = 0; i < document.docs.length; i++) {
        setState(() {
          total = total + document.docs[i]["amount"];
        });
      }
    }
  }
  gettotal2() async {
    if(type.text == "Student") {
      setState(() {
        total = 0;
      });
      var document = await FirebaseFirestore.instance.collection("Students")
          .doc(studentid).collection("Fees")
          .get();
      for (int i = 0; i < document.docs.length; i++) {
        setState(() {
          total = total + document.docs[i]["amount"];
        });
      }
    }
  }

  gettotal3() async {
    setState(() {
      total=0;
    });
    var document=await FirebaseFirestore.instance.collection("FeesCollection").get();
    for(int i=0;i<document.docs.length;i++){
      setState(() {
        total=total+document.docs[i]["amount"];
      });
    }
  }
}

