import 'package:bouncing_draggable_dialog/bouncing_draggable_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:random_string/random_string.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vidhaan/eventcal.dart';
import 'package:vidhaan/profile.dart';
import 'package:vidhaan/profiledw.dart';
import 'package:vidhaan/stafflist.dart';
import 'package:vidhaan/staffpiechart.dart';
import 'package:vidhaan/student_pie_chart.dart';
import 'package:vidhaan/studentlist.dart';

import 'demo2.dart';
import 'demobar graph.dart';


class Dashboard2 extends StatefulWidget {
  const Dashboard2({Key? key}) : super(key: key);

  @override
  State<Dashboard2> createState() => _Dashboard2State();
}

class _Dashboard2State extends State<Dashboard2> {

  int total=0;
  int present=0;
  int absent=0;

  int selectedvalue=0;
  int selectedvalue2=0;
  int selectedvalue3=0;
  int selectedvalue4=0;

  int cyear = 0;
  String cmonth = "";
  String day = "";
  int currentDate = 0;

  sendBirthWishes() async {
    var staffsDoc = await FirebaseFirestore.instance.collection('Staffs').get();
    var studentsDoc = await FirebaseFirestore.instance.collection('Students').get();

    for(int i = 0; i < staffsDoc.docs.length; i++){
      var staff = await FirebaseFirestore.instance.collection('Staffs').doc(staffsDoc.docs[i].id).get();
      if(staff.get("dob").toString().startsWith(DateFormat('dd / M / yyyy').format(DateTime.now()).toString())){
        FirebaseFirestore.instance.collection('Staffs').doc(staffsDoc.docs[i].id).collection('Notification').doc('BirthdayWish').set({
          "body" : "Dear ${staff.get("stname")},\nWish you many more return days.",
          "date" : DateFormat('dd/MM/yyyy').format(DateTime.now()),
          "readstatus" : false,
          "time" : DateFormat('hh:mm aa').format(DateTime.now()),
          "timestamp" : DateTime.now().millisecondsSinceEpoch,
          "title" : "Happy Birthday",
        });
      }
    }

    for(int j = 0; j < studentsDoc.docs.length; j++){
      var student = await FirebaseFirestore.instance.collection('Students').doc(studentsDoc.docs[j].id).get();
      if(student.get("dob") == DateFormat('dd-M-yyyy').format(DateTime.now()).toString()){
        FirebaseFirestore.instance.collection('Staffs').doc(student.id).collection('Notification').doc('BirthdayWish').set({
          "body" : "Dear ${student.get("stname")},\nWish you many more return days.",
          "date" : DateFormat('dd/MM/yyyy').format(DateTime.now()),
          "readstatus" : false,
          "time" : DateFormat('hh:mm aa').format(DateTime.now()),
          "timestamp" : DateTime.now().millisecondsSinceEpoch,
          "title" : "Happy Birthday",
        });
      }
    }

  }

  String getMonth(int currentMonthIndex) {
    return DateFormat('MMM').format(DateTime(0, currentMonthIndex)).toString();
  }
  DateTime _chosenDate = DateTime.now();
  String  _chosenDay ="";
  bool dateselected=false;
  String formattedDate='';
  Date() {
    setState(() {
      day = DateFormat('EEEE').format(DateTime.now());
      cyear = DateTime.now().year;
      cmonth = getMonth(DateTime.now().month);
      currentDate = DateTime.now().day;
    });

  }

  setMonthlyFees() async {
    var doc = await FirebaseFirestore.instance.collection("FeesCollection").where("paytype", isEqualTo: "Monthly").get();
    var date = DateTime.now();
    int lastday = DateTime(date.year, date.month + 1, 0).day;
    for(int i = 0; i < doc.docs.length; i++){
      var doc1 = await FirebaseFirestore.instance.collection("FeesCollection").doc(doc.docs[i].get("stId")+":"+DateFormat('MMM yyyy').format(DateTime(date.year, date.month + 1, date.day))).get();
      if(date.day == lastday){
        if(!doc1.exists){
          FirebaseFirestore.instance.collection("FeesCollection").doc(doc.docs[i].get("stId")+":"+DateFormat('MMM yyyy').format(DateTime(date.year, date.month + 1, date.day))).set({
            "feesname": doc.docs[i].get("feesname")+" " +DateFormat('MMM yyyy').format(DateTime(date.year, date.month + 1, 1)),
            "amount": doc.docs[i].get("amount"),
            "payedamount": 0.0,
            "timestamp": DateTime.now().millisecondsSinceEpoch,
            "paytype": doc.docs[i].get("paytype"),
            "status": false,
            "date": "",
            "time": "",
            "class" : doc.docs[i].get("class"),
            "section" : doc.docs[i].get("section"),
            "stRegNo" : doc.docs[i].get("stRegNo"),
            "stName" : doc.docs[i].get("stName"),
            "email" : doc.docs[i].get("email"),
            "stId" : doc.docs[i].get("stId"),
            "duedate":  DateFormat('dd/MM/yyyy').format(DateTime(date.year, date.month + 1, 5)),
          });
          FirebaseFirestore.instance.collection("Students").doc(doc.docs[i].id.toString().split(":").first).collection('Fees').doc(DateFormat('MMM yyyy').format(DateTime(date.year, date.month + 1, date.day))).set({
            "feesname": doc.docs[i].get("feesname")+" " +DateFormat('MMM yyyy').format(DateTime(date.year, date.month + 1, 1)),
            "amount": doc.docs[i].get("amount"),
            "payedamount": 0.0,
            "timestamp": DateTime.now().millisecondsSinceEpoch,
            "paytype": doc.docs[i].get("paytype"),
            "status": false,
            "date": "",
            "time": "",
            "class" : doc.docs[i].get("class"),
            "section" : doc.docs[i].get("section"),
            "stRegNo" : doc.docs[i].get("stRegNo"),
            "stName" : doc.docs[i].get("stName"),
            "email" : doc.docs[i].get("email"),
            "stId" : doc.docs[i].get("stId"),
            "duedate": DateFormat('dd/MM/yyyy').format(DateTime(date.year, date.month + 1, 5)),
          });
        }
      }
    }
    
  }

  @override
  void initState() {
    //sendBirthWishes(); ///Enabale to send birth day wishes
    getvalue();
    Date();
    getadmin();
    getevents();
    setMonthlyFees();
    // TODO: implement initState
    super.initState();
  }
  String schoolname="";
  String schooladdress="";
  String schoollogo="";
  String idcarddesign="";
  String solgan="";
  String imgurl="";
  getadmin() async {
    var document = await FirebaseFirestore.instance.collection("Admin").get();
    setState(() {
       schoolname=document.docs[0]["schoolname"];
       schooladdress=
       "${document.docs[0]["area"]} ${document.docs[0]["city"]} ${document.docs[0]["pincode"]}";
       schoollogo=document.docs[0]["logo"];
       idcarddesign=document.docs[0]["idcard"].toString();
       solgan=document.docs[0]["solgan"];
       imgurl=document.docs[0]["logo"];
    });
  }


   _showPopupMenu()  {
    return showMenu(
      context: context,
      position: RelativeRect.fromLTRB(900, 80, 0, 100),
      items: [
        PopupMenuItem<String>(
          onTap: () async {
            final navigator = Navigator.of(context);
            await Future.delayed(Duration.zero);
            navigator.push(
              MaterialPageRoute(builder: (_) => ProfileDarwer()),
            );

          },
            child:  Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.person),
                ),
                Text('Profile'),
              ],
            ), value: 'Doge'),
        PopupMenuItem<String>(
          onTap: (){
            Navigator.of(context).pop();
          },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.logout_rounded),
                ),
                 Text('Log out'),
              ],
            ), value: 'Lion'),


      ],

      elevation: 8.0,
    );
  }
  int students= 0;
  int staffs= 0;
  int classes= 0;
  int amount= 0;
  int staffcount= 0;
  int studentcount= 0;
  List studentname= [];
  List studentid= [];
  List studentphone= [];
  List studentimg= [];


  List stname= [];
  List stid= [];
  List stphone= [];
  List stimg= [];



  getvalue() async {
    var doucment = await FirebaseFirestore.instance.collection("Students").get();
    var doucment2 = await FirebaseFirestore.instance.collection("Staffs").get();
    var doucment3 = await FirebaseFirestore.instance.collection("ClassMaster").get();
    var doucment4 = await FirebaseFirestore.instance.collection("Students").where("studentid",isNotEqualTo:"").get();
    var doucment6 = await FirebaseFirestore.instance.collection("Students").orderBy("timestamp").get();
    var doucment5 = await FirebaseFirestore.instance.collection("Staffs").where("userid",isNotEqualTo:"").get();
    var doucment7 = await FirebaseFirestore.instance.collection("Staffs").orderBy("timestamp").get();

    setState(() {
      students=doucment.docs.length;
      staffs=doucment2.docs.length;
      classes=doucment3.docs.length;
      staffcount= doucment5.docs.length;
      studentcount= doucment4.docs.length;
    });


    for(int i=0;i<doucment6.docs.length;i++) {
      if (doucment6.docs[i]["studentid"] == "") {
        setState(() {
          studentname.add(doucment6.docs[i]["stname"]);
          studentid.add(doucment6.docs[i]["regno"]);
          studentimg.add(doucment6.docs[i]["imgurl"]);
          studentphone.add(doucment6.docs[i]["mobile"]);
        });
      }
    }
    for(int i=0;i<doucment7.docs.length;i++) {
      if (doucment7.docs[i]["userid"] == "") {
        setState(() {
          stname.add(doucment7.docs[i]["stname"]);
          stid.add(doucment7.docs[i]["regno"]);
          stimg.add(doucment7.docs[i]["imgurl"]);
          stphone.add(doucment7.docs[i]["mobile"]);
        });
      }
    }

  }
  Widget content() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'User not enrolled',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: width/68.3,
            ),
          ),
          SizedBox(
            height: height/81.375,
          ),
          Divider(
            color: Colors.black,
          ),
        Container(
          height: height/1.302, // Change as per your requirement
          width: width/3.415, // Change as per your requirement
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: studentname.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(studentname[index]),
                subtitle: Text(studentid[index]),
                leading: CircleAvatar(

                  radius: 30,foregroundImage: NetworkImage(
                    studentimg[index],
                ),
                ),
                trailing: Text(studentphone[index]),
              );
            },
          ),
        ),
          Padding(
            padding: const EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
            child: Container(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: width/97.571428571,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget content2() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'User not enrolled',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: width/68.3,
            ),
          ),
          SizedBox(
            height: height/81.375,
          ),
          Divider(
            color: Colors.black,
          ),
        Container(
          height: height/1.302, // Change as per your requirement
          width: width/3.415, // Change as per your requirement
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: stname.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(stname[index]),
                subtitle: Text(stid[index]),
                leading: CircleAvatar(

                  radius: 30,foregroundImage: NetworkImage(
                    stimg[index],
                ),
                ),
                trailing: Text(stphone[index]),
              );
            },
          ),
        ),
          Padding(
            padding: const EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
            child: Container(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: width/97.571428571,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }




  var pages;

  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
    return pages == null ? Container(
        width: width/1.707,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Image.asset("assets/Hello Admin 👋🏼,.png"),
                  ),

                  Container(
                      width: width/3.415,
                      height:height/6.51,
                      decoration: BoxDecoration(
                        color: Color(0xff00A0E3),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(120),
                          bottomLeft: Radius.circular(120),
                        ),

                      ),
                      child: Row(
                        children: [
                          SizedBox(width: width/68.3,),
                          Container(
                            width: width/19.51428571428571,
                            height:height/9.3,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(70)


                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(70),
                              child: Container(
                                width: width/19.51428571428571,
                                height:height/9.3,
                                child: Image.network(imgurl, fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          SizedBox(width: width/113.8333333333333,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: width/6.2090909090909090,
                                  child: Text(schoolname,style: GoogleFonts.poppins(fontSize: width/80.352941176,fontWeight: FontWeight.w700,color: Colors.white),)),
                              SizedBox(height: height/130.2,),
                              Text(schooladdress,style: GoogleFonts.poppins(fontSize: width/113.833333333,fontWeight: FontWeight.w600,color: Colors.white),),
                            ],
                          ),
                          SizedBox(width: width/45.53333333333333,),
                          InkWell(
                              onTap: (){
                                _showPopupMenu();
                              },

                              child: Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.white,size: 25,))

                        ],
                      )
                  )


                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top:15.0,left:8),
                child: Row(
                  children:[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.calendar_month),
                    ),
                    Text("${currentDate} ${cmonth} , ${cyear}",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: width/91.066666667),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(right: width/34.15, top: height/32.85),
                child: Material(
                  elevation: 7,
                  borderRadius: BorderRadius.circular(12),
                  shadowColor:  Color(0xff53B175).withOpacity(0.20),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top:height/131.4, left: width/50.592),
                              child: Container(
                                child: Image.asset("assets/students 1.png"),
                                width: width / 17.07,
                                height: height / 8.2,
                                //color: Color(0xffD1F3E0),
                                decoration: BoxDecoration(
                                    color: Color(0xffD1F3E0),
                                    borderRadius: BorderRadius.circular(52)),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(top:height/36.5, left:width/85.375,right:width/75.888,),
                              child: Image.asset("assets/Line.png"),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(
                                      top: height/32.85, right: width/136.6),
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        pages=StudentList(isfromDashboard: true);
                                      });
                                    },
                                    child: Text(
                                      "Students",
                                      style: GoogleFonts.poppins(
                                          color: Color(0xffA3A3A3), fontSize:width/105.076),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(right:width/75.88),
                                  child: Text(
                                    students.toString(),
                                    style: GoogleFonts.poppins(
                                        fontSize:width/85.375, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding:  EdgeInsets.only(top:height/36.5, right:width/75.888),
                              child: Image.asset("assets/Line 2.png"),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(top:height/131.4, right:width/75.888),
                              child: Container(
                                child: Image.asset("assets/staffs.png"),
                                width: width / 17.05,
                                height: height / 8.2,
                                //color: Color(0xffD1F3E0),
                                decoration: BoxDecoration(
                                    color: Color(0xffE1F1FF),
                                    borderRadius: BorderRadius.circular(52)),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(right:width/75.888, top:height/34.578),
                              child: Image.asset(
                                "assets/Line.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top:height/23.464),
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        pages= StaffList(isfromDashboard: true);
                                      });
                                    },
                                    child: Text(
                                      "Staffs",
                                      style: GoogleFonts.poppins(
                                          color: Color(0xffA3A3A3), fontSize:width/105.076),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(right:width/20.088),
                                  child: Text(
                                    staffs.toString(),
                                    style: GoogleFonts.poppins(
                                        fontSize:width/85.375, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(top:height/36.5, left: width/683, right: width/170.75),
                              child: Image.asset("assets/Line 2.png"),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(top:height/131.4, left:width/91.06),
                              child: Container(
                                child: Image.asset("assets/classes.png",scale: 1.50,),
                                width: width / 17.0,
                                height: height / 8,
                                //color: Color(0xffD1F3E0),
                                decoration: BoxDecoration(
                                    color: Color(0xffFFF2D8),
                                    borderRadius: BorderRadius.circular(52)),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(
                                  top: height/54.75, left: width/47.103, right: width/273.2),
                              child: Image.asset(
                                "assets/Line.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Row(
                              children: [

                                Padding(
                                  padding:  EdgeInsets.only(left: width/97.571),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.only(top:height/23.464),
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              pages= StudentList(isfromDashboard: true);
                                            });
                                          },
                                          child: Text(
                                            "Classes",
                                            style: GoogleFonts.poppins(
                                                color: Color(0xffA3A3A3), fontSize:width/105.076),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(
                                            bottom: height/82.125, right:width/75.888),
                                        child: Text(
                                          classes.toString(),
                                          style: GoogleFonts.poppins(
                                              fontSize:width/85.375,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding:  EdgeInsets.only(top: height/109.5, left: width/37.94),
                                  child: Container(
                                    child: Icon(Icons.perm_identity_outlined,size: 40,color: Colors.red,),
                                    width: width / 17,
                                    height: height / 8.2,
                                    //color: Color(0xffD1F3E0),
                                    decoration: BoxDecoration(
                                        color: Color(0xffFFEAEA),
                                        borderRadius: BorderRadius.circular(52)),
                                  ),
                                ),

                                Padding(
                                  padding:  EdgeInsets.only(
                                      right:width/75.888, top:height/34.578, left:width/75.888),
                                  child: Image.asset(
                                    "assets/Line.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                Padding(
                                  padding:  EdgeInsets.only(top:height/23.464),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "App Users",
                                        style: GoogleFonts.poppins(
                                            color: Color(0xffA3A3A3), fontSize:width/105.076),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(right: width/48.785),
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return BouncingDraggableDialog(
                                                        width: width/3.415,
                                                        height:height/0.7233333333333333,
                                                        content: content2(),
                                                      );
                                                    });
                                              },
                                              child: Text(
                                                "Staffs: ${staffcount}",
                                                style: GoogleFonts.poppins(
                                                    fontSize:width/85.375,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: (){
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return BouncingDraggableDialog(
                                                        width: width/3.415,
                                                        height:height/0.7233333333333333,
                                                        content: content(),
                                                      );
                                                    });
                                              },
                                              child: Text(
                                                "| Students: ${studentcount}",
                                                style: GoogleFonts.poppins(
                                                    fontSize:width/85.375,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    width:width/1.1,
                    height: height / 6.57,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border:Border.all(color: Color(0xff53B175).withOpacity(0.20))
                    ),
                  ),
                ),
              ),
              Padding(
                //padding:  EdgeInsets.only(right: width/34.15, top: height/32.85),
                padding:  EdgeInsets.only(right: 0, top: height/32.85),
                child: Material(
                  elevation: 7,
                  borderRadius: BorderRadius.circular(12),
                  shadowColor:  Color(0xff53B175).withOpacity(0.20),
                  child: Container(
                    width: width/1.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border:Border.all(color: Color(0xff53B175).withOpacity(0.20))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FutureBuilder(
                          future: getTodayStaffPresent(),
                          builder: (ctx,snap){
                            if(snap.hasData){
                              return Container(
                                width: width/2.548507462686567,
                                height: height / 2.55,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Today Staff Reports",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: width/75.888888889),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:15.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0.0,top:8,bottom: 8),
                                            child:  Column(
                                              children: [
                                                CircularPercentIndicator(
                                                  circularStrokeCap: CircularStrokeCap.round,
                                                  radius: 40.0,
                                                  lineWidth: 12.0,
                                                  percent: (snap.data!.presentPercentage*100)/100,
                                                  center:  Text("${(snap.data!.presentPercentage*100).toInt()}%",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500)),
                                                  progressColor: Colors.green,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 8,top: 12),
                                                  child:  ChoiceChip(

                                                    label: Text("  Present  ",style: TextStyle(color: Colors.white),),


                                                    onSelected: (bool selected) {

                                                      setState(() {

                                                      });
                                                    },
                                                    selectedColor: Color(0xff53B175),
                                                    shape: StadiumBorder(
                                                        side: BorderSide(
                                                            color: Color(0xff53B175))),
                                                    backgroundColor: Colors.white,
                                                    labelStyle: TextStyle(color: Colors.black),

                                                    elevation: 1.5, selected: true,),

                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0.0,top: 8,bottom: 8.0),
                                            child:  Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    CircularPercentIndicator(
                                                      circularStrokeCap: CircularStrokeCap.round,
                                                      radius: 40.0,
                                                      lineWidth: 12.0,
                                                      percent: (snap.data!.absentPercentage*100)/100,
                                                      center:  Text("${(snap.data!.absentPercentage * 100).toInt()}%",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500)),
                                                      progressColor: Colors.red,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 12),
                                                      child: ChoiceChip(

                                                        label: Text("  Absent  ",style: TextStyle(color: Colors.white),),


                                                        onSelected: (bool selected) {

                                                          setState(() {

                                                          });
                                                        },
                                                        selectedColor: Colors.red,
                                                        shape: StadiumBorder(
                                                            side: BorderSide(
                                                                color: Colors.red)),
                                                        backgroundColor: Colors.white,
                                                        labelStyle: TextStyle(color: Colors.black),

                                                        elevation: 1.5, selected: true,),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("Staffs on leave Today",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600,fontSize: width/97.571428571),
                                                ),
                                              ),
                                              Container(
                                                  height: height / 5.57,
                                                  width: width/5.253846153846154,
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: snap.data!.todayAbsentPersons.length,
                                                      itemBuilder: (context,i){
                                                        return Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                //radio button
                                                                Radio(
                                                                    value: 1,
                                                                    activeColor: Color(0xff263646),
                                                                    groupValue:selectedvalue,
                                                                    onChanged:(value){
                                                                      setState(() {
                                                                        value=selectedvalue;
                                                                        selectedvalue=1;
                                                                        selectedvalue2=0;
                                                                        selectedvalue3=0;
                                                                        selectedvalue4=0;
                                                                      });
                                                                    }),
                                                                //text1
                                                                Text(
                                                                  "${snap.data!.todayAbsentPersons[i].name} ",
                                                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: width/113.833333333),
                                                                ),
                                                                Text(
                                                                  "- ID ${snap.data!.todayAbsentPersons[i].id} ",
                                                                  style: GoogleFonts.poppins(
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: width/136.6,color: Colors.grey),
                                                                ),





                                                              ],
                                                            ),




                                                          ],);
                                                      })
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              );
                            }
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: width/2.553271028037383,
                                  height: height / 2.55,

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Today Staff Reports",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: width/75.888888889),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top:15.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 0.0,top:8,bottom: 8),
                                              child:  Column(
                                                children: [
                                                  CircularPercentIndicator(
                                                    circularStrokeCap: CircularStrokeCap.round,
                                                    radius: 40.0,
                                                    lineWidth: 12.0,
                                                    percent: 0.0,
                                                    center:  Text("0%",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500)),
                                                    progressColor: Colors.green,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8.0,right: 8,top: 12),
                                                    child:  ChoiceChip(

                                                      label: Text("  Present  ",style: TextStyle(color: Colors.white),),


                                                      onSelected: (bool selected) {

                                                        setState(() {

                                                        });
                                                      },
                                                      selectedColor: Color(0xff53B175),
                                                      shape: StadiumBorder(
                                                          side: BorderSide(
                                                              color: Color(0xff53B175))),
                                                      backgroundColor: Colors.white,
                                                      labelStyle: TextStyle(color: Colors.black),

                                                      elevation: 1.5, selected: true,),

                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 0.0,top: 8,bottom: 8.0),
                                              child:  Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      CircularPercentIndicator(
                                                        circularStrokeCap: CircularStrokeCap.round,
                                                        radius: 40.0,
                                                        lineWidth: 12.0,
                                                        percent: 0.0,
                                                        center:  Text("0%",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500)),
                                                        progressColor: Colors.red,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0,right: 8,top: 12),
                                                        child: ChoiceChip(

                                                          label: Text("  Absent  ",style: TextStyle(color: Colors.white),),


                                                          onSelected: (bool selected) {

                                                            setState(() {

                                                            });
                                                          },
                                                          selectedColor: Colors.red,
                                                          shape: StadiumBorder(
                                                              side: BorderSide(
                                                                  color: Colors.red)),
                                                          backgroundColor: Colors.white,
                                                          labelStyle: TextStyle(color: Colors.black),

                                                          elevation: 1.5, selected: true,),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("Staffs on leave Today",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w600,fontSize: width/97.571428571),
                                                  ),
                                                ),
                                                Container(
                                                    height: height / 5.57,
                                                    width: width/5.253846153846154,
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: 0,
                                                        itemBuilder: (context,i){
                                                          return Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  //radio button
                                                                  Radio(
                                                                      value: 1,
                                                                      activeColor: Color(0xff263646),
                                                                      groupValue:selectedvalue,
                                                                      onChanged:(value){
                                                                        setState(() {
                                                                          value=selectedvalue;
                                                                          selectedvalue=1;
                                                                          selectedvalue2=0;
                                                                          selectedvalue3=0;
                                                                          selectedvalue4=0;
                                                                        });
                                                                      }),
                                                                  //text1
                                                                  Text(
                                                                    "",
                                                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: width/113.833333333),
                                                                  ),
                                                                  Text(
                                                                    "- ID ",
                                                                    style: GoogleFonts.poppins(
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: width/136.6,color: Colors.grey),
                                                                  ),





                                                                ],
                                                              ),




                                                            ],);
                                                        })
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                CircularProgressIndicator()
                              ],
                            );
                          },
                        ),
                        Container(
                            height: height / 3.57,
                            child: VerticalDivider(width: 2,color:Colors.grey)),
                        Container(
                            width: width/2.553271028037383,
                            height: height / 2.55,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top:8.0,left:8),
                                  child: Text("Overall Staff Report",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: width/75.888888889),),
                                ),
                                Container(
                                    height: height / 2.97,
                                    child: StaffPieChart()),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                //padding:  EdgeInsets.only(right: width/34.15, top: height/32.85),
                padding:  EdgeInsets.only(right: 0, top: height/32.85),
                child: Material(
                  elevation: 7,
                  borderRadius: BorderRadius.circular(12),
                  shadowColor:  Color(0xff53B175).withOpacity(0.20),
                  child: Container(
                    width: width/1.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border:Border.all(color: Color(0xff53B175).withOpacity(0.20))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FutureBuilder<TodayPresentReport>(
                          future: getTodayStudentPresent(),
                          builder: (ctx, snap){
                            if(snap.hasData){
                              return Container(
                                width: width/2.553271028037383,
                                height: height / 2.87,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Today Student Reports",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: width/75.888888889),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:15.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0.0,top:8,bottom: 8),
                                            child:  Column(
                                              children: [
                                                CircularPercentIndicator(
                                                  circularStrokeCap: CircularStrokeCap.round,
                                                  radius: 40.0,
                                                  lineWidth: 12.0,
                                                  percent: (snap.data!.presentPercentage*100)/100,
                                                  center:  Text("${(snap.data!.presentPercentage*100).toInt()}%",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500)),
                                                  progressColor: Colors.green,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 8,top: 12),
                                                  child:  ChoiceChip(

                                                    label: Text("  Present  ",style: TextStyle(color: Colors.white),),


                                                    onSelected: (bool selected) {

                                                      setState(() {

                                                      });
                                                    },
                                                    selectedColor: Color(0xff53B175),
                                                    shape: StadiumBorder(
                                                        side: BorderSide(
                                                            color: Color(0xff53B175))),
                                                    backgroundColor: Colors.white,
                                                    labelStyle: TextStyle(color: Colors.black),

                                                    elevation: 1.5, selected: true,),

                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0.0,top: 8,bottom: 8.0),
                                            child:  Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    CircularPercentIndicator(
                                                      circularStrokeCap: CircularStrokeCap.round,
                                                      radius: 40.0,
                                                      lineWidth: 12.0,
                                                      percent: (snap.data!.absentPercentage*100)/100,
                                                      center:  Text("${(snap.data!.absentPercentage * 100).toInt()}%",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500)),
                                                      progressColor: Colors.red,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 12),
                                                      child: ChoiceChip(

                                                        label: Text("  Absent  ",style: TextStyle(color: Colors.white),),


                                                        onSelected: (bool selected) {

                                                          setState(() {

                                                          });
                                                        },
                                                        selectedColor: Colors.red,
                                                        shape: StadiumBorder(
                                                            side: BorderSide(
                                                                color: Colors.red)),
                                                        backgroundColor: Colors.white,
                                                        labelStyle: TextStyle(color: Colors.black),

                                                        elevation: 1.5, selected: true,),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("Students on leave Today",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600,fontSize: width/97.571428571),
                                                ),
                                              ),
                                              Container(
                                                  height: height / 5.57,
                                                  width: width/5.253846153846154,
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: snap.data!.todayAbsentPersons.length,
                                                      itemBuilder: (context,i){
                                                        return Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                //radio button
                                                                Radio(
                                                                    value: 1,
                                                                    activeColor: Color(0xff263646),
                                                                    groupValue:selectedvalue,
                                                                    onChanged:(value){
                                                                      setState(() {
                                                                        value=selectedvalue;
                                                                        selectedvalue=1;
                                                                        selectedvalue2=0;
                                                                        selectedvalue3=0;
                                                                        selectedvalue4=0;
                                                                      });
                                                                    }),
                                                                //text1
                                                                Text(
                                                                  "${snap.data!.todayAbsentPersons[i].name} ",
                                                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: width/113.833333333),
                                                                ),
                                                                Text(
                                                                  "- ID ${snap.data!.todayAbsentPersons[i].id} ",
                                                                  style: GoogleFonts.poppins(
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: width/136.6,color: Colors.grey),
                                                                ),





                                                              ],
                                                            ),




                                                          ],);
                                                      })
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              );
                            }
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Material(
                                  elevation: 7,
                                  borderRadius: BorderRadius.circular(12),
                                  shadowColor:  Color(0xff53B175).withOpacity(0.20),
                                  child: Container(
                                    width: width/2.539033457249071,
                                    height: height / 2.87,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border:Border.all(color: Color(0xff53B175).withOpacity(0.20))
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Today Student Reports",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: width/75.888888889),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:15.0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0.0,top:8,bottom: 8),
                                                child:  Column(
                                                  children: [
                                                    CircularPercentIndicator(
                                                      circularStrokeCap: CircularStrokeCap.round,
                                                      radius: 40.0,
                                                      lineWidth: 12.0,
                                                      percent: 0.0,
                                                      center:  Text("0%",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500)),
                                                      progressColor: Colors.green,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 12),
                                                      child:  ChoiceChip(

                                                        label: Text("  Present  ",style: TextStyle(color: Colors.white),),


                                                        onSelected: (bool selected) {

                                                          setState(() {

                                                          });
                                                        },
                                                        selectedColor: Color(0xff53B175),
                                                        shape: StadiumBorder(
                                                            side: BorderSide(
                                                                color: Color(0xff53B175))),
                                                        backgroundColor: Colors.white,
                                                        labelStyle: TextStyle(color: Colors.black),

                                                        elevation: 1.5, selected: true,),

                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0.0,top: 8,bottom: 8.0),
                                                child:  Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        CircularPercentIndicator(
                                                          circularStrokeCap: CircularStrokeCap.round,
                                                          radius: 40.0,
                                                          lineWidth: 12.0,
                                                          percent: 0.0,
                                                          center:  Text("0%",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500)),
                                                          progressColor: Colors.red,
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 8.0,right: 8,top: 12),
                                                          child: ChoiceChip(

                                                            label: Text("  Absent  ",style: TextStyle(color: Colors.white),),


                                                            onSelected: (bool selected) {

                                                              setState(() {

                                                              });
                                                            },
                                                            selectedColor: Colors.red,
                                                            shape: StadiumBorder(
                                                                side: BorderSide(
                                                                    color: Colors.red)),
                                                            backgroundColor: Colors.white,
                                                            labelStyle: TextStyle(color: Colors.black),

                                                            elevation: 1.5, selected: true,),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text("Students on leave Today",
                                                      style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.w600,fontSize: width/97.571428571),
                                                    ),
                                                  ),
                                                  Container(
                                                      height: height / 5.57,
                                                      width: width/5.253846153846154,
                                                      child: ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: 0,
                                                          itemBuilder: (context,i){
                                                            return Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    //radio button
                                                                    Radio(
                                                                        value: 1,
                                                                        activeColor: Color(0xff263646),
                                                                        groupValue:selectedvalue,
                                                                        onChanged:(value){
                                                                          setState(() {
                                                                            value=selectedvalue;
                                                                            selectedvalue=1;
                                                                            selectedvalue2=0;
                                                                            selectedvalue3=0;
                                                                            selectedvalue4=0;
                                                                          });
                                                                        }),
                                                                    //text1
                                                                    Text(
                                                                      "",
                                                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: width/113.833333333),
                                                                    ),
                                                                    Text(
                                                                      "- ID ",
                                                                      style: GoogleFonts.poppins(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: width/136.6,color: Colors.grey),
                                                                    ),





                                                                  ],
                                                                ),




                                                              ],);
                                                          })
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
                                CircularProgressIndicator()
                              ],
                            );
                          },
                        ),
                        Container(
                            height: height / 3.57,
                            child: VerticalDivider(width: 2,color:Colors.grey)),
                        Container(
                            width: width/2.553271028037383,
                            height: height / 2.55,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top:8.0,left:8),
                                  child: Text("Overall Student Report",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: width/75.888888889),),
                                ),
                                Container(
                                    height: height / 2.97,
                                    child: StudentPieChart(),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:8.0,right: 12),
                    child: Material(
                      elevation: 7,
                      borderRadius: BorderRadius.circular(12),
                      shadowColor:  Color(0xff53B175).withOpacity(0.20),
                      child: Container(
                        width: width/2.553271028037383,
                        height:height/1.55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:Border.all(color: Color(0xff53B175).withOpacity(0.20))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:20.0,left: 15),
                              child: Text("Fees Reports",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: width/75.888888889),),
                            ),
                            SizedBox(height:height/65.1),
                            Container(
                                width: width/2.483636363636364,
                                height:height/1.86,
                                child: BarChartSample2(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0,right: 12),
                    child: Material(
                      elevation: 7,
                      borderRadius: BorderRadius.circular(12),
                      shadowColor:  Color(0xff53B175).withOpacity(0.20),
                      child: Container(
                          width: width/2.553271028037383,
                          height:height/1.55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:Border.all(color: Color(0xff53B175).withOpacity(0.20))
                          ),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:20.0,left: 15),
                                child: Text("Events Calendar",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: width/75.888888889),),
                              ),
                              Container(
                                width: width/2.732,
                                height:height/1.759459459459459,
                                child: SfCalendar(
                                  onLongPress: (val){

                                    setState(() {
                                      datecon.text = "${val.date!.day} / ${val.date!.month} / ${val.date!.year}";
                                    });
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return BouncingDraggableDialog(
                                            width: width/3.415,
                                            height:height/2.604,
                                            content: eventspop(val.date),
                                          );
                                        });                            },
                                  view: CalendarView.month,
                                  allowDragAndDrop: true,
                                  dataSource: MeetingDataSource(_getDataSource()),
                                  monthViewSettings: MonthViewSettings(showAgenda: true),

                                ),
                              )

                            ],
                          )
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height:height/16.275),
            ],
          ),
        )) : pages;
  }
  List Eventsname =[];
  List Eventdate =[];
  final List<Meeting> meetingsmain = <Meeting>[];
  getevents() async {
    setState(() {
      meetingsmain.clear();
    });
    var document = await FirebaseFirestore.instance.collection("Events").get();
    for(int i=0;i<document.docs.length;i++) {
    setState(() {
      meetingsmain.add(
          Meeting(
              document.docs[i]["name"], DateFormat("dd / MM / yyyy").parse(document.docs[i]["ondate"]),DateFormat("dd / MM / yyyy").parse(document.docs[i]["ondate"]), const Color(0xFF0F8644), true));
    });
    }
    }

  List<Meeting> _getDataSource()  {
    List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime startTime2 = today.add(const Duration(days: 5));
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    final DateTime endTime2 = today.add( Duration(days: 5,));

    setState(() {
      meetings= meetingsmain;
    });


    return meetings;
  }
  Future<TodayPresentReport> getTodayStudentPresent() async {
    var studentDocument = await FirebaseFirestore.instance.collection('Students').limit(10).get();
    List<NameWithId> presentPeoples = [];
    List<NameWithId> absentPeoples = [];
    presentPeoples.clear();
    absentPeoples.clear();
    studentDocument.docs.forEach((student) async {
      try{
        var document1 = await FirebaseFirestore.instance.collection("Students").doc(student.id).collection('Attendance').doc(DateFormat('d-M-yyyy').format(DateTime.now())).get();// .collection(DateFormat('dd-M-yyyy').format(DateTime.now())).get();
        if(document1.exists && document1.get("Attendance").toString().toLowerCase() == "present"){
          presentPeoples.add(
              NameWithId(name: student.get("stname") + student.get("stlastname"), id: student.get('regno'))
          );
        }
        if(!document1.exists || document1.get("Attendance").toString().toLowerCase() == "absent"){
          absentPeoples.add(
              NameWithId(name: student.get("stname") + student.get("stlastname"), id: student.get('regno'))
          );
        }
      }catch(e){
      }
    });
    await Future.delayed(const Duration(seconds: 10));
    TodayPresentReport report = TodayPresentReport(
      absentPercentage: absentPeoples.length/(presentPeoples.length+absentPeoples.length).toDouble(), //0.7
      presentPercentage: presentPeoples.length/(presentPeoples.length+absentPeoples.length).toDouble(),  //0.3
      todayAbsentPersons: absentPeoples
    );
    return report;
  }

  Future<TodayPresentReport> getTodayStaffPresent() async {
    var studentDocument = await FirebaseFirestore.instance.collection('Staffs').limit(10).get();
    List<NameWithId> presentPeoples = [];
    List<NameWithId> absentPeoples = [];
    presentPeoples.clear();
    absentPeoples.clear();
    studentDocument.docs.forEach((staff) async {
      try{
        var document1 = await FirebaseFirestore.instance.collection("Staffs").doc(staff.id).collection('Attendance').doc(DateFormat('d-M-yyyy').format(DateTime.now())).get();// .collection(DateFormat('dd-M-yyyy').format(DateTime.now())).get();
        if(document1.exists && document1.get("Attendance").toString().toLowerCase() == "present"){
          presentPeoples.add(
              NameWithId(name: staff.get("stname") + staff.get("stlastname"), id: staff.get('regno'))
          );
        }
        if(!document1.exists || document1.get("Attendance").toString().toLowerCase() == "absent"){
          absentPeoples.add(
              NameWithId(name: staff.get("stname") + staff.get("stlastname"), id: staff.get('regno'))
          );
        }
      }catch(e){
      }
    });
    await Future.delayed(const Duration(seconds: 10));
    TodayPresentReport report = TodayPresentReport(
        absentPercentage: absentPeoples.length/(presentPeoples.length+absentPeoples.length).toDouble(), //0.7
        presentPercentage: presentPeoples.length/(presentPeoples.length+absentPeoples.length).toDouble(),  //0.3
        todayAbsentPersons: absentPeoples
    );
    return report;
  }

TextEditingController eventtitle = new TextEditingController();
TextEditingController datecon = new TextEditingController();
  Widget eventspop(date) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<String> brother = ["Select Option","Remainder","Holiday"];
    String _typeAheadControllertype = "Select Option";
    return StatefulBuilder(
      builder: (context, set) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add an event',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: width/68.3,
                ),
              ),
              SizedBox(
                height: height/81.375,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:10.0),
                    child: Container(
                        width: width/10.106,
                        height: height/16.42,

                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("Event Type  :",style: GoogleFonts.poppins(fontSize: 15,)),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Container(

                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint:  Row(
                            children: [
                              Icon(
                                Icons.list,
                                size: 16,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: width/341.5,
                              ),
                              Expanded(
                                child: Text(
                                  'Select Option',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: brother
                              .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style:  GoogleFonts.poppins(
                                  fontSize: 15
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                              .toList(),
                          value:  _typeAheadControllertype,
                          onChanged: (String? value) {
                            set(() {
                              _typeAheadControllertype = value!;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height:height/13.02,
                            width: width/8.5375,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),

                              color: Color(0xffDDDEEE),
                            ),

                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                            ),
                            iconSize: 14,
                            iconEnabledColor: Colors.black,
                            iconDisabledColor: Colors.grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight:height/3.255,
                            width: width/5.464,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Color(0xffDDDEEE),
                            ),

                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(7),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility: MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: MenuItemStyleData(
                            height:height/16.275,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                      width: width/7.464,
                      height: height/16.425,
                      //color: Color(0xffDDDEEE),
                      decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                    ),
                  ),
                ],
              ),
              SizedBox(
                height:height/65.1,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:10.0),
                    child: Container(
                        width: width/10.106,
                        height: height/16.42,

                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("Event Name  :",style: GoogleFonts.poppins(fontSize: 15,)),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Container(child: TextFormField(
                      controller: eventtitle,
                      style: GoogleFonts.poppins(
                          fontSize: 15
                      ),

                      validator: (value) {

                        if(value!.isNotEmpty) {
                          if (value.characters.length !=
                              12) {
                            return 'Enter the aadhaar number correctly';
                          }
                          else{
                            return null;
                          }
                        }
                        else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                        border: InputBorder.none,



                      ),
                    ),
                      width: width/7.464,
                      height: height/16.425,
                      //color: Color(0xffDDDEEE),
                      decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                    ),
                  ),
                ],
              ),
              SizedBox(
                height:height/65.1,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:10.0),
                    child: Container(
                        width: width/10.106,
                        height: height/16.42,

                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("Date  :",style: GoogleFonts.poppins(fontSize: 15,)),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Container(child: TextFormField(
                      readOnly:  true,
                      controller: datecon,
                      style: GoogleFonts.poppins(
                          fontSize: 15
                      ),

                      validator: (value) {

                        if(value!.isNotEmpty) {
                          if (value.characters.length !=
                              12) {
                            return 'Enter the aadhaar number correctly';
                          }
                          else{
                            return null;
                          }
                        }
                        else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                        border: InputBorder.none,



                      ),
                    ),
                      width: width/7.464,
                      height: height/16.425,
                      //color: Color(0xffDDDEEE),
                      decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                    ),
                  ),
                ],
              ),
              SizedBox(
                height:height/65.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, top: 8.0, bottom: 8.0,right: 153),
                    child: Container(

                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return BouncingDraggableDialog(
                                  width: width/3.415,
                                  height:height/1.085,
                                  content: eventspop2(datecon.text),
                                );
                              });
                        },
                        child: Text(
                          'View Events',
                          style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                            fontSize: width/97.571428571,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Close',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: width/97.571428571,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          FirebaseFirestore.instance.collection("Events").doc().set({
                            "name":eventtitle.text,
                            "ondate" : datecon.text,
                            "type" : _typeAheadControllertype,
                            "date":date,
                          });
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                          Navigator.pop(context);
                          getevents();
                        },
                        child: Text(
                          'Add Event',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: width/97.571428571,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
    );
  }
  Widget eventspop2(date) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Events on $date',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: width/68.3,
            ),
          ),
          SizedBox(
            height: height/81.375,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              color: Colors.black,
            ),
          ),

          Container(
            width: width/3.415,
            height: height/1.6275,
            child: StreamBuilder<QuerySnapshot>(
              stream:  FirebaseFirestore.instance.collection("Events").where("ondate",isEqualTo: date).snapshots(),
                builder: (context,snap){
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snap.data!.docs.length,
                  itemBuilder: (context,index){

                      return ListTile(
                        title: Text(snap.data!.docs[index]["name"]),
                        subtitle: Text(snap.data!.docs[index]["ondate"]),
                        trailing: Icon(Icons.delete_forever_rounded),
                        onTap: (){
                          FirebaseFirestore.instance.collection("Events").doc(snap.data!.docs[index].id).delete();
                        },
                      );

              });
            }),
          ),


          SizedBox(
            height:height/65.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Padding(
                padding: const EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      getevents();
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: width/97.571428571,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
        padding:  EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xff00A0E3), width: 3),
          boxShadow:  [
            BoxShadow(
              color: Color(0x19000000),
              spreadRadius: 2.0,
              blurRadius: 8.0,
              offset: Offset(2, 4),
            )
          ],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(Icons.done_all, color:Color(0xff00A0E3)),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('Event Added Sucessfully',
                  style: TextStyle(color: Colors.black)),
            ),
            Spacer(),
            TextButton(
                onPressed: () => debugPrint("Undid"),
                child:  Text("Undo"))
          ],
        )),
  );
  int customtotal=0;
}


class TodayPresentReport{
  TodayPresentReport({required this.absentPercentage, required this.presentPercentage, required this.todayAbsentPersons});

  double presentPercentage;
  double absentPercentage;
  List<NameWithId> todayAbsentPersons;
}

class NameWithId{
  NameWithId({required this.name, required this.id});

  String name;
  String id;
}