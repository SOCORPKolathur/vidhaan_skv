import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PayrollReports extends StatefulWidget {
  const PayrollReports({Key? key}) : super(key: key);

  @override
  State<PayrollReports> createState() => _PayrollReportsState();
}

class _PayrollReportsState extends State<PayrollReports> {
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(
            child: Padding(
            padding: const EdgeInsets.only(left: 38.0,top: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Payroll Reports",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 25),
                  child: GestureDetector(
                    onTap:(){
                      setState(() {

                      });

                    },
                    child: Container(child:
                    Center(child: Text("Send Salary for this Month",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
                    ),
                      width: width/4.902,
                      height: height/16.425,
                      //color: Color(0xffDDDEEE),
                      decoration: BoxDecoration(color: const Color(0xffFFA002),borderRadius: BorderRadius.circular(5)),

                    ),
                  ),
                )

              ],
            ),
          ),
            //color: Colors.white,
            width: width/1.050,
            height: height/8.212,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height:height/13.14,
            width: width/1.366,
            decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

            ),
            child: Row(
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 35.0, right: 0),
                  child: Container(
                    width: 90,
                    child: Text(
                      "Reg NO",
                      style:
                      GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width:150,
                  child: Text(
                    "Staff Name",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40,),
                  child: Text(
                    "Designation",
                    style:
                    GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),
                Text(
                  "Salary",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 80.0, right: 45),
                  child: Text(
                    "This Month status",
                    style:
                    GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),

                Text(
                  "Actions",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ],
            ),
            //color: Colors.pink,


          ),
        ),
        Container(
          height: 500,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Staffs").orderBy("timestamp").snapshots(),
              builder: (context,snap){
                return ListView.builder(
                  shrinkWrap: true,
                    itemCount: snap.data!.docs.length,
                    itemBuilder: (context,index){

                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height:height/13.14,
                      width: width/1.366,

                      child: Row(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 85.0,),
                            child: Container(
                              width: 100,

                              child: Text(
                                snap.data!.docs[index]["regno"],
                                style:
                                GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.black),
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            child: Text(
                              snap.data!.docs[index]["stname"],
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                          ),
                          Container(
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 40.0, right: 0,),
                              child: Text(
                                snap.data!.docs[index]["designation"],
                                style:
                                GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.black),
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance.collection("PayrollMaster").where("Designations",isEqualTo: snap.data!.docs[index]["designation"]).snapshots(),
                                builder: (context, snapshot) {
                                  return Text(
                                    snapshot.data!.docs.length>0? snapshot.data!.docs[0]["gross"] : "Not Assigned",
                                    style:
                                    GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.black),
                                  );
                                }
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 80),
                            child: Text(
                              "UnPaid",
                              style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.red),
                            ),
                          ),

                          InkWell(
                            child: Text(
                              "Pay Now",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.indigoAccent),
                            ),
                          ),
                        ],
                      ),
                      //color: Colors.pink,


                    ),
                  );
                });

          }),
        )

      ],
    );
  }
}
