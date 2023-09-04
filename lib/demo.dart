import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ip_geolocation/ip_geolocation.dart';
import 'package:pattern_lock/pattern_lock.dart';


class DemoClassIo extends StatefulWidget {
  const DemoClassIo({Key? key}) : super(key: key);

  @override
  State<DemoClassIo> createState() => _DemoClassIoState();
}

class _DemoClassIoState extends State<DemoClassIo> {
  List patternlist=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  List<int> patternused=[1,3,4,6];
  @override
  Widget build(BuildContext context) {

    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height:height/5.425,
            width:width/6.276,
            child:
            PatternLock(

              // color of selected points.
              selectedColor: Colors.yellowAccent,
              // radius of points.
              pointRadius: 5,
              // whether show user's input and highlight selected points.
              showInput: true,
              // count of points horizontally and vertically.
              dimension: 3,
              // padding of points area relative to distance between points.
              relativePadding: 0.7,
              // needed distance from input to point to select point.
              selectThreshold: 25,
              // whether fill points.
              fillPoints: true,
              used: patternused,
              // callback that called when user's input complete. Called if user selected one or more points.
              onInputComplete: (List<int> input) {
                patternlist=input;
              },

            ),

          ),
        ],
      ),
    );
  }
}
