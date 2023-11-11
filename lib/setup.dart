import 'dart:html';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:vidhaan/Dashboard.dart';

class Setup extends StatefulWidget {
  const Setup({Key? key}) : super(key: key);

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {

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

  @override
  void initState() {
    getorderno();
    // TODO: implement initState
    super.initState();
  }
  int design=1;
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
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0,top:50),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: width/1.050,
                  height: height/8.212,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 38.0,top: 30),
                        child: Text("School Setup",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(
                        width:    page!=1? 800:900
                      ),
                  page!=1?   Padding(
                        padding: const EdgeInsets.only(top:30.0),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              page=page-1;
                            });
                          },
                          child: Container(child: Center(child: Text("Previous ",style: GoogleFonts.poppins(color:Colors.white),)),
                            width: width/10.507,
                            height: height/16.425,
                            // color:Color(0xff00A0E3),
                            decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                          ),
                        ),
                      ) : Container(),
                      Padding(
                        padding: const EdgeInsets.only(top:30.0,left:20),
                        child: InkWell(
                          onTap: (){
                            if(page!=4) {
                              setState(() {
                                page = page + 1;
                              });
                            }
                            else{
                              admin();
                              _bulkuploadstudent();
                            }
                          },
                          child: Container(child: Center(child: Text(page==4? "Finish":"Next",style: GoogleFonts.poppins(color:Colors.white),)),
                            width: width/10.507,
                            height: height/16.425,
                            // color:Color(0xff00A0E3),
                            decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
           page==1? Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width:  width/0.950,
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
                                  Text("Select Logo",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),)
                                    ],
                                  ) : Image.network(imgUrl): Center(
                                    child: CircularProgressIndicator(),
                                  )
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 20,),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Container(
                              width: 200,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                    Color(0xff00A0E3)

                                ),

                                child:ListTile(

                                  title: Row(
                                    children: [
                                      Icon(Icons.account_circle_outlined,color: Colors.white,),
                                      SizedBox(width: 10,),
                                      Text("School Details",style: GoogleFonts.poppins(color: Colors.white,),),
                                    ],
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Container(
                              width: 200,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),


                                ),

                                child:ListTile(

                                  title: Row(
                                    children: [
                                      Icon(Icons.room_preferences_sharp,color: Color(0xff00A0E3),),
                                      SizedBox(width: 10,),
                                      Text("Class & Sections",style: GoogleFonts.poppins(color: Color(0xff00A0E3),),),
                                    ],
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Container(
                              width: 200,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),

                                ),

                                child:ListTile(

                                  title: Row(
                                    children: [
                                      Icon(Icons.menu_book,color: Color(0xff00A0E3),),
                                      SizedBox(width: 10,),
                                      Text("ID Card",style: GoogleFonts.poppins(color: Color(0xff00A0E3),),),
                                    ],
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Container(
                              width: 200,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),



                                ),

                                child:ListTile(

                                  title: Row(
                                    children: [
                                      Icon(Icons.attach_money,color: Color(0xff00A0E3),),
                                      SizedBox(width: 10,),
                                      Text("Fees",style: GoogleFonts.poppins(color: Color(0xff00A0E3),),),
                                    ],
                                  ),
                                )),
                          ),
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
                                      child: Text("School Name *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                       controller: schoolname,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                                      child: Text("School Phone Number *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                      controller: schoolphone,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                                      child: Text("School Slogan ",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                      controller: solgan,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                                      child: Text("Building No: *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                      controller: schoolbuilding,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                                      child: Text("Street Name : *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                      controller: schoolstreet,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                                      child: Text("Area : *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                      controller: schoolarea,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                                      child: Text("City /District : *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                      controller: schoolcity,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                                      child: Text("State: *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                      controller: schoolstate,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                                      child: Text("Pincode : *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                      controller: schoolpincode,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                                      child: Text("Website : *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                      controller: schoolweb,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
            ) :
           page==2?  SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child: Padding(
               padding: const EdgeInsets.only(left:20),
               child: Material(
                 elevation: 5,
                 borderRadius: BorderRadius.circular(12),
                 child: Container(
                   width: width/0.950,
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
                                         Text("Select Logo",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),)
                                       ],
                                     ) : Image.network(imgUrl): Center(
                                       child: CircularProgressIndicator(),
                                     )
                                 ),
                               ),
                             ),
                           ),

                           SizedBox(height: 20,),

                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 6),
                             child: Container(
                                 width: 200,
                                 height: 50,
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),


                                 ),

                                 child:ListTile(

                                   title: Row(
                                     children: [
                                       Icon(Icons.account_circle_outlined,color: Color(0xff00A0E3)),
                                       SizedBox(width: 10,),
                                       Text("School Details",style: GoogleFonts.poppins(color:  Color(0xff00A0E3)),),
                                     ],
                                   ),
                                 )),
                           ),
                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 6),
                             child: Container(
                                 width: 200,
                                 height: 50,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),
                                     color:
                                     Color(0xff00A0E3)

                                 ),

                                 child:ListTile(

                                   title: Row(
                                     children: [
                                       Icon(Icons.room_preferences_sharp,color: Colors.white,),
                                       SizedBox(width: 10,),
                                       Text("Class & Sections",style: GoogleFonts.poppins(color: Colors.white,),),
                                     ],
                                   ),
                                 )),
                           ),
                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 6),
                             child: Container(
                                 width: 200,
                                 height: 50,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),

                                 ),

                                 child:ListTile(

                                   title: Row(
                                     children: [
                                       Icon(Icons.menu_book,color: Color(0xff00A0E3),),
                                       SizedBox(width: 10,),
                                       Text("ID Card",style: GoogleFonts.poppins(color: Color(0xff00A0E3),),),
                                     ],
                                   ),
                                 )),
                           ),
                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 6),
                             child: Container(
                                 width: 200,
                                 height: 50,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),



                                 ),

                                 child:ListTile(

                                   title: Row(
                                     children: [
                                       Icon(Icons.attach_money,color: Color(0xff00A0E3),),
                                       SizedBox(width: 10,),
                                       Text("Fees",style: GoogleFonts.poppins(color: Color(0xff00A0E3),),),
                                     ],
                                   ),
                                 )),
                           ),
                         ],
                       ),
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
                                           child: Text("Order Si.No",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.only(left: 0.0,right: 10),
                                           child: Container(
                                             child: TextField(
                                               controller: orderno,
                                               style: GoogleFonts.poppins(
                                                   fontSize: width/91.066666667
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
                                           child: Text("Class",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.only(left: 0.0,right: 10),
                                           child: Container(child: TextField(
                                             controller: name,
                                             style: GoogleFonts.poppins(
                                                 fontSize: width/91.066666667
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
                                         child: Text("Order Si.no",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                         child: Text("Class",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
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
                                                       child: Text("00${value["order"].toString()}",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),),
                                                     ),
                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                       child: Container(
                                                           width:150,
                                                           child: Text(value["name"],style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),)),
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
                                           child: Text("Order Si.No",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.only(left: 0.0,right: 10),
                                           child: Container(
                                             child: TextField(
                                               controller: orderno2,
                                               style: GoogleFonts.poppins(
                                                   fontSize: width/91.066666667
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
                                           child: Text("Section",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.only(left: 0.0,right: 10),
                                           child: Container(child: TextField(
                                             controller: name2,
                                             style: GoogleFonts.poppins(
                                                 fontSize: width/91.066666667
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
                                         child: Text("Order Si.no",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                         child: Text("Section",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
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
                                                       child: Text("00${value["order"].toString()}",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),),
                                                     ),
                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                       child: Container(width:150,child: Text(value["name"],style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),)),
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
                                           child: Text("Order Si.No",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.only(left: 0.0,right: 10),
                                           child: Container(
                                             child: TextField(
                                               controller: orderno3,
                                               style: GoogleFonts.poppins(
                                                   fontSize: width/91.066666667
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
                                           child: Text("Academic Year",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
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
                                         child: Text("Order Si.no",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                         child: Text("Academic Year",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
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
           ) :
           page==3?
           SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child: Padding(
               padding: const EdgeInsets.only(left:20),
               child: Material(
                 elevation: 5,
                 borderRadius: BorderRadius.circular(12),
                 child: Container(
                   width: width/0.950,
                   decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                   child:  Row(
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
                                         Text("Select Logo",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),)
                                       ],
                                     ) : Image.network(imgUrl): Center(
                                       child: CircularProgressIndicator(),
                                     )
                                 ),
                               ),
                             ),
                           ),

                           SizedBox(height: 20,),

                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 6),
                             child: Container(
                                 width: 200,
                                 height: 50,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),


                                 ),

                                 child:ListTile(

                                   title: Row(
                                     children: [
                                       Icon(Icons.account_circle_outlined,color: Color(0xff00A0E3)),
                                       SizedBox(width: 10,),
                                       Text("School Details",style: GoogleFonts.poppins(color:  Color(0xff00A0E3)),),
                                     ],
                                   ),
                                 )),
                           ),
                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 6),
                             child: Container(
                                 width: 200,
                                 height: 50,
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),


                                 ),

                                 child:ListTile(

                                   title: Row(
                                     children: [
                                       Icon(Icons.room_preferences_sharp,color: Color(0xff00A0E3),),
                                       SizedBox(width: 10,),
                                       Text("Class & Sections",style: GoogleFonts.poppins(color: Color(0xff00A0E3),),),
                                     ],
                                   ),
                                 )),
                           ),
                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 6),
                             child: Container(
                                 width: 200,
                                 height: 50,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),
                                     color:
                                     Color(0xff00A0E3)
                                 ),

                                 child:ListTile(

                                   title: Row(
                                     children: [
                                       Icon(Icons.menu_book,color:  Colors.white,),
                                       SizedBox(width: 10,),
                                       Text("ID Card",style: GoogleFonts.poppins(color:  Colors.white,),),
                                     ],
                                   ),
                                 )),
                           ),
                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 6),
                             child: Container(
                                 width: 200,
                                 height: 50,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),



                                 ),

                                 child:ListTile(

                                   title: Row(
                                     children: [
                                       Icon(Icons.attach_money,color: Color(0xff00A0E3),),
                                       SizedBox(width: 10,),
                                       Text("Fees",style: GoogleFonts.poppins(color:  Color(0xff00A0E3),),),
                                     ],
                                   ),
                                 )),
                           ),
                         ],
                       ),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Padding(
                             padding: const EdgeInsets.only(top:20.0),
                             child: Row(
                               children: [
                                 InkWell(
                                   onTap: (){
                                     setState(() {
                                       viewtem=false;
                                     });
                                   },
                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Icon(Icons.arrow_back),
                                   ),
                                 ),
                                 Text("Select Templates",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: width/68.3),),
                               ],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Material(
                               elevation:7,
                               child: Container(
                                 child: Column(
                                   children: [
                                     Row(
                                       children: [
                                         Material(

                                           child: Container(
                                             width: 260,
                                             height: 410,

                                             child: Stack(
                                               children: [
                                                 Column(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Image.asset("assets/idbg4.png",color: pickerColor,),
                                                     Image.asset("assets/idbg6.png",color: pickerColor,),

                                                   ],
                                                 ),
                                                 Column(
                                                   crossAxisAlignment: CrossAxisAlignment.center,

                                                   children: [
                                                     SizedBox(height: 20,),
                                                     Row(
                                                       mainAxisAlignment: MainAxisAlignment.center,
                                                       children: [
                                                         Container(
                                                             width:50,
                                                         height:50, decoration: BoxDecoration(
                                                         borderRadius: BorderRadius.circular(25),
                                                             color:Colors.white
                                                         ),
                                                             child: Image.network(imgUrl)),
                                                       ],
                                                     ),
                                                     SizedBox(height: 2,),
                                                     Text(schoolname.text,style: GoogleFonts.poppins(
                                                         color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                     Text("${schoolarea.text} ${schoolcity.text}  ${schoolpincode.text}",style: GoogleFonts.poppins(
                                                         color: Colors.white, fontSize: width/170.75,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                                                     Text("Phone: +91 ${schoolphone.text}",style: GoogleFonts.poppins(
                                                         color: Colors.white, fontSize: width/170.75,fontWeight: FontWeight.w400),),
                                                    
                                                     Text(schoolweb.text,style: GoogleFonts.poppins(
                                                         color: Colors.white, fontSize: width/170.75,fontWeight: FontWeight.w400),),
                                                     SizedBox(height: 20,),
                                                     Stack(
                                                       alignment: Alignment.center,
                                                       children: [
                                                         Container(
                                                           width: 120,
                                                           height: 120,
                                                           decoration: BoxDecoration(
                                                               color: pickerColor,
                                                               borderRadius: BorderRadius.circular(60)
                                                           ),


                                                         ),
                                                         Container(
                                                           width: 112,
                                                           height: 112,
                                                           decoration: BoxDecoration(
                                                               borderRadius: BorderRadius.circular(50)
                                                           ),
                                                           child: ClipRRect(
                                                               borderRadius: BorderRadius.circular(60),
                                                               child: Image.asset("assets/profile.jpg")),
                                                         ),

                                                       ],
                                                     ),
                                                     SizedBox(height: 15,),
                                                     Text("Sam Jebaseelan",style: GoogleFonts.poppins(
                                                         color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                                     Text("ID: VBSB004",style: GoogleFonts.poppins(
                                                         color:  pickerColor, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                     SizedBox(height: 10,),
                                                     Row(
                                                       children: [
                                                         SizedBox(width: 20,),
                                                         Text("Class       : ",style: GoogleFonts.poppins(
                                                             color: pickerColor, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                         Text("LKG A",style: GoogleFonts.poppins(
                                                             color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                       ],
                                                     ),
                                                     Row(
                                                       children: [
                                                         SizedBox(width: 20,),
                                                         Text("DOB          : ",style: GoogleFonts.poppins(

                                                             color: pickerColor, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                         Text("05/05/2002",style: GoogleFonts.poppins(
                                                             color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                       ],
                                                     ),
                                                     Row(
                                                       children: [
                                                         SizedBox(width: 20,),
                                                         Text("Blood       : ",style: GoogleFonts.poppins(
                                                             color:pickerColor, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                         Text("B+ve",style: GoogleFonts.poppins(
                                                             color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                       ],
                                                     ),
                                                     Row(
                                                       children: [
                                                         SizedBox(width: 20,),
                                                         Text("Phone      : ",style: GoogleFonts.poppins(
                                                             color: pickerColor, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                         Text("789456213",style: GoogleFonts.poppins(
                                                             color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                       ],
                                                     ),

                                                   ],
                                                 ),

                                               ],
                                             ),
                                           ),
                                         ),
                                         SizedBox(width: 50,),
                                         Container(
                                           width: 260,
                                           height: 410,
                                           child: Stack(
                                             children: [
                                               Column(
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: [
                                                   Image.asset("assets/idbg7.png",color: pickerColor,),
                                                   Image.asset("assets/idbg6.png",color: pickerColor,),

                                                 ],
                                               ),
                                               Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,

                                                 children: [
                                                   SizedBox(height: 20,),
                                                   Padding(
                                                     padding: const EdgeInsets.only(left: 25.0),
                                                     child: Row(
                                                       mainAxisAlignment: MainAxisAlignment.start,
                                                       children: [
                                                         Container(
                                                             width:60,
                                                             height:60, decoration: BoxDecoration(
                                                             borderRadius: BorderRadius.circular(25),
                                                             color:Colors.white
                                                         ),
                                                             child: Image.network(imgUrl)),
                                                       ],
                                                     ),
                                                   ),
                                           

                                                   Padding(
                                                     padding: const EdgeInsets.only(left: 20.0,top:70),
                                                     child: Text("Student Details",style: GoogleFonts.poppins(
                                                         color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                                   ),
                                                   Text("",style: GoogleFonts.poppins(
                                                       color: Color(0xff0271C5), fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                   SizedBox(height: 10,),
                                                   Row(
                                                     children: [
                                                       SizedBox(width: 20,),
                                                       Container(
                                                         width: 110,
                                                         child: Text("Parent Phone : ",style: GoogleFonts.poppins(
                                                             color: pickerColor, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                       ),
                                                       Text("9944861235",style: GoogleFonts.poppins(
                                                           color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                     ],
                                                   ),
                                                   Row(
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                       SizedBox(width: 20,),
                                                       Container(
                                                         width: 110,
                                                         child: Text("Address : ",style: GoogleFonts.poppins(

                                                             color: pickerColor, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                       ),
                                                       Text("No120/2 Kolathur \nChennai",style: GoogleFonts.poppins(
                                                           color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                     ],
                                                   ),
                                             
                                                   Padding(
                                                     padding: const EdgeInsets.only(left: 0.0),
                                                     child: Row(
                                                       mainAxisAlignment: MainAxisAlignment.center,
                                                       children: [
                                                         Column(
                                                           children: [
                                                             SizedBox(height:5),
                                                             Container(
                                                                 width: 75,
                                                                 height: 75,
                                                                 child: Image.asset("assets/VIDHAANLOGO.png",fit: BoxFit.contain,)),

                                                             Text("e    d    u    c    a    r    e",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: width/195.142857143),),
                                                             SizedBox(height:7),
                                                           ],
                                                         ),
                                                       ],
                                                     ),
                                                   )

                                                 ],
                                               ),

                                             ],
                                           ),
                                         ),
                                         SizedBox(width: 50,),
                                         Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             SizedBox(height: 10,),
                                             Text("Card Design 1",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: width/68.3),),
                                             Text("Change Color:",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 15),),

                                             Container(
                                               width: 465,
                                               child: ColorPicker(
                                                 colorPickerWidth: 120,
                                                 pickerColor: pickerColor,
                                                 onColorChanged: changeColor,
                                                 hexInputBar: true,
                                                 enableAlpha: false,
                                                 displayThumbColor: false,

                                                 onHistoryChanged: (value)  {
                                                   print(value);
                                                 },

                                                 onHsvColorChanged: (value)  {
                                                   print(value);
                                                 },

                                               ),
                                             ),
                                             SizedBox(height: 10,),
                                             InkWell(
                                               onTap: (){
                                                 setState(() {
                                                   design=1;
                                                 });
                                                 Successdialogd();
                                               },
                                               child: Padding(
                                                 padding: const EdgeInsets.all(8.0),
                                                 child: Container(
                                                   child: Center(
                                                       child: Text(
                                                         "Select Design",
                                                         style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),
                                                       )),
                                                   width: width/6.83,
                                                   //color: Color(0xff00A0E3),
                                                   height: height/16.425,
                                                   decoration: BoxDecoration(
                                                       color: Color(0xff53B175),
                                                       borderRadius: BorderRadius.circular(6)),
                                                 ),
                                               ),
                                             ),

                                           ],
                                         ),
                                       ],
                                     ),
                                     SizedBox(height: 55,),
                                     Row(
                                       children: [
                                         Material(

                                           child: Container(
                                             width: 260,
                                             height: 410,

                                             child: Stack(
                                               children: [
                                                 Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   children: [
                                                     Image.asset("assets/id2bg7.png",color: pickerColor2,),


                                                   ],
                                                 ),
                                                 Column(
                                                   crossAxisAlignment: CrossAxisAlignment.center,

                                                   children: [

                                                     Row(
                                                       crossAxisAlignment: CrossAxisAlignment.start,
                                                       children: [
                                                         SizedBox(width:10),
                                                         Column(
                                                           children: [
                                                             SizedBox(height:30),
                                                             Image.asset("assets/Logo.png"),
                                                           ],
                                                         ),
                                                         SizedBox(width:10),
                                                         Column(
                                                           crossAxisAlignment: CrossAxisAlignment.start,
                                                           children: [
                                                             SizedBox(height:20),
                                                             Text(schoolname.text,style: GoogleFonts.poppins(
                                                                 color: Colors.white, fontSize: width/97.571428571,fontWeight: FontWeight.w600),),
                                                             Text("Phone: +91 9977888456",style: GoogleFonts.poppins(
                                                                 color: Colors.white, fontSize: width/170.75,fontWeight: FontWeight.w400),),
                                                             Text("Anna Nagar, Chennai- 600062",style: GoogleFonts.poppins(
                                                                 color: Colors.white, fontSize: width/170.75,fontWeight: FontWeight.w400),),
                                                           ],
                                                         ),
                                                       ],
                                                     ),



                                                     SizedBox(height: 50,),
                                                     Stack(
                                                       alignment: Alignment.center,
                                                       children: [
                                                         Container(
                                                           width: 120,
                                                           height: 120,
                                                           decoration: BoxDecoration(
                                                               color: pickerColor2,
                                                               borderRadius: BorderRadius.circular(12)
                                                           ),


                                                         ),
                                                         Container(
                                                           width: 115,
                                                           height: 115,
                                                           decoration: BoxDecoration(
                                                               borderRadius: BorderRadius.circular(12)
                                                           ),
                                                           child: ClipRRect(
                                                               borderRadius: BorderRadius.circular(12),
                                                               child: Image.asset("assets/profile.jpg")),
                                                         ),

                                                       ],
                                                     ),
                                                     SizedBox(height: 15,),
                                                     Text("Sam Jebaseelan",style: GoogleFonts.poppins(
                                                         color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                                     Text("ID: VBSB004",style: GoogleFonts.poppins(
                                                         color:  pickerColor2, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                     SizedBox(height: 10,),
                                                     Stack(

                                                       children: [
                                                         Row(
                                                           children: [
                                                             SizedBox(width:50),
                                                             Column(
                                                               crossAxisAlignment: CrossAxisAlignment.start,

                                                               children: [
                                                                 Row(
                                                                   children: [
                                                                     SizedBox(width: 20,),
                                                                     Text("Class       : ",style: GoogleFonts.poppins(
                                                                         color: pickerColor2, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                     Text("LKG A",style: GoogleFonts.poppins(
                                                                         color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                   ],
                                                                 ),
                                                                 Row(
                                                                   children: [
                                                                     SizedBox(width: 20,),
                                                                     Text("DOB          : ",style: GoogleFonts.poppins(

                                                                         color: pickerColor2, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                     Text("05/05/2002",style: GoogleFonts.poppins(
                                                                         color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                   ],),
                                                                 Row(
                                                                   children: [
                                                                     SizedBox(width: 20,),
                                                                     Text("Blood       : ",style: GoogleFonts.poppins(
                                                                         color:pickerColor2, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                     Text("B+ve",style: GoogleFonts.poppins(
                                                                         color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                   ],
                                                                 ),
                                                                 Row(
                                                                   children: [
                                                                     SizedBox(width: 20,),
                                                                     Text("Phone      : ",style: GoogleFonts.poppins(
                                                                         color: pickerColor2, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                     Text("789456213",style: GoogleFonts.poppins(
                                                                         color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                   ],
                                                                 ),
                                                               ],
                                                             ),
                                                           ],
                                                         ),
                                                         Padding(
                                                           padding:  EdgeInsets.only(top:50.0),
                                                           child: Row(
                                                             mainAxisAlignment: MainAxisAlignment.end,
                                                             children: [
                                                               Column(
                                                                 children: [
                                                                   Container(
                                                                       width:37,


                                                                       child: Image.asset("assets/sign.png")),
                                                                   Text("Principle",style: GoogleFonts.poppins(
                                                                       color: Colors.black, fontSize: width/136.6,fontWeight: FontWeight.w700),),
                                                                 ],
                                                               ),
                                                             ],
                                                           ),
                                                         )
                                                       ],
                                                     ),




                                                   ],
                                                 ),

                                               ],
                                             ),
                                           ),
                                         ),
                                         SizedBox(width: 50,),
                                         Container(
                                           width: 260,
                                           height: 410,
                                           child: Stack(
                                             children: [
                                               Column(
                                                 mainAxisAlignment: MainAxisAlignment.end,
                                                 children: [

                                                   Image.asset("assets/id2bg2.png",color: pickerColor2,),

                                                 ],
                                               ),
                                               Column(
                                                 crossAxisAlignment: CrossAxisAlignment.center,

                                                 children: [
                                                   SizedBox(height: 20,),
                                                   Padding(
                                                     padding: const EdgeInsets.only(left: 10.0),
                                                     child: Row(
                                                       mainAxisAlignment: MainAxisAlignment.center,
                                                       children: [
                                                         Image.asset("assets/Logo.png", color: pickerColor2,),
                                                       ],
                                                     ),
                                                   ),
                                                   SizedBox(height: 10,),
                                                   Padding(
                                                     padding: const EdgeInsets.only(left: 10.0),
                                                     child: Text(schoolname.text,style: GoogleFonts.poppins(
                                                         color: pickerColor2, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                   ),
                                                   Padding(
                                                     padding: const EdgeInsets.only(left: 10.0),
                                                     child: Text("Let the joy begins",style: GoogleFonts.poppins(
                                                         color: pickerColor2, fontSize: width/170.75,fontWeight: FontWeight.w400),),
                                                   ),
                                                   SizedBox(height: 40,),

                                                   Padding(
                                                     padding: const EdgeInsets.only(left: 20.0),
                                                     child: Text("Student Details",style: GoogleFonts.poppins(
                                                         color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                                   ),
                                                   Text("",style: GoogleFonts.poppins(
                                                       color: Color(0xff0271C5), fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                   SizedBox(height: 10,),
                                                   Row(
                                                     children: [
                                                       SizedBox(width: 20,),
                                                       Container(
                                                         width: 110,
                                                         child: Text("Parent Phone : ",style: GoogleFonts.poppins(
                                                             color: pickerColor2, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                       ),
                                                       Text("9944861235",style: GoogleFonts.poppins(
                                                           color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                     ],
                                                   ),
                                                   Row(
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                       SizedBox(width: 20,),
                                                       Container(
                                                         width: 110,
                                                         child: Text("Address : ",style: GoogleFonts.poppins(

                                                             color: pickerColor2, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                       ),
                                                       Text("No120/2 Kolathur \nChennai",style: GoogleFonts.poppins(
                                                           color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                     ],
                                                   ),
                                                   Row(
                                                     children: [
                                                       SizedBox(width: 20,),
                                                       Container(
                                                         width: 110,
                                                         child: Text("Contact US : ",style: GoogleFonts.poppins(
                                                             color: pickerColor2, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                       ),
                                                       Text("45845614534",style: GoogleFonts.poppins(
                                                           color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                     ],
                                                   ),
                                                   Row(
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                       SizedBox(width: 20,),
                                                       Container(
                                                         width: 110,
                                                         child: Text("School Address : ",style: GoogleFonts.poppins(
                                                             color: pickerColor2, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                       ),
                                                       Text("No120/2 Kolathur \nChennai",style: GoogleFonts.poppins(
                                                           color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                     ],
                                                   ),
                                                   Row(
                                                     children: [
                                                       Padding(
                                                         padding: const EdgeInsets.only(left: 20.0),
                                                         child: Container(
                                                             width: 60,
                                                             height: 60,
                                                             child: Image.asset("assets/VIDHAANLOGO.png",fit: BoxFit.contain,)),
                                                       ),
                                                     ],
                                                   )

                                                 ],
                                               ),

                                             ],
                                           ),
                                         ),
                                         SizedBox(width: 50,),
                                         Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             SizedBox(height: 10,),
                                             Text("Card Design 2",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: width/68.3),),
                                             Text("Change Color:",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 15),),

                                             Container(
                                               width: 465,
                                               child: ColorPicker(
                                                 colorPickerWidth: 120,
                                                 pickerColor: pickerColor2,
                                                 onColorChanged: changeColor2,
                                                 hexInputBar: true,
                                                 enableAlpha: false,
                                                 displayThumbColor: false,

                                                 onHistoryChanged: (value)  {
                                                   print(value);
                                                 },

                                                 onHsvColorChanged: (value)  {
                                                   print(value);
                                                 },

                                               ),
                                             ),
                                             SizedBox(height: 10,),
                                             InkWell(
                                               onTap: (){
                                                 setState(() {
                                                   design=2;
                                                 });
                                                 Successdialog();
                                               },
                                               child: Padding(
                                                 padding: const EdgeInsets.all(8.0),
                                                 child: Container(
                                                   child: Center(
                                                       child: Text(
                                                         "Select Design",
                                                         style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),
                                                       )),
                                                   width: width/6.83,
                                                   //color: Color(0xff00A0E3),
                                                   height: height/16.425,
                                                   decoration: BoxDecoration(
                                                       color: Color(0xff53B175),
                                                       borderRadius: BorderRadius.circular(6)),
                                                 ),
                                               ),
                                             ),

                                           ],
                                         ),
                                       ],
                                     ),
                                     SizedBox(height: 55,),
                                     Row(
                                       children: [
                                         Column(
                                           children: [
                                             Material(

                                               child: Container(
                                                 width: 410,
                                                 height: 260,

                                                 child: Stack(
                                                   children: [
                                                     Column(
                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                       children: [
                                                         Image.asset("assets/id3bg1.png",color: pickerColor3,),
                                                         Image.asset("assets/id3bg2.png",color: pickerColor3,),


                                                       ],
                                                     ),
                                                     Column(
                                                       crossAxisAlignment: CrossAxisAlignment.center,

                                                       children: [
                                                         SizedBox(height: 7,),
                                                         Row(
                                                           mainAxisAlignment: MainAxisAlignment.center,
                                                           children: [
                                                             Image.asset("assets/Logo.png",color:pickerColor3),
                                                             SizedBox(width:20),
                                                             Column(
                                                               crossAxisAlignment:CrossAxisAlignment.start,
                                                               children: [
                                                                 Text(schoolname.text,style: GoogleFonts.poppins(
                                                                     color: pickerColor3, fontSize: 15,fontWeight: FontWeight.w600),),
                                                                 Text("Phone: +91 9977888456",style: GoogleFonts.poppins(
                                                                     color: pickerColor3, fontSize: width/151.777777778,fontWeight: FontWeight.w400),),
                                                                 Text("Anna Nagar, Chennai- 600062",style: GoogleFonts.poppins(
                                                                     color: pickerColor3, fontSize: width/151.777777778,fontWeight: FontWeight.w400),),
                                                                 Text("www.school.in",style: GoogleFonts.poppins(
                                                                     color: pickerColor3, fontSize: width/151.777777778,fontWeight: FontWeight.w400),),


                                                               ],
                                                             ),

                                                           ],
                                                         ),
                                                         SizedBox(height: 5,),

                                                         Row(
                                                           children: [
                                                             SizedBox(width:10),
                                                             Stack(
                                                               alignment: Alignment.center,
                                                               children: [
                                                                 Container(
                                                                   width: 120,
                                                                   height: 120,
                                                                   decoration: BoxDecoration(
                                                                       color: pickerColor3,
                                                                       borderRadius: BorderRadius.circular(60)
                                                                   ),


                                                                 ),
                                                                 Container(
                                                                   width: 112,
                                                                   height: 112,
                                                                   decoration: BoxDecoration(
                                                                       borderRadius: BorderRadius.circular(50)
                                                                   ),
                                                                   child: ClipRRect(
                                                                       borderRadius: BorderRadius.circular(60),
                                                                       child: Image.asset("assets/profile.jpg")),
                                                                 ),

                                                               ],
                                                             ),
                                                             Column(
                                                                 crossAxisAlignment:CrossAxisAlignment.start,
                                                                 children:[
                                                                   SizedBox(height: 15,),
                                                                   Padding(
                                                                     padding: const EdgeInsets.only(left:15.0),
                                                                     child: Text("Sam Jebaseelan",style: GoogleFonts.poppins(
                                                                         color: pickerColor3, fontSize: 15,fontWeight: FontWeight.w700),),
                                                                   ),
                                                                   Padding(
                                                                     padding: const EdgeInsets.only(left:15.0),
                                                                     child: Text("ID: VBSB004",style: GoogleFonts.poppins(
                                                                         color:  pickerColor3, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                   ),
                                                                   SizedBox(height: 10,),
                                                                   Row(
                                                                     children: [
                                                                       SizedBox(width: 20,),
                                                                       Text("Class       : ",style: GoogleFonts.poppins(
                                                                           color: pickerColor3, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                       Text("LKG A",style: GoogleFonts.poppins(
                                                                           color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                     ],
                                                                   ),
                                                                   Row(
                                                                     children: [
                                                                       SizedBox(width: 20,),
                                                                       Text("DOB          : ",style: GoogleFonts.poppins(

                                                                           color: pickerColor3, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                       Text("05/05/2002",style: GoogleFonts.poppins(
                                                                           color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                     ],
                                                                   ),
                                                                   Row(
                                                                     children: [
                                                                       SizedBox(width: 20,),
                                                                       Text("Blood       : ",style: GoogleFonts.poppins(
                                                                           color:pickerColor3, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                       Text("B+ve",style: GoogleFonts.poppins(
                                                                           color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                     ],
                                                                   ),
                                                                   Row(
                                                                     children: [
                                                                       SizedBox(width: 20,),
                                                                       Text("Phone      : ",style: GoogleFonts.poppins(
                                                                           color: pickerColor3, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                       Text("789456213",style: GoogleFonts.poppins(
                                                                           color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                     ],
                                                                   ),
                                                                 ]
                                                             )
                                                           ],
                                                         ),


                                                       ],
                                                     ),


                                                   ],
                                                 ),
                                               ),
                                             ),
                                             SizedBox(height: 30,),
                                             Material(

                                               child: Container(
                                                 width: 410,
                                                 height: 260,

                                                 child: Stack(
                                                   children: [
                                                     Padding(
                                                       padding: const EdgeInsets.only(top: 100.0,left:250),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.center,
                                                         children: [
                                                           Column(
                                                             children: [
                                                               SizedBox(height:5),
                                                               Opacity(
                                                                 opacity:0.39,
                                                                 child: Container(
                                                                     width: 75,
                                                                     height: 75,
                                                                     child: Image.asset("assets/VIDHAANLOGO.png",fit: BoxFit.contain,)),
                                                               ),

                                                               Opacity(
                                                                   opacity:0.39,
                                                                   child: Text("e    d    u    c    a    r    e",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: width/195.142857143),)),
                                                               SizedBox(height:7),
                                                             ],
                                                           ),
                                                         ],
                                                       ),
                                                     ),
                                                     Column(
                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                       children: [
                                                         Image.asset("assets/id3bg3.png",color: pickerColor3,),
                                                         Image.asset("assets/id3bg2.png",color: pickerColor3,),


                                                       ],
                                                     ),
                                                     Padding(
                                                       padding: const EdgeInsets.only(top:30.0),
                                                       child: Column(
                                                         children: [
                                                           Row(
                                                             mainAxisAlignment: MainAxisAlignment.center,
                                                             children: [
                                                               Image.asset("assets/Logo.png",color:pickerColor3),
                                                               SizedBox(width:30),
                                                               Column(
                                                                 crossAxisAlignment:CrossAxisAlignment.start,
                                                                 children: [
                                                                   Text(schoolname.text,style: GoogleFonts.poppins(
                                                                       color: pickerColor3, fontSize: 15,fontWeight: FontWeight.w600),),
                                                                   Text("Phone: +91 9977888456",style: GoogleFonts.poppins(
                                                                       color: pickerColor3, fontSize: width/151.777777778,fontWeight: FontWeight.w400),),
                                                                   Text("Anna Nagar, Chennai- 600062",style: GoogleFonts.poppins(
                                                                       color: pickerColor3, fontSize: width/151.777777778,fontWeight: FontWeight.w400),),
                                                                   Text("www.school.in",style: GoogleFonts.poppins(
                                                                       color: pickerColor3, fontSize: width/151.777777778,fontWeight: FontWeight.w400),),


                                                                 ],
                                                               ),

                                                             ],
                                                           ),
                                                           Row(
                                                             children: [
                                                               Padding(
                                                                 padding: const EdgeInsets.only(left: 20.0),
                                                                 child: Text("Student Details",style: GoogleFonts.poppins(
                                                                     color:  pickerColor3, fontSize: 15,fontWeight: FontWeight.w700),),
                                                               ),
                                                             ],
                                                           ),

                                                           SizedBox(height: 5,),
                                                           Row(
                                                             children: [
                                                               SizedBox(width: 20,),
                                                               Container(
                                                                 width: 110,
                                                                 child: Text("Parent Phone : ",style: GoogleFonts.poppins(
                                                                     color: pickerColor3, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                               ),
                                                               Text("9944861235",style: GoogleFonts.poppins(
                                                                   color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                             ],
                                                           ),
                                                           Row(
                                                             crossAxisAlignment: CrossAxisAlignment.start,
                                                             children: [
                                                               SizedBox(width: 20,),
                                                               Container(
                                                                 width: 110,
                                                                 child: Text("Address : ",style: GoogleFonts.poppins(

                                                                     color: pickerColor3, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                               ),
                                                               Text("No120/2 Kolathur \nChennai",style: GoogleFonts.poppins(
                                                                   color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                             ],
                                                           ),
                                                           Row(
                                                             children: [
                                                               SizedBox(width: 20,),
                                                               Container(
                                                                 width: 110,
                                                                 child: Text("Contact US : ",style: GoogleFonts.poppins(
                                                                     color: pickerColor3, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                               ),
                                                               Text("45845614534",style: GoogleFonts.poppins(
                                                                   color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                             ],
                                                           ),
                                                           Row(
                                                             crossAxisAlignment: CrossAxisAlignment.start,
                                                             children: [
                                                               SizedBox(width: 20,),
                                                               Container(
                                                                 width: 110,
                                                                 child: Text("School Address : ",style: GoogleFonts.poppins(
                                                                     color: pickerColor3, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                               ),
                                                               Text("No120/2 Kolathur Chennai",style: GoogleFonts.poppins(
                                                                   color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                             ],
                                                           ),

                                                         ],
                                                       ),
                                                     ),




                                                   ],
                                                 ),
                                               ),
                                             ),
                                           ],
                                         ),

                                         SizedBox(width: 150,),
                                         Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             SizedBox(height: 10,),
                                             Text("Card Design 3",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: width/68.3),),
                                             Text("Change Color:",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 15),),

                                             Container(
                                               width: 465,
                                               child: ColorPicker(
                                                 colorPickerWidth: 120,
                                                 pickerColor: pickerColor3,
                                                 onColorChanged: changeColor3,
                                                 hexInputBar: true,
                                                 enableAlpha: false,
                                                 displayThumbColor: false,

                                                 onHistoryChanged: (value)  {
                                                   print(value);
                                                 },

                                                 onHsvColorChanged: (value)  {
                                                   print(value);
                                                 },

                                               ),
                                             ),
                                             SizedBox(height: 10,),
                                             InkWell(
                                               onTap: (){
                                                 setState(() {
                                                   design=3;
                                                 });
                                                 Successdialog();
                                               },
                                               child: Padding(
                                                 padding: const EdgeInsets.all(8.0),
                                                 child: Container(
                                                   child: Center(
                                                       child: Text(
                                                         "Select Design",
                                                         style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),
                                                       )),
                                                   width: width/6.83,
                                                   //color: Color(0xff00A0E3),
                                                   height: height/16.425,
                                                   decoration: BoxDecoration(
                                                       color: Color(0xff53B175),
                                                       borderRadius: BorderRadius.circular(6)),
                                                 ),
                                               ),
                                             ),

                                           ],
                                         ),
                                       ],
                                     ),
                                     SizedBox(height: 20,)
                                   ],
                                 ),
                               ),
                             ),
                           ),
                           SizedBox(height: 20,)
                         ],
                       ),
                     ],
                   ),
                 ),
               ),
             ),
           ) : 
           SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child: Padding(
               padding: const EdgeInsets.only(left:20),
               child: Material(
                 elevation: 5,
                 borderRadius: BorderRadius.circular(12),
                 child: Container(
                   width: width/1.150,
                   decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                   child:  Row(
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
                                         Text("Select Logo",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),)
                                       ],
                                     ) : Image.network(imgUrl): Center(
                                       child: CircularProgressIndicator(),
                                     )
                                 ),
                               ),
                             ),
                           ),

                           SizedBox(height: 20,),

                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 6),
                             child: Container(
                                 width: 200,
                                 height: 50,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),


                                 ),

                                 child:ListTile(

                                   title: Row(
                                     children: [
                                       Icon(Icons.account_circle_outlined,color: Color(0xff00A0E3)),
                                       SizedBox(width: 10,),
                                       Text("School Details",style: GoogleFonts.poppins(color:  Color(0xff00A0E3)),),
                                     ],
                                   ),
                                 )),
                           ),
                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 6),
                             child: Container(
                                 width: 200,
                                 height: 50,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),


                                 ),

                                 child:ListTile(

                                   title: Row(
                                     children: [
                                       Icon(Icons.room_preferences_sharp,color: Color(0xff00A0E3),),
                                       SizedBox(width: 10,),
                                       Text("Class & Sections",style: GoogleFonts.poppins(color: Color(0xff00A0E3),),),
                                     ],
                                   ),
                                 )),
                           ),
                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 6),
                             child: Container(
                                 width: 200,
                                 height: 50,
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                             
                                 ),

                                 child:ListTile(

                                   title: Row(
                                     children: [
                                       Icon(Icons.menu_book,color:  Color(0xff00A0E3),),
                                       SizedBox(width: 10,),
                                       Text("ID Card",style: GoogleFonts.poppins(color:  Color(0xff00A0E3),),),
                                     ],
                                   ),
                                 )),
                           ),
                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 6),
                             child: Container(
                                 width: 200,
                                 height: 50,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),
                                       color: Color(0xff00A0E3)
                                     
                                 ),

                                 child:ListTile(

                                   title: Row(
                                     children: [
                                       Icon(Icons.attach_money,color: Colors.white,),
                                       SizedBox(width: 10,),
                                       Text("Fees",style: GoogleFonts.poppins(color:  Colors.white,),),
                                     ],
                                   ),
                                 )),
                           ),
                         ],
                       ),
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
                                         child: Text("Order Si.no",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                         child: Text("Fee Name",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
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
                                                       child: Text("00${value["order"].toString()}",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
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
           )
          ],
        ),
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
                title:  Text('All Set, Good to Go...',style: GoogleFonts.poppins(
                    color: Colors.black, fontSize:18,fontWeight: FontWeight.w600),),
                content:  Container(
                    width: 350,
                    height: 250,

                    child:  Lottie.asset("assets/welcome.json")
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
                          Text("Get Started",style: GoogleFonts.poppins(color:Colors.white),),
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
