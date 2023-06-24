import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vidhaan/Masters/Acdemic%20Master.dart';
import 'package:vidhaan/attendence.dart';
import 'package:vidhaan/classincharge.dart';
import 'package:vidhaan/Masters/classmaster.dart';
import 'package:vidhaan/irregularstudents.dart';
import 'package:vidhaan/positionwisereports.dart';
import 'package:vidhaan/staffattendance.dart';
import 'package:vidhaan/stafflist.dart';
import 'package:vidhaan/studentlist.dart';
import 'package:vidhaan/studentsearch.dart';
import 'package:vidhaan/staff%20entry.dart';
import 'package:vidhaan/student%20from.dart';
import 'package:vidhaan/studetails.dart';

import 'Accountpage.dart';
import 'Masters/classwisefeemaster.dart';
import 'Masters/desigination.dart';
import 'Masters/feesmaster.dart';
import 'Masters/section.dart';
import 'admission.dart';
import 'classstudentreport.dart';







class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int dawer = 0;
  var pages;
  @override
  void initState() {
    setState(() {
      pages=Dashboard2();
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Row(
        children: [
          Container(
            width: width/5.939,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,top: 20),
                  child: Material(
                  elevation: 20,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(

                      width: width/5.003,
                      height: height/1.0428,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [

                            Container(
                              child: Row(
                                children: [
                                  Image.asset("assets/imagevidh.png"),
                                  Text(
                                    "Vidhaan",
                                    style: GoogleFonts.poppins(
                                        color: Color(0xff0271C5), fontSize: 25),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              width: width/4.878,
                              height: height/6.57,

                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: dawer == 0
                                      ? Color(0xff00A0E3) : Colors.transparent,
                                ),
                                child: ListTile(


                                  leading: Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Image.asset(dawer == 0
                                        ? "assets/iconwhite.png" : "assets/icon1.png",
                                      color: dawer == 0 ?  Colors.white : Color(0xff9197B3),
                                    ),
                                  ),

                                  title: Text(
                                    "Dashboard",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: dawer == 0 ?  Colors.white : Color(0xff9197B3)),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      pages = Dashboard2();
                                      dawer=0;

                                    });
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: dawer == 1
                                      ? Color(0xff00A0E3) : Colors.transparent,
                                ),
                                child: ListTile(


                                  leading: Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Image.asset("assets/icon2.png",color: dawer == 1 ?  Colors.white : Color(0xff9197B3),
                                    ),
                                  ),

                                  title: Text(
                                    "Admission",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: dawer == 1 ?  Colors.white : Color(0xff9197B3)),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      pages = admission();
                                      dawer=1;

                                    });
                                  },
                                ),
                              ),
                            ),



                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: dawer == 2
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                  ),

                                  child:ExpansionTile(
                                    iconColor: Colors.white,
                                    backgroundColor:dawer == 2
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                    onExpansionChanged: (value){
                                      if(value==true){
                                        setState(() {
                                          dawer=2;
                                        });
                                      }

                                    },
                                    leading: Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                child: Image.asset("assets/icon3.png",color: dawer == 2 ?  Colors.white : Color(0xff9197B3),),
                              ),
                                    title: Text("Students",style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: dawer == 2?  Colors.white : Color(0xff9197B3)),
                                    ),
                                    children: [
                                      ListTile(
                                        onTap:(){
                                          setState((){
                                            pages=StudentFrom();
                                          });

                              },
                                        title: Text("Students Entry Admission",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 2?  Colors.white : Color(0xff9197B3)),
                                      )),
                                      ListTile(
                                          onTap:(){
                                            setState((){
                                              pages=Studentsearch();
                                            });

                                          },
                                        title: Text("Students Search",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 2?  Colors.white : Color(0xff9197B3)),
                                      )),
                                      ExpansionTile(
                                        iconColor: Colors.white,
                                        collapsedIconColor: Colors.white,

                                        title: Text("Students Masters",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 2?  Colors.white : Color(0xff9197B3)),
                                        ),
                                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap:(){
                                              setState((){
                                                pages=ClassMaster();
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Class Master",style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: dawer == 2?  Colors.white : Color(0xff9197B3)),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap:(){
                                              setState((){
                                                pages=SectionMaster();
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Section Master",style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: dawer == 2?  Colors.white : Color(0xff9197B3)),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap:(){
                                              setState((){
                                                pages=AcademicMaster();
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Academic year Master",style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: dawer == 2?  Colors.white : Color(0xff9197B3)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      ExpansionTile(
                                        iconColor: Colors.white,
                                        collapsedIconColor: Colors.white,

                                        title: Text("Students Reports",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 2?  Colors.white : Color(0xff9197B3)),
                                        ),
                                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap:(){
                                              setState((){
                                                pages=StudentList();

                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Student List",style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: dawer == 2?  Colors.white : Color(0xff9197B3)),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap:(){
                                              setState((){
                                                pages=ClassStudentReport();
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Class wise",style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: dawer == 2?  Colors.white : Color(0xff9197B3)),
                                              ),
                                            ),
                                          ),


                                        ],
                                      ),
                                      ListTile(
                                          onTap:(){


                                          },
                                          title: Text("Students ID Cards",style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: dawer == 2?  Colors.white : Color(0xff9197B3)),
                                          )),



                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: dawer == 3
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                  ),

                                  child:ExpansionTile(
                                    iconColor: Colors.white,
                                    backgroundColor:dawer == 3
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                    onExpansionChanged: (value){
                                      if(value==true){
                                        setState(() {
                                          dawer=3;
                                        });
                                      }

                                    },
                                    leading: Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                child: Image.asset(
                                  "assets/icon4.png",
                                  color: dawer == 3 ?  Colors.white : Color(0xff9197B3),
                                ),),
                                    title: Text("Staff",style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: dawer == 3?  Colors.white : Color(0xff9197B3)),
                                    ),
                                    children: [
                                      ListTile(
                                          onTap:(){
                                            setState((){
                                              pages=StaffEntry();
                                            });
                                          },
                                        title: Text("Staff Entry",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 3?  Colors.white : Color(0xff9197B3)),
                                      )),
                                      ListTile(
                                          onTap:(){
                                            setState((){
                                              pages=ClassIncharge();
                                            });
                                          },
                                        title: Text("Class Teacher/In-charge",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 3?  Colors.white : Color(0xff9197B3)),
                                      )),
                                      ExpansionTile(
                                        iconColor: Colors.white,
                                        collapsedIconColor: Colors.white,

                                        title: Text("Staff Masters",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 3?  Colors.white : Color(0xff9197B3)),
                                        ),
                                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap:(){
                                              setState((){
                                                pages=Desigination();
                                              });
                                              },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Designation",style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: dawer == 3?  Colors.white : Color(0xff9197B3)),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),

                                      ExpansionTile(
                                        iconColor: Colors.white,
                                        collapsedIconColor: Colors.white,

                                        title: Text("Staff Reports",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 3?  Colors.white : Color(0xff9197B3)),
                                        ),
                                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap:(){
                                              setState((){
                                                pages=Postionwisestaff();
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Position Wise",style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: dawer == 3?  Colors.white : Color(0xff9197B3)),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap:(){
                                              setState((){
                                                pages=StaffList();
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Staff List",style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: dawer == 3?  Colors.white : Color(0xff9197B3)),
                                              ),
                                            ),
                                          ),


                                        ],
                                      ),



                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: dawer == 4
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                  ),

                                  child:ExpansionTile(
                                    iconColor: Colors.white,
                                    backgroundColor:dawer == 4
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                    onExpansionChanged: (value){
                                      if(value==true){
                                        setState(() {
                                          dawer=4;
                                        });
                                      }

                                    },
                                    leading: Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                child: Image.asset(
                                  "assets/icon5.png",
                                  color: dawer == 4 ?  Colors.white : Color(0xff9197B3),
                                ),),
                                    title: Text("Attendence",style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: dawer == 4?  Colors.white : Color(0xff9197B3)),
                                    ),
                                    children: [
                                      ListTile(
                                        onTap:(){
                                          setState((){
                                            pages=Attendence();
                                          });
                                        },
                                        title: Text("Student Attendance ",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 4?  Colors.white : Color(0xff9197B3)),
                                      )),

                                      ListTile(
                                        onTap: (){
                                          setState((){
                                            pages=StaffAttendance();
                                          });
                                        },
                                        title: Text("Staff Attendance",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 4?  Colors.white : Color(0xff9197B3)),
                                      )),
                                      ExpansionTile(
                                        iconColor: Colors.white,
                                        collapsedIconColor: Colors.white,

                                        title: Text("Student reports",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 4?  Colors.white : Color(0xff9197B3)),
                                        ),
                                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap:(){
                                              setState((){
                                                pages=IrregularStudents();
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Irregular Student",style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: dawer == 4?  Colors.white : Color(0xff9197B3)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Regular Student",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: dawer == 4?  Colors.white : Color(0xff9197B3)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Class Wise",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: dawer == 4?  Colors.white : Color(0xff9197B3)),
                                            ),
                                          ),

                                        ],
                                      ),

                                      ExpansionTile(
                                        iconColor: Colors.white,
                                        collapsedIconColor: Colors.white,

                                        title: Text("Staff Reports",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 4?  Colors.white : Color(0xff9197B3)),
                                        ),
                                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Position Wise",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: dawer == 4?  Colors.white : Color(0xff9197B3)),
                                            ),
                                          ),



                                        ],
                                      ),



                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: dawer == 5
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                  ),

                                  child:ExpansionTile(
                                    iconColor: Colors.white,
                                    backgroundColor:dawer == 5
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                    onExpansionChanged: (value){
                                      if(value==true){
                                        setState(() {
                                          dawer=5;
                                        });
                                      }

                                    },
                                    leading: Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: Image.asset(
                                          "assets/icon6.png",
                                          color: dawer == 5 ?  Colors.white : Color(0xff9197B3)
                                      ),
                                    ),

                                    title: Text(
                                      "Fees",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: dawer == 5 ?  Colors.white : Color(0xff9197B3)),
                                    ),

                                    children: [
                                      ListTile(
                                        onTap:(){

                                        },
                                        title: Text("Fee Payment Reg",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 5?  Colors.white : Color(0xff9197B3)),
                                      )),


                                      ExpansionTile(
                                        iconColor: Colors.white,
                                        collapsedIconColor: Colors.white,

                                        title: Text("Fees Master",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 5?  Colors.white : Color(0xff9197B3)),
                                        ),
                                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap:(){
                                              setState(() {
                                                pages=FeesMaster();
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Fees creation",style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: dawer == 5?  Colors.white : Color(0xff9197B3)),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                              onTap:(){
                                                setState(() {
                                                  pages=ClasswiseFees();
                                                });
                                              },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Class Wise fees Master",style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: dawer == 5?  Colors.white : Color(0xff9197B3)),
                                              ),
                                            ),
                                          ),


                                        ],
                                      ),

                                      ExpansionTile(
                                        iconColor: Colors.white,
                                        collapsedIconColor: Colors.white,

                                        title: Text("Fees Reports",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 5?  Colors.white : Color(0xff9197B3)),
                                        ),
                                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Fees Payment reports",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: dawer == 5?  Colors.white : Color(0xff9197B3)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Class Wise",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: dawer == 5?  Colors.white : Color(0xff9197B3)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Student Wise",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: dawer == 5?  Colors.white : Color(0xff9197B3)),
                                            ),
                                          ),
                                        ],
                                      ),



                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: dawer == 6
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                  ),

                                  child:ExpansionTile(
                                    iconColor: Colors.white,
                                    backgroundColor:dawer == 6
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                    onExpansionChanged: (value){
                                      if(value==true){
                                        setState(() {
                                          dawer=6;
                                        });
                                      }

                                    },
                                    leading: Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: Image.asset(
                                          "assets/icon7.png",
                                          color: dawer == 6 ?  Colors.white : Color(0xff9197B3)
                                      ),
                                    ),

                                    title: Text(
                                      "Exams",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: dawer == 6 ?  Colors.white : Color(0xff9197B3)),
                                    ),
                                    children: [
                                      ListTile(
                                        title: Text("Exam Selection",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                      )),
                                      ListTile(
                                        title: Text("Subject Master",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                      )),

                                      ExpansionTile(
                                        iconColor: Colors.white,
                                        collapsedIconColor: Colors.white,

                                        title: Text("Exam Master",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                        ),
                                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Add Exam",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                            ),
                                          ),



                                        ],
                                      ),

                                      ExpansionTile(
                                        iconColor: Colors.white,
                                        collapsedIconColor: Colors.white,

                                        title: Text("Exam Reports",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                        ),
                                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Class Wise",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Subject Wise",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Student Wise",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                            ),
                                          ),
                                        ],
                                      ),



                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: dawer == 8
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                  ),

                                  child:ExpansionTile(
                                    iconColor: Colors.white,
                                    backgroundColor:dawer == 8
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                    onExpansionChanged: (value){
                                      if(value==true){
                                        setState(() {
                                          dawer=8;
                                        });
                                      }

                                    },
                                    leading: Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: Image.asset(

                                        "assets/icon9.png",
                                        color: dawer == 8 ?  Colors.white : Color(0xff9197B3),
                                      ),
                                    ),

                                    title: Text(
                                      "HR ",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: dawer == 8 ?  Colors.white : Color(0xff9197B3)),
                                    ),
                                    children: [
                                      ListTile(
                                        title: Text("Payroll Generation",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 8?  Colors.white : Color(0xff9197B3)),
                                      )),
                                      ListTile(
                                        title: Text("Salary Statement",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 8?  Colors.white : Color(0xff9197B3)),
                                      )),

                                      ExpansionTile(
                                        iconColor: Colors.white,
                                        collapsedIconColor: Colors.white,

                                        title: Text("Payroll Reports",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 8?  Colors.white : Color(0xff9197B3)),
                                        ),
                                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Salary",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: dawer == 8?  Colors.white : Color(0xff9197B3)),
                                            ),
                                          ),



                                        ],
                                      ),





                                    ],
                                  )),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: dawer == 7
                                      ? Color(0xff00A0E3)
                                      : Colors.white,
                                ),
                                child:  ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Image.asset(
                                      "assets/icon8.png",
                                        color: dawer == 7 ?  Colors.white : Color(0xff9197B3)
                                    ),
                                  ),

                                  title: Text(
                                    "Accounts",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: dawer == 7 ?  Colors.white : Color(0xff9197B3)),
                                  ),
                                  onTap: () {
                                    setState(() {

                                      dawer=7;
                                    //  pages=Accountpage();
                                    });
                                  },
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: dawer == 9
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                  ),

                                  child:ExpansionTile(
                                    iconColor: Colors.white,
                                    backgroundColor:dawer == 9
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                    onExpansionChanged: (value){
                                      if(value==true){
                                        setState(() {
                                          dawer=9;
                                        });
                                      }

                                    },
                                    leading: Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child:Icon(
                                        Icons.message,
                                        color: dawer == 9 ?  Colors.white : Color(0xff9197B3),
                                      ),
                                    ),

                                    title: Text(
                                      "Notices",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: dawer == 9 ?  Colors.white : Color(0xff9197B3)),
                                    ),
                                    children: [
                                      ListTile(
                                          title: Text("Send SMS",style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: dawer == 9?  Colors.white : Color(0xff9197B3)),
                                          )),
                                      ListTile(
                                          title: Text("View Previous",style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: dawer == 9?  Colors.white : Color(0xff9197B3)),
                                          )),
                                      ListTile(
                                          title: Text("Individual SMS",style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: dawer == 9?  Colors.white : Color(0xff9197B3)),
                                          )),







                                    ],
                                  )),
                            ),
                            SizedBox(height: height/32.85,)



                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0,top: 20),
            child: Container(
              width: width/1.219,
              height: height/1,

              child: pages,
            ),
          )
        ],
      ),
    );
  }
}
class Dashboard2 extends StatefulWidget {
  const Dashboard2({Key? key}) : super(key: key);

  @override
  State<Dashboard2> createState() => _Dashboard2State();
}

class _Dashboard2State extends State<Dashboard2> {
  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
    return Container(
      width: width/1.707,


        child: Image.asset("assets/Group 78.png",fit: BoxFit.cover,));
  }
}

