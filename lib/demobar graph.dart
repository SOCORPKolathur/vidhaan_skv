import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Bar Graph Files/resources/app_colors.dart';

class BarChartSample2 extends StatefulWidget {
  BarChartSample2({super.key});
  final Color leftBarColor = Color(0xff53B175);
  final Color rightBarColor = Colors.redAccent;
  final Color avgColor = Color(0xff00A0E3);
  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final double width = 12;

  late List<BarChartGroupData> rawBarGroups = [];
  List<BarChartGroupData> showingBarGroups = [];
  late List<String> titles;
  late List<String> bottomTitleHeaders;
  List bottomTitleHeaders1 = [];

  int touchedGroupIndex = -1;

  int totalStudents = 0;

  Future<List<BarChartGroupData>> getFeesDetails() async {

    var examsDoc = await FirebaseFirestore.instance.collection("ClassMaster").get();
    var studentsDoc = await FirebaseFirestore.instance.collection("Students").get();
    totalStudents = studentsDoc.docs.length;

    titles = [];
    for(int e = 0; e < examsDoc.docs.length; e++){
      var feesDoc = await FirebaseFirestore.instance.collection("ClassMaster").doc(examsDoc.docs[e].id).collection('Fees').get();
      for(int f = 0; f < feesDoc.docs.length; f++){
        if(feesDoc.docs[f].get("paytype").toString().toLowerCase() == 'custom'){
          if(!titles.contains(feesDoc.docs[f].get("feesname"))){
            titles.add(feesDoc.docs[f].get("feesname"));
          }
        }
      }
    }


    for(int t = 0; t < titles.length; t++){
      int x= t;
      double y1 = 0.0;
      double y2 = 0.0;
        for(int s = 0; s < studentsDoc.docs.length; s++) {
          //try{
            var feesDoc = await FirebaseFirestore.instance.collection("Students").doc(studentsDoc.docs[s].id).collection('Fees').where("feesname", isEqualTo: titles[t]).get();
            for(int f = 0; f < feesDoc.docs.length; f++){
              if(feesDoc.docs[f].get("status") == true){
                y1 = y1 + 1;
              }else{
                y2 = y2 + 1;
              }
              // if(feesDoc.docs[f].get("status") == false){
              //   y2 = y2 + 1;
              // }
            }
          // }catch (e){
          // }
        }
      setState(() {
        showingBarGroups.add(
            makeGroupData(x, y1, y2)
        );
      });
    }
    return showingBarGroups;
  }

  @override
  void initState() {
    getFeesDetails();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 38,
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: double.parse((totalStudents).toString()),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.white,
                      tooltipBorder: const BorderSide(
                        color: Colors.grey,
                      ),
                      getTooltipItem: (a, b, c, d) {
                        return BarTooltipItem(
                          d.isEven  ? "Paid : ${c.toY}" : "Unpaid : ${c.toY}",
                          TextStyle(
                            color: d.isEven ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w800,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 75,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 25,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,//snap.data,
                  gridData: const FlGridData(show: true,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {

    String text = value.toString();
    if (value == 0) {
      text = '0';
    } else if (value == (totalStudents/2).floorToDouble()) {
      text = ((totalStudents/2).floorToDouble()).toString();
    } else if (value == totalStudents) {
      text = totalStudents.toString();
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style:  GoogleFonts.montserrat(
        color: const Color(0xff7589a2),
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    String textValue = '';
    List<String> values = titles[value.toInt()].split(" ");

    for(int i = 0; i < values.length; i++){
      if(i == 0){
        textValue += values[i];
      }else{
        textValue += "\n${values[i]}";
      }
    }

    final Widget text = Container(
      width: 100,
      child: Text(
        textValue,
        textAlign: TextAlign.center,
        maxLines: null,
        style:  GoogleFonts.montserrat(
          color: Color(0xff7589a2),
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 4,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}

class FeesDetailsModel{
  FeesDetailsModel({required this.x,required this.y1, required this.y2});

  int x; double y1; double y2;
}