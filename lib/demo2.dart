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
                width: 260,
                height: 410,
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
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width:50,
                                height:50, decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color:Colors.white
                            ),
                                child: Image.network(schoollogo)),
                          ],
                        ),
                        SizedBox(height: 2,),
                        Text(schoolname,style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 12,fontWeight: FontWeight.w600),),
                        Text(schooladdress,style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 8,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                        Text("Phone: +91 ${schoolphone}",style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 8,fontWeight: FontWeight.w400),),

                        Text(schoolweb,style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 8,fontWeight: FontWeight.w400),),
                        SizedBox(height: 0,),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                  color: Color(0xff00A0E3),
                                  borderRadius: BorderRadius.circular(60)
                              ),


                            ),
                            Container(
                              width: 112,
                              height: 112,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.asset("assets/profile.jpg")),
                            ),

                          ],
                        ),
                        SizedBox(height: 15,),
                        Text("Sam Jebaseelan",style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                        Text("ID: VBSB004",style: GoogleFonts.poppins(
                            color:  Color(0xff00A0E3), fontSize: 12,fontWeight: FontWeight.w600),),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Text("Class       : ",style: GoogleFonts.poppins(
                                color: Color(0xff00A0E3), fontSize: 12,fontWeight: FontWeight.w600),),
                            Text("LKG A",style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Text("DOB          : ",style: GoogleFonts.poppins(

                                color: Color(0xff00A0E3), fontSize: 12,fontWeight: FontWeight.w600),),
                            Text("05/05/2002",style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Text("Blood Group       : ",style: GoogleFonts.poppins(
                                color:Color(0xff00A0E3), fontSize: 12,fontWeight: FontWeight.w600),),
                            Text("B+ve",style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Text("Emergency Contact No    : ",style: GoogleFonts.poppins(
                                color: Color(0xff00A0E3), fontSize: 12,fontWeight: FontWeight.w600),),
                            Text("789456213",style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                          ],
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
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
    return Scaffold(
      body: Center(
        child:  Container(
            height: 252.35,
            width: 161.5,

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
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width:30,
                            height:30, decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color:Colors.white
                        ),
                            ),
                      ],
                    ),
                    SizedBox(height: 2,),
                    Text("Vidhaan Educare",style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: 8,fontWeight: FontWeight.w600),),
                    Text("120/2 Cathedral Nagar Eeast 11th street ",style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: 4,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                    Text("Phone: +91 ${"7708804532"}",style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: 4,fontWeight: FontWeight.w400),),

                    Text("www.vidhaan.in",style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: 4,fontWeight: FontWeight.w400),),
                    SizedBox(height: 8,),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Color(0xff00A0E3),
                              borderRadius: BorderRadius.circular(60)
                          ),


                        ),
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.asset("assets/profile.jpg")),
                        ),

                      ],
                    ),
                    SizedBox(height: 15,),
                    Text("Sam Jebaseelan",style: GoogleFonts.poppins(
                        color: Colors.black, fontSize: 10,fontWeight: FontWeight.w700),),
                    Text("ID: VBSB004",style: GoogleFonts.poppins(
                        color:  Color(0xff00A0E3), fontSize: 8,fontWeight: FontWeight.w600),),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Container(
                          width:80,
                          child: Text("Class",style: GoogleFonts.poppins(
                              color: Color(0xff00A0E3), fontSize: 8,fontWeight: FontWeight.w600),),
                        ),
                        Text(": ",style: GoogleFonts.poppins(
                            color: Color(0xff00A0E3), fontSize: 8,fontWeight: FontWeight.w600),),
                        Text("LKG A",style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 8,fontWeight: FontWeight.w600),),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Container(
                          width:80,
                          child: Text("DOB",style: GoogleFonts.poppins(
                              color: Color(0xff00A0E3), fontSize: 8,fontWeight: FontWeight.w600),),
                        ),
                        Text(": ",style: GoogleFonts.poppins(
                            color: Color(0xff00A0E3), fontSize: 8,fontWeight: FontWeight.w600),),
                        Text("11/05/2002".substring(0,10),style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 8,fontWeight: FontWeight.w600),),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Container(
                          width:80,
                          child: Text("Blood Group",style: GoogleFonts.poppins(
                              color:Color(0xff00A0E3), fontSize: 8,fontWeight: FontWeight.w600),),
                        ),
                        Text(": ",style: GoogleFonts.poppins(
                            color: Color(0xff00A0E3), fontSize: 8,fontWeight: FontWeight.w600),),
                        Text("B+ve",style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 8,fontWeight: FontWeight.w600),),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Container(
                          width:80,
                          child: Text("Phone No",style: GoogleFonts.poppins(
                              color: Color(0xff00A0E3), fontSize: 8,fontWeight: FontWeight.w600),),
                        ),
                        Text(": ",style: GoogleFonts.poppins(
                            color: Color(0xff00A0E3), fontSize: 8,fontWeight: FontWeight.w600),),
                        Text("9176582347",style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 8,fontWeight: FontWeight.w600),),
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
