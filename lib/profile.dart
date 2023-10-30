import 'dart:html';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:random_string/random_string.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:vidhaan/Dashboard.dart';
import 'package:vidhaan/timetable/classsubjects.dart';
import 'package:vidhaan/timetable/subject.dart';

import 'Masters/desigination.dart';

import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';

import 'Masters/excelgen.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin{
  int page=1;


  TextEditingController name = new TextEditingController();
  TextEditingController name2 = new TextEditingController();
  TextEditingController name3 = new TextEditingController();
  TextEditingController orderno = new TextEditingController();
  TextEditingController orderno2 = new TextEditingController();
  TextEditingController orderno3 = new TextEditingController();


  TextEditingController schoolname = new TextEditingController();
  TextEditingController schoolphone = new TextEditingController();
  TextEditingController schoolweb = new TextEditingController();
  TextEditingController schooladdress = new TextEditingController();
  TextEditingController schoolbuilding = new TextEditingController();
  TextEditingController schoolstreet = new TextEditingController();
  TextEditingController schoolarea = new TextEditingController();
  TextEditingController schoolcity = new TextEditingController();
  TextEditingController schoolstate = new TextEditingController();
  TextEditingController schoolpincode = new TextEditingController();
  TextEditingController solgan = new TextEditingController();


  final check = List<bool>.generate(1000, (int index) => false, growable: true);

  getorderno() async {
    var document = await  FirebaseFirestore.instance.collection("ClassMaster").get();
    setState(() {
      orderno.text="00${document.docs.length+1}";
    });
    var document2 = await  FirebaseFirestore.instance.collection("SectionMaster").get();
    setState(() {
      orderno2.text="00${document2.docs.length+1}";
    });
    var document3 = await  FirebaseFirestore.instance.collection("AcademicMaster").get();
    setState(() {
      orderno3.text="00${document3.docs.length+1}";
    });

  }

  addclass(){
    FirebaseFirestore.instance.collection("ClassMaster").doc().set({
      "name": name.text,
      "order": int.parse(orderno.text),
    });
  }
  addclass2() async {
    FirebaseFirestore.instance.collection("SectionMaster").doc().set({
      "name": name2.text,
      "order": int.parse(orderno2.text),
    });
    var document = await FirebaseFirestore.instance.collection("ClassMaster").get();
    for(int i=0;i<document.docs.length;i++) {
      FirebaseFirestore.instance.collection("Attendance").doc("${document.docs[i]["name"]}${name2.text}").set({
        "name": "${document.docs[i]["name"]}${name2.text}",
      });
    }
  }
  addclass3(){
    FirebaseFirestore.instance.collection("AcademicMaster").doc().set({
      "name": name3.text,
      "order": int.parse(orderno3.text),
    });
  }

  Successdialog(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Class Added Successfully',
      desc: 'Class - ${name.text} is been added',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {
        name.clear();
        orderno.clear();
        getorderno();

      },
    )..show();
  }
  Successdialogd(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Are you sure of save the Design',
      btnCancelText: "Edit",

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {


      },
    )..show();
  }
  Successdialog2(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Section Added Successfully',
      desc: 'Section - ${name2.text} is been added',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {
        name2.clear();
        orderno2.clear();
        getorderno();

      },
    )..show();
  }
  Successdialog3(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Academic Year Added Successfully',
      desc: 'Academic Year - ${name3.text} is been added',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {
        name3.clear();
        orderno3.clear();
        getorderno();

      },
    )..show();
  }


  bool search= false;
  bool byclass = false;

  bool viewtem = false;

  bool mainconcent= false;
  final deletecheck = List<bool>.generate(1000, (int index) => false, growable: true);
  final deletecheck2 = List<bool>.generate(1000, (int index) => false, growable: true);
  final deletecheck3 = List<bool>.generate(1000, (int index) => false, growable: true);
  final deletecheck4 = List<bool>.generate(1000, (int index) => false, growable: true);
  final expand = List<bool>.generate(1000, (int index) => false, growable: true);
// create some values
  Color pickerColor = Color(0xff00A0E3);
  Color currentColor = Color(0xff00A0E3);

  Color pickerColor2 = Color(0xff90C01F);
  Color currentColor2 = Color(0xff90C01F);

  Color pickerColor3 = Color(0xffD62F5E);
  Color currentColor3 = Color(0xffD62F5E);


  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }
  void changeColor2(Color color) {
    setState(() => pickerColor2 = color);
  }
  void changeColor3(Color color) {
    setState(() => pickerColor3 = color);
  }

  setdatas() async {
    var document = await FirebaseFirestore.instance.collection("Admin").get();
    setState(() {
      imgUrl=document.docs[0]["logo"];
      schoolname.text=document.docs[0]["schoolname"];
      schoolphone.text=document.docs[0]["phone"];
      solgan.text=document.docs[0]["solgan"];
      schoolarea.text=document.docs[0]["area"];
      schoolbuilding.text=document.docs[0]["buildingno"];
      schoolcity.text=document.docs[0]["city"];
      schoolpincode.text=document.docs[0]["pincode"];
      schoolstate.text=document.docs[0]["state"];
      schoolstreet.text=document.docs[0]["street"];
      schoolweb.text=document.docs[0]["web"];
      design=document.docs[0]["idcard"];
    });
  }
  TabController? _controller;
  @override
  void initState() {
    _controller = new TabController(length: 6, vsync: this);
    getorderno();
    setdatas();
    // TODO: implement initState
    super.initState();
  }
  int design=1;
  int index=0;
  String rollno="";
  Future<void> deletestudent(coll,id) async {
    return showDialog<void>(
      context: context,

      builder: (BuildContext context) {

        double width=MediaQuery.of(context).size.width;
        double height=MediaQuery.of(context).size.height;
        return StatefulBuilder(
            builder: (context,setState) {
              return AlertDialog(
                title:  Text('Are you Sure of Deleting',style: GoogleFonts.poppins(
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
                      FirebaseFirestore.instance.collection(coll).doc(id).delete();
                      getorderno();
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
  bool selectfile=false;
  String studentid = "";
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body:



          Stack(

            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0,top:30),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: width/1.050,
                    height: height/1.012,
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 38.0,top: 30),
                              child: Text("School Profile",style: GoogleFonts.poppins(fontSize: 20,fontWeight:FontWeight.w700),),
                            ),
                            SizedBox(
                                width:900
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top:30.0,left:20),
                              child: InkWell(
                                onTap: (){

                                   admin();
                                   _bulkuploadstudent();

                                },
                                child: Container(child: Center(child: Text("Update Profile",style: GoogleFonts.poppins(color:Colors.white),)),
                                  width: width/10.507,
                                  height: height/16.425,
                                  // color:Color(0xff00A0E3),
                                  decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        TabBar(
                          indicatorPadding: EdgeInsets.only(),
                          indicatorColor:const Color(0xff00A0E3),
                          unselectedLabelColor: Colors.black,
                          labelColor: Color(0xff00A0E3),
                          controller: _controller,
                          indicator:   MaterialIndicator(
                            horizontalPadding: 5,
                            color: const Color(0xff00A0E3),
                            height:height/138,
                            paintingStyle: PaintingStyle.fill,
                          ),
                          isScrollable: true,
                          onTap: (int val) => setState(() => index = val),
                          tabs: [

                            Tab(
                                child: Container(

                                  child: Text("School Details",
                                    style: GoogleFonts.poppins(
                                        fontSize:20),),
                                )
                            ),
                            Tab(
                                child: Container(

                                  child: Text("Classes",
                                    style: GoogleFonts.poppins(
                                        fontSize:20),),
                                )
                            ),
                            Tab(
                                child: Container(

                                  child: Text("Bulk Upload",
                                    style: GoogleFonts.poppins(
                                        fontSize:20),),
                                )
                            ),
                            Tab(
                                child: Container(

                                  child: Text("Subjects",
                                    style: GoogleFonts.poppins(
                                        fontSize:20),),
                                )
                            ),
                            Tab(
                                child: Container(

                                  child: Text("Fees",
                                    style: GoogleFonts.poppins(
                                        fontSize:20),),
                                )
                            ),
                            Tab(
                                child: Container(

                                  child: Text("Designation",
                                    style: GoogleFonts.poppins(
                                        fontSize:20),),
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

      Padding(
        padding: const EdgeInsets.only(top:168.0),
        child: TabBarView(
            controller: _controller,
          physics: NeverScrollableScrollPhysics(),

            children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0,right:45),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: width/1.050,
                  height: height/1.512,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(100),
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    isloading=true;
                                  });
                                  uploadToStorage();
                                },
                                child: Container(
                                    width: 170,
                                    height: 170,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100)
                                    ),
                                    child: isloading==false?
                                    imgUrl==""?

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.camera_alt_rounded,size: 50,),
                                        Text("Select Logo",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),)
                                      ],
                                    ) : Image.network(imgUrl): Center(
                                      child: CircularProgressIndicator(),
                                    )
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 20,),


                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:28.0,left: 10),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("School Name *",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: schoolname,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
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
                                      child: Text("School Phone Number *",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: schoolphone,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
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
                                      child: Text("School Slogan ",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: solgan,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:28.0,left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Building No: *",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: schoolbuilding,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,
                                        ),
                                      ),

                                        width: width/7.106,
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
                                      child: Text("Street Name : *",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: schoolstreet,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,
                                        ),
                                      ),

                                        width: width/7.106,
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
                                      child: Text("Area : *",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: schoolarea,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,
                                        ),
                                      ),

                                        width: width/7.106,
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
                                      child: Text("City /District : *",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: schoolcity,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,
                                        ),
                                      ),

                                        width: width/7.106,
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
                            padding: const EdgeInsets.only(top:28.0,left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("State: *",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: schoolstate,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
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
                                      child: Text("Pincode : *",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: schoolpincode,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
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
                                      child: Text("Website : *",style: GoogleFonts.poppins(fontSize: 15,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: schoolweb,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:10.0,top:58),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isloading2=true;
                                    });
                                    uploadToStorage2();
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(10),
                                    dashPattern: [5,5],
                                    color: Color(0xff00A0E3),
                                    strokeWidth:2, child: Container(
                                      width:width/6.22,
                                      height:height/8.69,
                                      child:Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height:height/104.3,),
                                          imgUrl2==""? Icon(Icons.photo_library_outlined,color:Color(0xff00A0E3),size: width/46.65,): Icon(Icons.cloud_done_rounded,color:Color(0xff00A0E3),size: width/46.65,),
                                          SizedBox(height:height/104.3,),

                                          imgUrl2==""? Text('Select the Principal Sign to Upload',
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,
                                                  fontSize:width/124.4,color: Color(0xff00A0E3))) :

                                          Text('File Selected',
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,
                                                  fontSize:width/124.4,color: Color(0xff00A0E3)))

                                        ],)
                                  ),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isloading3=true;
                                    });
                                    uploadToStorage3();
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(10),
                                    dashPattern: [5,5],
                                    color: Color(0xff00A0E3),
                                    strokeWidth:2, child: Container(
                                      width:width/6.22,
                                      height:height/8.69,
                                      child:Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height:height/104.3,),
                                          imgUrl3==""? Icon(Icons.photo_library_outlined,color:Color(0xff00A0E3),size: width/46.65,): Icon(Icons.cloud_done_rounded,color:Color(0xff00A0E3),size: width/46.65,),
                                          SizedBox(height:height/104.3,),

                                          imgUrl3==""? Text('Select the School Seal to Upload',
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,
                                                  fontSize:width/124.4,color: Color(0xff00A0E3))) :

                                          Text('File Selected',
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,
                                                  fontSize:width/124.4,color: Color(0xff00A0E3)))

                                        ],)
                                  ),
                                  ),
                                ),


                              ],
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(

              child: Padding(
                padding: const EdgeInsets.only(left:20,right:45),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: width/1.050,
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 5.0,top: 20),
                          child: Container(
                            width: width/3.650,

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
                                            child: Text("Order Si.No",style: GoogleFonts.poppins(fontSize: 15,)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0.0,right: 10),
                                            child: Container(
                                              child: TextField(
                                                controller: orderno,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15
                                                ),
                                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                              width: width/10.902,
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
                                            child: Text("Class",style: GoogleFonts.poppins(fontSize: 15,)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0.0,right: 10),
                                            child: Container(child: TextField(
                                              controller: name,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15
                                              ),
                                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                              width: width/10.902,
                                              height: height/16.425,
                                              //color: Color(0xffDDDEEE),
                                              decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

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
                                          width: width/15.507,
                                          height: height/16.425,
                                          // color:Color(0xff00A0E3),
                                          decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

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

                                    decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 20.0),
                                          child: Text("Order Si.no",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                          child: Text("Class",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                        ),
                                      ],
                                    ),

                                  ),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("ClassMaster").orderBy("order").snapshots(),

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
                                          itemBuilder: (context,index){
                                            var value = snapshot.data!.docs[index];
                                            return  MouseRegion(
                                              onEnter: (_){
                                                setState(() {
                                                  deletecheck[index]=true;
                                                });
                                              },
                                              onExit: (_){
                                                setState(() {
                                                  deletecheck[index]=false;
                                                });
                                              },
                                              child: Padding(
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
                                                        child: Text("00${value["order"].toString()}",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                        child: Container(
                                                            width:150,
                                                            child: Text(value["name"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),)),
                                                      ),
                                                      deletecheck[index]==true?     InkWell(
                                                        onTap: (){
                                                          deletestudent("ClassMaster",value.id);
                                                        },
                                                        child: Padding(
                                                            padding:
                                                            const EdgeInsets.only(left: 15.0),
                                                            child: Container(
                                                                width: 30,

                                                                child: Image.asset("assets/delete.png"))
                                                        ),
                                                      ) : Container()
                                                    ],
                                                  ),

                                                ),
                                              ),
                                            );
                                          });

                                    }),


                              ],
                            ),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0,top: 20),
                          child: Container(
                            width: width/3.650,
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
                                            child: Text("Order Si.No",style: GoogleFonts.poppins(fontSize: 15,)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0.0,right: 10),
                                            child: Container(
                                              child: TextField(
                                                controller: orderno2,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15
                                                ),
                                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                              width: width/10.902,
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
                                            child: Text("Section",style: GoogleFonts.poppins(fontSize: 15,)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0.0,right: 10),
                                            child: Container(child: TextField(
                                              controller: name2,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15
                                              ),
                                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                              width: width/10.902,
                                              height: height/16.425,
                                              //color: Color(0xffDDDEEE),
                                              decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                            ),
                                          ),

                                        ],

                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          addclass2();
                                          Successdialog2();
                                        },
                                        child: Container(child: Center(child: Text("Save",style: GoogleFonts.poppins(color:Colors.white),)),
                                          width: width/15.507,
                                          height: height/16.425,
                                          // color:Color(0xff00A0E3),
                                          decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

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

                                    decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 20.0),
                                          child: Text("Order Si.no",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                          child: Text("Section",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                        ),

                                      ],
                                    ),

                                  ),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("SectionMaster").orderBy("order").snapshots(),

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
                                          itemBuilder: (context,index){
                                            var value = snapshot.data!.docs[index];
                                            return  MouseRegion(
                                              onEnter: (_){
                                                setState(() {
                                                  deletecheck2[index]=true;
                                                });
                                              },
                                              onExit: (_){
                                                setState(() {
                                                  deletecheck2[index]=false;
                                                });
                                              },
                                              child: Padding(
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
                                                        child: Text("00${value["order"].toString()}",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                        child: Container(width:150,child: Text(value["name"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),)),
                                                      ),
                                                      deletecheck2[index]==true?     InkWell(
                                                        onTap: (){
                                                          deletestudent("SectionMaster",value.id);
                                                        },
                                                        child: Padding(
                                                            padding:
                                                            const EdgeInsets.only(left: 15.0),
                                                            child: Container(
                                                                width: 30,

                                                                child: Image.asset("assets/delete.png"))
                                                        ),
                                                      ) : Container()
                                                    ],
                                                  ),

                                                ),
                                              ),
                                            );
                                          });

                                    }),


                              ],
                            ),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0,top: 20),
                          child: Container(
                            width: width/3.650,
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
                                            child: Text("Order Si.No",style: GoogleFonts.poppins(fontSize: 15,)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0.0,right: 10),
                                            child: Container(
                                              child: TextField(
                                                controller: orderno3,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15
                                                ),
                                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                              width: width/10.902,
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
                                            child: Text("Academic Year",style: GoogleFonts.poppins(fontSize: 15,)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0.0,right: 10),
                                            child: Container(child: TextField(
                                              controller: name3,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15
                                              ),
                                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                              width: width/10.902,
                                              height: height/16.425,
                                              //color: Color(0xffDDDEEE),
                                              decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                            ),
                                          ),

                                        ],

                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          addclass3();
                                          Successdialog3();
                                        },
                                        child: Container(child: Center(child: Text("Save",style: GoogleFonts.poppins(color:Colors.white),)),
                                          width: width/15.507,
                                          height: height/16.425,
                                          // color:Color(0xff00A0E3),
                                          decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

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

                                    decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 20.0),
                                          child: Text("Order Si.no",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                          child: Text("Academic Year",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                        ),
                                      ],
                                    ),

                                  ),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("AcademicMaster").orderBy("order").snapshots(),

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
                                          itemBuilder: (context,index){
                                            var value = snapshot.data!.docs[index];
                                            return  MouseRegion(
                                              onEnter: (_){
                                                setState(() {
                                                  deletecheck3[index]=true;
                                                });
                                              },
                                              onExit: (_){
                                                setState(() {
                                                  deletecheck3[index]=false;
                                                });
                                              },
                                              child: Padding(
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
                                                        child: Text("00${value["order"].toString()}",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                        child: Container(width:110,child: Text(value["name"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),)),
                                                      ),
                                                      deletecheck3[index]==true?     InkWell(
                                                        onTap: (){
                                                          deletestudent("AcademicMaster",value.id);
                                                        },
                                                        child: Padding(
                                                            padding:
                                                            const EdgeInsets.only(left: 15.0),
                                                            child: Container(
                                                                width: 30,

                                                                child: Image.asset("assets/delete.png"))
                                                        ),
                                                      ) : Container()
                                                    ],
                                                  ),

                                                ),
                                              ),
                                            );
                                          });

                                    }),


                              ],
                            ),

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right:45.0,left:20),
              child: ClassSubjects(),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left:20),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: width/1.050,
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 20.0,top: 20),
                          child: Container(
                            width: width/1.550,
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
                                            child: Text("Order Si.No",style: GoogleFonts.poppins(fontSize: 15,)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0.0,right: 25),
                                            child: Container(child: TextField(
                                              controller: orderno,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15
                                              ),
                                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                              width: width/4.102,
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
                                            child: Text("Fees",style: GoogleFonts.poppins(fontSize: 15,)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0.0,right: 25),
                                            child: Container(
                                              child: TextField(
                                                controller: name,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15
                                                ),
                                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                              width: width/4.102,
                                              height: height/16.425,
                                              //color: Color(0xffDDDEEE),
                                              decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

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
                                          decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: height/13.14,
                                    width: width/1.550,

                                    decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 20.0),
                                          child: Text("Order Si.no",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                          child: Text("Fee Name",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                        ),
                                      ],
                                    ),

                                  ),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("FeesMaster").orderBy("order").snapshots(),

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
                                          itemBuilder: (context,index){
                                            var value = snapshot.data!.docs[index];
                                            return  MouseRegion(
                                              onEnter: (_){
                                                setState(() {
                                                  deletecheck4[index]=true;
                                                });
                                              },
                                              onExit: (_){
                                                setState(() {
                                                  deletecheck4[index]=false;
                                                });
                                              },

                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: height/ 21.9,
                                                  width: width/1.550,

                                                  decoration: BoxDecoration(color:Colors.white60,borderRadius: BorderRadius.circular(12)

                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 30.0,right: 70.0),
                                                        child: Text("${(index+1).toString().padLeft(3,"0")}",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                        child: Text(value["name"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                                      ),
                                                      deletecheck4[index]==true?     InkWell(
                                                        onTap: (){
                                                          deletestudent("FeesMaster",value.id);
                                                        },
                                                        child: Padding(
                                                            padding:
                                                            const EdgeInsets.only(left: 15.0),
                                                            child: Container(
                                                                width: 30,

                                                                child: Image.asset("assets/delete.png"))
                                                        ),
                                                      ) : Container()
                                                    ],
                                                  ),

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
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right:25.0),
              child: Desigination(),
            )
        ],
        ),
      ),


            ],
          ),

    );
  }

  String imgUrl="";
  String imgUrl2="";
  String imgUrl3="";
  bool isloading=false;
  bool isloading2=false;
  bool isloading3=false;
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
          isloading= false;

        });

        print(imgUrl);
      });
    });




  }
  uploadToStorage2() async{

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
          imgUrl2 = downloadUrl;
          isloading2= false;

        });

        print(imgUrl2);
      });
    });




  }
  uploadToStorage3() async{

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
          imgUrl3 = downloadUrl;
          isloading3= false;

        });

        print(imgUrl3);
      });
    });




  }


  admin(){
    FirebaseFirestore.instance.collection("Admin").doc("AbeOpc23Rx9Z6n4fxIVw").set({
      "schoolname":schoolname.text,
      "solgan":solgan.text,
      "phone":schoolphone.text,
      "buildingno":schoolbuilding.text,
      "street":schoolstreet.text,
      "area":schoolarea.text,
      "city":schoolcity.text,
      "state":schoolstate.text,
      "pincode":schoolpincode.text,
      "idcard":design,
      "logo":imgUrl,
      "logo2":imgUrl2,
      "web":schoolweb.text,
    });
  }
  Future<void> _bulkuploadstudent() async {
    return showDialog<void>(
      context: context,

      builder: (BuildContext context) {
        double width=MediaQuery.of(context).size.width;
        double height=MediaQuery.of(context).size.height;
        return StatefulBuilder(
            builder: (context,setState) {
              return AlertDialog(
                title:  Text('Profile Updated Sucessfully',style: GoogleFonts.poppins(
                    color: Colors.black, fontSize:18,fontWeight: FontWeight.w600),),
                content:  Container(
                    width: 350,
                    height: 250,

                    child:  Lottie.asset("assets/uploaded.json")
                ),
                actions: [
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Dashboard()));
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
}



class BulkUploadfunction extends StatefulWidget {
  const BulkUploadfunction({Key? key}) : super(key: key);

  @override
  State<BulkUploadfunction> createState() => _BulkUploadfunctionState();
}

class _BulkUploadfunctionState extends State<BulkUploadfunction> {
  bool selectfile=false;
  String studentid = "";
  String rollno="";
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Container(
        child: Row(
          children: [
            SizedBox(width:150),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Download the sample template here",style: GoogleFonts.poppins(
                      color: Colors.black, fontSize:18,fontWeight: FontWeight.w600),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Templatedown(),
                ),
              ],
            ),
            Column(
      children: [
            SizedBox(height:20),
            Text(selectfile==false?'Bulk Upload Students': "Your File is Uploaded to Database",style: GoogleFonts.poppins(
                color: Colors.black, fontSize:18,fontWeight: FontWeight.w600),),

            Container(
                width: 400,
                height: 350,

                child: selectfile==false? Lottie.asset("assets/file choosing.json"):Lottie.asset("assets/uploaded.json",repeat: false)),
            selectfile==false?  InkWell(
              onTap: () async {

                FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['xlsx'],
                  allowMultiple: false,
                );


                var bytes = pickedFile!.files.single.bytes;
                var excel = Excel.decodeBytes(bytes!);


                final row = excel.tables[excel.tables.keys.first]!.rows
                    .map((e) => e.map((e) => e!.value).toList()).toList();

                for(int i = 1;i <row.length;i++) {
                  print(row[i][1]);
                  setState(() {
                    studentid=randomAlphaNumeric(16);
                  });
                  var document = await  FirebaseFirestore.instance.collection("Students").where("admitclass",isEqualTo:row[i][0].toString()).where("section",isEqualTo:row[i][1].toString()).get();
                  setState(() {
                    rollno=(document.docs.length +1).toString().padLeft(2,"0");
                  });
                  FirebaseFirestore.instance.collection("Students").doc(studentid).set({
                    "stname": row[i][3].toString(),
                    "stmiddlename": "",
                    "stlastname": "",
                    "regno": "VDSB${i.toString().padLeft(3, '0')}",
                    "studentid": studentid,
                    "rollno":rollno,
                    "entrydate": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                    "admitclass":row[i][0].toString(),
                    "section": row[i][1].toString(),
                    "academic": row[i][2].toString(),
                    "bloodgroup": row[i][4].toString(),
                    "dob": row[i][5].toString(),
                    "gender": row[i][7].toString(),
                    "address": row[i][14].toString(),
                    "community": row[i][8].toString(),
                    "house": row[i][11].toString(),
                    "religion": row[i][10].toString(),
                    "mobile": row[i][12].toString(),
                    "email": row[i][13].toString(),
                    "aadhaarno": row[i][18].toString(),
                    "sheight": row[i][16].toString(),
                    "stweight": row[i][17].toString(),
                    "EMIS": row[i][19].toString(),
                    "transport": row[i][20].toString(),
                    "identificatiolmark": row[i][15].toString(),

                    "fathername": row[i][21].toString(),
                    "fatherOccupation": row[i][22].toString(),
                    "fatherOffice":row[i][23].toString(),
                    "fatherMobile": row[i][25].toString(),
                    "fatherEmail": "",
                    "fatherAadhaar": row[i][26].toString(),

                    "mothername": row[i][27].toString(),
                    "motherOccupation": row[i][28].toString(),
                    "motherOffice":row[i][29].toString(),
                    "motherMobile": row[i][31].toString(),
                    "motherEmail":"",
                    "motherAadhaar": row[i][32].toString(),

                    "guardianname": row[i][36].toString(),
                    "guardianOccupation": row[i][38].toString(),
                    "guardianMobile": row[i][37].toString(),
                    "guardianEmail": "",
                    "guardianAadhaar": "",

                    "brother studying here": row[i][34].toString(),
                    "brothername": "${row[i][33].toString()} - ${row[i][35].toString()}",

                    "imgurl":"",
                    "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                    "time": "${DateTime.now().hour}:${DateTime.now().minute}",
                    "timestamp": DateTime.now().microsecondsSinceEpoch,
                    "absentdays":0,
                    "behaviour":0,
                  });
                  FirebaseFirestore.instance.collection("Classstudents").doc("${row[i][0].toString()}${row[i][1].toString()}").collection("Students").doc(studentid).set({
                    "regno": "VDSB${i.toString().padLeft(3, '0')}",
                    "studentid": studentid,
                    "admitclass": row[i][0].toString(),
                    "section": row[i][1].toString(),
                    "stname": row[i][3].toString(),
                    "absentdays":0,
                    "behaviour":0,
                  });

                }
                setState(() {
                  selectfile=true;
                });


              },
              child: Material(
                borderRadius: BorderRadius.circular(5),
                elevation: 7,
                child: Container(child: Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.file_upload,color: Colors.white,),
                    ),
                    Text("Select Excel",style: GoogleFonts.poppins(color:Colors.white),),
                  ],
                )),
                  width: width/10.507,
                  height: height/20.425,
                  // color:Color(0xff00A0E3),
                  decoration: BoxDecoration(color:  Colors.green,borderRadius: BorderRadius.circular(5)),

                ),
              ),
            ) :
            Container(),
      ],
    ),

          ],
        ));
  }

}
