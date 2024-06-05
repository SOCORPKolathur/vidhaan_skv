import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Accountpage extends StatefulWidget {
  const Accountpage({Key? key}) : super(key: key);

  @override
  State<Accountpage> createState() => _AccountpageState();
}

class _AccountpageState extends State<Accountpage> {
  String currentTab = 'all';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Accounts').orderBy("timestamp",descending: true).snapshots(),
      builder: (ctx, snap) {
        if (snap.hasData) {
          List inwardsList = [];
          List expensesList = [];
          double totalAmount = 0.0;
          double totalReceivedAmount = 0.0;
          double totalSpendAmount = 0.0;
          snap.data!.docs.forEach((element) {
            if (element.get("type").toString().toLowerCase() == "credit") {
              totalReceivedAmount +=
                  double.parse(element.get("amount").toString());
              inwardsList.add(element);
            } else if (element.get("type").toString().toLowerCase() ==
                "debit") {
              totalSpendAmount +=
                  double.parse(element.get("amount").toString());
              expensesList.add(element);
            }
            totalAmount += double.parse(element.get("amount").toString());
          });
          return currentTab == "all"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 718.0, top: 10, bottom: 10),
                      child: Container(
                        child: Text(
                          "Accounts",
                          style: GoogleFonts.poppins(
                              fontSize: width/68.3, fontWeight: FontWeight.bold),
                        ),
                        width: width / 10.507,
                        height: height / 25.269,
                        color: Color(0xffF5F5F5),
//decoration: BoxDecoration(color: Color(0xffF5F5F5),borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 88.0, bottom: 14),
                      child: Container(
                        width: width / 1.02,
                        height: height / 5.475,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xffFFFFFF),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, left: 40),
                              child: Row(
                                children: [
                                  Container(
                                    child: Image.asset("assets/Group 10.png"),
                                    color: Color(0xffFFFFFF),
                                    width: width / 21.015,
                                    height: height / 10.107,
                                  ),
                                  SizedBox(
                                    width: width/136.6,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 38.0),
                                        child: Text(
                                          "Fee received",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: width/113.833333333),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 68.0),
                                        child: Text(
                                          "Rs ${totalReceivedAmount.toStringAsFixed(2)}",
                                          style: GoogleFonts.poppins(
                                              fontSize: width/91.066666667,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 28),
                                    child: Image.asset("assets/linee.png"),
                                  ),
                                  Container(
                                    child: Image.asset("assets/Group 11.png"),
                                    color: Color(0xffFFFFFF),
                                    width: width / 21.015,
                                    height: height / 10.107,
                                  ),
                                  SizedBox(
                                    width: width/136.6,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Expenses",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black, fontSize: width/113.833333333),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 40.0),
                                        child: Text(
                                          "Rs " + totalSpendAmount.toStringAsFixed(2),
                                          style: GoogleFonts.poppins(
                                              fontSize: width/91.066666667,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 28),
                                    child: Image.asset("assets/linee.png"),
                                  ),
                                  Container(
                                    child: Image.asset("assets/Group12.png"),
                                    color: Color(0xffFFFFFF),
                                    width: width / 21.015,
                                    height: height / 10.107,
                                  ),
                                  SizedBox(
                                    width: width/136.6,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          "Total Balance",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: width/113.833333333),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 48.0),
                                        child: Text(
                                          "Rs " + totalAmount.toStringAsFixed(2),
                                          style: GoogleFonts.poppins(
                                              fontSize: width/91.066666667,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: width/45.53333333333333,
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            currentTab = 'inward';
                                          });
                                        },
                                        child: Container(
                                          width: width / 6.83,
                                          //color: Color(0xff00A0E3),
                                          height: height / 16.425,
                                          decoration: BoxDecoration(
                                              color: Color(0xff53B175),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: Center(
                                              child: Text(
                                            "Veiw In- Ward Payments",
                                            style: GoogleFonts.poppins(
                                                color: Color(0xffFFFFFF)),
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        height:height/65.1,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            currentTab = 'expense';
                                          });
                                        },
                                        child: Container(
                                          child: Center(
                                              child: Text(
                                            "View Expenses Payments",
                                            style: GoogleFonts.poppins(
                                                color: Color(0xffFFFFFF)),
                                          )),
                                          width: width / 6.83,
                                          //color: Color(0xff00A0E3),
                                          height: height / 16.425,
                                          decoration: BoxDecoration(
                                              color: Color(0xffFFA002),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                        ),
                                      ),
                                      SizedBox(
                                        height:height/65.1,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 88.0),
                      child: Container(
                        width: width / 1.221,
                        height: height / 1.46,
                        color: Color(0xffFFFFFF),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 28.0, top: 20),
                              child: Text(
                                "Lastest Transaction",
                                style: GoogleFonts.poppins(
                                    fontSize: width/68.3, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height:height/65.1,
                            ),
                            Container(width: width/2.732, child: Divider()),
                            SizedBox(
                              height:height/65.1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: width/10.50769230769231,
                                  child: Text(
                                    'Payment Type',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: width / 81.13),
                                  ),
                                ),
                                Container(
                                  width: width/10.50769230769231,
                                  child: Text(
                                    'Amount',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: width / 81.13),
                                  ),
                                ),
                                Container(
                                  width: width/10.50769230769231,
                                  child: Text(
                                    'Actioned By',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: width / 81.13),
                                  ),
                                ),
                                Container(
                                  width: width/10.50769230769231,
                                  child: Text(
                                    'Date',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: width / 81.13),
                                  ),
                                ),
                                Container(
                                  width: width/10.50769230769231,
                                  child: Text(
                                    'Time',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: width / 81.13),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height:height/1.972727272727273,
                              child: ListView.builder(
                                itemCount: snap.data!.docs.length,
                                itemBuilder: (ctx, i) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 28.0),
                                          child: Container(
                                            child: snap.data!.docs[i]['type']
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "credit"
                                                ? Image.asset(
                                                    "assets/Group 4.png")
                                                : Image.asset(
                                                    "assets/Group 3.png"),
                                            color: Color(0xffFFFFFF),
                                            width: width / 34.15,
                                            height: height / 16.425,
                                          ),
                                        ),
                                        Container(
                                          width: width/8.5375,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, top: 7),
                                                child: Text(
                                                  snap.data!.docs[i]['title'],
                                                  style: GoogleFonts.mulish(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: width/85.375),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20.0, left: 8),
                                                child: Text(
                                                  snap.data!.docs[i]['payee'],
                                                  style: GoogleFonts.mulish(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: width/105.076923077,
                                                      color: Color(0xffA29EBC)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: width/6.83,
                                          child: Text(
                                            "RS ${double.parse(snap.data!.docs[i]['amount'].toString()).toStringAsFixed(2)}",
                                            style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.bold,
                                                fontSize: width/91.066666667,
                                                color: snap.data!
                                                            .docs[i]['type']
                                                            .toString()
                                                            .toLowerCase() ==
                                                        "credit"
                                                    ? Color(0xff53B175)
                                                    : Colors.red),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width/13.66,
                                          child: Text(
                                            snap.data!.docs[i]['receivedBy'],
                                            style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.bold,
                                                fontSize: width/91.066666667,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 100.0),
                                          child: Text(
                                            snap.data!.docs[i]['date'],
                                            style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.bold,
                                                fontSize: width/91.066666667,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 100.0),
                                          child: Text(
                                            snap.data!.docs[i]['time'],
                                            style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.bold,
                                                fontSize: width/91.066666667,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.only(left: 28.0,top: 18),
                            //       child: Container(child: Image.asset("assets/Group 4.png"),
                            //         color:Color(0xffFFFFFF),
                            //         width: width/34.15,
                            //         height: height/16.425,
                            //
                            //       ),
                            //     ),
                            //     Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Padding(
                            //           padding: const EdgeInsets.only(left: 8.0,top: 7),
                            //           child: Text("Fee Received",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/85.375),),
                            //         ),
                            //         Padding(
                            //           padding: const EdgeInsets.only(right: 20.0,left: 8),
                            //           child: Text("Monthly Fee",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontsize: width/105.076923077,color: Color(0xffA29EBC)),),
                            //         ),
                            //
                            //       ],
                            //
                            //     ),
                            //
                            //     Padding(
                            //       padding: const EdgeInsets.only(left: 60.0),
                            //       child: Text("RS 50,000.00",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/91.066666667,color: Color(0xff53B175)),),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(left: 120.0),
                            //       child: Text("Completed",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/91.066666667,color: Color(0xff53B175)),),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(left: 100.0),
                            //       child: Text("01-08-3023",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/91.066666667,color: Colors.black),),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(left: 100.0),
                            //       child: Text("11:50 PM",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/91.066666667,color: Colors.black),),
                            //     ),
                            //
                            //   ],
                            //
                            // ),
                            // SizedBox(height: 8,),
                            // Row(
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.only(left: 28.0,top: 18),
                            //       child: Container(child: Image.asset("assets/Frame 39.png"),
                            //         color:Color(0xffFFFFFF),
                            //         width: width/34.15,
                            //         height: height/16.425,
                            //
                            //       ),
                            //     ),
                            //     Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Padding(
                            //           padding: const EdgeInsets.only(left: 8.0,top: 7),
                            //           child: Text("Maintenance",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/85.375),),
                            //         ),
                            //         Padding(
                            //           padding: const EdgeInsets.only(right: 20.0,left: 8),
                            //           child: Text("Bus Driver",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontsize: width/105.076923077,color: Color(0xffA29EBC)),),
                            //         ),
                            //
                            //       ],
                            //
                            //     ),
                            //
                            //     Padding(
                            //       padding: const EdgeInsets.only(left: 60.0),
                            //       child: Text("RS 20,000.00",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/91.066666667,color: Colors.red),),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(left: 120.0),
                            //       child: Text("Completed",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/91.066666667,color: Color(0xff53B175)),),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(left: 100.0),
                            //       child: Text("02-08-2023",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/91.066666667,color: Colors.black),),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(left: 100.0),
                            //       child: Text("12:57 AM",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/91.066666667,color: Colors.black),),
                            //     ),
                            //
                            //   ],
                            //
                            // ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : currentTab == "inward"
                  ? viewSpecificRecords(inwardsList,'In - Ward')
                  : currentTab == "expense"
                      ? viewSpecificRecords(expensesList, 'Expense')
                      : Container();
        }
        return Container();
      },
    );
  }

  viewSpecificRecords(List docs,String title){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 138.0),
          child: Container(
            width: width / 1.221,
            height:height/1.085,
            decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(left: 28.0, top: 20,right: 28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Center(
                        child: Text(
                          "Lastest  ${title}  Transactions",
                          style: GoogleFonts.poppins(
                              fontSize: width/68.3, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                          onPressed: (){
                            setState(() {
                              currentTab = 'all';
                            });
                          },
                          icon: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Center(
                              child: Icon(
                                Icons.cancel_outlined,
                                color: Colors.white,
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height:height/65.1,
                ),
                Container(width: width/2.732, child: Divider()),
                SizedBox(
                  height:height/65.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: width/10.50769230769231,
                      child: Text(
                        'Payment Type',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: width / 81.13),
                      ),
                    ),
                    Container(
                      width: width/10.50769230769231,
                      child: Text(
                        'Amount',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: width / 81.13),
                      ),
                    ),
                    Container(
                      width: width/10.50769230769231,
                      child: Text(
                        'Received By',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: width / 81.13),
                      ),
                    ),
                    Container(
                      width: width/10.50769230769231,
                      child: Text(
                        'Date',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: width / 81.13),
                      ),
                    ),
                    Container(
                      width: width/10.50769230769231,
                      child: Text(
                        'Time',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: width / 81.13),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    //height:height/1.972727272727273,
                    child: ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (ctx, i) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 28.0),
                                child: Container(
                                  child: docs[i]['type']
                                      .toString()
                                      .toLowerCase() ==
                                      "credit"
                                      ? Image.asset(
                                      "assets/Group 4.png")
                                      : Image.asset(
                                      "assets/Group 3.png"),
                                  color: Color(0xffFFFFFF),
                                  width: width / 34.15,
                                  height: height / 16.425,
                                ),
                              ),
                              Container(
                                width: width/8.5375,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 7),
                                      child: Text(
                                        docs[i]['title'],
                                        style: GoogleFonts.mulish(
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: width/85.375),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20.0, left: 8),
                                      child: Text(
                                        docs[i]['payee'],
                                        style: GoogleFonts.mulish(
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: width/105.076923077,
                                            color: Color(0xffA29EBC)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: width/6.83,
                                child: Text(
                                  "RS ${docs[i]['amount']}",
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width/91.066666667,
                                      color: docs[i]['type']
                                          .toString()
                                          .toLowerCase() ==
                                          "credit"
                                          ? Color(0xff53B175)
                                          : Colors.red),
                                ),
                              ),
                              SizedBox(
                                width: width/13.66,
                                child: Text(
                                  docs[i]['receivedBy'],
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width/91.066666667,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 100.0),
                                child: Text(
                                  docs[i]['date'],
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width/91.066666667,
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 100.0),
                                child: Text(
                                  docs[i]['time'],
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width/91.066666667,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(left: 28.0,top: 18),
                //       child: Container(child: Image.asset("assets/Group 4.png"),
                //         color:Color(0xffFFFFFF),
                //         width: width/34.15,
                //         height: height/16.425,
                //
                //       ),
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.only(left: 8.0,top: 7),
                //           child: Text("Fee Received",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/85.375),),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(right: 20.0,left: 8),
                //           child: Text("Monthly Fee",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontsize: width/105.076923077,color: Color(0xffA29EBC)),),
                //         ),
                //
                //       ],
                //
                //     ),
                //
                //     Padding(
                //       padding: const EdgeInsets.only(left: 60.0),
                //       child: Text("RS 50,000.00",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/91.066666667,color: Color(0xff53B175)),),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 120.0),
                //       child: Text("Completed",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/91.066666667,color: Color(0xff53B175)),),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 100.0),
                //       child: Text("01-08-3023",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/91.066666667,color: Colors.black),),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 100.0),
                //       child: Text("11:50 PM",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/91.066666667,color: Colors.black),),
                //     ),
                //
                //   ],
                //
                // ),
                // SizedBox(height: 8,),
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(left: 28.0,top: 18),
                //       child: Container(child: Image.asset("assets/Frame 39.png"),
                //         color:Color(0xffFFFFFF),
                //         width: width/34.15,
                //         height: height/16.425,
                //
                //       ),
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.only(left: 8.0,top: 7),
                //           child: Text("Maintenance",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/85.375),),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(right: 20.0,left: 8),
                //           child: Text("Bus Driver",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontsize: width/105.076923077,color: Color(0xffA29EBC)),),
                //         ),
                //
                //       ],
                //
                //     ),
                //
                //     Padding(
                //       padding: const EdgeInsets.only(left: 60.0),
                //       child: Text("RS 20,000.00",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/91.066666667,color: Colors.red),),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 120.0),
                //       child: Text("Completed",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/91.066666667,color: Color(0xff53B175)),),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 100.0),
                //       child: Text("02-08-2023",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/91.066666667,color: Colors.black),),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 100.0),
                //       child: Text("12:57 AM",style: GoogleFonts.mulish(fontWeight: FontWeight.bold,fontSize: width/91.066666667,color: Colors.black),),
                //     ),
                //
                //   ],
                //
                // ),
              ],
            ),
          ),
        )
      ],
    );
  }

}
