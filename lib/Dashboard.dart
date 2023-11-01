

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as mt;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:random_string/random_string.dart';
import 'package:uuid/uuid.dart';

import 'package:vidhaan/attendence.dart';
import 'package:vidhaan/classincharge.dart';
import 'package:vidhaan/exam/examtimetable.dart';
import 'package:vidhaan/fees/fees.dart';
import 'package:vidhaan/notification.dart';
import 'package:vidhaan/payrollgenration.dart';
import 'package:vidhaan/payrollreports.dart';
import 'package:vidhaan/staffattdence.dart';

import 'package:vidhaan/stafflist.dart';
import 'package:vidhaan/studentlist.dart';

import 'package:vidhaan/staff%20entry.dart';
import 'package:vidhaan/timetable/classTimeTable.dart';
import 'package:vidhaan/timetable/stafftimetable.dart';
import 'package:vidhaan/timetable/subtution.dart';

import 'package:vidhaan/timetable/subjectteacher.dart';
import 'package:vidhaan/timetable/timetable.dart';
import 'package:vidhaan/view%20previous.dart';


import 'Accountpage.dart';
import 'Masters/desigination.dart';
import 'Masters/staffidcard.dart';
import 'Masters/student id card.dart';
import 'exam/exammaster.dart';
import 'exam/examsubjectmaster.dart';
import 'fees/classwisefeemaster.dart';

import 'admission.dart';

import 'dashboadrmain.dart';

import 'fees/feesreports.dart';
import 'feesdemo.dart';
import 'leavemanagement.dart';
import 'studententry.dart';

import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';



import 'package:pdf/widgets.dart' as p;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:vidhaan/demopdf.dart';


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
    //addinglist();
    getadmin();
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
String rollno="";
  var uuid = Uuid();

  // Generate a v1 (time-based) id
  setuuu() {
    var v1 = uuid.v5(Uuid.NAMESPACE_URL, 'www.google.com');
    print(v1);
  }
  updatestudentregno() async {

    var document = await FirebaseFirestore.instance.collection("Students").orderBy("timestamp").get();
    for(int i=0;i<document.docs.length;i++){

      FirebaseFirestore.instance.collection("Students").doc(document.docs[i].id).update({
        "token":"",
      });
    }
    print("Reg No Changed");

}
  updatestudentrollno() async {
    String classesA ="";
    int rollnoA=0;
    var document = await FirebaseFirestore.instance.collection("Students").orderBy("timestamp").get();
    for(int i=0;i<document.docs.length;i++){
      if(classesA==document.docs[i]["admitclass"]) {
        FirebaseFirestore.instance.collection("Students").doc(document.docs[i].id).update({
          "rollno": "${(rollnoA).toString().padLeft(2, '0')}",
        });

        print("${document.docs[i]["stname"]} ${(rollnoA).toString().padLeft(2, '0')}");
        setState(() {
          rollnoA=rollnoA+1;
        });
      }
      else{
        setState(() {
          classesA=document.docs[i]["admitclass"];print(classesA);
          rollnoA=2;
        });

        FirebaseFirestore.instance.collection("Students").doc(document.docs[i].id).update({
          "rollno": "${(1).toString().padLeft(2, '0')}",
        });


        print("${document.docs[i]["stname"]} ${(1).toString().padLeft(2, '0')}");
      }
    }
    print("Reg NO changed successfully");
  }

checkdemo() async {
  var document = await FirebaseFirestore.instance.collection("Students").orderBy("timestamp").get();
  for(int i=0;i<document.docs.length;i++) {
    if(document.docs[i]["dob"].toString().contains("/")&&document.docs[i]["dob"].toString().length==10) {
      DateFormat format = DateFormat("dd/MM/yyyy");
      print(i);
      print(format.parse(document.docs[i]["dob"].toString()));
      FirebaseFirestore.instance.collection("Students").doc(document.docs[i].id).update(
        {
          "dob":"${format.parse(document.docs[i]["dob"].toString()).day}-${format.parse(document.docs[i]["dob"].toString()).month}-${format.parse(document.docs[i]["dob"].toString()).year}"
        }
      );

    }
   else if(document.docs[i]["dob"].toString().contains("/")&&document.docs[i]["dob"].toString().length==9) {
      DateFormat format = DateFormat("dd/M/yyyy");
      print(i);
      print(format.parse(document.docs[i]["dob"].toString()));
      FirebaseFirestore.instance.collection("Students").doc(document.docs[i].id).update(
          {
            "dob":"${format.parse(document.docs[i]["dob"].toString()).day}-${format.parse(document.docs[i]["dob"].toString()).month}-${format.parse(document.docs[i]["dob"].toString()).year}"
          }
      );

    }
   else if(document.docs[i]["dob"].toString().contains("-")) {
      DateFormat format = DateFormat("yyyy-MM-dd");
      print(i);
      print(format.parse(document.docs[i]["dob"].toString()));
      FirebaseFirestore.instance.collection("Students").doc(document.docs[i].id).update(
          {
            "dob":"${format.parse(document.docs[i]["dob"].toString()).day}-${format.parse(document.docs[i]["dob"].toString()).month}-${format.parse(document.docs[i]["dob"].toString()).year}"
          }
      );

    }
   else{
     print("Errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
     print(i);
    }

  }
  print("Reg NO changed successfully");
}

  String schoolname="";
  String schooladdress="";
  String schoolphone="";
  String schoollogo="";
  String idcarddesign="";
  String solgan="";
  String schoolweb="";

  getadmin() async {
    var document = await FirebaseFirestore.instance.collection("Admin").get();
    setState(() {
      schoolname=document.docs[0]["schoolname"];
      schooladdress="${document.docs[0]["area"]} ${document.docs[0]["city"]} ${document.docs[0]["pincode"]}";
      schoollogo=document.docs[0]["logo"];
      idcarddesign=document.docs[0]["idcard"].toString();
      solgan=document.docs[0]["solgan"];
      schoolphone=document.docs[0]["phone"];
      schoolweb=document.docs[0]["web"];
    });
  }
  getvalue() async {
    print("gbdffd");
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    List<p.Widget> widgets = [];

    final bg1 = p.MemoryImage((await rootBundle.load('assets/idbg4.png')).buffer.asUint8List(),);
    final bg2 = p.MemoryImage((await rootBundle.load('assets/idbg6.png')).buffer.asUint8List(),);
    final bg3 = p.MemoryImage((await rootBundle.load('assets/idbg7.png')).buffer.asUint8List(),);
   
    final vidhaanlogo = p.MemoryImage((await rootBundle.load('assets/VIDHAANLOGO.png')).buffer.asUint8List(),);
    final plusicon = p.MemoryImage((await rootBundle.load('assets/plus.png')).buffer.asUint8List(),);
    final schoolsign = p.MemoryImage((await rootBundle.load('assets/schoolsign.png')).buffer.asUint8List(),);
    final schoollogoii = await flutterImageProvider(NetworkImage(schoollogo));

    var fontsemipoppoins = await PdfGoogleFonts.poppinsSemiBold();
    var fontregpoppoins = await PdfGoogleFonts.poppinsRegular();
    var fontrmedpoppoins = await PdfGoogleFonts.poppinsMedium();
    var fontsemimon = await PdfGoogleFonts.montserratSemiBold();
  

    widgets.add(

          p.Padding(
              padding: p.EdgeInsets.only(top: 0),
              child:   p.ListView.builder(itemBuilder: (context,index){
                return
                p.Container(
                    height: 1190,
                    width:840,
                    child:
                    p.Column(children: [
                    p.Container(
                      height: 12.1,

                    ),
                    p.Padding(
                        padding: p.EdgeInsets.only(left:20),
                        child:
                    p.Row(
                        mainAxisAlignment: p.MainAxisAlignment.start,
                        children: [
                          namelist[index].length>0?
                          p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Container(
                                  height: 252.35,
                                  width: 161.5,
                                  color:PdfColors.white,

                                  child: p.Stack(
                                    children: [
                                      p.Column(
                                        mainAxisAlignment:  p.MainAxisAlignment.spaceBetween,
                                        children: [
                                          p.Image(bg1),
                                          p.Image(bg2),
                                        ],
                                      ),
                                      p.Column(
                                        crossAxisAlignment: p.CrossAxisAlignment.center,

                                        children: [
                                          p.SizedBox(height: 16,),
                                          p.Row(
                                            mainAxisAlignment: p.MainAxisAlignment.center,
                                            children: [
                                              p.Container(
                                                width:30,
                                                height:30,
                                                child:
                                                p.ClipRRect(
                                                  verticalRadius: 18,
                                                  horizontalRadius: 18,
                                                  child: p.Image(schoollogoii),),
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),
                                              ),
                                            ],
                                          ),
                                          p.SizedBox(height: 2,),
                                          p.Text(schoolname,style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                          p.Text(schooladdress,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                          p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                          p.Text(schoolweb,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                           p.SizedBox(height: 0,),
                                          p.Stack(
                                            alignment: p.Alignment.center,
                                            children: [
                                              p.Container(
                                                width: 60,
                                                height: 60,
                                                decoration:  p.BoxDecoration(
                                                  color: PdfColor.fromHex("00A0E3"),
                                                  
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.Container(
                                                width: 55,
                                                height: 55,
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.Padding(
                                                  padding: p.EdgeInsets.only(top:0),
                                                  child:
                                              p.ClipRRect(
                                                 horizontalRadius: 14,
                                                verticalRadius: 20,
                                                child:
                                              p.Image(imglist[index][0],height: 55,width: 55))
                                              )
                                            ],
                                          ),
                                          p.SizedBox(height: 1,),
                                         p.Text("${namelist[index][0]} ${lastnamelist[index][0]}",style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.black, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                          p.Text("ID: ${regnolist[index][0]}",style: p.TextStyle(
                                              font: fontrmedpoppoins,
                                              color:  PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                          p.SizedBox(height: 0,),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("Class",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text("${classlist[index][0]} ${sectionlist[index][0]}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("DOB",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(doblist[index][0],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Blood Group",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color:PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(bloodlist[index][0],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Phone No",style:  p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style:  p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(phonelist[index][0],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                  p.Row(
                                           children:[
                                             p.SizedBox(width: 10,),
                                             p.Container(
                                  width:40,height:20,
                                                 child:
                                             p.Image(schoolsign)
                                             )
                                  ]

                                  ),
                                                  p.Row(
                                              children:[
                                                p.SizedBox(width: 10,),
                                               p.Text("Principal",style: p.TextStyle(
                                                   font: fontregpoppoins,
                                                   color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal))
                                              ]

                                          ),


                                        ],
                                      ),

                                    ],
                                  ),
                                ),]
                          ):
                          p.Container(),
                          namelist[index].length>1?
                          p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Container(
                                  height: 252.35,
                                  width: 161.5,
                                  color:PdfColors.white,

                                  child: p.Stack(
                                    children: [
                                      p.Column(
                                        mainAxisAlignment:  p.MainAxisAlignment.spaceBetween,
                                        children: [
                                          p.Image(bg1),
                                          p.Image(bg2),


                                        ],
                                      ),
                                      p.Column(
                                        crossAxisAlignment: p.CrossAxisAlignment.center,

                                        children: [
                                          p.SizedBox(height: 16,),
                                          p.Row(
                                            mainAxisAlignment: p.MainAxisAlignment.center,
                                            children: [
                                              p.Container(
                                                width:30,
                                                height:30,
                                                child:   p.ClipRRect(
                                                  verticalRadius: 18,
                                                  horizontalRadius: 18,
                                                  child: p.Image(schoollogoii),),
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),
                                              ),
                                            ],
                                          ),
                                          p.SizedBox(height: 2,),
                                          p.Text(schoolname,style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                          p.Text(schooladdress,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                          p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                          p.Text(schoolweb,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                           p.SizedBox(height: 0,),
                                          p.Stack(
                                            alignment: p.Alignment.center,
                                            children: [
                                              p.Container(
                                                width: 60,
                                                height: 60,
                                                decoration:  p.BoxDecoration(
                                                  color: PdfColor.fromHex("00A0E3"),
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.Container(
                                                width: 55,
                                                height: 55,
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.ClipRRect(
                                                  horizontalRadius: 14,
                                                  verticalRadius: 20,
                                                  child:
                                                  p.Image(imglist[index][1],height: 55,width: 55))

                                            ],
                                          ),
                                          p.SizedBox(height: 1,),
                                          p.Text("${namelist[index][1]} ${lastnamelist[index][1]}",style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.black, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                          p.Text("ID: ${regnolist[index][1]}",style: p.TextStyle(
                                              font: fontrmedpoppoins,
                                              color:  PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                          p.SizedBox(height: 0,),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("Class",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text("${classlist[index][1]} ${sectionlist[index][1]}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("DOB",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(doblist[index][1],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Blood Group",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color:PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(bloodlist[index][1],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Phone No",style:  p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style:  p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(phonelist[index][1],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                              children:[
                                                p.SizedBox(width: 10,),
                                                p.Container(
                                                    width:40,height:20,
                                                    child:
                                                    p.Image(schoolsign)
                                                )
                                              ]

                                          ),
                                          p.Row(
                                              children:[
                                                p.SizedBox(width: 10,),
                                                p.Text("Principal",style: p.TextStyle(
                                                    font: fontregpoppoins,
                                                    color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal))
                                              ]

                                          ),

                                        ],
                                      ),

                                    ],
                                  ),
                                ),]
                          ):
                          p.Container(),
                          namelist[index].length>2?
                          p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Container(
                                  height: 252.35,
                                  width: 161.5,
                                  color:PdfColors.white,

                                  child: p.Stack(
                                    children: [
                                      p.Column(
                                        mainAxisAlignment:  p.MainAxisAlignment.spaceBetween,
                                        children: [
                                          p.Image(bg1),
                                          p.Image(bg2),


                                        ],
                                      ),
                                      p.Column(
                                        crossAxisAlignment: p.CrossAxisAlignment.center,

                                        children: [
                                          p.SizedBox(height: 16,),
                                          p.Row(
                                            mainAxisAlignment: p.MainAxisAlignment.center,
                                            children: [
                                              p.Container(
                                                width:30,
                                                height:30,
                                                child:   p.ClipRRect(
                                                  verticalRadius: 18,
                                                  horizontalRadius: 18,
                                                  child: p.Image(schoollogoii),),
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),
                                              ),
                                            ],
                                          ),
                                          p.SizedBox(height: 2,),
                                          p.Text(schoolname,style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                          p.Text(schooladdress,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                          p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                          p.Text(schoolweb,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                           p.SizedBox(height: 0,),
                                          p.Stack(
                                            alignment: p.Alignment.center,
                                            children: [
                                              p.Container(
                                                width: 60,
                                                height: 60,
                                                decoration:  p.BoxDecoration(
                                                  color: PdfColor.fromHex("00A0E3"),
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.Container(
                                                width: 55,
                                                height: 55,
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.ClipRRect(
                                                  horizontalRadius: 14,
                                                  verticalRadius: 20,
                                                  child:
                                                  p.Image(imglist[index][2],height: 55,width: 55))

                                            ],
                                          ),
                                          p.SizedBox(height: 1,),
                                          p.Text("${namelist[index][2]} ${lastnamelist[index][2]}",style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.black, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                          p.Text("ID: ${regnolist[index][2]}",style: p.TextStyle(
                                              font: fontrmedpoppoins,
                                              color:  PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                          p.SizedBox(height: 0,),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("Class",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text("${classlist[index][2]} ${sectionlist[index][2]}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("DOB",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(doblist[index][2],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Blood Group",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color:PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(bloodlist[index][2],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Phone No",style:  p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style:  p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(phonelist[index][2],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                              children:[
                                                p.SizedBox(width: 10,),
                                                p.Container(
                                                    width:40,height:20,
                                                    child:
                                                    p.Image(schoolsign)
                                                )
                                              ]

                                          ),
                                          p.Row(
                                              children:[
                                                p.SizedBox(width: 10,),
                                                p.Text("Principal",style: p.TextStyle(
                                                    font: fontregpoppoins,
                                                    color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal))
                                              ]

                                          ),

                                        ],
                                      ),

                                    ],
                                  ),
                                ),]
                          ):
                          p.Container(),
                          namelist[index].length>3?
                          p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Container(
                                  height: 252.35,
                                  width: 161.5,
                                  color:PdfColors.white,

                                  child: p.Stack(
                                    children: [
                                      p.Column(
                                        mainAxisAlignment:  p.MainAxisAlignment.spaceBetween,
                                        children: [
                                          p.Image(bg1),
                                          p.Image(bg2),


                                        ],
                                      ),
                                      p.Column(
                                        crossAxisAlignment: p.CrossAxisAlignment.center,

                                        children: [
                                          p.SizedBox(height: 16,),
                                          p.Row(
                                            mainAxisAlignment: p.MainAxisAlignment.center,
                                            children: [
                                              p.Container(
                                                width:30,
                                                height:30,
                                                child:   p.ClipRRect(
                                                  verticalRadius: 18,
                                                  horizontalRadius: 18,
                                                  child: p.Image(schoollogoii),),
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),
                                              ),
                                            ],
                                          ),
                                          p.SizedBox(height: 2,),
                                          p.Text(schoolname,style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                          p.Text(schooladdress,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                          p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                          p.Text(schoolweb,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                           p.SizedBox(height: 0,),
                                          p.Stack(
                                            alignment: p.Alignment.center,
                                            children: [
                                              p.Container(
                                                width: 60,
                                                height: 60,
                                                decoration:  p.BoxDecoration(
                                                  color: PdfColor.fromHex("00A0E3"),
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.Container(
                                                width: 55,
                                                height: 55,
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.ClipRRect(
                                                  horizontalRadius: 14,
                                                  verticalRadius: 20,
                                                  child:
                                                  p.Image(imglist[index][3],height: 55,width: 55))

                                            ],
                                          ),
                                          p.SizedBox(height: 1,),
                                          p.Text("${namelist[index][3]} ${lastnamelist[index][3]}",style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.black, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                          p.Text("ID: ${regnolist[index][3]}",style: p.TextStyle(
                                              font: fontrmedpoppoins,
                                              color:  PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                          p.SizedBox(height: 0,),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("Class",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text("${classlist[index][3]} ${sectionlist[index][3]}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("DOB",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(doblist[index][3],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Blood Group",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color:PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(bloodlist[index][3],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Phone No",style:  p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style:  p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(phonelist[index][3],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                              children:[
                                                p.SizedBox(width: 10,),
                                                p.Container(
                                                    width:40,height:20,
                                                    child:
                                                    p.Image(schoolsign)
                                                )
                                              ]

                                          ),
                                          p.Row(
                                              children:[
                                                p.SizedBox(width: 10,),
                                                p.Text("Principal",style: p.TextStyle(
                                                    font: fontregpoppoins,
                                                    color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal))
                                              ]

                                          ),

                                        ],
                                      ),

                                    ],
                                  ),
                                ),]
                          ):
                          p.Container(),
                          namelist[index].length>4?
                          p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Container(
                                  height: 252.35,
                                  width: 161.5,
                                  color:PdfColors.white,

                                  child: p.Stack(
                                    children: [
                                      p.Column(
                                        mainAxisAlignment:  p.MainAxisAlignment.spaceBetween,
                                        children: [
                                          p.Image(bg1),
                                          p.Image(bg2),


                                        ],
                                      ),
                                      p.Column(
                                        crossAxisAlignment: p.CrossAxisAlignment.center,

                                        children: [
                                          p.SizedBox(height: 16,),
                                          p.Row(
                                            mainAxisAlignment: p.MainAxisAlignment.center,
                                            children: [
                                              p.Container(
                                                width:30,
                                                height:30,
                                                child:   p.ClipRRect(
                                                  verticalRadius: 18,
                                                  horizontalRadius: 18,
                                                  child: p.Image(schoollogoii),),
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),
                                              ),
                                            ],
                                          ),
                                          p.SizedBox(height: 2,),
                                          p.Text(schoolname,style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                          p.Text(schooladdress,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                          p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                          p.Text(schoolweb,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                           p.SizedBox(height: 0,),
                                          p.Stack(
                                            alignment: p.Alignment.center,
                                            children: [
                                              p.Container(
                                                width: 60,
                                                height: 60,
                                                decoration:  p.BoxDecoration(
                                                  color: PdfColor.fromHex("00A0E3"),
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.Container(
                                                width: 55,
                                                height: 55,
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.ClipRRect(
                                                  horizontalRadius: 14,
                                                  verticalRadius: 20,
                                                  child:
                                                  p.Image(imglist[index][4],height: 55,width: 55))

                                            ],
                                          ),
                                          p.SizedBox(height: 1,),
                                          p.Text("${namelist[index][4]} ${lastnamelist[index][4]}",style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.black, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                          p.Text("ID: ${regnolist[index][4]}",style: p.TextStyle(
                                              font: fontrmedpoppoins,
                                              color:  PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                          p.SizedBox(height: 0,),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("Class",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text("${classlist[index][4]} ${sectionlist[index][4]}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("DOB",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(doblist[index][4],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Blood Group",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color:PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(bloodlist[index][4],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Phone No",style:  p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style:  p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(phonelist[index][4],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                              children:[
                                                p.SizedBox(width: 10,),
                                                p.Container(
                                                    width:40,height:20,
                                                    child:
                                                    p.Image(schoolsign)
                                                )
                                              ]

                                          ),
                                          p.Row(
                                              children:[
                                                p.SizedBox(width: 10,),
                                                p.Text("Principal",style: p.TextStyle(
                                                    font: fontregpoppoins,
                                                    color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal))
                                              ]

                                          ),

                                        ],
                                      ),

                                    ],
                                  ),
                                ),]
                          ):
                          p.Container(),






                        ]
                    ),
                    ),
                    p.Container(
                      height: 30.1,

                    ),
                    p.Padding(
                        padding: p.EdgeInsets.only(left:20),
                        child:
                    p.Row(
                        mainAxisAlignment: p.MainAxisAlignment.start,
                        children: [
                          namelist[index].length>5?
                          p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[

                                p.Container(
                                  height: 252.35,
                                  width: 161.5,
                                  color:PdfColors.white,

                                  child: p.Stack(
                                    children: [
                                      p.Column(
                                        mainAxisAlignment:  p.MainAxisAlignment.spaceBetween,
                                        children: [
                                          p.Image(bg1),
                                          p.Image(bg2),


                                        ],
                                      ),
                                      p.Column(
                                        crossAxisAlignment: p.CrossAxisAlignment.center,

                                        children: [
                                          p.SizedBox(height: 16,),
                                          p.Row(
                                            mainAxisAlignment: p.MainAxisAlignment.center,
                                            children: [
                                              p.Container(
                                                width:30,
                                                height:30,
                                                child:   p.ClipRRect(
                                                  verticalRadius: 18,
                                                  horizontalRadius: 18,
                                                  child: p.Image(schoollogoii),),
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),
                                              ),
                                            ],
                                          ),
                                          p.SizedBox(height: 2,),
                                          p.Text(schoolname,style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                          p.Text(schooladdress,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                          p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                          p.Text(schoolweb,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                           p.SizedBox(height: 0,),
                                          p.Stack(
                                            alignment: p.Alignment.center,
                                            children: [
                                              p.Container(
                                                width: 60,
                                                height: 60,
                                                decoration:  p.BoxDecoration(
                                                  color: PdfColor.fromHex("00A0E3"),
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.Container(
                                                width: 55,
                                                height: 55,
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.ClipRRect(
                                                  horizontalRadius: 14,
                                                  verticalRadius: 20,
                                                  child:
                                                  p.Image(imglist[index][5],height: 55,width: 55))

                                            ],
                                          ),
                                          p.SizedBox(height: 1,),
                                          p.Text("${namelist[index][5]} ${lastnamelist[index][5]}",style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.black, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                          p.Text("ID: ${regnolist[index][5]}",style: p.TextStyle(
                                              font: fontrmedpoppoins,
                                              color:  PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                          p.SizedBox(height: 0,),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("Class",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text("${classlist[index][5]} ${sectionlist[index][5]}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("DOB",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(doblist[index][5],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Blood Group",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color:PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(bloodlist[index][5],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Phone No",style:  p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style:  p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(phonelist[index][5],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                              children:[
                                                p.SizedBox(width: 10,),
                                                p.Container(
                                                    width:40,height:20,
                                                    child:
                                                    p.Image(schoolsign)
                                                )
                                              ]

                                          ),
                                          p.Row(
                                              children:[
                                                p.SizedBox(width: 10,),
                                                p.Text("Principal",style: p.TextStyle(
                                                    font: fontregpoppoins,
                                                    color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal))
                                              ]

                                          ),

                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),

                              ]
                          ):p.Container(),
                          namelist[index].length>6?
                          p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[

                                p.Container(
                                  height: 252.35,
                                  width: 161.5,
                                  color:PdfColors.white,

                                  child: p.Stack(
                                    children: [
                                      p.Column(
                                        mainAxisAlignment:  p.MainAxisAlignment.spaceBetween,
                                        children: [
                                          p.Image(bg1),
                                          p.Image(bg2),


                                        ],
                                      ),
                                      p.Column(
                                        crossAxisAlignment: p.CrossAxisAlignment.center,

                                        children: [
                                          p.SizedBox(height: 16,),
                                          p.Row(
                                            mainAxisAlignment: p.MainAxisAlignment.center,
                                            children: [
                                              p.Container(
                                                width:30,
                                                height:30,
                                                child:   p.ClipRRect(
                                                  verticalRadius: 18,
                                                  horizontalRadius: 18,
                                                  child: p.Image(schoollogoii),),
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),
                                              ),
                                            ],
                                          ),
                                          p.SizedBox(height: 2,),
                                          p.Text(schoolname,style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                          p.Text(schooladdress,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                          p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                          p.Text(schoolweb,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                           p.SizedBox(height: 0,),
                                          p.Stack(
                                            alignment: p.Alignment.center,
                                            children: [
                                              p.Container(
                                                width: 60,
                                                height: 60,
                                                decoration:  p.BoxDecoration(
                                                  color: PdfColor.fromHex("00A0E3"),
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.Container(
                                                width: 55,
                                                height: 55,
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.ClipRRect(
                                                  horizontalRadius: 14,
                                                  verticalRadius: 20,
                                                  child:
                                                  p.Image(imglist[index][6],height: 55,width: 55))

                                            ],
                                          ),
                                          p.SizedBox(height: 1,),
                                          p.Text("${namelist[index][6]} ${lastnamelist[index][6]}",style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.black, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                          p.Text("ID: ${regnolist[index][6]}",style: p.TextStyle(
                                              font: fontrmedpoppoins,
                                              color:  PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                          p.SizedBox(height: 0,),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("Class",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text("${classlist[index][6]} ${sectionlist[index][6]}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("DOB",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(doblist[index][6],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Blood Group",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color:PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(bloodlist[index][6],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Phone No",style:  p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style:  p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(phonelist[index][6],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                              children:[
                                                p.SizedBox(width: 10,),
                                                p.Container(
                                                    width:40,height:20,
                                                    child:
                                                    p.Image(schoolsign)
                                                )
                                              ]

                                          ),
                                          p.Row(
                                              children:[
                                                p.SizedBox(width: 10,),
                                                p.Text("Principal",style: p.TextStyle(
                                                    font: fontregpoppoins,
                                                    color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal))
                                              ]

                                          ),

                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),

                              ]
                          ):p.Container(),
                          namelist[index].length>7?
                          p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[

                                p.Container(
                                  height: 252.35,
                                  width: 161.5,
                                  color:PdfColors.white,

                                  child: p.Stack(
                                    children: [
                                      p.Column(
                                        mainAxisAlignment:  p.MainAxisAlignment.spaceBetween,
                                        children: [
                                          p.Image(bg1),
                                          p.Image(bg2),


                                        ],
                                      ),
                                      p.Column(
                                        crossAxisAlignment: p.CrossAxisAlignment.center,

                                        children: [
                                          p.SizedBox(height: 16,),
                                          p.Row(
                                            mainAxisAlignment: p.MainAxisAlignment.center,
                                            children: [
                                              p.Container(
                                                width:30,
                                                height:30,
                                                child:   p.ClipRRect(
                                                  verticalRadius: 18,
                                                  horizontalRadius: 18,
                                                  child: p.Image(schoollogoii),),
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),
                                              ),
                                            ],
                                          ),
                                          p.SizedBox(height: 2,),
                                          p.Text(schoolname,style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                          p.Text(schooladdress,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                          p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                          p.Text(schoolweb,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                           p.SizedBox(height: 0,),
                                          p.Stack(
                                            alignment: p.Alignment.center,
                                            children: [
                                              p.Container(
                                                width: 60,
                                                height: 60,
                                                decoration:  p.BoxDecoration(
                                                  color: PdfColor.fromHex("00A0E3"),
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.Container(
                                                width: 55,
                                                height: 55,
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.ClipRRect(
                                                  horizontalRadius: 14,
                                                  verticalRadius: 20,
                                                  child:
                                                  p.Image(imglist[index][7],height: 55,width: 55))

                                            ],
                                          ),
                                          p.SizedBox(height: 1,),
                                          p.Text("${namelist[index][7]} ${lastnamelist[index][7]}",style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.black, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                          p.Text("ID: ${regnolist[index][7]}",style: p.TextStyle(
                                              font: fontrmedpoppoins,
                                              color:  PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                          p.SizedBox(height: 0,),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("Class",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text("${classlist[index][7]} ${sectionlist[index][7]}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("DOB",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(doblist[index][7],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Blood Group",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color:PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(bloodlist[index][7],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Phone No",style:  p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style:  p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(phonelist[index][7],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                              children:[
                                                p.SizedBox(width: 10,),
                                                p.Container(
                                                    width:40,height:20,
                                                    child:
                                                    p.Image(schoolsign)
                                                )
                                              ]

                                          ),
                                          p.Row(
                                              children:[
                                                p.SizedBox(width: 10,),
                                                p.Text("Principal",style: p.TextStyle(
                                                    font: fontregpoppoins,
                                                    color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal))
                                              ]

                                          ),

                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),

                              ]
                          ):p.Container(),
                          namelist[index].length>8?
                          p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[

                                p.Container(
                                  height: 252.35,
                                  width: 161.5,
                                  color:PdfColors.white,

                                  child: p.Stack(
                                    children: [
                                      p.Column(
                                        mainAxisAlignment:  p.MainAxisAlignment.spaceBetween,
                                        children: [
                                          p.Image(bg1),
                                          p.Image(bg2),


                                        ],
                                      ),
                                      p.Column(
                                        crossAxisAlignment: p.CrossAxisAlignment.center,

                                        children: [
                                          p.SizedBox(height: 16,),
                                          p.Row(
                                            mainAxisAlignment: p.MainAxisAlignment.center,
                                            children: [
                                              p.Container(
                                                width:30,
                                                height:30,
                                                child:   p.ClipRRect(
                                                  verticalRadius: 18,
                                                  horizontalRadius: 18,
                                                  child: p.Image(schoollogoii),),
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),
                                              ),
                                            ],
                                          ),
                                          p.SizedBox(height: 2,),
                                          p.Text(schoolname,style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                          p.Text(schooladdress,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                          p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                          p.Text(schoolweb,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                           p.SizedBox(height: 0,),
                                          p.Stack(
                                            alignment: p.Alignment.center,
                                            children: [
                                              p.Container(
                                                width: 60,
                                                height: 60,
                                                decoration:  p.BoxDecoration(
                                                  color: PdfColor.fromHex("00A0E3"),
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.Container(
                                                width: 55,
                                                height: 55,
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.ClipRRect(
                                                  horizontalRadius: 14,
                                                  verticalRadius: 20,
                                                  child:
                                                  p.Image(imglist[index][8],height: 55,width: 55))

                                            ],
                                          ),
                                          p.SizedBox(height: 1,),
                                          p.Text("${namelist[index][8]} ${lastnamelist[index][8]}",style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.black, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                          p.Text("ID: ${regnolist[index][8]}",style: p.TextStyle(
                                              font: fontrmedpoppoins,
                                              color:  PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                          p.SizedBox(height: 0,),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("Class",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text("${classlist[index][8]} ${sectionlist[index][8]}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("DOB",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(doblist[index][8],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Blood Group",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color:PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(bloodlist[index][8],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Phone No",style:  p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style:  p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(phonelist[index][8],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                              children:[
                                                p.SizedBox(width: 10,),
                                                p.Container(
                                                    width:40,height:20,
                                                    child:
                                                    p.Image(schoolsign)
                                                )
                                              ]

                                          ),
                                          p.Row(
                                              children:[
                                                p.SizedBox(width: 10,),
                                                p.Text("Principal",style: p.TextStyle(
                                                    font: fontregpoppoins,
                                                    color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal))
                                              ]

                                          ),

                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),

                              ]
                          ):p.Container(),
                          namelist[index].length>9?
                          p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[

                                p.Container(
                                  height: 252.35,
                                  width: 161.5,
                                  color:PdfColors.white,

                                  child: p.Stack(
                                    children: [
                                      p.Column(
                                        mainAxisAlignment:  p.MainAxisAlignment.spaceBetween,
                                        children: [
                                          p.Image(bg1),
                                          p.Image(bg2),


                                        ],
                                      ),
                                      p.Column(
                                        crossAxisAlignment: p.CrossAxisAlignment.center,
                                        children: [
                                          p.SizedBox(height: 16,),
                                          p.Row(
                                            mainAxisAlignment: p.MainAxisAlignment.center,
                                            children: [
                                              p.Container(
                                                width:30,
                                                height:30,
                                                child:   p.ClipRRect(
                                                  verticalRadius: 18,
                                                  horizontalRadius: 18,
                                                  child: p.Image(schoollogoii),),
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),
                                              ),
                                            ],
                                          ),
                                          p.SizedBox(height: 2,),
                                          p.Text(schoolname,style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                          p.Text(schooladdress,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                          p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                          p.Text(schoolweb,style: p.TextStyle(
                                              font: fontregpoppoins,
                                              color: PdfColors.white, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                           p.SizedBox(height: 0,),
                                          p.Stack(
                                            alignment: p.Alignment.center,
                                            children: [
                                              p.Container(
                                                width: 60,
                                                height: 60,
                                                decoration:  p.BoxDecoration(
                                                  color: PdfColor.fromHex("00A0E3"),
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.Container(
                                                width: 55,
                                                height: 55,
                                                decoration: p.BoxDecoration(
                                                  color:PdfColors.white,
                                                  shape: p.BoxShape.circle,
                                                ),


                                              ),
                                              p.ClipRRect(
                                                  horizontalRadius: 14,
                                                  verticalRadius: 20,
                                                  child:
                                                  p.Image(imglist[index][9],height: 55,width: 55))

                                            ],
                                          ),
                                          p.SizedBox(height: 1,),
                                          p.Text("${namelist[index][9]} ${lastnamelist[index][9]}",style: p.TextStyle(
                                              font: fontsemipoppoins,
                                              color: PdfColors.black, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                          p.Text("ID: ${regnolist[index][9]}",style: p.TextStyle(
                                              font: fontrmedpoppoins,
                                              color:  PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                          p.SizedBox(height: 0,),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("Class",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text("${classlist[index][9]} ${sectionlist[index][9]}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child: p.Text("DOB",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(doblist[index][9],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Blood Group",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color:PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(bloodlist[index][9],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                            children: [
                                              p.SizedBox(width: 10,),
                                              p.Container(
                                                width:80,
                                                child:  p.Text("Phone No",style:  p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              ),
                                              p.Text(": ",style:  p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColor.fromHex("00A0E3"), fontSize: 8,fontWeight: p.FontWeight.normal),),
                                              p.Text(phonelist[index][9],style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                            ],
                                          ),
                                          p.Row(
                                              children:[
                                                p.SizedBox(width: 10,),
                                                p.Container(
                                                    width:40,height:20,
                                                    child:
                                                    p.Image(schoolsign)
                                                )
                                              ]

                                          ),
                                          p.Row(
                                              children:[
                                                p.SizedBox(width: 10,),
                                                p.Text("Principal",style: p.TextStyle(
                                                    font: fontregpoppoins,
                                                    color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.normal))
                                              ]

                                          ),

                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),

                              ]
                          ):p.Container(),




                        ]
                    ),),
                    p.Container(
                      height: 3.1,

                    ),
                    p.Padding(
                        padding: p.EdgeInsets.only(left:20),
                        child:
                    p.Container(
                      width:820,
                      child: p.Divider( thickness: 2,color:PdfColors.black),

                    ),
                    ),

                    p.Container(
                      height: 3.1,

                    ),
                    p.Padding(
                        padding: p.EdgeInsets.only(left:20),
                        child:
                    p.Row(
                        mainAxisAlignment: p.MainAxisAlignment.start,
                        children: [

                          namelist[index].length>5?
                          p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Transform.scale(scale: -1,
                                  child:
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,

                                    child: p.Stack(
                                      children: [
                                        p.Column(
                                          mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
                                          children: [
                                            p.Image(bg3,),
                                            p.Image(bg2),

                                          ],
                                        ),
                                        p.Column(
                                          crossAxisAlignment: p.CrossAxisAlignment.center,

                                          children: [
                                            p.SizedBox(height: 16,),
                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 10.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.start,
                                                children: [
                                                  p.Container(
                                                      width:30,
                                                      height:30, decoration: p.BoxDecoration(
                                                      shape: p.BoxShape.circle,
                                                      color:PdfColors.white
                                                  ),
                                                      child:   p.ClipRRect(
                                                  verticalRadius: 18,
                                                  horizontalRadius: 18,
                                                  child: p.Image(schoollogoii),),),
                                                ],
                                              ),
                                            ),
                                            p.SizedBox(height: 36,),


                                            p.Text("Emergency Contact No",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Text("+91 ${emgphonelist[index][5]}",style: p.TextStyle(
                                                font: fontregpoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                            p.SizedBox(height:5),
                                            p.Text("Address",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Container(
                                              width:150,
                                              child: p.Text(getCapitalizedName(addresslist[index][5]),style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                            ),
                                            p.SizedBox(height: 2,),



                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 0.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Column(
                                                    children: [
                                                      p.SizedBox(height:20),
                                                      p.Container(
                                                          width: 50,
                                                          height: 50,
                                                          child: p.Image(vidhaanlogo)),

                                                      p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                          font: fontsemimon,
                                                          color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ]) :p.Container(),
                          namelist[index].length>6?
                          p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Transform.scale(scale: -1,
                                  child:
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,

                                    child: p.Stack(
                                      children: [
                                        p.Column(
                                          mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
                                          children: [
                                            p.Image(bg3,),
                                            p.Image(bg2),

                                          ],
                                        ),
                                        p.Column(
                                          crossAxisAlignment: p.CrossAxisAlignment.center,

                                          children: [
                                            p.SizedBox(height: 16,),
                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 10.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.start,
                                                children: [
                                                  p.Container(
                                                    width:30,
                                                    height:30, decoration: p.BoxDecoration(
                                                      shape: p.BoxShape.circle,
                                                      color:PdfColors.white
                                                  ),
                                                    child:   p.ClipRRect(
                                                      verticalRadius: 18,
                                                      horizontalRadius: 18,
                                                      child: p.Image(schoollogoii),),),
                                                ],
                                              ),
                                            ),
                                            p.SizedBox(height: 36,),


                                            p.Text("Emergency Contact No",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Text("+91 ${emgphonelist[index][6]}",style: p.TextStyle(
                                                font: fontregpoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                            p.SizedBox(height:5),
                                            p.Text("Address",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Container(
                                              width:150,
                                              child: p.Text(getCapitalizedName(addresslist[index][6]),style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                            ),
                                            p.SizedBox(height: 2,),



                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 0.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Column(
                                                    children: [
                                                      p.SizedBox(height:20),
                                                      p.Container(
                                                          width: 50,
                                                          height: 50,
                                                          child: p.Image(vidhaanlogo)),

                                                      p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                          font: fontsemimon,
                                                          color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),

                              ]) :p.Container(),
                          namelist[index].length>7? p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Transform.scale(scale: -1,
                                  child:
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,

                                    child: p.Stack(
                                      children: [
                                        p.Column(
                                          mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
                                          children: [
                                            p.Image(bg3,),
                                            p.Image(bg2),

                                          ],
                                        ),
                                        p.Column(
                                          crossAxisAlignment: p.CrossAxisAlignment.center,

                                          children: [
                                            p.SizedBox(height: 16,),
                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 10.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.start,
                                                children: [
                                                  p.Container(
                                                    width:30,
                                                    height:30, decoration: p.BoxDecoration(
                                                      shape: p.BoxShape.circle,
                                                      color:PdfColors.white
                                                  ),
                                                    child:   p.ClipRRect(
                                                      verticalRadius: 18,
                                                      horizontalRadius: 18,
                                                      child: p.Image(schoollogoii),),),
                                                ],
                                              ),
                                            ),
                                            p.SizedBox(height: 36,),


                                            p.Text("Emergency Contact No",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Text("+91 ${emgphonelist[index][7]}",style: p.TextStyle(
                                                font: fontregpoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                            p.SizedBox(height:5),
                                            p.Text("Address",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Container(
                                              width:150,
                                              child: p.Text(getCapitalizedName(addresslist[index][7]),style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                            ),
                                            p.SizedBox(height: 2,),



                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 0.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Column(
                                                    children: [
                                                      p.SizedBox(height:20),
                                                      p.Container(
                                                          width: 50,
                                                          height: 50,
                                                          child: p.Image(vidhaanlogo)),

                                                      p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                          font: fontsemimon,
                                                          color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),

                              ]) :p.Container(),
                          namelist[index].length>8? p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Transform.scale(scale: -1,
                                  child:
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,

                                    child: p.Stack(
                                      children: [
                                        p.Column(
                                          mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
                                          children: [
                                            p.Image(bg3,),
                                            p.Image(bg2),

                                          ],
                                        ),
                                        p.Column(
                                          crossAxisAlignment: p.CrossAxisAlignment.center,

                                          children: [
                                            p.SizedBox(height: 16,),
                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 10.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.start,
                                                children: [
                                                  p.Container(
                                                    width:30,
                                                    height:30, decoration: p.BoxDecoration(
                                                      shape: p.BoxShape.circle,
                                                      color:PdfColors.white
                                                  ),
                                                    child:   p.ClipRRect(
                                                      verticalRadius: 18,
                                                      horizontalRadius: 18,
                                                      child: p.Image(schoollogoii),),),
                                                ],
                                              ),
                                            ),
                                            p.SizedBox(height: 36,),


                                            p.Text("Emergency Contact No",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Text("+91 ${emgphonelist[index][8]}",style: p.TextStyle(
                                                font: fontregpoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                            p.SizedBox(height:5),
                                            p.Text("Address",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Container(
                                              width:150,
                                              child: p.Text(getCapitalizedName(addresslist[index][8]),style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                            ),
                                            p.SizedBox(height: 2,),



                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 0.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Column(
                                                    children: [
                                                      p.SizedBox(height:20),
                                                      p.Container(
                                                          width: 50,
                                                          height: 50,
                                                          child: p.Image(vidhaanlogo)),

                                                      p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                          font: fontsemimon,
                                                          color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),

                              ]) :p.Container(),


                          namelist[index].length>9? p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Transform.scale(scale: -1,
                                  child:
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,

                                    child: p.Stack(
                                      children: [
                                        p.Column(
                                          mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
                                          children: [
                                            p.Image(bg3,),
                                            p.Image(bg2),

                                          ],
                                        ),
                                        p.Column(
                                          crossAxisAlignment: p.CrossAxisAlignment.center,

                                          children: [
                                            p.SizedBox(height: 16,),
                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 10.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.start,
                                                children: [
                                                  p.Container(
                                                    width:30,
                                                    height:30, decoration: p.BoxDecoration(
                                                      shape: p.BoxShape.circle,
                                                      color:PdfColors.white
                                                  ),
                                                    child:   p.ClipRRect(
                                                      verticalRadius: 18,
                                                      horizontalRadius: 18,
                                                      child: p.Image(schoollogoii),),),
                                                ],
                                              ),
                                            ),
                                            p.SizedBox(height: 36,),


                                            p.Text("Emergency Contact No",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Text("+91 ${emgphonelist[index][9]}",style: p.TextStyle(
                                                font: fontregpoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                            p.SizedBox(height:5),
                                            p.Text("Address",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Container(
                                              width:150,
                                              child: p.Text(getCapitalizedName(addresslist[index][9]),style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                            ),
                                            p.SizedBox(height: 2,),



                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 0.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Column(
                                                    children: [
                                                      p.SizedBox(height:20),
                                                      p.Container(
                                                          width: 50,
                                                          height: 50,
                                                          child: p.Image(vidhaanlogo)),

                                                      p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                          font: fontsemimon,
                                                          color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),

                              ]) :p.Container(),




                        ]
                    ),
                    ),
                    p.Container(
                      height: 30.1,
                    ),
                    p.Padding(
                        padding: p.EdgeInsets.only(left:20),
                        child:
                    p.Row(
                        mainAxisAlignment: p.MainAxisAlignment.start,
                        children: [
                          namelist[index].length>0?
                          p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[
                                p.Transform.scale(scale: -1,
                                  child:
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,

                                    child: p.Stack(
                                      children: [
                                        p.Column(
                                          mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
                                          children: [
                                            p.Image(bg3,),
                                            p.Image(bg2),

                                          ],
                                        ),
                                        p.Column(
                                          crossAxisAlignment: p.CrossAxisAlignment.center,

                                          children: [
                                            p.SizedBox(height: 16,),
                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 10.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.start,
                                                children: [
                                                  p.Container(
                                                    width:30,
                                                    height:30, decoration: p.BoxDecoration(
                                                      shape: p.BoxShape.circle,
                                                      color:PdfColors.white
                                                  ),
                                                    child:   p.ClipRRect(
                                                      verticalRadius: 18,
                                                      horizontalRadius: 18,
                                                      child: p.Image(schoollogoii),),),
                                                ],
                                              ),
                                            ),
                                            p.SizedBox(height: 36,),


                                            p.Text("Emergency Contact No",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Text("+91 ${emgphonelist[index][0]}",style: p.TextStyle(
                                                font: fontregpoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                            p.SizedBox(height:5),
                                            p.Text("Address",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Container(
                                              width:150,
                                              child: p.Text(getCapitalizedName(addresslist[index][0]),style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                            ),
                                            p.SizedBox(height: 2,),



                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 0.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Column(
                                                    children: [
                                                      p.SizedBox(height:20),
                                                      p.Container(
                                                          width: 50,
                                                          height: 50,
                                                          child: p.Image(vidhaanlogo)),

                                                      p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                          font: fontsemimon,
                                                          color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),
                              ]):p.Container(),

                          namelist[index].length>1?
                          p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[
                                p.Transform.scale(scale: -1,
                                  child:
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,

                                    child: p.Stack(
                                      children: [
                                        p.Column(
                                          mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
                                          children: [
                                            p.Image(bg3,),
                                            p.Image(bg2),

                                          ],
                                        ),
                                        p.Column(
                                          crossAxisAlignment: p.CrossAxisAlignment.center,

                                          children: [
                                            p.SizedBox(height: 16,),
                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 10.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.start,
                                                children: [
                                                  p.Container(
                                                    width:30,
                                                    height:30, decoration: p.BoxDecoration(
                                                      shape: p.BoxShape.circle,
                                                      color:PdfColors.white
                                                  ),
                                                    child:   p.ClipRRect(
                                                      verticalRadius: 18,
                                                      horizontalRadius: 18,
                                                      child: p.Image(schoollogoii),),),
                                                ],
                                              ),
                                            ),
                                            p.SizedBox(height: 36,),


                                            p.Text("Emergency Contact No",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Text("+91 ${emgphonelist[index][1]}",style: p.TextStyle(
                                                font: fontregpoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                            p.SizedBox(height:5),
                                            p.Text("Address",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Container(
                                              width:150,
                                              child: p.Text(getCapitalizedName(addresslist[index][1]),style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                            ),
                                            p.SizedBox(height: 2,),



                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 0.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Column(
                                                    children: [
                                                      p.SizedBox(height:20),
                                                      p.Container(
                                                          width: 50,
                                                          height: 50,
                                                          child: p.Image(vidhaanlogo)),

                                                      p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                          font: fontsemimon,
                                                          color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),
                              ]):p.Container(),
                          namelist[index].length>2? p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[
                                p.Transform.scale(scale: -1,
                                  child:
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,

                                    child: p.Stack(
                                      children: [
                                        p.Column(
                                          mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
                                          children: [
                                            p.Image(bg3,),
                                            p.Image(bg2),

                                          ],
                                        ),
                                        p.Column(
                                          crossAxisAlignment: p.CrossAxisAlignment.center,

                                          children: [
                                            p.SizedBox(height: 16,),
                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 10.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.start,
                                                children: [
                                                  p.Container(
                                                    width:30,
                                                    height:30, decoration: p.BoxDecoration(
                                                      shape: p.BoxShape.circle,
                                                      color:PdfColors.white
                                                  ),
                                                    child:   p.ClipRRect(
                                                      verticalRadius: 18,
                                                      horizontalRadius: 18,
                                                      child: p.Image(schoollogoii),),),
                                                ],
                                              ),
                                            ),
                                            p.SizedBox(height: 36,),


                                            p.Text("Emergency Contact No",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Text("+91 ${emgphonelist[index][2]}",style: p.TextStyle(
                                                font: fontregpoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                            p.SizedBox(height:5),
                                            p.Text("Address",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Container(
                                              width:150,
                                              child: p.Text(getCapitalizedName(addresslist[index][2]),style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                            ),
                                            p.SizedBox(height: 2,),



                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 0.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Column(
                                                    children: [
                                                      p.SizedBox(height:20),
                                                      p.Container(
                                                          width: 50,
                                                          height: 50,
                                                          child: p.Image(vidhaanlogo)),

                                                      p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                          font: fontsemimon,
                                                          color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),
                              ]) :p.Container(),
                          namelist[index].length>3?  p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[
                                p.Transform.scale(scale: -1,
                                  child:
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,

                                    child: p.Stack(
                                      children: [
                                        p.Column(
                                          mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
                                          children: [
                                            p.Image(bg3,),
                                            p.Image(bg2),

                                          ],
                                        ),
                                        p.Column(
                                          crossAxisAlignment: p.CrossAxisAlignment.center,

                                          children: [
                                            p.SizedBox(height: 16,),
                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 10.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.start,
                                                children: [
                                                  p.Container(
                                                    width:30,
                                                    height:30, decoration: p.BoxDecoration(
                                                      shape: p.BoxShape.circle,
                                                      color:PdfColors.white
                                                  ),
                                                    child:   p.ClipRRect(
                                                      verticalRadius: 18,
                                                      horizontalRadius: 18,
                                                      child: p.Image(schoollogoii),),),
                                                ],
                                              ),
                                            ),
                                            p.SizedBox(height: 36,),


                                            p.Text("Emergency Contact No",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Text("+91 ${emgphonelist[index][3]}",style: p.TextStyle(
                                                font: fontregpoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                            p.SizedBox(height:5),
                                            p.Text("Address",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Container(
                                              width:150,
                                              child: p.Text(getCapitalizedName(addresslist[index][3]),style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                            ),
                                            p.SizedBox(height: 2,),



                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 0.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Column(
                                                    children: [
                                                      p.SizedBox(height:20),
                                                      p.Container(
                                                          width: 50,
                                                          height: 50,
                                                          child: p.Image(vidhaanlogo)),

                                                      p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                          font: fontsemimon,
                                                          color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),
                              ]) :p.Container(),
                          namelist[index].length>4? p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.center,
                              children:[
                                p.Transform.scale(scale: -1,
                                  child:
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,

                                    child: p.Stack(
                                      children: [
                                        p.Column(
                                          mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
                                          children: [
                                            p.Image(bg3,),
                                            p.Image(bg2),

                                          ],
                                        ),
                                        p.Column(
                                          crossAxisAlignment: p.CrossAxisAlignment.center,

                                          children: [
                                            p.SizedBox(height: 16,),
                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 10.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.start,
                                                children: [
                                                  p.Container(
                                                    width:30,
                                                    height:30, decoration: p.BoxDecoration(
                                                      shape: p.BoxShape.circle,
                                                      color:PdfColors.white
                                                  ),
                                                    child:   p.ClipRRect(
                                                      verticalRadius: 18,
                                                      horizontalRadius: 18,
                                                      child: p.Image(schoollogoii),),),
                                                ],
                                              ),
                                            ),
                                            p.SizedBox(height: 36,),


                                            p.Text("Emergency Contact No",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Text("+91 ${emgphonelist[index][4]}",style: p.TextStyle(
                                                font: fontregpoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                            p.SizedBox(height:5),
                                            p.Text("Address",style: p.TextStyle(
                                                font: fontsemipoppoins,
                                                color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                            p.Container(
                                                width:90,
                                                height:2,
                                                child: p.Divider()
                                            ),
                                            p.SizedBox(height: 2,),

                                            p.Container(
                                              width:150,
                                              child: p.Text(getCapitalizedName(addresslist[index][4]),style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                            ),
                                            p.SizedBox(height: 2,),



                                            p.Padding(
                                              padding: p.EdgeInsets.only(left: 0.0),
                                              child: p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Column(
                                                    children: [
                                                      p.SizedBox(height:20),
                                                      p.Container(
                                                          width: 50,
                                                          height: 50,
                                                          child: p.Image(vidhaanlogo)),

                                                      p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                          font: fontsemimon,
                                                          color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                p.Container(
                                  height: 3.0,

                                ),
                                p.Container(
                                  height: 16,
                                  width: 16,
                                  child: p.Image(plusicon),
                                ),
                              ]

                          ) :p.Container(),




                        ]
                    ),
                    ),



                  ]));
                }, itemCount: namelist.length)



        ));

    final pdf = p.Document();
    pdf.addPage(

      p.MultiPage(
        pageFormat: PdfPageFormat.a3,
        orientation: p.PageOrientation.portrait,
        margin: p.EdgeInsets.all(0),
        build: (context) => widgets, //here goes the widgets list
      ),
    );
    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

    setState(() {

    });
  }

  List namelist = [];
  List lastnamelist = [];
  List imglist = [];
  List regnolist = [];
  List classlist = [];
  List sectionlist = [];
  List doblist = [];
  List bloodlist = [];
  List phonelist = [];
  List emgphonelist = [];
  List addresslist = [];
  addinglist() async {
    var doucment = await FirebaseFirestore.instance.collection("Students").orderBy("timestamp").get();
    print("Reg NO changed successfully");
    int temp= doucment.docs.length~/10;
    int remainder = doucment.docs.length.remainder(10);
    int pagecount=0;
    int g=0;
    print(temp);
    print(remainder);
    if(remainder!=0){
      setState(() {
        pagecount=temp+1;
      });
    }
    print(pagecount);
    for (int i=0;i<pagecount;i++){
setState(() {


       namelist.add([]);
       lastnamelist.add([]);
       imglist.add([]);
       regnolist.add([]);
       classlist.add([]);
       sectionlist.add([]);
       doblist.add([]);
       bloodlist.add([]);
       phonelist.add([]);
       emgphonelist.add([]);
       addresslist.add([]);
});
    }
    for (int j=0;j<doucment.docs.length;j++) {

      setState(()  {
      namelist[g].add(doucment.docs[j]["stname"]);
      lastnamelist[g].add(doucment.docs[j]["stlastname"]);
      regnolist[g].add(doucment.docs[j]["regno"]);
      classlist[g].add(doucment.docs[j]["admitclass"]);
      sectionlist[g].add(doucment.docs[j]["section"]);
      doblist[g].add(doucment.docs[j]["dob"]);
      bloodlist[g].add(doucment.docs[j]["bloodgroup"]);
      phonelist[g].add(doucment.docs[j]["mobile"]);
      emgphonelist[g].add(doucment.docs[j]["fatherMobile"]);
      addresslist[g].add(doucment.docs[j]["address"]);
      });
       imglist[g].add(await flutterImageProvider(NetworkImage(doucment.docs[j]["imgurl"]==""?"https://firebasestorage.googleapis.com/v0/b/vidhaan-4aee7.appspot.com/o/360_F_270188580_YDUEwBmDIxBMvCQxkcunmEkm93VqOgqm.jpg?alt=media&token=fe18ba43-4a31-4b53-9523-42bb4241d9a1":doucment.docs[j]["imgurl"])));

      if((j+1)%10==0){
        printtext(g);
        setState(() {
          g=g+1;
        });
      }
    }
    print("Added sucessfully");



  }
  printtext(g){
    print(namelist[g].length);
    print(imglist[g].length);
    print(regnolist[g].length);
    print(classlist[g].length);
    print(doblist[g].length);
    print(bloodlist[g].length);
    print(phonelist[g].length);
    print("Next Set------------------------${g+1}");
  }



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
                                      GestureDetector(
                                        onTap: (){
                                          //checkdemo();
                                          //getvalue();
                                          updatestudentregno();
                                         // updatestudentregno();
                                        },
                                        child: Container(
                                            width: 100,
                                            child: Image.asset("assets/VIDHAANTEXT.png")),
                                      ),
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
                                 /*   ListTile(
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

                                  */





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
                                     /* ListTile(
                                          onTap:(){
                                            setState((){
                                             pages=StaffID();
                                            });
                                          },
                                        title: Text("Staff ID Card",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 3?  Colors.white : Color(0xff9197B3)),
                                      )),*/
                                     /* ListTile(
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

                                      */
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

                                 /*   ListTile(
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

                                  */
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

                                            pages= ClassWiseTimeTable();

                                            dawer=10;

                                          });
                                        },
                                        title: Text("Classwise TimeTable",style: GoogleFonts.poppins(
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
                                        onTap:(){
                                          setState(() {
                                            pages=ExamTimeTable();
                                          });
                                          },
                                        title: Text("Exam Time Table",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                      )
                                      ),
                                      ListTile(
                                        onTap: (){
                                          setState(() {
                                            pages=ExamsubjectMaster();
                                          });
                                        },
                                        title: Text("Exam Subject Master",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                      )),
                                      ListTile(
                                        onTap: (){
                                          setState(() {
                                            pages=ExamMaster();
                                          });
                                        },
                                        title: Text("Add Exam",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                      )),
                                      ListTile(
                                        onTap: (){
                                          setState(() {
                                           // pages=ExamMaster();
                                          });
                                        },
                                        title: Text("Exam Reports",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 6?  Colors.white : Color(0xff9197B3)),
                                      )),







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
                                        onTap:(){
                                          setState(() {
                                            pages=PayrollGen();
                                          });

                              },
                                        title: Text("Payroll Generation",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 8?  Colors.white : Color(0xff9197B3)),
                                      )),
                                      ListTile(
                                        onTap: (){
                                          setState(() {
                                            pages=PayrollReports();
                                          });
                                        },
                                        title: Text("Payroll Reports",style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dawer == 8?  Colors.white : Color(0xff9197B3)),
                                      )),






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
  String getCapitalizedName(String name) {
    final names = name.split(' ');
    String finalName = '';
    for (var n in names) {
      n.trim();
      if (n.isNotEmpty) {
        finalName += '${n[0].toUpperCase()}${n.substring(1)} ';
      }
    }
    return finalName.trim();
  }
}


