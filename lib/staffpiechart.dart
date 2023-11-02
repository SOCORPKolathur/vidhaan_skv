import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  getvalues() async {

    var document = await FirebaseFirestore.instance.collection("Staff_attendance").get();
    var staffs = await FirebaseFirestore.instance.collection("Staffs").get();
    setState(() {
      total = document.docs.length;
      totalattdence = document.docs.length * staffs.docs.length;
    });
    for(int i=0;i<document.docs.length;i++){
      var document2 = await FirebaseFirestore.instance.collection("Staff_attendance").doc(document.docs[i].id).collection("Staffs").get();
      setState(() {
        presnet = presnet + document2.docs.length;
      });
    }
    setState(() {
      absent = totalattdence - presnet ;
    });
    print(totalattdence);
    print("Present");
    print((presnet/totalattdence *100).toInt());
    print("Absent");
    print((absent/totalattdence *100).toInt());

  }


  @override
  void initState() {
    getvalues();
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
              Indicator(
                color: Color(0xffe8ce0c),
                text: 'Holiday',
                isSquare: true,
              ),
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
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {

        case 0:
          return PieChartSectionData(
            color: Color(0xff53B175),
            value: 40,
            title: '30%',
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
            value: 25,
            title: '15%',
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
            value: 25,
            title: '15%',
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
