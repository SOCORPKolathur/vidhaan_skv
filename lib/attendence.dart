import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as sfc;
import 'package:vidhaan/models/attendance_pdf_model.dart';
import 'package:vidhaan/photoview.dart';
import 'package:vidhaan/print/attendance_print.dart';
import 'package:pdf/pdf.dart';


class SalesData {
  SalesData(this.year, this.sales,this.absentDay, this.presentDay);

  final String year;
  late double sales;
  final String absentDay;
  final String presentDay;
}

class Attendence extends StatefulWidget {
  const Attendence({Key? key}) : super(key: key);

  @override
  State<Attendence> createState() => _AttendenceState();
}

class _AttendenceState extends State<Attendence> {


  List<AttendancePdfModel> studentAttendanceListForPdf = [];
  String? _selectedCity;
  final TextEditingController _typeAheadControllerclass = TextEditingController();
  final TextEditingController _typeAheadControllersection = TextEditingController();
  final TextEditingController _typeAheadControllerstaffid = TextEditingController();
   TextEditingController date = new TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  static final List<String> classes = ["Select Option"];
  static final List<String> section = ["Select Option"];
  static final List<String> staffid = [];

  static List<String> getSuggestionsclass(String query) {
    List<String> matches = <String>[];
    matches.addAll(classes);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionssection(String query) {
    List<String> matches = <String>[];
    matches.addAll(section);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionsstaffid(String query) {
    List<String> matches = <String>[];
    matches.addAll(staffid);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  late sfc.TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    setState(() {
      _typeAheadControllerclass.text="Select Option";
      _typeAheadControllersection.text="Select Option";
    });
    _tooltipBehavior = sfc.TooltipBehavior(enable: true);
    adddropdownvalue();

    // TODO: implement initState
    super.initState();
  }
  adddropdownvalue() async {
    var sudentsdocument = await  FirebaseFirestore.instance.collection("Students").get();
    setState(() {
      schooltotal=sudentsdocument.docs.length;
      classes.clear();
      section..clear();
    });
    var document = await  FirebaseFirestore.instance.collection("ClassMaster").orderBy("order").get();
    var document2 = await  FirebaseFirestore.instance.collection("SectionMaster").orderBy("order").get();
    var document3 = await  FirebaseFirestore.instance.collection("Staffs").orderBy("entryno").get();
    setState(() {
      classes.add("Select Option");
      section.add("Select Option");
    });
    for(int i=0;i<document.docs.length;i++) {
      setState(() {
        classes.add(document.docs[i]["name"]);
      });

    }
    for(int i=0;i<document2.docs.length;i++) {
      setState(() {
        section.add(document2.docs[i]["name"]);
      });

    }
    for(int i=0;i<document3.docs.length;i++) {
      setState(() {
        staffid.add(document3.docs[i]["regno"]);
      });

    }
  }

  String staffdocid="";
  String staffname="";
  getstaffbyid() async {
    print("fdgggggggggg");
    print(_typeAheadControllerstaffid.text);
    var document = await FirebaseFirestore.instance.collection("Staffs").get();
    for(int i=0;i<document.docs.length;i++){
      if(_typeAheadControllerstaffid.text==document.docs[i]["regno"]){
        setState(() {
          staffdocid= document.docs[i].id;
        }
        );
      }
    }
    print("fdgggggggggg");
    print(staffdocid);
    var staffdocument = await FirebaseFirestore.instance.collection("Staffs").doc(staffdocid).get();
    Map<String, dynamic>? value = staffdocument.data();
    setState(() {
      staffname=value!["stname"];
    });
    print("fdgggggggggg");
    print(staffname);

  }
  String selecteddate="";

  Successdialog(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555555555556,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'In-charge Staff Added Successfully',
      desc: 'For class - ${_typeAheadControllerclass.text} ${_typeAheadControllersection.text} is been added',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {


      },
    )..show();
  }
  final DateFormat formatter = DateFormat('d-M-yyy');


  int total=0;
  int present=0;
  int absent=0;
  int schooltotal=0;

  gettotal() async {
 var document=await  FirebaseFirestore.instance.collection("Attendance").doc("${_typeAheadControllerclass.text}""${_typeAheadControllersection.text}").collection(selecteddate).get();
 var document2=await  FirebaseFirestore.instance.collection("Attendance").doc("${_typeAheadControllerclass.text}""${_typeAheadControllersection.text}").collection(selecteddate).where("present",isEqualTo: true).get();
 var document3=await  FirebaseFirestore.instance.collection("Attendance").doc("${_typeAheadControllerclass.text}""${_typeAheadControllersection.text}").collection(selecteddate).where("present",isEqualTo: false).get();
setState(() {
  total= document.docs.length;
  present= document2.docs.length;
  absent= document3.docs.length;

});
  }


  bool view= false;
  bool absentonly= false;



  int viewTab = 0;
  String studentid = '';

  int totalWorkDay = 0;

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return viewTab == 1 ? SingleChildScrollView(
      child: ShowUpAnimation(
        curve: Curves.fastOutSlowIn,
        direction: Direction.horizontal,
        delayStart: Duration(milliseconds: 200),
        child:
        FutureBuilder<dynamic>(
          future: FirebaseFirestore.instance.collection('Students').doc(studentid).get(),
          builder: (context, snapshot) {
            if(snapshot.hasData==null)
            {
              return Container(
                  width: width/17.075,
                  height: height/8.212,
                  child: Center(child:CircularProgressIndicator(),));
            }
            Map<String,dynamic>?value = snapshot.data!.data();
            return
              Padding(
                padding:EdgeInsets.only(left: width/93.3,top:0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Material(
                          elevation: 15,
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            decoration: BoxDecoration(
                                color:Colors.white,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            width: width/4.44,
                            height: height/1.050,
                            child: Column(
                              children: [
                                SizedBox(height:height/30,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context)=>Photoviewpage(value['imgurl']))
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: width/26.6666,
                                    backgroundImage:  NetworkImage(value!['imgurl']==""?"https://firebasestorage.googleapis.com/v0/b/vidhaan-4aee7.appspot.com/o/360_F_270188580_YDUEwBmDIxBMvCQxkcunmEkm93VqOgqm.jpg?alt=media&token=fe18ba43-4a31-4b53-9523-42bb4241d9a1"
                                        :value['imgurl']),

                                  ),
                                ),

                                SizedBox(height:height/52.15,),
                                Center(
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('${value!['stname']} ${value['stlastname']}',style: GoogleFonts.montserrat(
                                          fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                      ),),
                                    ],
                                  ),
                                ),
                                SizedBox(height:height/130.3,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Application No :',style: GoogleFonts.montserrat(
                                        fontWeight:FontWeight.w500,color: Colors.black,fontSize: width/124.4
                                    ),),
                                    Text(value['regno'],style: GoogleFonts.montserrat(
                                        fontWeight:FontWeight.w500,color: Colors.black,fontSize: width/124.4
                                    ),),
                                  ],
                                ),
                                SizedBox(height:height/52.15),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text('Current Class',style: GoogleFonts.montserrat(
                                        fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                    ),),
                                  ],
                                ),
                                SizedBox(height: height/65.7,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Material(
                                      elevation: 7,
                                      borderRadius: BorderRadius.circular(12),
                                      shadowColor:  Color(0xff53B175),
                                      child: Container(
                                        height: height/8.212,
                                        width: width/7.588,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            border:Border.all(color: Color(0xff53B175))
                                        ),
                                        child:  Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Class / Section",style:GoogleFonts.montserrat(
                                                fontWeight:FontWeight.w600,color: Colors.black,fontSize:width/98.13
                                            ),),
                                            SizedBox(height: height/65.7,),
                                            ChoiceChip(

                                              label: Text("    ${value["admitclass"]} / ${value["section"]}    ",style: TextStyle(color: Colors.white),),


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
                                          ],
                                        ),

                                      ),


                                    ),
                                  ],
                                ),
                                Divider(),
                                SizedBox(height:height/32.85,),
                                Row(children: [
                                  SizedBox(width:width/62.2),
                                  Icon(Icons.email_outlined,),
                                  SizedBox(width:width/373.2),
                                  GestureDetector(onTap: (){

                                  },
                                    child: Text('${value["email"]}',style: GoogleFonts.montserrat(
                                        fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/124.4
                                    ),),
                                  ),
                                ],),
                                SizedBox(height:height/34.76,),
                                Row(children: [
                                  SizedBox(width:width/62.2),
                                  Icon(Icons.call,),
                                  SizedBox(width:width/373.2),
                                  GestureDetector(onTap: (){

                                  },
                                    child: Text('${value["mobile"]}',style: GoogleFonts.montserrat(
                                        fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/124.4
                                    ),),
                                  ),
                                ],),
                                SizedBox(height:height/34.76,),
                                Row(children: [
                                  SizedBox(width:width/62.2),
                                  Icon(Icons.calendar_month_sharp,),
                                  SizedBox(width:width/373.2),
                                  GestureDetector(onTap: (){

                                  },
                                    child: Text(value["dob"]!="Null"?value["dob"].toString().length>15?'${value["dob"].toString().substring(0,10)}':'${value["dob"].toString().replaceAll(" ", "")}':"Null",style: GoogleFonts.montserrat(
                                        fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/124.4
                                    ),),
                                  ),
                                ],),
                                SizedBox(height:height/34.76,),
                                Row(children: [
                                  SizedBox(width:width/62.2),
                                  value["gender"]=="Male"? Icon(Icons.male_rounded,) :Icon(Icons.female_rounded,),
                                  SizedBox(width:width/373.2),
                                  GestureDetector(onTap: (){

                                  },
                                    child: Text('${value["gender"]}',style: GoogleFonts.montserrat(
                                        fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/124.4
                                    ),),
                                  ),
                                ],),


                                SizedBox(height:height/34.76,),
                                Row(children: [
                                  SizedBox(width:width/62.2),
                                  Icon(Icons.bloodtype_rounded,) ,
                                  SizedBox(width:width/373.2),
                                  GestureDetector(onTap: (){

                                  },
                                    child: Text('${value["bloodgroup"]}',style: GoogleFonts.montserrat(
                                        fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/124.4
                                    ),),
                                  ),
                                ],),
                                SizedBox(height:height/34.76,),
                                GestureDetector(
                                  onTap: (){

                                  },
                                  child: Container(width: width/5.464,
                                    height: height/16.425,
                                    // color:Color(0xff00A0E3),
                                    decoration: BoxDecoration(color: Color(0xffFFA002),borderRadius: BorderRadius.circular(5)),child: Center(child: Text("View Fees Reports",style: GoogleFonts.poppins(color:Colors.white,fontWeight: FontWeight.w600),)),

                                  ),
                                ),




                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width:width/62.2,),
                    Column(
                      children: [
                        Material(
                          elevation: 15,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight:Radius.circular(15)  ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight:Radius.circular(15)  ),
                              color: Colors.white,
                            ),
                            width:width/1.8600,
                            height:height/19,
                            child: Padding(
                              padding: EdgeInsets.only(left:width/62.2,right:width/62.2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Student  Details',style: GoogleFonts.montserrat(
                                    fontSize:width/81.13,fontWeight: FontWeight.bold,
                                  ),),
                                  InkWell(
                                      onTap: (){
                                        setState(() {
                                          viewTab = 0;
                                        });
                                      },
                                      child: Icon(Icons.cancel,color: Colors.red,))
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height:height/58,),
                        Material(
                          elevation: 15,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15)  ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15)  ),
                                color:Colors.white
                            ),
                            width:width/1.86,
                            height: height/1.140,
                            child: Padding(
                              padding: EdgeInsets.only(left:width/62.2,right:width/62.2),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: width/1.7075,
                                        child: FutureBuilder<StudentAttendanceReportModel>(
                                          future: getMonthlyAttendanceReportForStudent(studentid),
                                          builder: (ctx,snapshot){
                                            if(snapshot.hasData){
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(15.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          'Total Working Days : ${((getStudentAttendancePersantage(snapshot.data!).present * getStudentAttendancePersantage(snapshot.data!).total)) + (getStudentAttendancePersantage(snapshot.data!).absent * getStudentAttendancePersantage(snapshot.data!).total)}',
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.black,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height:height/2.604,
                                                    width: width/1.751282051282051,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          height:height/2.604,
                                                          width: width/2.845833333333333,
                                                          child: sfc.SfCartesianChart(

                                                              primaryXAxis: sfc.CategoryAxis(),

                                                              title: sfc.ChartTitle(
                                                                  text: '   OverAll Present Reports',
                                                                  textStyle: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w600,
                                                                    color: Colors.black,
                                                                  ),
                                                                  alignment: sfc.ChartAlignment.near
                                                              ),
                                                              legend: sfc.Legend(isVisible: true),
                                                              tooltipBehavior: sfc.TooltipBehavior(enable: true),
                                                              series: <sfc.LineSeries<SalesData, String>>[
                                                                sfc.LineSeries<SalesData, String>(
                                                                  name: "",
                                                                  dataSource: snapshot.data!.presentReport,
                                                                  xValueMapper: (SalesData sales, _) => sales.year,
                                                                  yValueMapper: (SalesData sales, _) => sales.sales,
                                                                  // Enable data label
                                                                  dataLabelSettings: sfc.DataLabelSettings(isVisible: true),
                                                                  color: Colors.green,
                                                                  width: 5,
                                                                  animationDuration: 2000,
                                                                )
                                                              ]
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisAlignment : MainAxisAlignment.center,
                                                          children: [
                                                            CircularPercentIndicator(
                                                              circularStrokeCap: CircularStrokeCap.round,
                                                              radius: 45.0,
                                                              lineWidth: 10.0,
                                                              percent: getStudentAttendancePersantage(snapshot.data!).present,
                                                              center:  Text("${((getStudentAttendancePersantage(snapshot.data!).present)*100).toInt()}%",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500)),
                                                              progressColor: Colors.green,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all( 8.0),
                                                              child:  ChoiceChip(
                                                                label: Text(
                                                                  "${(getStudentAttendancePersantage(snapshot.data!).present * getStudentAttendancePersantage(snapshot.data!).total)} Present  ",style: TextStyle(color: Colors.white),),
                                                                onSelected: (bool selected) {
                                                                  setState(() {

                                                                  });
                                                                },
                                                                selectedColor: Colors.green,
                                                                shape: StadiumBorder(
                                                                    side: BorderSide(
                                                                        color: Color(0xff53B175))),
                                                                backgroundColor: Colors.white,
                                                                labelStyle: TextStyle(color: Colors.black),

                                                                elevation: 1.5, selected: true,),

                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height:height/2.604,
                                                    width: width/1.751282051282051,
                                                    child: Row(
                                                      mainAxisAlignment : MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          height:height/2.604,
                                                          width: width/2.845833333333333,
                                                          child: sfc.SfCartesianChart(
                                                              primaryXAxis: sfc.CategoryAxis(),
                                                              title: sfc.ChartTitle(
                                                                  text: '   OverAll Absent Reports',
                                                                  textStyle: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w600,
                                                                    color: Colors.black,
                                                                  ),
                                                                  alignment: sfc.ChartAlignment.near
                                                              ),
                                                              legend: sfc.Legend(isVisible: true),
                                                              tooltipBehavior: sfc.TooltipBehavior(enable: true),
                                                              series: <sfc.LineSeries<SalesData, String>>[
                                                                sfc.LineSeries<SalesData, String>(
                                                                  name: '',
                                                                  dataSource: snapshot.data!.absentReport,
                                                                  xValueMapper: (SalesData sales, _) => sales.year,
                                                                  yValueMapper: (SalesData sales, _) => sales.sales,
                                                                  // Enable data label
                                                                  dataLabelSettings: sfc.DataLabelSettings(isVisible: true),
                                                                  color: Colors.red,
                                                                  width: 5,
                                                                  animationDuration: 2000,
                                                                )
                                                              ]
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisAlignment : MainAxisAlignment.center,
                                                          children: [
                                                            CircularPercentIndicator(
                                                              circularStrokeCap: CircularStrokeCap.round,
                                                              radius: 45.0,
                                                              lineWidth: 10.0,
                                                              percent: getStudentAttendancePersantage(snapshot.data!).absent,
                                                              center:  Text("${((getStudentAttendancePersantage(snapshot.data!).absent * 100).toInt())}%",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500)),
                                                              progressColor: Colors.red,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all( 8.0),
                                                              child:  ChoiceChip(
                                                                label: Text("${(getStudentAttendancePersantage(snapshot.data!).absent * getStudentAttendancePersantage(snapshot.data!).total)} Absent  ",style: TextStyle(color: Colors.white),),
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
                                                  SizedBox(height:height/32.55),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Absent Days",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(height:height/32.55),
                                                      Container(
                                                        height:height/2.17,
                                                        child: ListView.builder(
                                                          itemCount: snapshot.data!.absentDays.length,
                                                          itemBuilder: (ctx, i){
                                                            return Card(
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: width/27.32,
                                                                      child: Text(
                                                                        'Date : ',
                                                                        style: TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                        "${snapshot.data!.absentDays[i]} / ${DateFormat('EEEE').format(DateFormat('dd-M-yyyy').parse(snapshot.data!.absentDays[i]))}",
                                                                      style: const TextStyle(
                                                                        fontWeight: FontWeight.normal,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              );
                                            }return sfc.SfCartesianChart(
                                                primaryXAxis: sfc.CategoryAxis(),
                                                title: sfc.ChartTitle(
                                                    text: '   Monthly Student Reports',
                                                    textStyle: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                    alignment: sfc.ChartAlignment.near
                                                ),
                                                legend: sfc.Legend(isVisible: true),
                                                tooltipBehavior: sfc.TooltipBehavior(enable: true),
                                                series: <sfc.LineSeries<SalesData, String>>[
                                                  sfc.LineSeries<SalesData, String>(
                                                    name: "Students \nAttendance",
                                                    dataSource: [],
                                                    xValueMapper: (SalesData sales, _) => sales.year,
                                                    yValueMapper: (SalesData sales, _) => sales.sales,
                                                    // Enable data label
                                                    dataLabelSettings: sfc.DataLabelSettings(isVisible: true),
                                                    color: Colors.green,
                                                    width: 5,
                                                    animationDuration: 2000,
                                                  )
                                                ]
                                            );
                                          },
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],)

                  ],),
              );
          },
        ),
      ),
    ) : SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Container(child: Padding(
              padding: const EdgeInsets.only(left: 38.0,top: 30),
              child: Text("Students Attendance Register",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),),
            ),
              //color: Colors.white,
              width: width/1.050,
              height: height/8.212,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
            ),
          ),

          FutureBuilder(
            future: getMonthlyAttendanceReportForClass(),
            builder: (ctx, snapshot){
              if(snapshot.hasData){
                return Row(
                  children: [
                    SizedBox(width: width/68.3,),
                    Container(
                        width: width/3.035555555555556,
                        child: Container(
                          height:height/2.604,
                          width: width/1.607058823529412,
                          child: sfc.SfCartesianChart(
                              primaryXAxis: sfc.CategoryAxis(),
                              title: sfc.ChartTitle(
                                  text: '   Monthly Student Reports',
                                  textStyle: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                  alignment: sfc.ChartAlignment.near
                              ),
                              legend: sfc.Legend(isVisible: true),
                              tooltipBehavior: _tooltipBehavior,
                              series: <sfc.LineSeries<SalesData, String>>[
                                sfc.LineSeries<SalesData, String>(
                                  name: "",
                                  dataSource: snapshot.data!.presentReport,
                                  xValueMapper: (SalesData sales, _) => sales.year,
                                  yValueMapper: (SalesData sales, _) => sales.sales,
                                  // Enable data label
                                  dataLabelSettings: sfc.DataLabelSettings(isVisible: true),
                                  color: Colors.green,
                                  width: 5,
                                  animationDuration: 2000,
                                )
                              ]
                          ),
                        )
                    ),
                    Column(
                      children: [
                        SizedBox(height: height/32.85,),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  Column(
                                children: [
                                  CircularPercentIndicator(
                                    circularStrokeCap: CircularStrokeCap.round,
                                    radius: 50.0,
                                    lineWidth: 10.0,
                                    percent:  getClassRegularPercentage(snapshot.data!).regular/100,
                                    center:  Text("${getClassRegularPercentage(snapshot.data!).regular.toInt()} %",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500)),
                                    progressColor: Colors.green,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all( 8.0),
                                    child:  ChoiceChip(

                                      label: Text("  Regular  ",style: TextStyle(color: Colors.white),),


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
                              padding: const EdgeInsets.all(8.0),
                              child:  Column(
                                children: [
                                  CircularPercentIndicator(
                                    circularStrokeCap: CircularStrokeCap.round,
                                    radius: 50.0,
                                    lineWidth: 10.0,
                                    percent: getClassRegularPercentage(snapshot.data!).irregular/100,
                                    center:  Text("${getClassRegularPercentage(snapshot.data!).irregular.toInt()} %",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500)),
                                    progressColor: Colors.red,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all( 8.0),
                                    child: ChoiceChip(

                                      label: const Text("  Ir-regular  ",style: TextStyle(color: Colors.white),),


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
                            ),
                          ],
                        ),
                        SizedBox(height: height/32.85),

                      ],
                    ),
                    SizedBox(width: width/68.3,),
                    Material(
                      elevation: 7,
                      borderRadius: BorderRadius.circular(12),
                      shadowColor:  Color(0xff53B175),
                      child: Container(
                        height: height/7.3,
                        width: width/5.464,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:Border.all(color: Color(0xff53B175))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Total No.of Students",style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: width/68.3,
                            ),),
                            ChoiceChip(

                              label: Text("${schooltotal.toString()} Students",style: TextStyle(color: Colors.white),),


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
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }return Row(
                children: [
                  SizedBox(width: width/68.3,),
                  Container(
                      width: width/3.035555555555556,
                      child: Container(
                        height:height/2.604,
                        width: width/1.607058823529412,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            sfc.SfCartesianChart(
                                primaryXAxis: sfc.CategoryAxis(),
                                title: sfc.ChartTitle(
                                    text: '   Monthly Student Reports',
                                    textStyle: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                    alignment: sfc.ChartAlignment.near
                                ),
                                legend: sfc.Legend(isVisible: true),
                                tooltipBehavior: _tooltipBehavior,
                                series: <sfc.LineSeries<SalesData, String>>[
                                  sfc.LineSeries<SalesData, String>(
                                    name: "",
                                    dataSource: [],
                                    xValueMapper: (SalesData sales, _) => sales.year,
                                    yValueMapper: (SalesData sales, _) => sales.sales,
                                    // Enable data label
                                    dataLabelSettings: sfc.DataLabelSettings(isVisible: true),
                                    color: Colors.green,
                                    width: 5,
                                    animationDuration: 2000,
                                  )
                                ]
                            ),
                            CircularProgressIndicator()
                          ],
                        ),
                      )
                  ),
                  Column(
                    children: [
                      SizedBox(height: height/32.85,),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:  Column(
                              children: [
                                CircularPercentIndicator(
                                  circularStrokeCap: CircularStrokeCap.round,
                                  radius: 50.0,
                                  lineWidth: 10.0,
                                  percent:  0.00,
                                  center:  Text("0%",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500)),
                                  progressColor: Colors.green,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all( 8.0),
                                  child:  ChoiceChip(

                                    label: Text("  Regular  ",style: TextStyle(color: Colors.white),),


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
                            padding: const EdgeInsets.all(8.0),
                            child:  Column(
                              children: [
                                CircularPercentIndicator(
                                  circularStrokeCap: CircularStrokeCap.round,
                                  radius: 50.0,
                                  lineWidth: 10.0,
                                  percent: 0.00,
                                  center:  Text("00%",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500)),
                                  progressColor: Colors.red,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all( 8.0),
                                  child: ChoiceChip(

                                    label: const Text("  Ir-regular  ",style: TextStyle(color: Colors.white),),


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
                          ),
                        ],
                      ),
                      SizedBox(height: height/32.85),

                    ],
                  ),
                  SizedBox(width: width/68.3,),
                  Material(
                    elevation: 7,
                    borderRadius: BorderRadius.circular(12),
                    shadowColor:  Color(0xff53B175),
                    child: Container(
                      height: height/7.3,
                      width: width/5.464,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:Border.all(color: Color(0xff53B175))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Total No.of Students",style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: width/68.3,
                          ),),
                          ChoiceChip(

                            label: Text("${schooltotal.toString()} Students",style: TextStyle(color: Colors.white),),


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
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0,top: 20),
            child: Container(
              width: width/1.050,

              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,top:20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right:0.0),
                              child: Text("Class",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0,right: 25),
                              child: Container(child:
                              DropdownButtonHideUnderline(
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
                                              fontSize: width/91.066666667
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  items: classes
                                      .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style:  GoogleFonts.poppins(
                                          fontSize: width/91.066666667
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                                      .toList(),
                                  value:  _typeAheadControllerclass.text,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _typeAheadControllerclass.text = value!;
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
                                width: width/6.83,
                                height: height/16.42,
                                //color: Color(0xffDDDEEE),
                                decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                              ),
                            ),

                          ],

                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right:0.0),
                              child: Text("Section",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0,right: 25),
                              child: Container(child:

                              DropdownButtonHideUnderline(
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
                                              fontSize: width/91.066666667
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  items: section
                                      .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style:  GoogleFonts.poppins(
                                          fontSize: width/91.066666667
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                                      .toList(),
                                  value:  _typeAheadControllersection.text,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _typeAheadControllersection.text = value!;
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
                                width: width/6.83,
                                height: height/16.42,
                                //color: Color(0xffDDDEEE),
                                decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                              ),
                            ),

                          ],

                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right:0.0),
                              child: Text("Date",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0,right: 25),
                              child: Container(child:
                              TextField(
                                style:  GoogleFonts.poppins(
                                    fontSize: width/91.066666667
                                ),
                                controller: date,
                                decoration: InputDecoration(


                                  prefixIcon: Icon(Icons.calendar_today,size: 17,),
                                  hintText: 'Date',


                                  contentPadding: EdgeInsets.only(left: 10,top: 8),
                                  border: InputBorder.none,
                              //editing controller of this TextField
                                ),
                                readOnly: true,  //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context, initialDate: DateTime.now(),
                                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime.now()
                                  );

                                  if(pickedDate != null ){
                                    print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate = DateFormat('d-M-yyyy').format(pickedDate);
                                    String formattedDate2 = DateFormat('d-M-yyyy').format(pickedDate);
                                    print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                    setState(() {
                                      date.text = formattedDate;
                                      selecteddate= formattedDate2;
                                      //set output date to TextField value.
                                    });
                                    print(selecteddate);
                                    print("${_typeAheadControllerclass.text}""${_typeAheadControllerclass.text}");
                                    gettotal();
                                  }else{
                                    print("Date is not selected");
                                  }
                                },
                              ),
                                width: width/6.83,
                                height: height/16.42,
                                //color: Color(0xffDDDEEE),
                                decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                              ),
                            ),

                          ],

                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              view=true;
                              absentonly=false;
                            });
                            gettotal();
                          },
                          child: Container(child: Center(child: Text("View All",style: GoogleFonts.poppins(color:Colors.white),)),
                            width: width/10.507,
                            height: height/16.425,
                            // color:Color(0xff00A0E3),
                            decoration: BoxDecoration(color: Color(0xff53B175),borderRadius: BorderRadius.circular(5)),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:25.0),
                          child: GestureDetector(
                            onTap: (){
                             setState(() {
                               view=true;
                               absentonly=true;
                             });
                             },
                            child: Container(child: Center(child: Text("Absent only",style: GoogleFonts.poppins(color:Colors.white),)),
                              width: width/10.507,
                              height: height/16.425,
                              // color:Color(0xff00A0E3),
                              decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(5)),

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: height/13.14,
                              width: width/2.101,

                              decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 20.0),
                                    child: Text("Reg No",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40.0,right: 8.0),
                                    child: Text("Student Name",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 80.0,right: 8.0),
                                    child: Text("Attendance",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 80.0,right: 8.0),
                                    child: Text("Actions",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                  ),
                                ],
                              ),

                            ),
                          ),
                          selecteddate!=""? view==true?  Container(
                            width: width/2.101,
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection("Attendance").doc("${_typeAheadControllerclass.text}""${_typeAheadControllersection.text}").collection(selecteddate).orderBy("order").snapshots(),

                                builder: (context,snapshot){
                                  if(!snapshot.hasData)
                                  {
                                    return   Center(
                                      child:  CircularProgressIndicator(),
                                    );}
                                  if(snapshot.hasData==null)
                                  {
                                    return   Center(
                                      child:  CircularProgressIndicator(),
                                    );}
                                  studentAttendanceListForPdf.clear();
                                  snapshot.data!.docs.forEach((element) {
                                    if(absentonly){
                                      if(element["present"]==false){
                                        studentAttendanceListForPdf.add(
                                          AttendancePdfModel(
                                            name: element['stname'],
                                            id: element['regno'],
                                            attendance: element['present'],
                                            date: selecteddate,
                                            clasS: "${_typeAheadControllerclass.text}-${_typeAheadControllersection.text}"
                                          )
                                        );
                                      }
                                    }else{
                                      studentAttendanceListForPdf.add(
                                          AttendancePdfModel(
                                              name: element['stname'],
                                              id: element['regno'],
                                              attendance: element['present'],
                                            date: selecteddate,
                                              clasS: "${_typeAheadControllerclass.text}-${_typeAheadControllersection.text}"
                                          )
                                      );
                                    }
                                  });
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context,index){
                                        var value = snapshot.data!.docs[index];
                                        return absentonly==false?
                                          Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: height/21.9,
                                            width: width/2.101,

                                            decoration: BoxDecoration(color:Colors.white60,borderRadius: BorderRadius.circular(12)

                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 5.0,right: 0.0),
                                                  child: Container(
                                                      width: width/11.383,

                                                      child: Text(value["regno"],style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500,color: Colors.black),)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                                                  child: Container(

                                                      width: width/6.2090,
                                                      child: Text(value["stname"],style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500,color: Colors.black),)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                                                  child: Container(

                                                      width: width/8.035,
                                                      child: Text(value["present"]==true?"Present": "Absent",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500,color:value["present"]==true? Colors.green: Colors.red),)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                                                  child: InkWell(
                                                    onTap: (){
                                                      setState(() {
                                                        viewTab = 1;
                                                        studentid = value['stdocid'];
                                                      });
                                                    },
                                                    child: Container(

                                                        width: width/13.66,
                                                        child: Text("View Student",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500,color: Color(0xff00A0E3)),)),
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ),
                                        ) : value["present"]==false? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: height/21.9,
                                            width: width/2.101,

                                            decoration: BoxDecoration(color:Colors.white60,borderRadius: BorderRadius.circular(12)

                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 5.0,right: 0.0),
                                                  child: Container(
                                                      width: width/11.383,

                                                      child: Text(value["regno"],style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500,color: Colors.black),)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                                                  child: Container(

                                                      width: width/6.2090,
                                                      child: Text(value["stname"],style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500,color: Colors.black),)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                                                  child: Container(

                                                      width: width/8.035,
                                                      child: Text(value["present"]==true?"Present": "Absent",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500,color:value["present"]==true? Colors.green: Colors.red),)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                                                  child: InkWell(
                                                    onTap: (){
                                                      setState(() {
                                                        viewTab = 1;
                                                        studentid = value['stdocid'];
                                                      });
                                                    },
                                                    child: Container(

                                                        width: width/13.66,
                                                        child: Text("View Student",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500,color: Color(0xff00A0E3)),)),
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ),
                                        ): Container();
                                      });

                                }),
                          ) : Container(): Container(),
                          SizedBox(height:height/32.55,)
                        ],
                      ),
                      Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,top:8.0),
                            child: Container(
                              height: height/13.14,
                              width: width/4.553,

                              decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                              ),
                              child: Center(child: Text("Reports",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),)),

                            ),
                          ),
                          SizedBox(height: height/32.85,),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:  Column(
                                  children: [
                                    CircularPercentIndicator(
                                      circularStrokeCap: CircularStrokeCap.round,
                                      radius: 45.0,
                                      lineWidth: 10.0,
                                      percent: total ==0? 0.70: (present/total*100)/100,
                                      center:  Text("${(present/total*100).toStringAsFixed(2)}%",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500)),
                                      progressColor: Colors.green,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all( 8.0),
                                      child:  ChoiceChip(

                                        label: Text(" ${present.toString()} Present  ",style: TextStyle(color: Colors.white),),


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
                                padding: const EdgeInsets.all(8.0),
                                child:  Column(
                                  children: [
                                    CircularPercentIndicator(
                                      circularStrokeCap: CircularStrokeCap.round,
                                      radius: 45.0,
                                      lineWidth: 10.0,
                                      percent: total ==0? 0.30: (absent/total*100)/100,
                                      center:  Text("${(absent/total*100).toStringAsFixed(2)}%",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500)),
                                      progressColor: Colors.red,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all( 8.0),
                                      child: ChoiceChip(

                                        label: Text(" ${absent.toString()} Absent  ",style: TextStyle(color: Colors.white),),


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
                              ),
                            ],
                          ),
                          SizedBox(height: height/32.85),
                          Material(
                            elevation: 7,
                            borderRadius: BorderRadius.circular(12),
                            shadowColor:  Color(0xff53B175),
                            child: Container(
                              height: height/7.3,
                              width: width/5.464,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border:Border.all(color: Color(0xff53B175))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Total No.of Students",style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: width/68.3,
                                  ),),
                                  ChoiceChip(

                                      label: Text("${total} Students",style: TextStyle(color: Colors.white),),


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
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: height/32.85),
                          Padding(
                            padding: const EdgeInsets.only(left:25.0),
                            child: GestureDetector(
                              onTap: (){
                                generateAttendancePdf(PdfPageFormat.letter,studentAttendanceListForPdf,true);
                              },
                              child: Container(child: Center(child: Text("Print",style: GoogleFonts.poppins(color:Colors.white),)),
                                width: width/10.507,
                                height: height/16.425,
                                // color:Color(0xff00A0E3),
                                decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(5)),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

            ),
          )
        ],
      ),
    );
  }

  Future<StudentAttendanceReportModel> getMonthlyAttendanceReportForClass() async {
    var snapshot = await FirebaseFirestore.instance.collection("Attendance").get();
    var admin = await FirebaseFirestore.instance.collection("Admin").get();
    int totalWorkingDays = admin.docs.first.get("days");
    List<SalesData> attendanceData = [];
    List<SalesData> attendanceData1 = [];
    List<SalesData> absentData = [];
    List<SalesData> absentData1 = [];
    snapshot.docs.forEach((standard) async {
      int presentCount = 0;
      int absentCount = 0;
      DateTime startDate = DateFormat("dd-M-yyyy").parse('01-06-2023');
      Duration dur =  DateTime.now().difference(startDate);
      try{
        for(int i =0; i < dur.inDays.abs()+1; i++){
          var document1 = await FirebaseFirestore.instance.collection("Attendance").doc(standard.id).collection(DateFormat('dd-M-yyyy').format(startDate.add(Duration(days: i+1)))).get();
          for (var element in document1.docs) {
            if(element.get("present")){
              presentCount++;
              String month = await getMonthForData(startDate.add(Duration(days: i+1)).month);
              SalesData sale = SalesData(month, presentCount.toDouble(),'','');
              attendanceData.add(sale);
            }
            if(!element.get("present")){
              absentCount++;
              String month = await getMonthForData(startDate.add(Duration(days: i+1)).month);
              SalesData sale = SalesData(month, presentCount.toDouble(),'','');
              absentData.add(sale);
            }
          }
        }
      }catch(e){
      }
    });
    await Future.delayed(Duration(seconds: 30));
    attendanceData1.add(SalesData('June',attendanceData.where((element) => element.year == 'June').length.toDouble(),'',''));
    attendanceData1.add(SalesData('July',attendanceData.where((element) => element.year == 'July').length.toDouble(),'',''));
    attendanceData1.add(SalesData('Aug',attendanceData.where((element) => element.year == 'Aug').length.toDouble(),'',''));
    attendanceData1.add(SalesData('Sep',attendanceData.where((element) => element.year == 'Sep').length.toDouble(),'',''));
    attendanceData1.add(SalesData('Oct',attendanceData.where((element) => element.year == 'Oct').length.toDouble(),'',''));
    attendanceData1.add(SalesData('Nov',attendanceData.where((element) => element.year == 'Nov').length.toDouble(),'',''));
    attendanceData1.add(SalesData('Dec',attendanceData.where((element) => element.year == 'Dec').length.toDouble(),'',''));
    attendanceData1.add(SalesData('Jan',attendanceData.where((element) => element.year == 'Jan').length.toDouble(),'',''));
    attendanceData1.add(SalesData('Feb',attendanceData.where((element) => element.year == 'Feb').length.toDouble(),'',''));
    attendanceData1.add(SalesData('Mar',attendanceData.where((element) => element.year == 'Mar').length.toDouble(),'',''));
    attendanceData1.add(SalesData('Apr',attendanceData.where((element) => element.year == 'Apr').length.toDouble(),'',''));

    absentData1.add(SalesData('June',absentData.where((element) => element.year == 'June').length.toDouble(),'',''));
    absentData1.add(SalesData('July',absentData.where((element) => element.year == 'July').length.toDouble(),'',''));
    absentData1.add(SalesData('Aug',absentData.where((element) => element.year == 'Aug').length.toDouble(),'',''));
    absentData1.add(SalesData('Sep',absentData.where((element) => element.year == 'Sep').length.toDouble(),'',''));
    absentData1.add(SalesData('Oct',absentData.where((element) => element.year == 'Oct').length.toDouble(),'',''));
    absentData1.add(SalesData('Nov',absentData.where((element) => element.year == 'Nov').length.toDouble(),'',''));
    absentData1.add(SalesData('Dec',absentData.where((element) => element.year == 'Dec').length.toDouble(),'',''));
    absentData1.add(SalesData('Jan',absentData.where((element) => element.year == 'Jan').length.toDouble(),'',''));
    absentData1.add(SalesData('Feb',absentData.where((element) => element.year == 'Feb').length.toDouble(),'',''));
    absentData1.add(SalesData('Mar',absentData.where((element) => element.year == 'Mar').length.toDouble(),'',''));
    absentData1.add(SalesData('Apr',absentData.where((element) => element.year == 'Apr').length.toDouble(),'',''));

    // print("fetcjhed");
    // return attendanceData1;
    StudentAttendanceReportModel studentReport = StudentAttendanceReportModel(
      absentReport: absentData1,
      presentReport: attendanceData1,
      absentDays: [],
      presentDays: [],
    );
    return studentReport;
  }


  Future<StudentAttendanceReportModel> getMonthlyAttendanceReportForStudent(String id) async {
    var snapshot = await FirebaseFirestore.instance.collection("Students").doc(id).collection('Attendance').get();
    List<SalesData> attendanceData = [];
    List<SalesData> attendanceData1 = [];
    List<SalesData> absentData = [];
    List<SalesData> absentData1 = [];
    List<String> presentDays = [];
    List<String> absentDays = [];
    snapshot.docs.forEach((element) async {
      int presentCount = 0;
      int absentCount = 0;
      if(element.get("Attendance").toString().toLowerCase() == "present"){
        presentCount++;
        DateTime startDate = DateFormat('dd-M-yyyy').parse(element.id);
        String month = await getMonthForData(startDate.month);
        SalesData sale = SalesData(month, presentCount.toDouble(),'',element.id);
        attendanceData.add(sale);
      }
      if(element.get("Attendance").toString().toLowerCase() == "absent"){
        absentCount++;
        DateTime startDate = DateFormat('dd-M-yyyy').parse(element.id);
        String month = await getMonthForData(startDate.month);
        SalesData sale = SalesData(month, absentCount.toDouble(),element.id,'');
        absentData.add(sale);
      }
    });
    await Future.delayed(Duration(seconds: 1));

    attendanceData.forEach((element) {
      presentDays.add(element.presentDay);
    });
    absentData.forEach((element) {
      absentDays.add(element.absentDay);
    });
     attendanceData1.add(SalesData('June',attendanceData.where((element) => element.year == 'June').length.toDouble(),'',''));

    attendanceData1.add(SalesData('July',attendanceData.where((element) => element.year == 'July').length.toDouble(),'',''));

    attendanceData1.add(SalesData('Aug',attendanceData.where((element) => element.year == 'Aug').length.toDouble(),'',''));

     attendanceData1.add(SalesData('Sep',attendanceData.where((element) => element.year == 'Sep').length.toDouble(),'',''));

     attendanceData1.add(SalesData('Oct',attendanceData.where((element) => element.year == 'Oct').length.toDouble(),'',''));

    attendanceData1.add(SalesData('Nov',attendanceData.where((element) => element.year == 'Nov').length.toDouble(),'',''));

    attendanceData1.add(SalesData('Dec',attendanceData.where((element) => element.year == 'Dec').length.toDouble(),'',''));
    attendanceData1.add(SalesData('Jan',attendanceData.where((element) => element.year == 'Jan').length.toDouble(),'',''));
    attendanceData1.add(SalesData('Feb',attendanceData.where((element) => element.year == 'Feb').length.toDouble(),'',''));

    attendanceData1.add(SalesData('Mar',attendanceData.where((element) => element.year == 'Mar').length.toDouble(),'',''));

    attendanceData1.add(SalesData('Apr',attendanceData.where((element) => element.year == 'Apr').length.toDouble(),'',''));




    absentData1.add(SalesData('June',absentData.where((element) => element.year == 'June').length.toDouble(),'',''));

     absentData1.add(SalesData('July',absentData.where((element) => element.year == 'July').length.toDouble(),'',''));

     absentData1.add(SalesData('Aug',absentData.where((element) => element.year == 'Aug').length.toDouble(),'',''));

    absentData1.add(SalesData('Sep',absentData.where((element) => element.year == 'Sep').length.toDouble(),'',''));

    absentData1.add(SalesData('Oct',absentData.where((element) => element.year == 'Oct').length.toDouble(),'',''));

    absentData1.add(SalesData('Nov',absentData.where((element) => element.year == 'Nov').length.toDouble(),'',''));

    absentData1.add(SalesData('Dec',absentData.where((element) => element.year == 'Dec').length.toDouble(),'',''));

    absentData1.add(SalesData('Jan',absentData.where((element) => element.year == 'Jan').length.toDouble(),'',''));

    absentData1.add(SalesData('Feb',absentData.where((element) => element.year == 'Feb').length.toDouble(),'',''));

    absentData1.add(SalesData('Mar',absentData.where((element) => element.year == 'Mar').length.toDouble(),'',''));

    absentData1.add(SalesData('Apr',absentData.where((element) => element.year == 'Apr').length.toDouble(),'',''));

    StudentAttendanceReportModel studentReport = StudentAttendanceReportModel(
      absentReport: absentData1,
      presentReport: attendanceData1,
      absentDays: absentDays,
      presentDays: presentDays,
    );
    return studentReport;
  }

  getMonthForData(int month){
    String result = '';
    switch(month){
      case 1:
        result = 'Jan';
        break;
      case 2:
        result = 'Feb';
        break;
      case 3:
        result = 'Mar';
        break;
      case 4:
        result = 'Apr';
        break;
      case 5:
        result = 'May';
        break;
      case 6:
        result = 'June';
        break;
      case 7:
        result = 'July';
        break;
      case 8:
        result = 'Aug';
        break;
      case 9:
        result = 'Sep';
        break;
      case 10:
        result = 'Oct';
        break;
      case 11:
        result = 'Nov';
        break;
      case 12:
        result = 'Dec';
        break;

    }
    return result;
  }


  getstudents() async {

    var doceumenttotal= await FirebaseFirestore.instance.collection("Attendance").doc("${_typeAheadControllerclass.text}""${_typeAheadControllersection.text}").collection(selecteddate).orderBy("order").get();
    var doceumentpresent= await FirebaseFirestore.instance.collection("Attendance").doc("${_typeAheadControllerclass.text}""${_typeAheadControllersection.text}").collection(selecteddate).where("present",isEqualTo: true).get();
    var doceumentabsent= await FirebaseFirestore.instance.collection("Attendance").doc("${_typeAheadControllerclass.text}""${_typeAheadControllersection.text}").collection(selecteddate).where("present",isEqualTo: false).get();

    setState(() {
      total=doceumenttotal.docs.length;
      present=doceumentpresent.docs.length;
      absent=doceumentabsent.docs.length;
    });


  }

  StudentAttendancePercentage getStudentAttendancePersantage(StudentAttendanceReportModel report){
    double presentPersantage = 0.0;
    double absentPersantage = 0.0;
    double totalPersantage = 0.0;
    report.presentReport.forEach((element) {
      presentPersantage = presentPersantage + element.sales;
      totalPersantage = totalPersantage + element.sales;
    });
    report.absentReport.forEach((element) {
      absentPersantage = absentPersantage + element.sales;
      totalPersantage = totalPersantage + element.sales;
    });
    StudentAttendancePercentage percentage = StudentAttendancePercentage(
      present: (presentPersantage/totalPersantage),
      absent: (absentPersantage/totalPersantage),
      total: totalPersantage
    );
    return percentage;
  }


  ClassAttendancePercentage getClassRegularPercentage(StudentAttendanceReportModel report){
    double regulatPersantage = 0.0;
    double irregularPersantage = 0.0;
    double totalPersantage = 0.0;
    report.presentReport.forEach((element) {
      regulatPersantage = regulatPersantage + element.sales;
      totalPersantage = totalPersantage + element.sales;
    });
    report.absentReport.forEach((element) {
      irregularPersantage = irregularPersantage + element.sales;
      totalPersantage = totalPersantage + element.sales;
    });
    ClassAttendancePercentage percentage = ClassAttendancePercentage(
        regular: (regulatPersantage/totalPersantage) * 100,
        irregular: (irregularPersantage/totalPersantage) * 100,
        total: totalPersantage
    );
    print(regulatPersantage);
    print(irregularPersantage);
    print(totalPersantage);
    return percentage;
  }



}


class StudentAttendanceReportModel {
  StudentAttendanceReportModel({required this.presentReport,required this.absentReport,required this.presentDays, required this.absentDays});

  List<SalesData> presentReport;
  List<SalesData> absentReport;
  List<String> presentDays;
  List<String> absentDays;
}

class StudentAttendancePercentage{
  StudentAttendancePercentage({required this.present, required this.absent, required this.total});
  double present;
  double absent;
  double total;
}

class ClassAttendancePercentage{
  ClassAttendancePercentage({required this.regular, required this.irregular, required this.total});
  double regular;
  double irregular;
  double total;
}