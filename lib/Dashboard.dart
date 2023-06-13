import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vidhaan/studetails.dart';

import 'Accountpage.dart';
import 'admission.dart';







class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool dashboard = false;
  bool Admission = false;
  bool Student = false;
  bool Staff = false;
  bool Attendence = false;
  bool Fee = false;
  bool Exam = false;
  bool Accounts = false;
  bool Hr = false;
  bool Record = false;
  int dawer = 0;
  var pages;
  bool color=true;
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
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Row(
        children: [
          Container(
            width: 230,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,top: 20),
                  child: Material(
                  elevation: 20,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(

                      width: 273,
                      height: 630,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
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
                            width: 280,
                            height: 100,

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
                                  padding: const EdgeInsets.only(left: 18.0),
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
                                borderRadius: BorderRadius.circular(8),
                                color: dawer == 1 ?Color(0xff00A0E3) : Colors.transparent,
                              ),
                              child: ListTile(


                                leading: Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Image.asset(
                                    "assets/icon2.png",
                                    color: dawer == 1 ?  Colors.white : Color(0xff9197B3),
                                  ),
                                ),

                                title: Text(
                                  "Admission",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: dawer == 1?  Colors.white : Color(0xff9197B3)),
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

                                child: ListTile(
                                  title: Text(
                                    "Student",
                                    style: GoogleFonts.poppins(
                                        color: dawer == 2 ?  Colors.white : Color(0xff9197B3),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  leading: Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Image.asset("assets/icon3.png",color: dawer == 2 ?  Colors.white : Color(0xff9197B3),),
                                  ),

                                  onTap: () {
                                    setState(() {
                                      pages= studetails();
                                      dawer=2;
                                    });
                                  },
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
                              child:ListTile(


                                leading: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Image.asset(
                                    "assets/icon4.png",
                                   color: dawer == 3 ?  Colors.white : Color(0xff9197B3),
                                  ),
                                ),

                                title: Text(
                                  "Staff",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: dawer == 3 ?  Colors.white : Color(0xff9197B3)),
                                ),
                                onTap: () {
                                  setState(() {

                                    dawer=3;
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
                                color: dawer == 4
                                    ?Color(0xff00A0E3)
                                    : Colors.transparent,
                              ),
                              child:ListTile(


                                leading: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Image.asset(
                                    "assets/icon5.png",
                                      color: dawer == 4 ?  Colors.white : Color(0xff9197B3)
                                  ),
                                ),

                                title: Text(
                                  "Attendence & Timatable",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: dawer == 4 ?  Colors.white : Color(0xff9197B3)),
                                ),
                                onTap: () {
                                  setState(() {

                                    dawer=4;
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
                                color: dawer == 5
                                    ?Color(0xff00A0E3)
                                    : Colors.transparent,
                              ),
                              child: ListTile(


                                leading: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Image.asset(
                                    "assets/icon6.png",
                                      color: dawer == 5 ?  Colors.white : Color(0xff9197B3)
                                  ),
                                ),

                                title: Text(
                                  "Fee Management",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: dawer == 5 ?  Colors.white : Color(0xff9197B3)),
                                ),
                                onTap: () {
                                  setState(() {

                                    dawer=5;
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
                                color: dawer == 6
                                    ? Color(0xff00A0E3)
                                    : Colors.transparent,
                              ),
                              child: ListTile(


                                leading: Padding(
                                  padding: const EdgeInsets.only(left: 13.0),
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
                                onTap: () {
                                  setState(() {

                                    dawer=6;
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
                                color: dawer == 7
                                    ? Color(0xff00A0E3)
                                    : Colors.white,
                              ),
                              child:  ListTile(
                                leading: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
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
                                    pages=Accountpage();
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
                                color: dawer == 8
                                    ? Color(0xff00A0E3)
                                    : Colors.transparent,
                              ),
                              child: ListTile(


                                leading: Padding(
                                  padding: const EdgeInsets.only(left: 13.0),
                                  child: Image.asset(

                                    "assets/icon9.png",
                                    color: dawer == 8 ?  Colors.white : Color(0xff9197B3),
                                  ),
                                ),

                                title: Text(
                                  "HR Management",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: dawer == 8 ?  Colors.white : Color(0xff9197B3)),
                                ),
                                onTap: () {
                                  setState(() {

                                    dawer=8;
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
                                    ? Color(0xff00A0E3)
                                    : Colors.transparent,
                              ),
                              child:ListTile(


                                leading: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Image.asset(
                                    "assets/icon10.png",
                                    color: dawer == 9 ?  Colors.white : Color(0xff9197B3),
                                  ),
                                ),

                                title: Text(
                                  "Records",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: dawer == 9 ?  Colors.white : Color(0xff9197B3)),
                                ),
                                onTap: () {
                                  setState(() {

                                    dawer=9;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
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
              width: 1000,
              height: 657,
              color: Color(0xffF5F5F5),
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
    return Container(
      width: 800,


        child: Image.asset("assets/Group 78.png",fit: BoxFit.cover,));
  }
}

