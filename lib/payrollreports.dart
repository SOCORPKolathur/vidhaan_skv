import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:month_year_picker/month_year_picker.dart';

class PayrollReports extends StatefulWidget {
  const PayrollReports({Key? key}) : super(key: key);

  @override
  State<PayrollReports> createState() => _PayrollReportsState();
}

class _PayrollReportsState extends State<PayrollReports> {

  List<String> payrollStaffList = [];
  int totalWorkingDyas = 0;
  bool isGeneratingReport = false;
  bool viewPreviuosRecords = false;
  TextEditingController monthController = TextEditingController();

  initState(){
    setAdmin();
  }

  setAdmin() async {
    var admin = await FirebaseFirestore.instance.collection("Admin").get();
    setState(() {
      totalWorkingDyas = admin.docs.first.get("days");
      monthController.text = DateFormat('MMM yyyy').format(DateTime.now().subtract(Duration(days: 31)));
    });
  }
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: viewPreviuosRecords
          ? Column(
        children: [
          Container(
            width: width/1.050,
            height: height/8.212,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.only(left: 38.0,top: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Payroll Reports for ${DateFormat('MMM yyyy').format(DateTime.now().subtract(Duration(days: 31)))}",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0,right: 25),
                    child: IconButton(
                      onPressed:(){
                        setState(() {
                          viewPreviuosRecords = false;
                        });
                      },
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 38.0,top: 0,bottom: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Select Month",style: GoogleFonts.poppins(fontSize: 15,)),
                    Container(child:  TextField(
                      controller: monthController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: width/136.6, left: width/91.06),
                        hintText: "dd/MM/yyyy",
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                      ),
                      onTap: () async {
                        final selected = await showMonthYearPicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if(selected != null){
                          setState(() {
                            monthController.text = DateFormat('MMM yyyy').format(selected);
                          });
                        }
                      },
                    ),
                      width: width/6.902,
                      height: height/16.42,
                      //color: Color(0xffDDDEEE),
                      decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                    ),

                  ],

                ),
              ],
            ),
          ),
          FutureBuilder<List<DocumentSnapshot>>(
            future: getPayrollsByMonth(monthController.text),
            builder: (ctx, snap) {
              if(snap.hasData){
                return snap.data!.isEmpty
                    ? Container(
                  height: 500,
                  child: Center(
                    child: Column(
                      children: [
                        Center(
                          child: Lottie.asset(
                            height: 300,
                            "assets/no_data.json",
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                    : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height:height/13.14,
                        width: width * 0.85,
                        decoration: BoxDecoration(
                          color:Color(0xff00A0E3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            SizedBox(
                              width: 150,
                              child: Center(
                                child: Text(
                                  "Reg NO",
                                  style:
                                  GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: Center(
                                child: Text(
                                  "Staff Name",
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: Center(
                                child: Text(
                                  "Designation",
                                  style:
                                  GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Center(
                                child: Text(
                                  "Worked Days",
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Center(
                                child: Text(
                                  "Gross Pay",
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: Center(
                                child: Text(
                                  "This Month status",
                                  style:
                                  GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //color: Colors.pink,
                      ),
                    ),
                    Container(
                        height: 400,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snap.data!.length,
                            itemBuilder: (context,index){
                              var data = snap.data![index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  height:height/13.14,
                                  width: width * 0.85,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 10),
                                      SizedBox(
                                        width: 150,
                                        child: Center(
                                          child: Text(
                                            data.get("staffid"),
                                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Center(
                                          child: Text(
                                            data.get("staffname"),
                                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Center(
                                          child: Text(
                                            data.get("Designations"),
                                            style:
                                            GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: Center(
                                          child: Text(
                                            data.get("workedDays").toString(),
                                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Center(
                                          child: Text(
                                            data.get("workedDays") > 0 ? ((double.parse(data.get("basic").toString()) / totalWorkingDyas) * data.get("workedDays")).toString() : "0.0",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Center(
                                          child: Text(
                                            data.get("status") == true ? "Paid" : "UnPaid",
                                            style:
                                            GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: data.get("status") == true ? Colors.green : Colors.red,
                                            ),
                                          ),
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
              }return  Container(
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Lottie.asset(
                          "assets/gen_report.json",
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      )
          : Stack(
               alignment: Alignment.center,
               children: [
                 Column(
                   children: [
                     Container(
                       width: width/1.050,
                       height: height/8.212,
                       decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                       child: Padding(
                         padding: const EdgeInsets.only(left: 38.0,top: 0),
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text("Payroll Reports for ${DateFormat('MMM yyyy').format(DateTime.now().subtract(Duration(days: 31)))}",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
                             Padding(
                               padding: const EdgeInsets.only(left: 20.0,right: 25),
                               child: GestureDetector(
                                 onTap:(){
                                   setState(() {
                                     viewPreviuosRecords = true;
                                   });
                                   },
                                 child: Container(
                                   decoration: BoxDecoration(
                                     color: Colors.orange,
                                     borderRadius: BorderRadius.circular(10),
                                   ),
                                   width: width/4.902,
                                   height: height/16.425,
                                   child: Center(
                                     child: Text(
                                       "View Previous Reports",
                                       style: GoogleFonts.poppins(
                                           fontSize: 18,
                                           fontWeight: FontWeight.w500,
                                           color: Colors.white,
                                       ),
                                     ),
                                   ),
                        ),
                      ),
                      )
                    ],
                  ),
                ),
                ),
                      FutureBuilder<List<DocumentSnapshot>>(
                        future: getPayrolls(),
                        builder: (ctx, snap) {
                          if(snap.hasData){
                            return snap.data!.isEmpty
                                ? Container(
                                  height: 500,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Lottie.asset(
                                            height: 400,
                                            "assets/no_data.json",
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap:(){
                                            generatePayrollForThisMonth();
                                          },
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                "Generate for ${DateFormat('MMM yyyy').format(DateTime.now().subtract(Duration(days: 31)))}",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            width: width/4.902,
                                            height: height/16.425,
                                            //color: Color(0xffDDDEEE),
                                            decoration: BoxDecoration(color: const Color(0xffFFA002),borderRadius: BorderRadius.circular(5)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                : Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Container(
                                          height:height/13.14,
                                          width: width * 0.85,
                                          decoration: BoxDecoration(
                                              color:Color(0xff00A0E3),
                                              borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(width: 10),
                                              SizedBox(
                                                width: 60,
                                                child: Center(
                                                  child: Checkbox(
                                                    value: payrollStaffList.isNotEmpty,
                                                    onChanged: (val){
                                                      for(int i = 0; i < snap.data!.length; i++){
                                                        setState(() {
                                                          if(snap.data![i].get("workedDays") > 0 && snap.data![i].get("status") == false){
                                                            if(val!){
                                                              payrollStaffList.add(snap.data![i].get('staffid'));
                                                            }else{
                                                              payrollStaffList.remove(snap.data![i].get('staffid'));
                                                            }
                                                          }else{
                                                            payrollStaffList.remove(snap.data![i].get('staffid'));
                                                          }
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 150,
                                                child: Center(
                                                  child: Text(
                                                    "Reg NO",
                                                    style:
                                                    GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 200,
                                                child: Center(
                                                  child: Text(
                                                    "Staff Name",
                                                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 200,
                                                child: Center(
                                                  child: Text(
                                                    "Designation",
                                                    style:
                                                    GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 150,
                                                child: Center(
                                                  child: Text(
                                                    "Worked Days",
                                                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 100,
                                                child: Center(
                                                  child: Text(
                                                    "Gross Pay",
                                                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 200,
                                                child: Center(
                                                  child: Text(
                                                    "This Month status",
                                                    style:
                                                    GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                                  ),
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
                                              var data = snap.data![index];
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                child: Container(
                                                  height:height/13.14,
                                                  width: width * 0.85,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 10),
                                                      SizedBox(
                                                        width: 60,
                                                        child: Center(
                                                          child: Checkbox(
                                                            value: payrollStaffList.contains(data.get("staffid")),
                                                            onChanged: (val){
                                                              setState(() {
                                                                if(data.get("workedDays") > 0 && data.get("status") == false){
                                                                  if(val!){
                                                                    payrollStaffList.add(data.get('staffid'));
                                                                  }else{
                                                                    payrollStaffList.remove(data.get('staffid'));
                                                                  }
                                                                }else{
                                                                  payrollStaffList.remove(data.get('staffid'));
                                                                }
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 150,
                                                        child: Center(
                                                          child: Text(
                                                            data.get("staffid"),
                                                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 200,
                                                        child: Center(
                                                          child: Text(
                                                            data.get("staffname"),
                                                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 200,
                                                        child: Center(
                                                          child: Text(
                                                            data.get("Designations"),
                                                            style:
                                                            GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 150,
                                                        child: Center(
                                                          child: Text(
                                                            data.get("workedDays").toString(),
                                                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.black),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 100,
                                                        child: Center(
                                                          child: Text(
                                                            data.get("workedDays") > 0 ? ((double.parse(data.get("basic").toString()) / totalWorkingDyas) * data.get("workedDays")).toString() : "0.0",
                                                            style: GoogleFonts.poppins(
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 200,
                                                        child: Center(
                                                          child: Text(
                                                            data.get("status") == true ? "Paid" : "UnPaid",
                                                            style:
                                                            GoogleFonts.poppins(
                                                                fontWeight: FontWeight.bold,
                                                                color: data.get("status") == true ? Colors.green : Colors.red,
                                                            ),
                                                          ),
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
                            // );
                          }return  Container(
                            height: 500,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Lottie.asset(
                                        "assets/gen_report.json",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ],
          ),
          Visibility(
            visible: isGeneratingReport,
            child: Center(
              child: Lottie.asset(
                "assets/loading_.json",
              ),
            ),
          )
        ],
      ),
        floatingActionButton: payrollStaffList.isNotEmpty
            ? InkWell(
          onTap: (){
            payForStaffs(payrollStaffList);
          },
          child: Padding(
            padding: const EdgeInsets.only(left:10.0),
            child: Material(
              borderRadius: BorderRadius.circular(5),
              elevation: 7,
              child: Container(child: Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Pay Now",style: GoogleFonts.poppins(color:Colors.white),textAlign: TextAlign.center,),
                ],
              )),
                width: width/13.507,
                height: height/16.425,
                // color:Color(0xff00A0E3),
                decoration: BoxDecoration(color: const Color(0xff53B175),borderRadius: BorderRadius.circular(5)),

              ),
            ),
          ),
        ) : Container()
    );
  }

  payForStaffs(List<String> selectedStaff) async {
    List<DocumentSnapshot> payRollStaffs = await getPayrolls();

    for(int i = 0; i < selectedStaff.length; i++){
      for(int j = 0; j < payRollStaffs.length; j ++){
        if(selectedStaff[i] == payRollStaffs[j].get("staffid")){
          FirebaseFirestore.instance.collection("Payroll_Reports").doc(DateFormat('MMM yyyy').format(DateTime.now().subtract(Duration(days: 31)))).collection('Staffs').doc(payRollStaffs[j].id).update({
            "status" : true,
          });
          FirebaseFirestore.instance.collection('Staffs').doc(payRollStaffs[j].id).collection('Payroll_Reports').doc(DateFormat('MMM yyyy').format(DateTime.now().subtract(Duration(days: 31)))).set({
            "workedDays" : payRollStaffs[j].get("workedDays"),
            "month" : DateFormat('MMM yyyy').format(DateTime.now().subtract(Duration(days: 31))),
            "status" : true,
            "assignto": 'Staff',
            "staffname": payRollStaffs[j].get("staffname"),
            "staffid": payRollStaffs[j].get("staffid"),
            "Designations": payRollStaffs[j].get("Designations"),
            "basic" : payRollStaffs[j].get("basic"),
            "hra" : payRollStaffs[j].get("hra"),
            "da" : payRollStaffs[j].get("da"),
            "other" : payRollStaffs[j].get("other"),
            "gross" : ((double.parse(payRollStaffs[j].get("basic").toString()) / totalWorkingDyas) * payRollStaffs[j].get("workedDays")).toString(),
            "timestamp" : DateTime.now().millisecondsSinceEpoch
          });
          FirebaseFirestore.instance.collection('Accounts').doc().set({
            "amount" : ((double.parse(payRollStaffs[j].get("gross").toString()) / totalWorkingDyas) * payRollStaffs[j].get("workedDays")).toString(),
            "date" : "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
            "payee" : payRollStaffs[j].get("staffname") + "Salary",
            "receivedBy" : "Admin",
            "time" : DateFormat('hh:mm aa').format(DateTime.now()),
            "timestamp" : DateTime.now().millisecondsSinceEpoch,
            "title" : "Salary Payed",
            "type" : "debit",
          });
        }
      }
    }
    Successdialog();
    setState(() {
      payrollStaffList.clear();
    });
  }


  Successdialog(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Payment Success',
      desc: '',


      btnOkText: "Ok",
      btnOkOnPress: () {

      },
    )..show();
  }

  generatePayrollForThisMonth() async {
    setState(() {
      isGeneratingReport = true;
    });
    int workedDays = 0;
    var staffs = await FirebaseFirestore.instance.collection('Staffs').get();
    var document = await FirebaseFirestore.instance.collection("Staff_attendance").get();
    for(int i = 0; i < staffs.docs.length; i++){
      workedDays =0;
      for(int j=0;j<document.docs.length;j++){
        var document2 = await FirebaseFirestore.instance.collection("Staff_attendance").doc(document.docs[j].id).collection("Staffs").get();
        //var count = document2.docs.where((element) => (element.get("Staffregno") == staffs.docs[i].get("regno") && (DateFormat('dd/MM/yyyy').parse(element.get("Date")).month == DateTime.now().subtract(Duration(days: 30)).month )));
        for(int k = 0; k < document2.docs.length; k ++){
          if(document2.docs[k].get("Staffregno") == staffs.docs[i].get("regno") && DateFormat('dd/MM/yyyy').parse(document2.docs[k].get("Date")).month == DateTime.now().subtract(Duration(days: 30)).month ){
            workedDays++;
          }
        }
      }
      var payroll = await FirebaseFirestore.instance.collection('Staffs').doc(staffs.docs[i].id).collection('PayrollMaster').get();
      if(payroll.docs.isNotEmpty){
        FirebaseFirestore.instance.collection("Payroll_Reports").doc(DateFormat('MMM yyyy').format(DateTime.now().subtract(Duration(days: 31)))).set({
          "date" : DateFormat('MMM yyyy').format(DateTime.now().subtract(Duration(days: 31))),
        });
        FirebaseFirestore.instance.collection("Payroll_Reports").doc(DateFormat('MMM yyyy').format(DateTime.now().subtract(Duration(days: 31)))).collection('Staffs').doc(staffs.docs[i].id).set({
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
          "timestamp" : DateTime.now().subtract(Duration(days: 31)).millisecondsSinceEpoch
        });
      }else{
        FirebaseFirestore.instance.collection("Payroll_Reports").doc(DateFormat('MMM yyyy').format(DateTime.now().subtract(Duration(days: 31)))).set({
          "date" : DateFormat('MMM yyyy').format(DateTime.now().subtract(Duration(days: 31))),
        });
         FirebaseFirestore.instance.collection("Payroll_Reports").doc(DateFormat('MMM yyyy').format(DateTime.now().subtract(Duration(days: 31)))).collection('Staffs').doc(staffs.docs[i].id).set({
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
          "timestamp" : DateTime.now().subtract(Duration(days: 31)).millisecondsSinceEpoch
        });
      }
    }

    setState(() {
      isGeneratingReport = false;
    });
  }

  Future<List<DocumentSnapshot>> getPayrolls() async {
    List<DocumentSnapshot> payrolls = [];
   var payroll = await FirebaseFirestore.instance.collection("Payroll_Reports").get();
   for(int  i= 0; i < payroll.docs.length; i++){
     if(payroll.docs[i].get("date") == DateFormat('MMM yyyy').format(DateTime.now().subtract(Duration(days: 31)))){
       var document = await FirebaseFirestore.instance.collection("Payroll_Reports").doc(payroll.docs[i].id).collection('Staffs').get();
       for(int j = 0; j < document.docs.length; j++){
         payrolls.add(document.docs[j]);
       }
     }
   }
   return payrolls;
  }

  Future<List<DocumentSnapshot>> getPayrollsByMonth(String month) async {
    List<DocumentSnapshot> payrolls = [];
    var payroll = await FirebaseFirestore.instance.collection("Payroll_Reports").get();
    for(int  i= 0; i < payroll.docs.length; i++){
      if(payroll.docs[i].get("date") == month){
        var document = await FirebaseFirestore.instance.collection("Payroll_Reports").doc(payroll.docs[i].id).collection('Staffs').get();
        for(int j = 0; j < document.docs.length; j++){
          payrolls.add(document.docs[j]);
        }
      }
    }
    return payrolls;
  }
}


class PayRollReportsModel{
  PayRollReportsModel({required this.isSelected, required this.staff});
  bool isSelected;
  DocumentSnapshot staff;
}
