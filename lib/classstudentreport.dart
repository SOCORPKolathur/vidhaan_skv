import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClassStudentReport extends StatefulWidget {
  const ClassStudentReport({Key? key}) : super(key: key);

  @override
  State<ClassStudentReport> createState() => _ClassStudentReportState();
}

class _ClassStudentReportState extends State<ClassStudentReport> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(child: Padding(
            padding: const EdgeInsets.only(left: 38.0,top: 30),
            child: Text("Class Wise Reports",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
          ),
            //color: Colors.white,
            width: 1300,
            height: 80,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0,top: 20),
          child: Container(width: 1300,
            height:520,
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
                            child: Text("Class",style: GoogleFonts.poppins(fontSize: 15,)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0,right: 25),
                            child: Container(child: TextField(
                              style: GoogleFonts.poppins(
                                  fontSize: 15
                              ),
                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                border: InputBorder.none,
                              ),
                            ),
                              width: 350,
                              height: 40,
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
                            padding: const EdgeInsets.only(left: 0.0,right: 25),
                            child: Container(child: TextField(
                              style: GoogleFonts.poppins(
                                  fontSize: 15
                              ),
                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                border: InputBorder.none,
                              ),
                            ),
                              width: 350,
                              height: 40,
                              //color: Color(0xffDDDEEE),
                              decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                            ),
                          ),

                        ],

                      ),
                      Container(child: Center(child: Text("View Reports",style: GoogleFonts.poppins(color:Colors.white),)),
                        width: 160,
                        height: 40,
                        // color:Color(0xff00A0E3),
                        decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 1100,

                    decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 20.0),
                          child: Text("Class",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 8.0),
                          child: Text("Reg Number",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 60.0,right: 8.0),
                          child: Text("Student Name",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80.0,right: 8.0),
                          child: Text("Father Name",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80.0,right: 8.0),
                          child: Text("Mother Name",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 60.0,right: 8.0),
                          child: Text("Phone",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                        ),
                      ],
                    ),

                  ),
                ),

              ],
            ),

          ),
        )
      ],
    );
  }
}
