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
  late List<BarChartGroupData> showingBarGroups;
  List<String> bottomTitleHeaders = [];
  List bottomTitleHeaders1 = [];

  int touchedGroupIndex = -1;

  Future<String> getFeesDetails() async {
    List<String> titles = [];
    List<FeesDetailsModel> datas = [];

    var examsDoc = await FirebaseFirestore.instance.collection("FeesMaster").get();
    var studentsDoc = await FirebaseFirestore.instance.collection("Students").get();

    for(int e = 0; e < examsDoc.docs.length; e++){
      if(!titles.contains(examsDoc.docs[e].get("name"))){
        titles.add(examsDoc.docs[e].get("name"));
      }
    }
    print(titles);

    for(int t = 0; t < titles.length; t++){
      print("))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))");
      int x= t;
      double y1 = 0.0;
      double y2 = 0.0;
        for(int s = 0; s < studentsDoc.docs.length; s++) {
          var feesDoc = await FirebaseFirestore.instance.collection("Students").doc(studentsDoc.docs[s].id).collection('Fees').where("feesname", isEqualTo: titles[t]).get();
          for(int f = 0; f < feesDoc.docs.length; f++){
            if(feesDoc.docs[f].get("status") == true){
              y1 = y1 + 1;
            }
            if(feesDoc.docs[f].get("status") == false){
              y2 = y2 + 1;
            }
          }
        }
        print(x.toString()+"))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))");
        print(y1);
        print(y2);
        datas.add(
            FeesDetailsModel(
                x: x,
                y1: y1,
                y2: y2,
            ),
        );
    }

    for(int d = 0; d < datas.length; d++){
      rawBarGroups.add(makeGroupData(datas[d].x, datas[d].y1, datas[d].y2));
    }



    // final barGroup1 = makeGroupData(0, 22, 12);
    // final barGroup2 = makeGroupData(1, 16, 12);
    // final barGroup3 = makeGroupData(2, 18, 5);
    // final barGroup4 = makeGroupData(3, 20, 16);
    // final barGroup5 = makeGroupData(4, 17, 6);
    // final barGroup6 = makeGroupData(5, 19, 1.5);
    // final barGroup7 = makeGroupData(6, 10, 1.5);

    // final items = [
    //   barGroup1,
    //   barGroup2,
    //   barGroup3,
    //   barGroup4,
    //   barGroup5,
    //   barGroup6,
    //   barGroup7,
    // ];
    //rawBarGroups = bottomTitleHeaders1;
    showingBarGroups = rawBarGroups;
    bottomTitleHeaders = titles;

    // FeesDetailsModel feesDetails = FeesDetailsModel(
    //     bottomTitles: titles,
    // );
    return "feesDetails";
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 38,
            ),
            Expanded(
              child: FutureBuilder<String>(
                future: getFeesDetails(),
                builder: (ctx, snap){
                  if(snap.hasData){
                    return BarChart(
                      BarChartData(
                        maxY: 20,
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: Colors.grey,
                            getTooltipItem: (a, b, c, d) => null,
                          ),
                          touchCallback: (FlTouchEvent event, response) {
                            /*      if (response == null || response.spot == null) {
                        setState(() {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                        });
                        return;
                      }

                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                      setState(() {
                        if (!event.isInterestedForInteractions) {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                          return;
                        }
                        showingBarGroups = List.of(rawBarGroups);
                        if (touchedGroupIndex != -1) {
                          var sum = 0.0;
                          for (final rod
                          in showingBarGroups[touchedGroupIndex].barRods) {
                            sum += rod.toY;
                          }
                          final avg = sum /
                              showingBarGroups[touchedGroupIndex]
                                  .barRods
                                  .length;

                          showingBarGroups[touchedGroupIndex] =
                              showingBarGroups[touchedGroupIndex].copyWith(
                                barRods: showingBarGroups[touchedGroupIndex]
                                    .barRods
                                    .map((rod) {
                                  return rod.copyWith(
                                      toY: avg, color: widget.avgColor);
                                }).toList(),
                              );
                        }
                      });*/

                            setState(() {

                            });
                          },
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
                              reservedSize: 45,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              interval: 1,
                              getTitlesWidget: leftTitles,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        barGroups: showingBarGroups,
                        gridData: const FlGridData(show: false,),
                      ),
                    );
                  }return Container();
                },
              )
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {

    String text;
    if (value == 0) {
      text = '0';
    } else if (value == 10) {
      text = '100';
    } else if (value == 19) {
      text = '200';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style:  GoogleFonts.montserrat(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {

    final Widget text = Text(
      bottomTitleHeaders[value.toInt()],
      textAlign: TextAlign.center,
      style:  GoogleFonts.montserrat(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.w600,
        fontSize: 10,
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