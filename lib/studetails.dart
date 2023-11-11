import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class studetails extends StatefulWidget {
  const studetails({Key? key}) : super(key: key);

  @override
  State<studetails> createState() => _studetailsState();
}

class _studetailsState extends State<studetails> {
  var page;

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return
      page==null?
      Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top:20,right: 850),
          child: Text("Students",style: GoogleFonts.poppins(fontSize: width/68.3,fontWeight: FontWeight.bold),),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 68.0,top: 30),
              child: GestureDetector(onTap: () {
                setState(() {
                  page=2;
                });
              },
                child: Container(child: Center(child: Text("Class 1",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                  // color: Color(0xffEFE7FF),
                  width: 150,
                  height: 100,
                  decoration: BoxDecoration(  color: Color(0xffEFE7FF),borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 68.0,top: 30),
              child: Container(child: Center(child: Text("Class 2",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                // color: Color(0xffEFE7FF),
                width: width/9.1066,
                height: height/6.57,
                decoration: BoxDecoration(  color: Color(0xffEFE7FF),borderRadius: BorderRadius.circular(12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 68.0,top: 30),
              child: Container(child: Center(child: Text("Class 3",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                // color: Color(0xffEFE7FF),
                width: width/9.1066,
                height: height/6.57,
                decoration: BoxDecoration(  color: Color(0xffEFE7FF),borderRadius: BorderRadius.circular(12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 68.0,top: 30),
              child: Container(child: Center(child: Text("Class 4",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                // color: Color(0xffEFE7FF),
                width: width/9.1066,
                height: height/6.57,
                decoration: BoxDecoration(  color: Color(0xffEFE7FF),borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 68.0,top: 30),
              child: Container(child: Center(child: Text("Class 5",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                // color: Color(0xffEFE7FF),
                width: width/9.1066,
                height: height/6.57,
                decoration: BoxDecoration(  color: Color(0xffEFE7FF),borderRadius: BorderRadius.circular(12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 68.0,top: 30),
              child: Container(child: Center(child: Text("Class 6",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                // color: Color(0xffEFE7FF),
                width: width/9.1066,
                height: height/6.57,
                decoration: BoxDecoration(  color: Color(0xffEFE7FF),borderRadius: BorderRadius.circular(12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 68.0,top: 30),
              child: Container(child: Center(child: Text("Class 7",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                // color: Color(0xffEFE7FF),
                width: width/9.1066,
                height: height/6.57,
                decoration: BoxDecoration(  color: Color(0xffEFE7FF),borderRadius: BorderRadius.circular(12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 68.0,top: 30),
              child: Container(child: Center(child: Text("Class 8",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                // color: Color(0xffEFE7FF),
                width: width/9.1066,
                height: height/6.57,
                decoration: BoxDecoration(  color: Color(0xffEFE7FF),borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 68.0,top: 30),
              child: Container(child: Center(child: Text("Class 9",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                // color: Color(0xffEFE7FF),
                width: width/9.1066,
                height: height/6.57,
                decoration: BoxDecoration(  color: Color(0xffEFE7FF),borderRadius: BorderRadius.circular(12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 68.0,top: 30),
              child: Container(child: Center(child: Text("Class 10",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                // color: Color(0xffEFE7FF),
                width: width/9.1066,
                height: height/6.57,
                decoration: BoxDecoration(  color: Color(0xffEFE7FF),borderRadius: BorderRadius.circular(12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 68.0,top: 30),
              child: Container(child: Center(child: Text("Class 11",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                // color: Color(0xffEFE7FF),
                width: width/9.1066,
                height: height/6.57,
                decoration: BoxDecoration(  color: Color(0xffEFE7FF),borderRadius: BorderRadius.circular(12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 68.0,top: 30),
              child: Container(child: Center(child: Text("Class 12",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                // color: Color(0xffEFE7FF),
                width: width/9.1066,
                height: height/6.57,
                decoration: BoxDecoration(  color: Color(0xffEFE7FF),borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ],
    )
    : Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28.0,bottom: 20,left: 20),
            child: Text("Class 1",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/68.3),),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(child: Center(child: Text("Section A",style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),)),
               // color: Color(0xff00A0E3),
                width: width/8.035,
                height: height/16.425,
                decoration: BoxDecoration(  color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)),
              ),
              Container(child: Center(child: Text("Section B",style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),)),
                // color: Color(0xff00A0E3),
                width: width/8.035,
                height: height/16.425,
                decoration: BoxDecoration(  color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)),
              ),
              Container(child: Center(child: Text("Section C",style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),)),
                // color: Color(0xff00A0E3),
                width: width/8.035,
                height: height/16.425,
                decoration: BoxDecoration(  color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)),
              ),
              Container(child: Center(child: Text("Section D",style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),)),
                // color: Color(0xff00A0E3),
                width: width/8.035,
                height: height/16.425,
                decoration: BoxDecoration(  color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28.0,left: 50),
            child: Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 40),
                    child: Text(
                      "Roll No",
                      style:
                      GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Student Name",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40),
                    child: Text(
                      "Phone no",
                      style:
                      GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Parent name",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40),
                    child: Text(
                      "Attendence%",
                      style:
                      GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Exam%",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40),
                    child: Text(
                      "Last Marks",
                      style:
                      GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Actions",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              //color: Colors.pink,
              width: width/1.349,
              height: height/13.14,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 42.0,top: 30),
            child: Container(
              width: width/1.349,
              height: height/13.14,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)),
            ),
          )
        ],
      );
  }
}
