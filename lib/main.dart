import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:vidhaan/demo.dart';
import 'package:vidhaan/setup.dart';
import 'package:vidhaan/sidebar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Dashboard.dart';
import 'demo2.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAlSXyLVpxsmAQbvJqSHZTLWqEfDAG7o1M",
          authDomain: "raven-english-school.firebaseapp.com",
          projectId: "raven-english-school",
          storageBucket: "raven-english-school.appspot.com",
          messagingSenderId: "532398284543",
          appId: "1:532398284543:web:f9e807c01c8b786e95f6ca",
          measurementId: "G-4W9V8FJ1T1"
      ));
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return MaterialApp(
      title: "Vidhaan",
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: Color(0xff00A0E3),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isVisible = true;
  TextEditingController name = new TextEditingController();
  TextEditingController password = new TextEditingController();
  static const snackBar = SnackBar(
    content: Text('Oops! Invalid Password,Try again...'),
  );

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 68.0, right: 0, left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                                print(MediaQuery.of(context).size.height);
                                print(MediaQuery.of(context).size.width);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 10.0, bottom: 10),
                                child: Stack(
                                  children: [
                                    Container(

                                        width: 160,
                                        child: Image.asset("assets/VIDHAANTEXT.png",color: Colors.white,)),
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0,top:35),
                                      child: Text("e    d    u    c    a    r    e",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: 13,color:Colors.white),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0,top:100),
                                      child: Text("Our organization's goal is to provide \nstreamlined data management, focusing on \ndigitizing admission to alumni management \nas a one-stop solution in our ERP system for schools.",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 14,color:Colors.white),),
                                    ),

                                  ],
                                ),

                              ),
                            ),
                            SizedBox(height: 10,),

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 48.0, right: 100),
                        child: Container(
                          child: Image.asset(
                            "assets/img.png",
                            fit: BoxFit.cover,
                          ),
                          color: Color(0xff00A0E3),
                          width: width/4.139,
                          height: height/2.19,
                        ),
                      )
                    ],
                  ),
                  color: Color(0xff00A0E3),
                  width: width/0.9106,
                  height: height/1.877,
                ),
                SizedBox(height: 40,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:60.0,top:15),
                      child: Text("Get in Touch,",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,fontSize: 25,),),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top:15.0),
                  child: Row(
                    children: [
                      SizedBox(width: 20,),
                      Material(

                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             Padding(
                               padding: const EdgeInsets.only(top:20.0),
                               child: Container(
                                   width: 35,
                                   child: Image.asset("assets/support.png")),
                             ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Support",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 18,),),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:15.0),
                        child: Material(

                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                               Padding(
                                 padding: const EdgeInsets.only(top:20.0),
                                 child: Container(
                                     width: 35,
                                     child: Image.asset("assets/developer.png")),
                               ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Dev Support",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 18,),),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:15.0),
                        child: Material(

                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                               Padding(
                                 padding: const EdgeInsets.only(top:20.0),
                                 child: Container(
                                     width: 35,
                                     child: Image.asset("assets/linkedin.png")),
                               ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Linkedin",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 18,),),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:15.0),
                        child: Material(

                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                               Padding(
                                 padding: const EdgeInsets.only(top:20.0),
                                 child: Container(
                                     width: 35,
                                     child: Image.asset("assets/whatsapp.png")),
                               ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Whatsapp",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 18,),),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 808.0, top: 40),
              child: Container(
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 58.0, right: 0,left:20),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: .0),
                                    child: Text(
                                      "Welcome to ",
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 60.0),
                                    child: Text("Vidhaan",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff0089ED),fontSize: 18)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 0,top: 20,left:20),
                              child: Text("Sign in",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40)),
                            ),
                            SizedBox(
                              height: height/32.85,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top:15.0, right: 0,bottom: 10,left:60),
                              child: Text(
                                "Enter your username or email address",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 60.0),
                              child: Container(
                                // color: Colors.grey,
                                height: height/13.14,
                                width: width/3.902,
                                decoration: BoxDecoration(
                                    border: Border.all(color:Colors.grey,),borderRadius: BorderRadius.circular(12)
                                ),
                                child: TextField(
                                  controller: name,
                                  decoration: InputDecoration(contentPadding:EdgeInsets.only(left:29),
                                      border: InputBorder.none,
                                      hintText:
                                      "Username or email address"),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 18.0,right: 0,bottom: 6,left:60),
                              child: Text("Enter your password",style: TextStyle(fontWeight: FontWeight.bold),),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 60.0),
                              child: Container(
                                //color: Colors.grey[50],
                                height: height/13.14,
                                width: width/3.902,
                                decoration: BoxDecoration(
                                    border: Border.all(color:Colors.grey),borderRadius: BorderRadius.circular(12)
                                ),
                                child: TextField(
                                  controller: password,
                                  obscureText: true,
                                  decoration: InputDecoration(contentPadding:EdgeInsets.only(left:29),
                                      border: InputBorder.none,
                                      hintText:
                                      "Password"),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: height/32.85,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 60.0,top: 18),
                              child: GestureDetector(onTap: () {
                                if(name.text=="demo"&&password.text=="demo@123"){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Setup(),));
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }

                              },
                                child: Container(child: Center(child: Text("Sign in",style: TextStyle(color: Colors.white),)),
                                  // color: Color(0xff00A0E3),
                                  height: height/13.14,
                                  width: width/3.902,
                                  decoration: BoxDecoration( color: Color(0xff00A0E3),
                                      borderRadius: BorderRadius.circular(12)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 178.0,top: 20),
                              child: Text("Forget password ? ",style: TextStyle(color: Color(0xff4285F4)),),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 258.0,top:10),
                          child: Container(
                            child: Image.asset("assets/vidh.png"),
                            color: Colors.white,
                            height: height/4.38,
                            width: width/9.757,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // color: Colors.white,
                width: width/2.906,
                height: height/1.1526,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
              ),
            )
          ]),
        ],
      ),
    );
  }
}

