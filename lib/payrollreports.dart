import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
                Text("Payroll Reports for ${DateFormat('MMM yyyy').format(DateTime.now().subtract(Duration(days: 31)))}",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 25),
                  child: GestureDetector(
                    onTap:(){
                      setState(() {

                      });
                    },
                    child: Container(child:
                    Center(child: Text("View Previous Reports",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
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
        FutureBuilder<List<DocumentSnapshot>>(
          future: getPayrolls(),
          builder: (ctx, snap) {
            if(snap.hasData){
              return snap.data!.isEmpty
                  ? Center(
                    child: GestureDetector(
                      onTap:(){
                        generatePayrollForThisMonth();
                      },
                      child: Container(
                        child:
                      Center(child: Text("Generate for this Month",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
                      ),
                        width: width/4.902,
                        height: height/16.425,
                        //color: Color(0xffDDDEEE),
                        decoration: BoxDecoration(color: const Color(0xffFFA002),borderRadius: BorderRadius.circular(5)),

                      ),
                    ),
                  )
                  : Column(
                      children: [
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
                                  "Worked Days",
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                                SizedBox(width: 20),
                                Text(
                                  "Gross Pay",
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
                              ],
                            ),
                            //color: Colors.pink,
                          ),
                        ),
                        Container(
                          height: 480,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snap.data!.length,
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
                                              snap.data![index]["staffid"],
                                              style:
                                              GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          child: Text(
                                            snap.data![index]["staffname"],
                                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 40.0, right: 0,),
                                            child: Text(
                                              snap.data![index]["Designations"],
                                              style:
                                              GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 40.0, right: 60),
                                          child: Text(
                                            snap.data![index]["workedDays"].toString(),
                                            style:
                                            GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.red),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 40.0, right: 120),
                                          child: Text(
                                            snap.data![index]["workedDays"] > 0 ? ((snap.data![index]["gross"] / 24) * snap.data![index]["workedDays"]).toString() : "0.0",
                                            style:
                                            GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.red),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          child: Text(
                                            snap.data![index]["status"] == true ? "Paid" : "UnPaid",
                                            style:
                                            GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //color: Colors.pink,
                                  ),
                                );
                              })
                        )
                      ],
              );
            }return  Center(
              child: CircularProgressIndicator(),
            );
          },
        )
      ],
    );
  }

  generatePayrollForThisMonth() async {
    int workedDays = 0;
    var staffs = await FirebaseFirestore.instance.collection('Staffs').get();
    var document = await FirebaseFirestore.instance.collection("Staff_attendance").get();
    
    for(int i = 0; i < staffs.docs.length; i++){

      for(int j=0;j<document.docs.length;j++){
        var document2 = await FirebaseFirestore.instance.collection("Staff_attendance").doc(document.docs[j].id).collection("Staffs").get();
        var count = document2.docs.where((element) => (element.get("Staffregno") == staffs.docs[i].get("regno") && DateFormat('MMM yyyy').format(DateTime.parse(DateFormat('dd/MM/yyyy').parse(element.get("Date")).toString())) == DateFormat('MMM yyyy').format(DateTime.now())));
        // if(document2.d){
          setState(() {
            workedDays = count.length;
          });
        // }
      }
      
      var payroll = await FirebaseFirestore.instance.collection('Staffs').doc(staffs.docs[i].id).collection('PayrollMaster').get();

      if(payroll.docs.isNotEmpty){
        FirebaseFirestore.instance.collection("Payroll_Reports").doc(DateFormat('MMM yyyy').format(DateTime.now())).set({
          "date" : DateFormat('MMM yyyy').format(DateTime.now()),
        });
        FirebaseFirestore.instance.collection("Payroll_Reports").doc(DateFormat('MMM yyyy').format(DateTime.now())).collection('Staffs').doc(staffs.docs[i].id).set({
          "workedDays" : workedDays,
          "status" : false,
          "assignto": 'Staff',
          "staffname": staffs.docs[i].get('stname'),
          "staffid": staffs.docs[i].get('regno'),
          "Designations": '',
          "basic" : payroll.docs.first.get('basic'),
          "hra" : payroll.docs.first.get('hra'),
          "da" : payroll.docs.first.get('da'),
          "other" : payroll.docs.first.get('other'),
          "gross" : payroll.docs.first.get('gross'),
          "timestamp" : DateTime.now().microsecondsSinceEpoch
        });
      }else{
        FirebaseFirestore.instance.collection("Payroll_Reports").doc(DateFormat('MMM yyyy').format(DateTime.now())).set({
          "date" : DateFormat('MMM yyyy').format(DateTime.now()),
        });
         FirebaseFirestore.instance.collection("Payroll_Reports").doc(DateFormat('MMM yyyy').format(DateTime.now())).collection('Staffs').doc(staffs.docs[i].id).set({
          "workedDays" : workedDays,
          "status" : false,
          "assignto": 'Staff',
          "staffname": staffs.docs[i].get('stname'),
          "staffid": staffs.docs[i].get('regno'),
          "Designations": '',
          "basic" : '0.0',
          "hra" : '0.0',
          "da" : '0.0',
          "other" : '0',
          "gross" : '0.0',
          "timestamp" : DateTime.now().microsecondsSinceEpoch
        });
      }
    }


  }

  Future<List<DocumentSnapshot>> getPayrolls() async {
    List<DocumentSnapshot> payrolls = [];
   var payroll = await FirebaseFirestore.instance.collection("Payroll_Reports").get();

   for(int  i= 0; i < payroll.docs.length; i++){
     if(payroll.docs[i].get("date") == DateFormat('MMM yyyy').format(DateTime.now())){
       var document = await FirebaseFirestore.instance.collection("Payroll_Reports").doc(payroll.docs[i].id).collection('Staffs').get();
       Future.forEach(document.docs, (element){
         payrolls.add(element);
       });
     }
   }

   await Future.delayed(Duration(seconds: 10));
   return payrolls;
  }

}
