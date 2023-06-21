import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Studentsearch extends StatefulWidget {
  const Studentsearch({Key? key}) : super(key: key);

  @override
  State<Studentsearch> createState() => _StudentsearchState();
}

class _StudentsearchState extends State<Studentsearch> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(child: Padding(
            padding: const EdgeInsets.only(left: 38.0,top: 30),
            child: Text("Search Student",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
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
                      child: Text("Register Number",style: GoogleFonts.poppins(fontSize: 15,)),
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
                      child: Text("Student Name",style: GoogleFonts.poppins(fontSize: 15,)),
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
                Container(child: Center(child: Text("Search",style: GoogleFonts.poppins(color:Colors.white),)),
                  width: 130,
                  height: 40,
                  // color:Color(0xff00A0E3),
                  decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                ),
              ],
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
