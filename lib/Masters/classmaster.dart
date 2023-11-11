import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';

class ClassMaster extends StatefulWidget {
  const ClassMaster({Key? key}) : super(key: key);

  @override
  State<ClassMaster> createState() => _ClassMasterState();
}

class _ClassMasterState extends State<ClassMaster> {

  TextEditingController name = new TextEditingController();
  TextEditingController name2 = new TextEditingController();
  TextEditingController name3 = new TextEditingController();
  TextEditingController orderno = new TextEditingController();
  TextEditingController orderno2 = new TextEditingController();
  TextEditingController orderno3 = new TextEditingController();




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
  @override
  void initState() {
    getorderno();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Container(child: Padding(
            padding: const EdgeInsets.only(left: 38.0,top: 30),
            child: Text("Class - Section - Acidemic Year Masters",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),),
          ),
            //color: Colors.white,
            width: width/1.050,
            height: height/8.212,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
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
                                        child: Text("00${value["order"].toString()}",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                        child: Text(value["name"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
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
                                        child: Text("00${value["order"].toString()}",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                        child: Text(value["name"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
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
                                        child: Text("00${value["order"].toString()}",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                        child: Text(value["name"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
