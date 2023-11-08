import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vidhaan/Chart%20FIles/indicator.dart';

import 'Chart FIles/app_colors.dart';
import 'attendence.dart';

class StudentPieChart extends StatefulWidget {
  const StudentPieChart({super.key});

  @override
  State<StudentPieChart> createState() => _StudentPieChartState();
}

class _StudentPieChartState extends State<StudentPieChart> {

  int touchedIndex= 1;
  int total=0;
  int presnet = 1000;
  int absent =40;
  double holiday =0;
  int totalattdence =0;


  int totaldays=0;
  int holidayscount=0;
  int holidaysenrty=0;
  final DateFormat formatter = DateFormat('dd / M / yyyy');
  int year1 =0;
  int day1= 0;
  int month1=0;
  int year2=0;
  int day2=0;
  int month2=0;
  List<String> mydate =[];

  getMonthlyAttendanceReportForClass() async {
    var snapshot = await FirebaseFirestore.instance.collection("Attendance").get();
    var studentsDoc  = await FirebaseFirestore.instance.collection("Attendance").get();
    var admin = await FirebaseFirestore.instance.collection("Admin").get();
    int totalWorkingDays = admin.docs.first.get("days");
    List<SalesData> attendanceData = [];
    List<SalesData> attendanceData1 = [];
    List<SalesData> absentData = [];
    List<SalesData> absentData1 = [];

    var holidaysdata = await FirebaseFirestore.instance.collection("Events").get();
    for(int i=0;i<holidaysdata.docs.length;i++){
      if(mydate.contains(holidaysdata.docs[i]["ondate"])) {
        setState(() {
          holidayscount = holidayscount + 1;
        });
      }
    }

    //totalattdence = studentsDoc.docs.length * totalWorkingDays;
    totalattdence = snapshot.docs.length;

    for(int k =0; k < snapshot.docs.length; k++){
      int presentCount = 0;
      int absentCount = 0;
      DateTime startDate = DateFormat("dd-M-yyyy").parse('01-06-2023');
      Duration dur =  DateTime.now().difference(startDate);
      try{
        for(int i =0; i < dur.inDays.abs()+1; i++){
          var document1 = await FirebaseFirestore.instance.collection("Attendance").doc(snapshot.docs[k].id).collection(DateFormat('dd-M-yyyy').format(startDate.add(Duration(days: i+1)))).get();
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
    }
    // snapshot.docs.forEach((standard) async {
    //   int presentCount = 0;
    //   int absentCount = 0;
    //   DateTime startDate = DateFormat("dd-M-yyyy").parse('01-06-2023');
    //   Duration dur =  DateTime.now().difference(startDate);
    //   try{
    //     for(int i =0; i < dur.inDays.abs()+1; i++){
    //       var document1 = await FirebaseFirestore.instance.collection("Attendance").doc(standard.id).collection(DateFormat('dd-M-yyyy').format(startDate.add(Duration(days: i+1)))).get();
    //       for (var element in document1.docs) {
    //         if(element.get("present")){
    //           presentCount++;
    //           String month = await getMonthForData(startDate.add(Duration(days: i+1)).month);
    //           SalesData sale = SalesData(month, presentCount.toDouble(),'','');
    //           attendanceData.add(sale);
    //         }
    //         if(!element.get("present")){
    //           absentCount++;
    //           String month = await getMonthForData(startDate.add(Duration(days: i+1)).month);
    //           SalesData sale = SalesData(month, presentCount.toDouble(),'','');
    //           absentData.add(sale);
    //         }
    //       }
    //     }
    //   }catch(e){
    //   }
    // });
    // await Future.delayed(Duration(seconds: 30));
    // attendanceData1.add(SalesData('June',attendanceData.where((element) => element.year == 'June').length.toDouble(),'',''));
    // attendanceData1.add(SalesData('July',attendanceData.where((element) => element.year == 'July').length.toDouble(),'',''));
    // attendanceData1.add(SalesData('Aug',attendanceData.where((element) => element.year == 'Aug').length.toDouble(),'',''));
    // attendanceData1.add(SalesData('Sep',attendanceData.where((element) => element.year == 'Sep').length.toDouble(),'',''));
    // attendanceData1.add(SalesData('Oct',attendanceData.where((element) => element.year == 'Oct').length.toDouble(),'',''));
    // attendanceData1.add(SalesData('Nov',attendanceData.where((element) => element.year == 'Nov').length.toDouble(),'',''));
    // attendanceData1.add(SalesData('Dec',attendanceData.where((element) => element.year == 'Dec').length.toDouble(),'',''));
    // attendanceData1.add(SalesData('Jan',attendanceData.where((element) => element.year == 'Jan').length.toDouble(),'',''));
    // attendanceData1.add(SalesData('Feb',attendanceData.where((element) => element.year == 'Feb').length.toDouble(),'',''));
    // attendanceData1.add(SalesData('Mar',attendanceData.where((element) => element.year == 'Mar').length.toDouble(),'',''));
    // attendanceData1.add(SalesData('Apr',attendanceData.where((element) => element.year == 'Apr').length.toDouble(),'',''));
    //
    // absentData1.add(SalesData('June',absentData.where((element) => element.year == 'June').length.toDouble(),'',''));
    // absentData1.add(SalesData('July',absentData.where((element) => element.year == 'July').length.toDouble(),'',''));
    // absentData1.add(SalesData('Aug',absentData.where((element) => element.year == 'Aug').length.toDouble(),'',''));
    // absentData1.add(SalesData('Sep',absentData.where((element) => element.year == 'Sep').length.toDouble(),'',''));
    // absentData1.add(SalesData('Oct',absentData.where((element) => element.year == 'Oct').length.toDouble(),'',''));
    // absentData1.add(SalesData('Nov',absentData.where((element) => element.year == 'Nov').length.toDouble(),'',''));
    // absentData1.add(SalesData('Dec',absentData.where((element) => element.year == 'Dec').length.toDouble(),'',''));
    // absentData1.add(SalesData('Jan',absentData.where((element) => element.year == 'Jan').length.toDouble(),'',''));
    // absentData1.add(SalesData('Feb',absentData.where((element) => element.year == 'Feb').length.toDouble(),'',''));
    // absentData1.add(SalesData('Mar',absentData.where((element) => element.year == 'Mar').length.toDouble(),'',''));
    // absentData1.add(SalesData('Apr',absentData.where((element) => element.year == 'Apr').length.toDouble(),'',''));

    // print("fetcjhed");
    // return attendanceData1;
    StudentAttendanceReportModel studentReport = StudentAttendanceReportModel(
      absentReport: absentData1,
      presentReport: attendanceData1,
      absentDays: [],
      presentDays: [],
    );

    presnet = attendanceData.length;
    absent = absentData.length;

    //print((presnet/totalattdence *100).toStringAsFixed(2));
    print((presnet).toStringAsFixed(2));
    print("Absent -PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP>1");
    //print((absent/totalattdence *100).toStringAsFixed(2));
    print((absent).toStringAsFixed(2));
    print("Holiday ->1");
    print(totalattdence);
    //print((holidaysenrty/totalattdence *100).toStringAsFixed(2));

    //   print(totaldays);
    //   print("Holidays Days ->");
    //   print(holidayscount);
    //   print("Total Entry to be ->");
    //   print(totalattdence);
    //   print("Present ->");
    //   print((presnet/totalattdence *100).toStringAsFixed(2));
    //   print("Absent ->");
    //   print((absent/totalattdence *100).toStringAsFixed(2));
    //   print("Holiday ->");
    //   print((holidaysenrty/totalattdence *100).toStringAsFixed(2));

    //return studentReport;
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

  // getvalues() async {
  //   DateTime startdate  =  DateFormat("dd / MM / yyyy").parse("01 / 06 / ${DateTime.now().year.toString()}");
  //   DateTime endtdate  =  DateTime.now();
  //   setState(() {
  //     totaldays = endtdate.difference(startdate).inDays;
  //   });
  //   setState(() {
  //     year1= startdate.year;
  //     day1= startdate.day;
  //     month1= startdate.month;
  //
  //     year2= endtdate.year;
  //     day2= endtdate.day;
  //     month2= endtdate.month;
  //
  //     //set output date to TextField value.
  //   });
  //   DateTime startDate = DateTime.utc(year1, month1, day1);
  //   DateTime endDate = DateTime.utc(year2, month2, day2);
  //   getDaysInBetween() {
  //     final int difference = endDate.difference(startDate).inDays;
  //     return difference;
  //   }
  //   final items = List<DateTime>.generate(getDaysInBetween(), (i) {
  //     DateTime date = startDate;
  //     return date.add(Duration(days: i));
  //   });
  //   setState(() {
  //     mydate.clear();
  //   });
  //   for(int i =0;i<items.length;i++) {
  //     setState(() {
  //       mydate.add(formatter.format(items[i]).toString());
  //     });
  //
  //   }
  //   print(mydate);
  //
  //   var holidaysdata = await FirebaseFirestore.instance.collection("Events").get();
  //   for(int i=0;i<holidaysdata.docs.length;i++){
  //     if(mydate.contains(holidaysdata.docs[i]["ondate"])) {
  //       setState(() {
  //         holidayscount = holidayscount + 1;
  //       });
  //     }
  //   }
  //
  //
  //   var document = await FirebaseFirestore.instance.collection("Staff_attendance").get();
  //   var staffs = await FirebaseFirestore.instance.collection("Staffs").get();
  //   setState(() {
  //     totalattdence = totaldays * staffs.docs.length;
  //     holidaysenrty = holidayscount * staffs.docs.length;
  //   });
  //   for(int i=0;i<document.docs.length;i++){
  //     var document2 = await FirebaseFirestore.instance.collection("Staff_attendance").doc(document.docs[i].id).collection("Staffs").get();
  //     setState(() {
  //       presnet = presnet + document2.docs.length;
  //     });
  //   }
  //   setState(() {
  //     absent = totalattdence - presnet - holidaysenrty;
  //   });
  //   print("Total Days ->");
  //   print(totaldays);
  //   print("Holidays Days ->");
  //   print(holidayscount);
  //   print("Total Entry to be ->");
  //   print(totalattdence);
  //   print("Present ->");
  //   print((presnet/totalattdence *100).toStringAsFixed(2));
  //   print("Absent ->");
  //   print((absent/totalattdence *100).toStringAsFixed(2));
  //   print("Holiday ->");
  //   print((holidaysenrty/totalattdence *100).toStringAsFixed(2));
  //
  // }


  @override
  void initState() {
    //getMonthlyAttendanceReportForClass();
    //getvalues();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        Container(
          width:260,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex = pieTouchResponse
                        .touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: showingSections(),
            ),
          ),
        ),
        Container(
          width: 230,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Indicator(
                color: Color(0xff53B175),
                text: 'Present',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Colors.red,
                text: 'Absent',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              // Indicator(
              //   color: Color(0xffe8ce0c),
              //   text: 'Holiday',
              //   isSquare: true,
              // ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
        ),

      ],
    );
  }





  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 10.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [
        Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {

        case 0:
          return PieChartSectionData(
            color: Color(0xff53B175),
            // value: (presnet/totalattdence *100),
            // title: '${(presnet/totalattdence *100).toStringAsFixed(2)}%',
            value:  (presnet/(presnet+absent))*100,//(presnet/totalattdence *100),
            title: '${((presnet/(presnet+absent))*100).toStringAsFixed(2)}%', //'${(presnet/totalattdence *100).toStringAsFixed(2)}%',
            radius: radius,
            titleStyle:  GoogleFonts.poppins(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: AppColors.mainTextColor1,

            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red,
            value:  (absent/(presnet+absent))*100,//(presnet/totalattdence *100),
            title: '${((absent/(presnet+absent))*100).toStringAsFixed(2)}%', //'${(presnet/totalattdence *100).toStringAsFixed(2)}%',
            // value: (absent/totalattdence *100),
            // title: '${(absent/totalattdence *100).toStringAsFixed(2)}%',
            radius: radius,
            titleStyle:  GoogleFonts.poppins(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: AppColors.mainTextColor1,
            ),
          );
        // case 2:
        //   return PieChartSectionData(
        //     color: Color(0xffe8ce0c),
        //     value:  (((presnet+absent)-(presnet+absent))/(presnet+absent))*100,//(presnet/totalattdence *100),
        //     title: '${((((presnet+absent)-(presnet+absent))/(presnet+absent))*100).toStringAsFixed(2)}%',
        //     // value: ((totalattdence-(presnet+absent))/totalattdence *100),
        //     // title:  '${((totalattdence-(presnet+absent))/totalattdence *100).toStringAsFixed(2)}%',
        //     radius: radius,
        //     titleStyle:  GoogleFonts.poppins(
        //       fontSize: fontSize,
        //       fontWeight: FontWeight.w700,
        //       color: AppColors.mainTextColor1,
        //
        //     ),
        //   );
        default:
          throw Error();
      }
    });
  }
}
