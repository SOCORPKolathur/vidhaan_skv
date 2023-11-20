import 'dart:html';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:screenshot/screenshot.dart';


import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();



  @override
  void initState() {

    getadmin();

    // TODO: implement initState
    super.initState();
  }

  String schoolname="";
  String schooladdress="";
  String schoolphone="";
  String schoollogo="";
  String idcarddesign="";
  String solgan="";
  String schoolweb="";

  getadmin() async {
    var document = await FirebaseFirestore.instance.collection("Admin").get();
    setState(() {
      schoolname=document.docs[0]["schoolname"];
      schooladdress="${document.docs[0]["area"]} ${document.docs[0]["city"]} ${document.docs[0]["pincode"]}";
      schoollogo=document.docs[0]["logo"];
      idcarddesign=document.docs[0]["idcard"].toString();
      solgan=document.docs[0]["solgan"];
      schoolphone=document.docs[0]["phone"];
      schoolweb=document.docs[0]["web"];
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Screenshot(
              controller: screenshotController,
              child:  Container(
                width: width/5.253846153846154,
                height:height/1.58780487804878,
                color:Colors.white,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/idbg4.png",color: Color(0xff00A0E3),),
                        Image.asset("assets/idbg6.png",color: Color(0xff00A0E3),),

                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        SizedBox(height:height/32.55,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: width/27.32,
                                height:height/13.02, decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color:Colors.white
                            ),
                                child: Image.network(schoollogo)),
                          ],
                        ),
                        SizedBox(height: height/325.5,),
                        Text(schoolname,style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                        Text(schooladdress,style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: width/170.75,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                        Text("Phone: +91 ${schoolphone}",style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: width/170.75,fontWeight: FontWeight.w400),),

                        Text(schoolweb,style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: width/170.75,fontWeight: FontWeight.w400),),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: width/11.38333333333333,
                              height:height/5.425,
                              decoration: BoxDecoration(
                                  color: Color(0xff00A0E3),
                                  borderRadius: BorderRadius.circular(60)
                              ),


                            ),
                            Container(
                              width: width/12.19642857142857,
                              height: height/5.8125,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.asset("assets/profile.jpg")),
                            ),

                          ],
                        ),
                        SizedBox(height:height/43.4,),
                        Text("Sam Jebaseelan",style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: width/91.066666667,fontWeight: FontWeight.w700),),
                        Text("ID: VBSB004",style: GoogleFonts.poppins(
                            color:  Color(0xff00A0E3), fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                        SizedBox(height:height/65.1,),
                        Row(
                          children: [
                            SizedBox(width: width/68.3,),
                            Text("Class       : ",style: GoogleFonts.poppins(
                                color: Color(0xff00A0E3), fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                            Text("LKG A",style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: width/68.3,),
                            Text("DOB          : ",style: GoogleFonts.poppins(

                                color: Color(0xff00A0E3), fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                            Text("05/05/2002",style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: width/68.3,),
                            Text("Blood Group       : ",style: GoogleFonts.poppins(
                                color:Color(0xff00A0E3), fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                            Text("B+ve",style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: width/68.3,),
                            Text("Emergency Contact No    : ",style: GoogleFonts.poppins(
                                color: Color(0xff00A0E3), fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                            Text("789456213",style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                          ],
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(
              height: height/26.04,
            ),
            ElevatedButton(
              child: Text(
                'Capture Above Widget',
              ),
              onPressed: () {
                screenshotController
                    .capture(delay: Duration(milliseconds: 10))
                    .then((capturedImage) async {
                  ShowCapturedWidget(context, capturedImage!);

                }).catchError((onError) {
                  print(onError);
                });
              },
            ),
            ElevatedButton(
              child: Text(
                'Capture An Invisible Widget',
              ),
              onPressed: () {
                var container = Container(
                    padding: const EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent, width: 5.0),
                      color: Colors.redAccent,
                    ),
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/flutter.png',
                        ),
                        Text(
                          "This is an invisible widget",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ));
                screenshotController
                    .captureFromWidget(
                    InheritedTheme.captureAll(
                        context, Material(child: container)),
                    delay: Duration(seconds: 1))
                    .then((capturedImage) {
                  ShowCapturedWidget(context, capturedImage);
                });
              },
            ),
            ElevatedButton(
              child: Text(
                'Capture A dynamic Sized Widget',
              ),
              onPressed: () {
                var randomItemCount = Random().nextInt(100);
                var container = Builder(builder: (context) {
                  return Container(
                    // width: size2.width,
                      padding: const EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: Colors.blueAccent, width: 5.0),
                        color: Colors.redAccent,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < randomItemCount; i++)
                            Text("Tile Index $i"),
                        ],
                      ));
                });
                screenshotController
                    .captureFromLongWidget(
                  InheritedTheme.captureAll(
                      context, Material(child: container)),
                  delay: Duration(milliseconds: 100),
                  context: context,
                )
                    .then((capturedImage) {
                  ShowCapturedWidget(context, capturedImage);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(child: Image.memory(capturedImage)),
      ),
    );
  }


     Future<void> _downloadImage() async {
       screenshotController
           .capture(delay: Duration(milliseconds: 10))
           .then((capturedImage) async {
         await WebImageDownloader.downloadImageFromUInt8List(uInt8List: capturedImage!,name: "IDCARD");
       }).catchError((onError) {
         print(onError);
       });

     }


}


class Demopage extends StatefulWidget {
  const Demopage({Key? key}) : super(key: key);

  @override
  State<Demopage> createState() => _DemopageState();
}

class _DemopageState extends State<Demopage> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child:  Container(
            height: height/2.579750346740638,
            width: width/8.458204334365325,

            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/idbg4.png",color: Color(0xff00A0E3),),
                    Image.asset("assets/idbg6.png",color: Color(0xff00A0E3),),

                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    SizedBox(height: height/81.375),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: width/45.53333333333333,
                            height:height/21.7, decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color:Colors.white
                        ),
                            ),
                      ],
                    ),
                    SizedBox(height: height/325.5),
                    Text("Vidhaan Educare",style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: width/170.75,fontWeight: FontWeight.w600),),
                    Text("120/2 Cathedral Nagar Eeast 11th street ",style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: width/341.5,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                    Text("Phone: +91 ${"7708804532"}",style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: width/341.5,fontWeight: FontWeight.w400),),

                    Text("www.vidhaan.in",style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: width/341.5,fontWeight: FontWeight.w400),),
                    SizedBox(height: height/81.375),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: width/22.76666666666667,
                          height:height/10.85,
                          decoration: BoxDecoration(
                              color: Color(0xff00A0E3),
                              borderRadius: BorderRadius.circular(60)
                          ),


                        ),
                        Container(
                          width: width/24.39285714285714,
                          height:height/11.625,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.asset("assets/profile.jpg")),
                        ),

                      ],
                    ),
                    SizedBox(height:height/43.4,),
                    Text("Sam Jebaseelan",style: GoogleFonts.poppins(
                        color: Colors.black, fontSize: width/136.6,fontWeight: FontWeight.w700),),
                    Text("ID: VBSB004",style: GoogleFonts.poppins(
                        color:  Color(0xff00A0E3), fontSize: width/170.75,fontWeight: FontWeight.w600),),
                    SizedBox(height: height/130.2),
                    Row(
                      children: [
                        SizedBox(width: width/136.6,),
                        Container(
                          width:width/17.075,
                          child: Text("Class",style: GoogleFonts.poppins(
                              color: Color(0xff00A0E3), fontSize: width/170.75,fontWeight: FontWeight.w600),),
                        ),
                        Text(": ",style: GoogleFonts.poppins(
                            color: Color(0xff00A0E3), fontSize: width/170.75,fontWeight: FontWeight.w600),),
                        Text("LKG A",style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: width/170.75,fontWeight: FontWeight.w600),),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: width/136.6),
                        Container(
                          width:width/17.075,
                          child: Text("DOB",style: GoogleFonts.poppins(
                              color: Color(0xff00A0E3), fontSize: width/170.75,fontWeight: FontWeight.w600),),
                        ),
                        Text(": ",style: GoogleFonts.poppins(
                            color: Color(0xff00A0E3), fontSize: width/170.75,fontWeight: FontWeight.w600),),
                        Text("11/05/2002".substring(0,10),style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: width/170.75,fontWeight: FontWeight.w600),),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: width/136.6),
                        Container(
                          width:width/17.075,
                          child: Text("Blood Group",style: GoogleFonts.poppins(
                              color:Color(0xff00A0E3), fontSize: width/170.75,fontWeight: FontWeight.w600),),
                        ),
                        Text(": ",style: GoogleFonts.poppins(
                            color: Color(0xff00A0E3), fontSize: width/170.75,fontWeight: FontWeight.w600),),
                        Text("B+ve",style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: width/170.75,fontWeight: FontWeight.w600),),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: width/136.6),
                        Container(
                          width:width/17.075,
                          child: Text("Phone No",style: GoogleFonts.poppins(
                              color: Color(0xff00A0E3), fontSize: width/170.75,fontWeight: FontWeight.w600),),
                        ),
                        Text(": ",style: GoogleFonts.poppins(
                            color: Color(0xff00A0E3), fontSize: width/170.75,fontWeight: FontWeight.w600),),
                        Text("9176582347",style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: width/170.75,fontWeight: FontWeight.w600),),
                      ],
                    ),

                  ],
                ),

              ],
            ),
          ),
      ),
    );
  }
}
