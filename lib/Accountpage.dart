import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Accountpage extends StatefulWidget {
  const Accountpage({Key? key}) : super(key: key);

  @override
  State<Accountpage> createState() => _AccountpageState();
}

class _AccountpageState extends State<Accountpage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 718.0,top: 30,bottom: 10),
          child: Container(child: Text("Accounts",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold),),
            width: 130,
            height: 26,
            color: Color(0xffF5F5F5),
//decoration: BoxDecoration(color: Color(0xffF5F5F5),borderRadius: BorderRadius.circular(12)),
          ),
        ),
      Padding(
        padding: const EdgeInsets.only(right: 138.0,bottom: 14),
        child: Container(child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 28.0,left:40),
              child: Row(
                children: [
                  Container(child:  Image.asset("assets/Group 10.png"),
                    color:  Color(0xffFFFFFF),
                    width: 65,
                    height: 65,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 38.0),
                        child: Text("Fee received",style: GoogleFonts.poppins(color: Color(0xffACACAC),fontSize: 12),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:68.0),
                        child: Text("₹198K",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0,top: 8),
                        child: Row(
                          children: [
                            Image.asset("assets/arrow.png"),
                            Text("37.8%",style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.bold,color: Color(0xff00AC4F)),),
                            Text("this month",style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.bold),),

                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,right: 28),
                    child: Image.asset("assets/linee.png"),
                  ),
                  Container(child:  Image.asset("assets/Group 11.png"),
                    color:  Color(0xffFFFFFF),
                    width: 65,
                    height: 65,
                  ),
                  Column(
                    children: [
                      Text("Total Expenses",style: GoogleFonts.poppins(color: Color(0xffACACAC),fontSize: 12),),
                      Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: Text("₹2.4K",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0,top: 8),
                        child: Row(
                          children: [
                            Image.asset("assets/arrow1.png"),
                            Text("2%",style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.bold,color: Color(0xffDA001A)),),
                            Text("this month",style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.bold),),

                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 28),
                    child: Image.asset("assets/linee.png"),
                  ),
                  Container(child:  Image.asset("assets/Group12.png"),
                    color:  Color(0xffFFFFFF),
                    width: 65,
                    height: 65,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text("Total Balance",style: GoogleFonts.poppins(color: Color(0xffACACAC),fontSize: 12),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 48.0),
                        child: Text("₹ 89K",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,top: 8),
                        child: Row(
                          children: [
                            Image.asset("assets/arrow.png"),
                            Text("11%",style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.bold,color: Color(0xff00AC4F)),),
                            Text("this month",style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.bold),),

                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
          color: Color(0xffFFFFFF),
          width: 750,
          height: 120,
          //decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        ),
      ),
        Padding(
          padding: const EdgeInsets.only(right: 408.0),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0,top: 20),
                        child: Text("Lastest Transaction",style: GoogleFonts.mulish(fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 208.0,top: 20),
                        child: Image.asset("assets/vec.png"),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0,top: 18),
                          child: Container(child: Image.asset("assets/Ellipse.png"),
                            color: Color(0xffFFFFFF),
                            width: 40,
                            height: 40,

                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12.0,top: 7),
                                      child: Text("Transfer to",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: 16),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0,top: 7),
                                      child: Text("Johdi",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: 16,color: Color(0xff4C49ED)),),
                                    ),
                                  ],

                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Text("Event Manager",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: 13,color: Color(0xffA29EBC)),),
                                ),

                              ],

                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 198.0),
                          child: Text("-\$35.00",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: 15,color: Color(0xffD14F4F)),),
                        ),

                      ],

                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0,top: 18),
                          child: Container(child: Image.asset("assets/Ellipse 1.png"),
                            color: Color(0xffFFFFFF),
                            width: 40,
                            height: 40,

                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12.0,top: 7),
                                      child: Text("School ID",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: 16),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0,top: 7),
                                      child: Text("Cards",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: 16),),
                                    ),
                                  ],

                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 80.0),
                                  child: Text("Exp",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: 13,color: Color(0xffA29EBC)),),
                                ),

                              ],

                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 198.0),
                          child: Text("-\$128.00",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: 15,color: Color(0xffD14F4F)),),
                        ),

                      ],

                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0,top: 18),
                          child: Container(child: Image.asset("assets/Group 1.png"),
                            color:Color(0xffFFFFFF),
                            width: 40,
                            height: 40,

                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 7,right: 44,left:14),
                                      child: Text("Canteen",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: 16),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0,top: 7),
                                      child: Text("",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: 16),),
                                    ),
                                  ],

                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30.0),
                                  child: Text("Maintance",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: 13,color: Color(0xffA29EBC)),),
                                ),

                              ],

                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 204.0),
                          child: Text("-\$10.00",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: 15,color: Color(0xffD14F4F)),),
                        ),

                      ],

                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0,top: 18),
                          child: Container(child: Image.asset("assets/Group 4.png"),
                            color:Color(0xffFFFFFF),
                            width: 40,
                            height: 40,

                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,top: 7),
                                      child: Text("Fee Received",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: 16),),
                                    ),

                                  ],

                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0,left: 15),
                                  child: Text("Monthly Fee",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: 13,color: Color(0xffA29EBC)),),
                                ),

                              ],

                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 218.0),
                          child: Text("+\$300.00",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: 15,color: Color(0xff6ED69E)),),
                        ),

                      ],

                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0,top: 18),
                          child: Container(child: Image.asset("assets/Group 3.png"),
                            color: Color(0xffFFFFFF),
                            width: 40,
                            height: 40,

                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12.0,top: 7),
                                      child: Text("Withdrawal    ",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: 16),),
                                    ),

                                  ],

                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30.0,left: 4),
                                  child: Text("Manitance",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: 13,color: Color(0xffA29EBC)),),
                                ),

                              ],

                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 208.0),
                          child: Text("-\$128.00",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: 15,color: Color(0xffD14F4F)),),
                        ),

                      ],

                    ),
                  ],

                ),
              ],
            ),
            width: 480,
            height: 450,
            color: Color(0xffFFFFFF),
          ),
        )
      ],
    );
  }
}
