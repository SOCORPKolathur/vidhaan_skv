import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Secondpage extends StatefulWidget {
  const Secondpage({Key? key}) : super(key: key);

  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Accounts",
                  style:
                      GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(child: Column(
                children: [
                  Row(
                    children: [
                      Container(child: Image.asset("assets/money.png"),
                        width: width/13.66,
                        height: height/6.57,
decoration:BoxDecoration(gradient:LinearGradient(colors: [Color(0xffD3FFE7),Color(0xffEFFFF6)]),borderRadius: BorderRadius.circular(52)),
                      ),
                      Text("Fee Received",style: GoogleFonts.poppins(),),
                    ],
                  )
                ],
              ),
               // color: Color(0xffFFFFFF),
                width: width/1.517,
                height: height/4.38,
                decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(10)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
