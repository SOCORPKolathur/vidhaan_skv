import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ip_geolocation/ip_geolocation.dart';


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

        ],
      ),
    );
  }
}
