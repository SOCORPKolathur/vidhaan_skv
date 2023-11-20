import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:show_up_animation/show_up_animation.dart' as an;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vidhaan/photoview.dart';
import 'package:vidhaan/print/attendance_print.dart';
import 'package:pdf/pdf.dart';
import 'models/attendance_pdf_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as sfc;


class SalesData {
  SalesData(this.year, this.sales,this.absentDay, this.presentDay);

  final String year;
  late double sales;
  final String absentDay;
  final String presentDay;
}

class StaffAttendence extends StatefulWidget {
  const StaffAttendence({Key? key}) : super(key: key);

  @override
  State<StaffAttendence> createState() => _StaffAttendenceState();
}

class _StaffAttendenceState extends State<StaffAttendence> {


  List<AttendancePdfModel> staffAttendanceListForPdf = [];
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
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    getvalues();
    setState(() {
      _typeAheadControllerclass.text="Select Option";
      _typeAheadControllersection.text="Select Option";
    });
    _tooltipBehavior = TooltipBehavior(enable: true);
    adddropdownvalue();

    // TODO: implement initState
    super.initState();
  }
  adddropdownvalue() async {
    var sudentsdocument = await  FirebaseFirestore.instance.collection("Staffs").get();
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

  final DateFormat formatter = DateFormat('dd.MM.yyy');


  int total=0;
  int present=0;
  int absent=0;
  int schooltotal=0;

  gettotal() async {
    var document=await FirebaseFirestore.instance.collection("Staffs").get();

    setState(() {
      total= document.docs.length;
      present=0;
      absent=0;
    });
    for(int i=0;i<document.docs.length;i++) {
      var document2=await FirebaseFirestore.instance.collection("Staffs").doc(document.docs[i].id).collection("Attendance").where("Date",isEqualTo: selecteddate).get();
      if(document2.docs.length>0){
        setState(() {
          present=present+1;

        });
        print("present");
      }
      else{
        print("absent");
        setState(() {
          absent=absent+1;
        });
      }
    }

  }


  bool view= false;
  bool absentonly= false;

  bool staffDetailView = false;

  String selectedStaffId = '';

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return staffDetailView == true
        ? SingleChildScrollView(
        child: an.ShowUpAnimation(
          curve: Curves.fastOutSlowIn,
          direction: an.Direction.horizontal,
          delayStart: Duration(milliseconds: 200),
          child:
          FutureBuilder<dynamic>(
            future: FirebaseFirestore.instance.collection('Staffs').doc(selectedStaffId).get(),
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
                                      backgroundImage:NetworkImage(value!['imgurl']==""?"https://firebasestorage.googleapis.com/v0/b/vidhaan-4aee7.appspot.com/o/teacher.jpg?alt=media&token=1782c5a6-34c3-42ab-819f-07d52ea06014"
                                          :value['imgurl']),

                                    ),
                                  ),

                                  SizedBox(height:height/52.15,),
                                  Center(
                                    child:Text('${value["stname"]} ${value["stlastname"]}',style: GoogleFonts.montserrat(
                                        fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                    ),),
                                  ),
                                  SizedBox(height:height/130.3,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Staff ID :',style: GoogleFonts.montserrat(
                                          fontWeight:FontWeight.w500,color: Colors.black,fontSize: width/124.4
                                      ),),
                                      Text(value['regno'],style: GoogleFonts.montserrat(
                                          fontWeight:FontWeight.w500,color: Colors.black,fontSize: width/124.4
                                      ),),
                                    ],
                                  ),
                                  SizedBox(height:height/52.15,),
                                  GestureDetector(
                                    onTap: (){

                                    },

                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffFFB946),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      width: width/7.46,
                                      height:height/28,
                                      child: Center(child: Text("View Payroll",style: GoogleFonts.montserrat(
                                          fontWeight:FontWeight.bold,color: Colors.white,fontSize:width/103.6
                                      ),)),
                                    ),
                                  ),


                                  SizedBox(height:height/52.15),
                                  value["incharge"]!="" ? Divider() :Container(),
                                  value["incharge"]!="" ?  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Text('In Charge Class',style: GoogleFonts.montserrat(
                                          fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                      ),),
                                    ],
                                  ):Container(),
                                  value["incharge"]!="" ?  SizedBox(height: height/65.7,):Container(),
                                  value["incharge"]!="" ? Row(
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

                                                label: Text("    ${value["incharge"]} / ${value["inchargesec"]}    ",style: TextStyle(color: Colors.white),),


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
                                  ):Container(),
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
                                      child: Text('${value["dob"]}',style: GoogleFonts.montserrat(
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
                                    Text('Staff  Details',style: GoogleFonts.montserrat(
                                      fontSize:width/81.13,fontWeight: FontWeight.bold,
                                    ),),

                                    InkWell(
                                        onTap: (){
                                          setState(() {
                                            staffDetailView=false;
                                            selectedStaffId = "";
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
                                          child: FutureBuilder<StaffAttendanceReportModel>(
                                            future: getMonthlyAttendanceReportForStaff(selectedStaffId),
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
                                                                    text: '   Monthly Present Reports',
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
                                                                  label: Text("${(getStudentAttendancePersantage(snapshot.data!).present * getStudentAttendancePersantage(snapshot.data!).total)} Present  ",style: TextStyle(color: Colors.white),),
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
                                                                    text: '   Monthly Absent Reports',
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
        )
    )
        : SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Container(child: Padding(
              padding: const EdgeInsets.only(left: 38.0,top: 30),
              child: Text("Staff Attendance Register",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),),
            ),
              //color: Colors.white,
              width: width/1.050,
              height: height/8.212,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
            ),
          ),
          FutureBuilder(
            future: getMonthlyAttendanceReportForAllStaffs(),
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
                                  text: '   Monthly Staff Reports',
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
                                    percent:  (presnetvalues/totalattdencevalues),
                                    center:  Text("${(presnetvalues/totalattdencevalues *100).toInt()} %",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500)),
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
                                    percent:(absentvalues/totalattdencevalues),
                                    center:  Text("${(absentvalues/totalattdencevalues *100).toInt()}%",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500)),
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
                            Text("Total No.of Staffs",style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: width/68.3,
                            ),),
                            ChoiceChip(

                              label: Text("${schooltotal.toString()} Staffs",style: TextStyle(color: Colors.white),),


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
                                    text: '   Monthly Staff Reports',
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
                                  percent:  (presnetvalues/totalattdencevalues),
                                  center:  Text("${(presnetvalues/totalattdencevalues *100).toInt()}%",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500)),
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
                                  percent:(absentvalues/totalattdencevalues),
                                  center:  Text("${(absentvalues/totalattdencevalues *100).toInt()}%",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500)),
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
                          Text("Total No.of Staffs",style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: width/68.3,
                          ),),
                          ChoiceChip(

                            label: Text("${schooltotal.toString()} Staffs",style: TextStyle(color: Colors.white),),


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
                                    String formattedDate = DateFormat('dd.MM.yyyy').format(pickedDate);
                                    String formattedDate2 = DateFormat('dd/M/yyyy').format(pickedDate);
                                    print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                    setState(() {
                                      date.text = formattedDate;
                                      selecteddate= formattedDate2;
                                      //set output date to TextField value.
                                    });
                                    print(selecteddate);
                                    print("${_typeAheadControllerclass.text}""${_typeAheadControllerclass.text}");
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
                              generateAttendancePdf(PdfPageFormat.letter,staffAttendanceListForPdf,false);
                            },
                            child: Container(child: Center(child: Text("Print",style: GoogleFonts.poppins(color:Colors.white),)),
                              width: width/10.507,
                              height: height/16.425,
                              // color:Color(0xff00A0E3),
                              decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        ),
                       /* Padding(
                          padding: const EdgeInsets.only(left:25.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
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
                        ),*/
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
                                    child: Text("Staff ID",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40.0,right: 8.0),
                                    child: Text("Staff Name",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 80.0,right: 8.0),
                                    child: Text("Attendance",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                  ),
                                  /*Padding(
                                    padding: const EdgeInsets.only(left: 80.0,right: 8.0),
                                    child: Text("Time",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                  ),

                                   */
                                ],
                              ),

                            ),
                          ),
                          selecteddate!=""? view==true?  Container(
                            width: width/2.101,
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection("Staffs").orderBy("timestamp").snapshots(),

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
                                  staffAttendanceListForPdf.clear();
                                  snapshot.data!.docs.forEach((element) {
                                      staffAttendanceListForPdf.add(
                                          AttendancePdfModel(
                                              name: element['stname'],
                                              id: element['regno'],
                                            date: selecteddate,
                                          )
                                      );
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

                                                      child: Text(value["regno"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                                                  child: Container(

                                                      width: width/6.2090,
                                                      child: Text(value["stname"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                                                  child: Container(

                                                      width: width/8.035,
                                                      child: StreamBuilder(
                                                        stream: FirebaseFirestore.instance.collection("Staffs").doc(value.id).collection("Attendance").where("Date",isEqualTo: selecteddate).snapshots(),
                                                        builder: (context,snap2) {
                                                          staffAttendanceListForPdf.forEach((element) {
                                                            if(element.id == value['regno'] && element.name == value['stname']){
                                                              element.attendance = snap2.data!.docs.length==0? false : true;
                                                            }
                                                          });
                                                          return Text(snap2.data!.docs.length==0? "Absent":"Present",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500,color: snap2.data!.docs.length==0? Colors.red:Colors.green),);
                                                        }
                                                      )),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                                                  child: InkWell(
                                                    onTap: (){
                                                      setState(() {
                                                        selectedStaffId = value.id;
                                                        staffDetailView = true;
                                                      });
                                                    },
                                                    child: Container(

                                                        width: width/13.66,
                                                        child: Text("View Staff",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500,color: Color(0xff00A0E3)),)),
                                                  ),
                                                ),


                                              ],
                                            ),

                                          ),
                                        ) : Container();
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
                                      center:  Text("${(present/total*100).toStringAsFixed(2)}%",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500)),
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
                                      center:  Text("${(absent/total*100).toStringAsFixed(2)}%",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500)),
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
                                  Text("Total No.of Staffs",style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: width/68.3,
                                  ),),
                                  ChoiceChip(

                                    label: Text("${total} Staffs",style: TextStyle(color: Colors.white),),


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

  Future<StaffAttendanceReportModel> getMonthlyAttendanceReportForAllStaffs() async {
    var snapshot = await FirebaseFirestore.instance.collection("Staff_attendance").get();//.doc(id).collection('Attendance').get();
    var admin = await FirebaseFirestore.instance.collection("Admin").get();
    var staffs = await FirebaseFirestore.instance.collection("Staffs").get();
    int totalWorkingDays = admin.docs.first.get("days");
    int totalStaffs = staffs.docs.length;
    int total = totalStaffs * totalWorkingDays;
    List<SalesData> attendanceData = [];
    List<SalesData> attendanceData1 = [];
    List<SalesData> absentData = [];
    List<SalesData> absentData1 = [];
    List<String> presentDays = [];
    List<String> absentDays = [];


    try{
      snapshot.docs.forEach((date) async {
        int presentCount = 0;
        int absentCount = 0;
        var staffs = await FirebaseFirestore.instance.collection('Staff_attendance').doc(date.id).collection('Staffs').get();
        staffs.docs.forEach((staff) async {
            if(staff.get("Staffattendance") == true){
              presentCount++;
              DateTime startDate = DateFormat('dd/M/yyyy').parse(staff.get("Date"));
              String month = await getMonthForData(startDate.month);
              SalesData sale = SalesData(month, presentCount.toDouble(),'',DateFormat("MMM yyyy").format(startDate));
              attendanceData.add(sale);
            }
            if(staff.get("Staffattendance") == false){
              absentCount++;
              DateTime startDate = DateFormat('dd/M/yyyy').parse(staff.get("Date"));
              String month = await getMonthForData(startDate.month);
              SalesData sale = SalesData(month, absentCount.toDouble(),DateFormat("MMM yyyy").format(startDate),'');
              absentData.add(sale);
            }
        });
      });
    }catch(e){

    }
    await Future.delayed(Duration(seconds: 20));

    attendanceData.forEach((element) {
      presentDays.add(element.presentDay);
    });
    absentData.forEach((element) {
      absentDays.add(element.absentDay);
    });


    attendanceData1.add(SalesData('June',((attendanceData.where((element) => element.year == 'June').length / total) * 100).toDouble().roundToDouble(),'',''));

    attendanceData1.add(SalesData('July',((attendanceData.where((element) => element.year == 'July').length / total) * 100).toDouble().roundToDouble(),'',''));

    attendanceData1.add(SalesData('Aug',((attendanceData.where((element) => element.year == 'Aug').length / total) * 100).toDouble().roundToDouble(),'',''));

    attendanceData1.add(SalesData('Sep',((attendanceData.where((element) => element.year == 'Sep').length / total) * 100).toDouble().roundToDouble(),'',''));

    attendanceData1.add(SalesData('Oct',((attendanceData.where((element) => element.year == 'Oct').length / total) * 100).toDouble().roundToDouble(),'',''));

    attendanceData1.add(SalesData('Nov',((attendanceData.where((element) => element.year == 'Nov').length / total) * 100).toDouble().roundToDouble(),'',''));

    attendanceData1.add(SalesData('Dec',((attendanceData.where((element) => element.year == 'Dec').length / total) * 100).toDouble().roundToDouble(),'',''));

    attendanceData1.add(SalesData('Jan',((attendanceData.where((element) => element.year == 'Jan').length / total) * 100).toDouble().roundToDouble(),'',''));

    attendanceData1.add(SalesData('Feb',((attendanceData.where((element) => element.year == 'Feb').length / total) * 100).toDouble().roundToDouble(),'',''));

    attendanceData1.add(SalesData('Mar',((attendanceData.where((element) => element.year == 'Mar').length / total) * 100).toDouble().roundToDouble(),'',''));

    attendanceData1.add(SalesData('Apr',((attendanceData.where((element) => element.year == 'Apr').length / total) * 100).toDouble().roundToDouble(),'',''));




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

    StaffAttendanceReportModel studentReport = StaffAttendanceReportModel(
      absentReport: absentData1,
      presentReport: attendanceData1,
      absentDays: absentDays,
      presentDays: presentDays,
    );
    return studentReport;
  }

  Future<StaffAttendanceReportModel> getMonthlyAttendanceReportForStaff(String id) async {
    var snapshot = await FirebaseFirestore.instance.collection("Staff_attendance").get();//.doc(id).collection('Attendance').get();
    List<SalesData> attendanceData = [];
    List<SalesData> attendanceData1 = [];
    List<SalesData> absentData = [];
    List<SalesData> absentData1 = [];
    List<String> presentDays = [];
    List<String> absentDays = [];


    try{
      for(int l = 0; l < snapshot.docs.length; l ++){
        int presentCount = 0;
        int absentCount = 0;
        try{
          var staff = await FirebaseFirestore.instance.collection('Staff_attendance').doc(snapshot.docs[l].id).collection('Staffs').doc(id).get();
          if(staff.exists){
            if(staff.get("Staffattendance") == true){
              presentCount++;
              DateTime startDate = DateFormat('dd/M/yyyy').parse(staff.get("Date"));
              String month = await getMonthForData(startDate.month);
              SalesData sale = SalesData(month, presentCount.toDouble(),'',DateFormat("MMM yyyy").format(startDate));
              attendanceData.add(sale);
            }
            if(staff.get("Staffattendance") == false){
              absentCount++;
              DateTime startDate = DateFormat('dd/M/yyyy').parse(staff.get("Date"));
              String month = await getMonthForData(startDate.month);
              SalesData sale = SalesData(month, absentCount.toDouble(),DateFormat("MMM yyyy").format(startDate),'');
              absentData.add(sale);
            }
          }else{
            print('No data');
          }
        }catch (e){
          print(e);
        }
      }
    }catch(e){
      print(e);
    }

    attendanceData.forEach((element) {
      presentDays.add(element.presentDay);
    });
    absentData.forEach((element) {
      absentDays.add(element.absentDay);
    });
    if(attendanceData.isNotEmpty){
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
    }




    if(absentData.isNotEmpty){
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
    }

    StaffAttendanceReportModel studentReport = StaffAttendanceReportModel(
      absentReport: absentData1,
      presentReport: attendanceData1,
      absentDays: absentDays,
      presentDays: presentDays,
    );
    return studentReport;
  }

  ClassAttendancePercentage getClassRegularPercentage(StaffAttendanceReportModel report){
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



  StaffAttendancePercentage getStudentAttendancePersantage(StaffAttendanceReportModel report){
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
    StaffAttendancePercentage percentage = StaffAttendancePercentage(
        present: (presentPersantage/totalPersantage),
        absent: (absentPersantage/totalPersantage),
        total: totalPersantage
    );
    return percentage;
  }



  int totalvalues=0;
  int presnetvalues = 0;
  int absentvalues =0;
  int holidayvalues =0;
  int totalattdencevalues =0;
  getvalues() async {
    var document = await FirebaseFirestore.instance.collection("Staff_attendance").get();
    var staffs = await FirebaseFirestore.instance.collection("Staffs").get();
    setState(() {
      totalvalues = document.docs.length;
      totalattdencevalues = document.docs.length * staffs.docs.length;
    });
    for(int i=0;i<document.docs.length;i++){
      var document2 = await FirebaseFirestore.instance.collection("Staff_attendance").doc(document.docs[i].id).collection("Staffs").get();
      setState(() {
        presnetvalues = presnetvalues + document2.docs.length;
      });
    }
    setState(() {
      absentvalues = totalattdencevalues - presnetvalues ;
    });
    print("Total++++++++++++++++++++++++++++++");
    print((totalattdencevalues).toInt());
    print("Present++++++++++++++++++++++++++++++");
    print((presnetvalues/totalattdencevalues *100));
    print("Absent+++++++++++++++++++++++++++");
    print((absentvalues/totalattdencevalues *100));

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
}



class StaffAttendanceReportModel {
  StaffAttendanceReportModel({required this.presentReport,required this.absentReport,required this.presentDays, required this.absentDays});

  List<SalesData> presentReport;
  List<SalesData> absentReport;
  List<String> presentDays;
  List<String> absentDays;
}

class StaffAttendancePercentage{
  StaffAttendancePercentage({required this.present, required this.absent, required this.total});
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
