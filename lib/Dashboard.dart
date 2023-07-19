

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:random_string/random_string.dart';

import 'package:vidhaan/attendence.dart';
import 'package:vidhaan/classincharge.dart';
import 'package:vidhaan/fees/fees.dart';
import 'package:vidhaan/notification.dart';
import 'package:vidhaan/staffattdence.dart';

import 'package:vidhaan/stafflist.dart';
import 'package:vidhaan/studentlist.dart';

import 'package:vidhaan/staff%20entry.dart';
import 'package:vidhaan/timetable/stafftimetable.dart';
import 'package:vidhaan/timetable/subtution.dart';

import 'package:vidhaan/timetable/subjectteacher.dart';
import 'package:vidhaan/timetable/timetable.dart';
import 'package:vidhaan/view%20previous.dart';


import 'Accountpage.dart';
import 'Masters/desigination.dart';
import 'Masters/staffidcard.dart';
import 'Masters/student id card.dart';
import 'fees/classwisefeemaster.dart';

import 'admission.dart';

import 'dashboadrmain.dart';

import 'fees/feesreports.dart';
import 'leavemanagement.dart';
import 'studententry.dart';

import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';






class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int dawer = 0;
  var pages;
  @override
  void initState() {
    setState(() {
      pages=Dashboard2();
    });
    // TODO: implement initState
    super.initState();
  }
  ExpansionTileController admissioncon= new ExpansionTileController();
  ExpansionTileController studdentcon= new ExpansionTileController();
  ExpansionTileController staffcon= new ExpansionTileController();
  ExpansionTileController attdencecon= new ExpansionTileController();
  ExpansionTileController feescon= new ExpansionTileController();
  ExpansionTileController examcon= new ExpansionTileController();
  ExpansionTileController hrcon= new ExpansionTileController();
  ExpansionTileController noticescon= new ExpansionTileController();
  ExpansionTileController timetable= new ExpansionTileController();

  List<String> rowdetail = [];
  String studentid = "";
  _importFromExcel() async {}


  Future<void> _bulkuploadstudent() async {
    return showDialog<void>(
      context: context,

      builder: (BuildContext context) {
        bool selectfile=false;
        double width=MediaQuery.of(context).size.width;
        double height=MediaQuery.of(context).size.height;
        return StatefulBuilder(
          builder: (context,setState) {
            return AlertDialog(
              title:  Text(selectfile==false?'Bulk Upload Students': "Your File is Uploaded to Database",style: GoogleFonts.poppins(
                  color: Colors.black, fontSize:18,fontWeight: FontWeight.w600),),
              content:  Container(
                  width: 350,
                  height: 250,

                 child: selectfile==false? Lottie.asset("assets/file choosing.json"):Lottie.asset("assets/uploaded.json",repeat: false)),
                  //child:  Lottie.asset("assets/file choosing.json")),
              actions: <Widget>[
                selectfile==false?  InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(5),
                    elevation: 7,
                    child: Container(child: Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.cancel,color: Colors.white,),
                        ),
                        Text("Cancel",style: GoogleFonts.poppins(color:Colors.white),),
                      ],
                    )),
                      width: width/10.507,
                      height: height/20.425,
                      // color:Color(0xff00A0E3),
                      decoration: BoxDecoration(color:  Colors.red,borderRadius: BorderRadius.circular(5)),

                    ),
                  ),
                ): Container(),
                selectfile==false?  InkWell(
                  onTap: () async {

                    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['xlsx'],
                      allowMultiple: false,
                    );


                    var bytes = pickedFile!.files.single.bytes;
                    var excel = Excel.decodeBytes(bytes!);


                    final row = excel.tables[excel.tables.keys.first]!.rows
                        .map((e) => e.map((e) => e!.value).toList()).toList();

                    for(int i = 1;i <row.length;i++) {
                      print(row[i][1]);
                      setState(() {
                        studentid=randomAlphaNumeric(16);
                      });
                      FirebaseFirestore.instance.collection("Students").doc(studentid).set({
                        "stname": row[i][3].toString(),
                        "stmiddlename": "",
                        "stlastname": "",
                        "regno": "VDSB${i.toString().padLeft(3, '0')}",
                        "studentid": studentid,
                        "entrydate": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        "admitclass":row[i][0].toString(),
                        "section": row[i][1].toString(),
                        "academic": row[i][2].toString(),
                        "bloodgroup": row[i][4].toString(),
                        "dob": row[i][5].toString(),
                        "gender": row[i][7].toString(),
                        "address": row[i][14].toString(),
                        "community": row[i][8].toString(),
                        "house": row[i][11].toString(),
                        "religion": row[i][10].toString(),
                        "mobile": row[i][12].toString(),
                        "email": row[i][13].toString(),
                        "aadhaarno": row[i][18].toString(),
                        "sheight": row[i][16].toString(),
                        "stweight": row[i][17].toString(),
                        "EMIS": row[i][19].toString(),
                        "transport": row[i][20].toString(),
                        "identificatiolmark": row[i][15].toString(),

                        "fathername": row[i][21].toString(),
                        "fatherOccupation": row[i][22].toString(),
                        "fatherOffice":row[i][23].toString(),
                        "fatherMobile": row[i][25].toString(),
                        "fatherEmail": "",
                        "fatherAadhaar": row[i][26].toString(),

                        "mothername": row[i][27].toString(),
                        "motherOccupation": row[i][28].toString(),
                        "motherOffice":row[i][29].toString(),
                        "motherMobile": row[i][31].toString(),
                        "motherEmail":"",
                        "motherAadhaar": row[i][32].toString(),

                        "guardianname": row[i][36].toString(),
                        "guardianOccupation": row[i][38].toString(),
                        "guardianMobile": row[i][37].toString(),
                        "guardianEmail": "",
                        "guardianAadhaar": "",

                        "brother studying here": row[i][34].toString(),
                        "brothername": "${row[i][33].toString()} - ${row[i][35].toString()}",

                        "imgurl":"",
                        "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        "time": "${DateTime.now().hour}:${DateTime.now().minute}",
                        "timestamp": DateTime.now().microsecondsSinceEpoch,
                        "absentdays":0,
                        "behaviour":0,
                      });
                    }
                    setState(() {
                      selectfile=true;
                    });


                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(5),
                    elevation: 7,
                    child: Container(child: Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.file_upload,color: Colors.white,),
                        ),
                        Text("Select Excel",style: GoogleFonts.poppins(color:Colors.white),),
                      ],
                    )),
                      width: width/10.507,
                      height: height/20.425,
                      // color:Color(0xff00A0E3),
                      decoration: BoxDecoration(color:  Colors.green,borderRadius: BorderRadius.circular(5)),

                    ),
                  ),
                ) :
                InkWell(
                  onTap: (){
                   Navigator.pop(context);

                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(5),
                    elevation: 7,
                    child: Container(child: Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text("Ok",style: GoogleFonts.poppins(color:Colors.white),),
                      ],
                    )),
                      width: width/10.507,
                      height: height/20.425,
                      // color:Color(0xff00A0E3),
                      decoration: BoxDecoration(color:  Colors.green,borderRadius: BorderRadius.circular(5)),

                    ),
                  ),
                ),
              ],
            );
          }
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Row(
        children: [
          Container(
            width: width/5.939,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,top: 20),
                  child: Material(
                  elevation: 20,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(

                      width: width/5.003,
                      height: height/1.0428,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [

                            Container(
                              child: Row(
                                children: [
                                  Image.asset("assets/imagevidh.png"),
                                  Column(

                                    children: [
                                      SizedBox(height:35),
                                      Container(

                                          width: 100,
                                          child: Image.asset("assets/VIDHAANTEXT.png")),
                                      Text("e    d    u    c    a    r    e",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: 8),)
                                    ],
                                  ),

                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              width: width/4.878,
                              height: height/6.57,

                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: dawer == 0
                                      ? Color(0xff00A0E3) : Colors.transparent,
                                ),
                                child: ListTile(


                                  leading: Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Image.asset(dawer == 0
                                        ? "assets/iconwhite.png" : "assets/icon1.png",
                                      color: dawer == 0 ?  Colors.white : Color(0xff9197B3),
                                    ),
                                  ),

                                  title: Text(
                                    "Dashboard",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: dawer == 0 ?  Colors.white : Color(0xff9197B3)),
                                  ),
                                  onTap: () {
                                    admissioncon.collapse();
                                    studdentcon.collapse();
                                    staffcon.collapse();
                                    attdencecon.collapse();
                                    feescon.collapse();
                                    examcon.collapse();
                                    hrcon.collapse();
                                    timetable.collapse();
                                    noticescon.collapse();
                                    setState(() {
                                      pages = Dashboard2();
                                      dawer=0;

                                    });
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: dawer == 1
                                      ? Color(0xff00A0E3) : Colors.transparent,
                                ),
                                child: ExpansionTile(
                                  controller: admissioncon,

                                  iconColor: Colors.white,
                                  backgroundColor:dawer == 1
                                      ?Color(0xff00A0E3)
                                      : Colors.transparent,
                                  onExpansionChanged: (value){
                                    if(value==true){

                                      studdentcon.collapse();
                                      staffcon.collapse();
                                      attdencecon.collapse();
                                      feescon.collapse();
                                      examcon.collapse();
                                      hrcon.collapse();
                                      timetable.collapse();
                                      noticescon.collapse();
                                      setState(() {
                                        dawer=1;
                                      });
                                    }

                                  },
                                  leading: Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Image.asset("assets/icon2.png",color: dawer == 1 ?  Colors.white : Color(0xff9197B3),),
                                  ),
                                  title: Text("Admission",style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: dawer == 1?  Colors.white : Color(0xff9197B3)),
                                  ),
                                  children: [
                                    ListTile(
                                        onTap:(){
                                          setState((){
                                            pages=admission();
                                          });
                                        },
                                        title: Text("Admission Enquiries",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 1?  Colors.white : Color(0xff9197B3)),
                                        )),
                                    ListTile(
                                        onTap:(){
                                          setState((){
                                            pages=StudentEntry();
                                          });

                                        },
                                        title: Text("Students Admission Entry",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 1?  Colors.white : Color(0xff9197B3)),
                                        )),
                                    ListTile(
                                        onTap:(){
                                          setState((){
                                          pages=StudentID();
                                          });

                                        },
                                        title: Text("Students ID CARD",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 1?  Colors.white : Color(0xff9197B3)),
                                        )),





                                  ],
                                )
                              ),
                            ),



                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: dawer == 2
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                  ),

                                  child:ExpansionTile(
                                    controller: studdentcon,
                                    iconColor: Colors.white,
                                    backgroundColor:dawer == 2
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                    onExpansionChanged: (value){
                                      if(value==true){
                                        admissioncon.collapse();
                                        staffcon.collapse();
                                        attdencecon.collapse();
                                        feescon.collapse();
                                        examcon.collapse();
                                        hrcon.collapse();
                                        timetable.collapse();
                                        noticescon.collapse();
                                        setState(() {
                                          dawer=2;
                                        });
                                      }

                                    },
                                    leading: Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                child: Image.asset("assets/icon3.png",color: dawer == 2 ?  Colors.white : Color(0xff9197B3),),
                              ),
                                    title: Text("Students",style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: dawer == 2?  Colors.white : Color(0xff9197B3)),
                                    ),
                                    children: [
                                      ListTile(
                                        onTap:(){
                                          setState((){
                                            pages=StudentList();
                                          });

                              },
                                        title: Text("Students List",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 2?  Colors.white : Color(0xff9197B3)),
                                      )),
                                      ListTile(
                                        onTap:(){
                                          setState((){
                                           // pages=ClassMaster();
                                          });

                              },
                                        title: Text("Progress Reports",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 2?  Colors.white : Color(0xff9197B3)),
                                      )),


                                      /*ListTile(
                                          onTap:(){
                                            _bulkuploadstudent();
                                          },
                                          title: Text("Bulk Upload Students",style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: dawer == 2?  Colors.white : Color(0xff9197B3)),
                                          )),

                                       */




                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: dawer == 3
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                  ),
                                  child:ExpansionTile(
                                    controller: staffcon,
                                    iconColor: Colors.white,
                                    backgroundColor:dawer == 3
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                    onExpansionChanged: (value){

                                      if(value==true){
                                        admissioncon.collapse();
                                        studdentcon.collapse();

                                        attdencecon.collapse();
                                        feescon.collapse();
                                        examcon.collapse();
                                        hrcon.collapse();
                                        timetable.collapse();
                                        noticescon.collapse();
                                        setState(() {
                                          admissioncon.collapse();
                                          dawer=3;
                                        });
                                      }

                                    },
                                    leading: Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                child: Image.asset(
                                  "assets/icon4.png",
                                  color: dawer == 3 ?  Colors.white : Color(0xff9197B3),
                                ),),
                                    title: Text("Staff",style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: dawer == 3?  Colors.white : Color(0xff9197B3)),
                                    ),
                                    children: [
                                      ListTile(
                                          onTap:(){
                                            setState((){
                                              pages=StaffEntry();
                                            });
                                          },
                                        title: Text("Staff Entry",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 3?  Colors.white : Color(0xff9197B3)),
                                      )),
                                      ListTile(
                                          onTap:(){
                                            setState((){
                                              pages=StaffList();
                                            });
                                          },
                                          title: Text("Staff List",style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: dawer == 3?  Colors.white : Color(0xff9197B3)),
                                          )),
                                      ListTile(
                                          onTap:(){
                                            setState((){
                                             pages=StaffID();
                                            });
                                          },
                                        title: Text("Staff ID Card",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 3?  Colors.white : Color(0xff9197B3)),
                                      )),
                                      ListTile(
                                          onTap:(){
                                            setState((){
                                              pages=ClassIncharge();
                                            });
                                          },
                                          title: Text("Class Teacher/In-charge",style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: dawer == 3?  Colors.white : Color(0xff9197B3)),
                                          )),
                                    /*  ExpansionTile(
                                        iconColor: Colors.white,
                                        collapsedIconColor: Colors.white,

                                        title: Text("Staff Masters",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 3?  Colors.white : Color(0xff9197B3)),
                                        ),
                                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                         /* ListTile(
                                              onTap:(){
                                                setState((){
                                                  pages=Desigination();
                                                });
                                              },
                                              title: Text("Designation",style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: dawer == 3?  Colors.white : Color(0xff9197B3)),
                                              )),

                                          */
                                        ],
                                      ),

                                     */

                                   /*   ListTile(
                                          onTap:(){
                                            _bulkuploadstudent();
                                          },
                                          title: Text("Bulk Upload Staff",style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: dawer == 3?  Colors.white : Color(0xff9197B3)),
                                          )),

                                    */





                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: dawer == 10
                                      ? Color(0xff00A0E3)
                                      : Colors.white,
                                ),
                                child:ExpansionTile(
                                  controller: timetable,
                                  iconColor: Colors.white,
                                  backgroundColor:dawer == 10
                                      ?Color(0xff00A0E3)
                                      : Colors.transparent,
                                  onExpansionChanged: (value){
                                    if(value==true){
                                      admissioncon.collapse();
                                      studdentcon.collapse();
                                      staffcon.collapse();
                                      attdencecon.collapse();
                                      feescon.collapse();
                                      examcon.collapse();
                                      hrcon.collapse();

                                      noticescon.collapse();

                                      setState(() {
                                        dawer=10;
                                      });
                                    }

                                  },
                                  leading: Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child:Container(
                                      width: 25,
                                      child: Image.asset(
                                          "assets/timetable.png",
                                          color: dawer == 10 ?  Colors.white : Color(0xff9197B3)
                                      ),
                                    ),
                                  ),

                                  title: Text(
                                    "Time Table",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: dawer == 10 ?  Colors.white : Color(0xff9197B3)),
                                  ),
                                  children: [
                                    ListTile(




                                      title: Text(
                                        "Assign Time Table",
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: dawer == 10 ?  Colors.white : Color(0xff9197B3)),
                                      ),
                                      onTap: () {
                                        setState(() {

                                          pages=TimeTable();

                                          dawer=10;

                                        });
                                      },
                                    ),

                                    ListTile(
                                        onTap: () {
                                          setState(() {

                                            pages=SubjectTeacher();

                                          });
                                        },
                                        title: Text("Subject Teachers",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 10?  Colors.white : Color(0xff9197B3)),
                                        )),
                                    ListTile(
                                        onTap: () {
                                          setState(() {

                                            pages=StaffTimeTable();

                                          });
                                        },
                                        title: Text("Staff TimeTable",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 10?  Colors.white : Color(0xff9197B3)),
                                        )),
                                    ListTile(
                                        onTap: () {
                                          setState(() {
                                            pages=Subtution();

                                          });
                                        },
                                        title: Text("Substitution Teachers",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 10?  Colors.white : Color(0xff9197B3)),
                                        )),
                                    /*  ListTile(
                                          title: Text("Individual SMS",style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: dawer == 9?  Colors.white : Color(0xff9197B3)),
                                          )),

                                     */







                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: dawer == 4
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                  ),

                                  child:ExpansionTile(
                                    controller: attdencecon,
                                    iconColor: Colors.white,
                                    backgroundColor:dawer == 4
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                    onExpansionChanged: (value){
                                      if(value==true){
                                        admissioncon.collapse();
                                        studdentcon.collapse();
                                        staffcon.collapse();

                                        feescon.collapse();
                                        examcon.collapse();
                                        hrcon.collapse();
                                        timetable.collapse();
                                        noticescon.collapse();
                                        setState(() {
                                          dawer=4;
                                        });
                                      }

                                    },
                                    leading: Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                child: Image.asset(
                                  "assets/icon5.png",
                                  color: dawer == 4 ?  Colors.white : Color(0xff9197B3),
                                ),),
                                    title: Text("Attendance",style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: dawer == 4?  Colors.white : Color(0xff9197B3)),
                                    ),
                                    children: [
                                      ListTile(
                                        onTap:(){
                                          setState((){
                                            pages=Attendence();
                                          });
                                        },
                                        title: Text("Student Attendance ",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 4?  Colors.white : Color(0xff9197B3)),
                                      )),

                                      ListTile(
                                        onTap: (){
                                          setState((){
                                           pages=StaffAttendence();
                                          });
                                        },
                                        title: Text("Staff Attendance",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 4?  Colors.white : Color(0xff9197B3)),
                                      )),
                                      ListTile(
                                        onTap: (){
                                          setState((){
                                            pages=Leave();
                                          });
                                        },
                                        title: Text("Leave Management",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 4?  Colors.white : Color(0xff9197B3)),
                                      )),
                                    /*  ExpansionTile(
                                        iconColor: Colors.white,
                                        collapsedIconColor: Colors.white,

                                        title: Text("Student reports",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 4?  Colors.white : Color(0xff9197B3)),
                                        ),
                                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap:(){
                                              setState((){
                                                pages=IrregularStudents();
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Irregular Student",style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: dawer == 4?  Colors.white : Color(0xff9197B3)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Regular Student",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: dawer == 4?  Colors.white : Color(0xff9197B3)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Class Wise",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: dawer == 4?  Colors.white : Color(0xff9197B3)),
                                            ),
                                          ),

                                        ],
                                      ),

                                      ExpansionTile(
                                        iconColor: Colors.white,
                                        collapsedIconColor: Colors.white,

                                        title: Text("Staff Reports",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 4?  Colors.white : Color(0xff9197B3)),
                                        ),
                                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Position Wise",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: dawer == 4?  Colors.white : Color(0xff9197B3)),
                                            ),
                                          ),



                                        ],
                                      ),*/


                                    ],
                                  )),



                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: dawer == 5
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                  ),

                                  child:ExpansionTile(
                                    controller: feescon,
                                    iconColor: Colors.white,
                                    backgroundColor:dawer == 5
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                    onExpansionChanged: (value){
                                      if(value==true){
                                        admissioncon.collapse();
                                        studdentcon.collapse();
                                        staffcon.collapse();
                                        attdencecon.collapse();

                                        examcon.collapse();
                                        hrcon.collapse();
                                        timetable.collapse();
                                        noticescon.collapse();
                                        setState(() {
                                          dawer=5;
                                        });
                                      }

                                    },
                                    leading: Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: Image.asset(
                                          "assets/icon6.png",
                                          color: dawer == 5 ?  Colors.white : Color(0xff9197B3)
                                      ),
                                    ),

                                    title: Text(
                                      "Fees",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: dawer == 5 ?  Colors.white : Color(0xff9197B3)),
                                    ),

                                    children: [
                                      ListTile(
                                        onTap:(){
                                          setState(() {
                                            pages=FeesReg();
                                          });
                                        },
                                        title: Text("Fee Payment Reg",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 5?  Colors.white : Color(0xff9197B3)),
                                      )),
                                      ListTile(
                                        onTap:(){
                                          setState(() {
                                            pages=ClasswiseFees();
                                          });
                                        },
                                        title: Text("Assign Fees",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 5?  Colors.white : Color(0xff9197B3)),
                                      )),
                                   /*   ListTile(
                                        onTap:(){
                                          setState(() {
                                            pages=FeesMaster();
                                          });
                                        },
                                        title: Text("Fee Creation",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 5?  Colors.white : Color(0xff9197B3)),
                                      )),

                                    */
                                      ListTile(
                                        onTap:(){
                                          setState(() {
                                            pages=FeesReports();
                                          });
                                        },
                                        title: Text("Fees Reports",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 5?  Colors.white : Color(0xff9197B3)),
                                      )),








                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: dawer == 6
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                  ),

                                  child:ExpansionTile(
                                    controller: examcon,
                                    iconColor: Colors.white,
                                    backgroundColor:dawer == 6
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                    onExpansionChanged: (value){
                                      if(value==true){
                                        admissioncon.collapse();
                                        studdentcon.collapse();
                                        staffcon.collapse();
                                        attdencecon.collapse();
                                        feescon.collapse();
                                        hrcon.collapse();
                                        timetable.collapse();
                                        noticescon.collapse();
                                        setState(() {
                                          dawer=6;
                                        });
                                      }

                                    },
                                    leading: Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: Image.asset(
                                          "assets/icon7.png",
                                          color: dawer == 6 ?  Colors.white : Color(0xff9197B3)
                                      ),
                                    ),

                                    title: Text(
                                      "Exams",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: dawer == 6 ?  Colors.white : Color(0xff9197B3)),
                                    ),
                                    children: [
                                      ListTile(
                                        title: Text("Exam Selection",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                      )),
                                      ListTile(
                                        title: Text("Subject Master",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                      )),

                                      ExpansionTile(
                                        iconColor: Colors.white,
                                        collapsedIconColor: Colors.white,

                                        title: Text("Exam Master",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                        ),
                                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Add Exam",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                            ),
                                          ),



                                        ],
                                      ),

                                      ExpansionTile(
                                        iconColor: Colors.white,
                                        collapsedIconColor: Colors.white,

                                        title: Text("Exam Reports",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                        ),
                                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Class Wise",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Subject Wise",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Student Wise",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                            ),
                                          ),
                                        ],
                                      ),



                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: dawer == 8
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                  ),

                                  child:ExpansionTile(
                                    controller: hrcon,
                                    iconColor: Colors.white,
                                    backgroundColor:dawer == 8
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                    onExpansionChanged: (value){
                                      if(value==true){
                                        admissioncon.collapse();
                                        studdentcon.collapse();
                                        staffcon.collapse();
                                        attdencecon.collapse();
                                        feescon.collapse();
                                        examcon.collapse();
                                        timetable.collapse();

                                        noticescon.collapse();
                                        setState(() {
                                          dawer=8;
                                        });
                                      }

                                    },
                                    leading: Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: Image.asset(

                                        "assets/icon9.png",
                                        color: dawer == 8 ?  Colors.white : Color(0xff9197B3),
                                      ),
                                    ),

                                    title: Text(
                                      "HR ",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: dawer == 8 ?  Colors.white : Color(0xff9197B3)),
                                    ),
                                    children: [
                                      ListTile(
                                        title: Text("Payroll Generation",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 8?  Colors.white : Color(0xff9197B3)),
                                      )),
                                      ListTile(
                                        title: Text("Salary Statement",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 8?  Colors.white : Color(0xff9197B3)),
                                      )),

                                      ExpansionTile(
                                        iconColor: Colors.white,
                                        collapsedIconColor: Colors.white,

                                        title: Text("Payroll Reports",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 8?  Colors.white : Color(0xff9197B3)),
                                        ),
                                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Salary",style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: dawer == 8?  Colors.white : Color(0xff9197B3)),
                                            ),
                                          ),



                                        ],
                                      ),





                                    ],
                                  )),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: dawer == 7
                                      ? Color(0xff00A0E3)
                                      : Colors.white,
                                ),
                                child:  ListTile(


                                  leading: Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Image.asset(
                                      "assets/icon8.png",
                                        color: dawer == 7 ?  Colors.white : Color(0xff9197B3)
                                    ),
                                  ),

                                  title: Text(
                                    "Accounts",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: dawer == 7 ?  Colors.white : Color(0xff9197B3)),
                                  ),
                                  onTap: () {
                                    admissioncon.collapse();
                                    studdentcon.collapse();
                                    staffcon.collapse();
                                    attdencecon.collapse();
                                    feescon.collapse();
                                    examcon.collapse();
                                    hrcon.collapse();
                                    timetable.collapse();
                                    noticescon.collapse();
                                    setState(() {
                                        pages=Accountpage();
                                      dawer=7;
                                    //  pages=Accountpage();
                                    });
                                  },
                                ),
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: dawer == 9
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                  ),

                                  child:ExpansionTile(
                                    controller: noticescon,
                                    iconColor: Colors.white,
                                    backgroundColor:dawer == 9
                                        ?Color(0xff00A0E3)
                                        : Colors.transparent,
                                    onExpansionChanged: (value){
                                      if(value==true){
                                        admissioncon.collapse();
                                        studdentcon.collapse();
                                        staffcon.collapse();
                                        attdencecon.collapse();
                                        feescon.collapse();
                                        examcon.collapse();
                                        hrcon.collapse();
                                        timetable.collapse();

                                        setState(() {
                                          dawer=9;
                                        });
                                      }

                                    },
                                    leading: Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child:Icon(
                                        Icons.message,
                                        color: dawer == 9 ?  Colors.white : Color(0xff9197B3),
                                      ),
                                    ),

                                    title: Text(
                                      "Notices",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: dawer == 9 ?  Colors.white : Color(0xff9197B3)),
                                    ),
                                    children: [
                                      ListTile(
                                        onTap:(){
                                          setState(() {
                                            pages=NotificationCus();

                                          });
                                          },
                                          title: Text("Send SMS",style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: dawer == 9?  Colors.white : Color(0xff9197B3)),
                                          )),
                                      ListTile(
                                          onTap:(){
                                            setState(() {
                                              pages=Previous();

                                            });
                                          },
                                          title: Text("View Previous",style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: dawer == 9?  Colors.white : Color(0xff9197B3)),
                                          )),
                                    /*  ListTile(
                                          title: Text("Individual SMS",style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: dawer == 9?  Colors.white : Color(0xff9197B3)),
                                          )),

                                     */







                                    ],
                                  )),
                            ),
                            SizedBox(height: height/32.85,)



                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0,top: 20),
            child: Container(
              width: width/1.219,
              height: height/1,

              child: pages,
            ),
          )
        ],
      ),
    );
  }

}


