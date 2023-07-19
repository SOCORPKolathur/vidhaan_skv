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
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 718.0,top: 10,bottom: 10),
          child: Container(child: Text("Accounts",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold),),
            width: width/10.507,
            height: height/25.269,
            color: Color(0xffF5F5F5),
//decoration: BoxDecoration(color: Color(0xffF5F5F5),borderRadius: BorderRadius.circular(12)),
          ),
        ),
      Padding(
        padding: const EdgeInsets.only(right: 138.0,bottom: 14),
        child: Container(child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0,left:40),
              child: Row(
                children: [
                  Container(child:  Image.asset("assets/Group 10.png"),
                    color:  Color(0xffFFFFFF),
                    width: width/21.015,
                    height: height/10.107,
                  ),
                  SizedBox(width: 10,),
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

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,right: 28),
                    child: Image.asset("assets/linee.png"),
                  ),
                  Container(child:  Image.asset("assets/Group 11.png"),
                    color:  Color(0xffFFFFFF),
                    width: width/21.015,
                    height: height/10.107,
                  ),
                  SizedBox(width: 10,),
                  Column(
                    children: [
                      Text("Total Expenses",style: GoogleFonts.poppins(color: Color(0xffACACAC),fontSize: 12),),
                      Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: Text("₹2.4K",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 28),
                    child: Image.asset("assets/linee.png"),
                  ),
                  Container(child:  Image.asset("assets/Group12.png"),
                    color:  Color(0xffFFFFFF),
                    width: width/21.015,
                    height: height/10.107,
                  ),
                  SizedBox(width: 10,),
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

                    ],
                  ),
                  SizedBox(width: 30,),
                  Column(
                    children: [
                      Container(
                        child: Center(
                            child: Text(
                              "Veiw In- Ward Payments",
                              style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),
                            )),
                        width: width/6.83,
                        //color: Color(0xff00A0E3),
                        height: height/16.425,
                        decoration: BoxDecoration(
                            color: Color(0xff53B175),
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        child: Center(
                            child: Text(
                              "View Expenses Payments",
                              style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),
                            )),
                        width: width/6.83,
                        //color: Color(0xff00A0E3),
                        height: height/16.425,
                        decoration: BoxDecoration(
                            color: Color(0xffFFA002),
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),

                ],
              ),
            ),

          ],
        ),
          color: Color(0xffFFFFFF),
          width: width/1.221,
          height: height/5.475,
          //decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        ),
      ),
        Padding(
          padding: const EdgeInsets.only(right: 138.0),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width:130,
                          child: Text('Payment Type',style: GoogleFonts.montserrat(
                              fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                          ),),
                        ),
                        Container(
                          width:130,
                          child: Text('Amount',style: GoogleFonts.montserrat(
                              fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                          ),),
                        ),
                        Container(
                          width:130,
                          child: Text('Status',style: GoogleFonts.montserrat(
                              fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                          ),),
                        ),
                        Container(
                          width:130,
                          child: Text('Date',style: GoogleFonts.montserrat(
                              fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                          ),),
                        ),
                        Container(
                          width:130,
                          child: Text('Time',style: GoogleFonts.montserrat(
                              fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                          ),),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0,top: 18),
                          child: Container(child: Image.asset("assets/Group 4.png"),
                            color:Color(0xffFFFFFF),
                            width: width/34.15,
                            height: height/16.425,

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

                  ],

                ),
              ],
            ),
            width: width/1.221,
            height: height/1.46,
            color: Color(0xffFFFFFF),
          ),
        )
      ],
    );
  }
}
