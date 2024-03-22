import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vidhaan/Chart%20FIles/indicator.dart';

import 'Chart FIles/app_colors.dart';

class StaffPieChart extends StatefulWidget {
  const StaffPieChart({super.key});

  @override
  State<StaffPieChart> createState() => _StaffPieChartState();
}

class _StaffPieChartState extends State<StaffPieChart> {
  int touchedIndex= 1;

  int total=0;
  int presnet = 0;
  int absent =0;
  int holiday =0;
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
  getvalues() async {
    DateTime startdate  =  DateFormat("dd / MM / yyyy").parse("01 / 06 / ${DateTime.now().year.toString()}");
    DateTime endtdate  =  DateTime.now();
    setState(() {
      totaldays = endtdate.difference(startdate).inDays;
    });


    setState(() {
      year1= startdate.year;
      day1= startdate.day;
      month1= startdate.month;

      year2= endtdate.year;
      day2= endtdate.day;
      month2= endtdate.month;

      //set output date to TextField value.
    });
    DateTime startDate = DateTime.utc(year1, month1, day1);
    DateTime endDate = DateTime.utc(year2, month2, day2);
    getDaysInBetween() {
      final int difference = endDate.difference(startDate).inDays;
      return difference;
    }
    final items = List<DateTime>.generate(getDaysInBetween(), (i) {
      DateTime date = startDate;
      return date.add(Duration(days: i));
    });
    setState(() {
      mydate.clear();
    });
    for(int i =0;i<items.length;i++) {
      setState(() {
        mydate.add(formatter.format(items[i]).toString());
      });

    }

    var holidaysdata = await FirebaseFirestore.instance.collection("Events").get();
    for(int i=0;i<holidaysdata.docs.length;i++){
      if(mydate.contains(holidaysdata.docs[i]["ondate"])) {
        setState(() {
          holidayscount = holidayscount + 1;
        });
      }
    }


    var document = await FirebaseFirestore.instance.collection("Staff_attendance").get();
    var staffs = await FirebaseFirestore.instance.collection("Staffs").get();
    setState(() {
      totalattdence = totaldays * staffs.docs.length;
      holidaysenrty = holidayscount * staffs.docs.length;
    });
    for(int i=0;i<document.docs.length;i++){
      var document2 = await FirebaseFirestore.instance.collection("Staff_attendance").doc(document.docs[i].id).collection("Staffs").get();
      setState(() {
        presnet = presnet + document2.docs.length;
      });
    }
    setState(() {
      absent = totalattdence - presnet - holidaysenrty;
    });

  }


  @override
  void initState() {
    getvalues();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        Container(
          width: width/5.253846153846154,
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
           width: width/5.939130434782609,
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
              Indicator(
                color: Color(0xffe8ce0c),
                text: 'Holiday',
                isSquare: true,
              ),
              SizedBox(
                height:height/36.16666666666667,
              ),
            ],
        ),
         ),

      ],
    );
  }





  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 10.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [
        Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {

        case 0:
          return PieChartSectionData(
            color: Color(0xff53B175),
            //value: (presnet/totalattdence *100),
            value: (65/100 *100),
            //title: '${(presnet/totalattdence *100).toStringAsFixed(2)}%',
            title: '${(65/100 *100).toStringAsFixed(2)}%',
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
            //value: (absent/totalattdence *100),
            value: (25/100 *100),
            //title: '${(absent/totalattdence *100).toStringAsFixed(2)}%',
            title: '${(25/100 *100).toStringAsFixed(2)}%',
            radius: radius,
            titleStyle:  GoogleFonts.poppins(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: AppColors.mainTextColor1,

            ),
          );
        case 2:
          return PieChartSectionData(
            color: Color(0xffe8ce0c),
            //value: (holidaysenrty/totalattdence *100),
            value: (10/100 *100),
            //title: '${(holidaysenrty/totalattdence *100).toStringAsFixed(2)}%',
            title: '${(10/100 *100).toStringAsFixed(2)}%',
            radius: radius,
            titleStyle:  GoogleFonts.poppins(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: AppColors.mainTextColor1,

            ),
          );
        default:
          throw Error();
      }
    });
  }
}
