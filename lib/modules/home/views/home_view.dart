import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidhaan/modules/home/controllers/home_controller.dart';


class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  final homecontroller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    log(homecontroller.clientusers.length.toString());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Admin ",
              style: TextStyle(fontSize: width/45.533333333),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: "Description"),
                controller: homecontroller.title,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: "Heding"),
                controller: homecontroller.body,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                homecontroller.findusers('All');
              },
              child: Text("Send Notification All"),
            )
          ],
        ),
      ),
    );
  }
}
