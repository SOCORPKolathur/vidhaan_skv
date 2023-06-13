import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaan/sidebar.dart';

import 'Dashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyAZJWv4gcTv_CZogqRNEUGqlJlOkuo1UgA",
        authDomain: "vidhaantask.firebaseapp.com",
        projectId: "vidhaantask",
        storageBucket: "vidhaantask.appspot.com",
        appId: "1:1058764254442:web:0469e99ff66a7e9aff7b93",
        measurementId: "G-E5SJXV1G87",
        messagingSenderId: "1058764254442",
      ));
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Column(
        children: [

          Column(

            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(child: Padding(
                  padding: const EdgeInsets.only(left: 38.0,top: 20),
                  child: Text("Add New Students",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
                ),
                  //color: Colors.white,
                  width: 1050,
                  height: 80,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20.0,top: 20),
                child: Container(width: 1050,
                  height:550,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),child: Padding(
                  padding: const EdgeInsets.only(top: 38.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right:68.0),
                                child: Text("Name *",style: GoogleFonts.poppins(fontSize: 15,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 28.0,right: 20),
                                child: Container(child: TextField(
                                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                    border: InputBorder.none,
                                  ),
                                ),
                                  width: 150,
                                  height: 40,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                ),
                              ),

                            ],

                          ),       Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right:78.0),
                                    child: Text("Gender *",style: GoogleFonts.poppins(fontSize: 15,)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 28.0,right: 30),
                                    child: Container(child: TextField(style: TextStyle(fontSize: 10),
                                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,top: 13),
                                        border: InputBorder.none,
                                        hintText: "Please Select Gender",
                                        
                                        suffixIcon: Icon(Icons.arrow_drop_down),
                                      ),

                                    ),
                                      width: 150,
                                      height: 40,
                                      //color: Color(0xffDDDEEE),
                                      decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Column(
                                    children: [
                                      
                                      Padding(
                                        padding: const EdgeInsets.only(right:98.0),
                                        child: Text("class *",style: GoogleFonts.poppins(fontSize: 15,)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 28.0,right: 30),
                                        child: Container(child: TextField(style: TextStyle(fontSize: 10),
                                          decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,top: 13),
                                            border: InputBorder.none,
                                            hintText: "Please Select Class",
                                            suffixIcon: Icon(Icons.arrow_drop_down),
                                          ),
                                        ),
                                          width: 150,
                                          height: 40,
                                          //color: Color(0xffDDDEEE),
                                          decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right:40.0),
                                        child: Text("Date of birth *",style: GoogleFonts.poppins(fontSize: 15,)),
                                      ),
                                      Container(child: TextField(style: TextStyle(fontSize: 10),
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,top: 13),
                                          border: InputBorder.none,
                                        hintText: "dd/mm/yy",
                                          suffixIcon: Icon(Icons.calendar_month),


                                        ),
                                      ),
                                        width: 150,
                                        height: 40,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ],
                                  ),

                                ],
                              ),


                            ],
                          ),


                        ],
                      ),


                      Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20,right:10),
                                    child: Text("Blood Group *",style: GoogleFonts.poppins(fontSize: 15,)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 28.0),
                                    child: Container(child: TextField(
                                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom:2),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                      width: 150,
                                      height: 40,
                                      //color: Color(0xffDDDEEE),
                                      decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(

                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20.0,right:30),
                                        child: Text("Religion *",style: GoogleFonts.poppins(fontSize: 15,)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 48.0),
                                        child: Container(child: TextField(style: TextStyle(fontSize: 10),
                                          decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,top: 13),
                                            border: InputBorder.none,
                                            hintText: "Please Select Religion",
                                            suffixIcon: Icon(Icons.arrow_drop_down),


                                          ),
                                        ),
                                          width: 150,
                                          height: 40,
                                          //color: Color(0xffDDDEEE),
                                          decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20,left: 40),
                                        child: Text("Admission Date *",style: GoogleFonts.poppins(fontSize: 15,)),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(left: 58.0),
                                        child: Container(child: TextField(style: TextStyle(fontSize: 10),
                                          decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,top: 13),
                                            border: InputBorder.none,
                                            hintText: "dd/mm/yy",
                                            suffixIcon: Icon(Icons.calendar_month),


                                          ),
                                        ),
                                          width: 150,
                                          height: 40,
                                          //color: Color(0xffDDDEEE),
                                          decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ],

                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0,right: 8),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right:828.0,bottom:10),
                                  child: Text("Add New Parent",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 18),),
                                ),
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left:1.0),
                                                  child: Text("Father's Name ",style: GoogleFonts.poppins(fontSize: 15,)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left:28.0),
                                                  child: Container(child: TextField(
                                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                    width: 150,
                                                    height: 40,
                                                    //color: Color(0xffDDDEEE),
                                                    decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                                  ),
                                                ),
                                              ]
                                              ,
                                            ),
                                            Row(
                                              children: [

                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left:18.0),
                                                      child: Text("Mother's Name ",style: GoogleFonts.poppins(fontSize: 15,)),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left:48.0),
                                                      child: Container(child: TextField(
                                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                                          border: InputBorder.none,
                                                        ),
                                                      ),
                                                        width: 150,
                                                        height: 40,
                                                        //color: Color(0xffDDDEEE),
                                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(right:48.0),
                                                          child: Text("Email",style: GoogleFonts.poppins(fontSize: 15,)),
                                                        ),

                                                        Padding(
                                                          padding: const EdgeInsets.only(left:48.0),
                                                          child: Container(child: TextField(
                                                            decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                                              border: InputBorder.none,
                                                            ),
                                                          ),
                                                            width: 150,
                                                            height: 40,
                                                           // color: Color(0xffDDDEEE),
                                                            decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(right:58.0),
                                                          child: Text("Phone",style: GoogleFonts.poppins(fontSize: 15,)),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:38.0),
                                                          child: Container(child: TextField(
                                                            decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                                              border: InputBorder.none,
                                                            ),
                                                          ),
                                                            width: 150,
                                                            height: 40,
                                                           // color: Color(0xffDDDEEE),
                                                            decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                  ],
                                                ),

                                              ],
                                            ),

                                          ],
                                        ),



                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left:20.0,top:20),
                                                  child: Text("Father's  Occupation",style: GoogleFonts.poppins(fontSize: 15,)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left:28.0,bottom:10,right:20),
                                                  child: Container(child: TextField(
                                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                    width: 150,
                                                    height: 40,
                                                   // color: Color(0xffDDDEEE),
                                                    decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                                  ),
                                                ),
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(right:40.0,top:8),
                                                      child: Text("Address *",style: GoogleFonts.poppins(fontSize: 15,)),
                                                    ),
                                                    
                                                    Padding(
                                                      padding: const EdgeInsets.only(left:28.0),
                                                      child: Container(child: TextField(
                                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                                          border: InputBorder.none,
                                                        ),
                                                      ),
                                                        width: 150,
                                                        height: 40,
                                                        //color: Color(0xffDDDEEE),
                                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top:8.0,right:22),
                                                      child: Text("Religion *",style: GoogleFonts.poppins(fontSize: 15,)),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left:48.0),
                                                      child: Container(child: TextField(style: TextStyle(fontSize: 10),
                                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,top: 13),
                                                          border: InputBorder.none,
                                                          hintText: "Please Select Religion",
                                                          suffixIcon: Icon(Icons.arrow_drop_down),


                                                        ),
                                                      ),
                                                        width: 150,
                                                        height: 40,
                                                       // color: Color(0xffDDDEEE),
                                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top:8.0,left:50,right:10),
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                //color: Color(0xffDDDEEE),
                                                decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(52)),

                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left:48.0),
                                                      child: Text("Upload Student Photo(150pxX150px",style: GoogleFonts.poppins(fontSize: 15),),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(child: Center(child: Text("choose file",style: GoogleFonts.poppins(fontSize: 16))),
                                                          width: 130,
                                                          height: 40,
                                                          // color: Color(0xffDDDEEE),
                                                          decoration: BoxDecoration(border: Border.all(color: Colors.black),color: Color(0xffDDDEEE)),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text("No file chosen",style: GoogleFonts.poppins(fontSize: 13),),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left:28.0,right:20),
                                                      child: Container(child: Center(child: Text("save ",style: GoogleFonts.poppins(color:Colors.white),)),
                                                        width: 130,
                                                        height: 40,
                                                        //color:Color(0xffD60A0B),
                                                        decoration: BoxDecoration(color: Color(0xffD60A0B),borderRadius: BorderRadius.circular(5)),

                                                      ),
                                                    ),
                                                    Container(child: Center(child: Text("Reset ",style: GoogleFonts.poppins(color:Colors.white),)),
                                                      width: 130,
                                                      height: 40,
                                                     // color:Color(0xff00A0E3),
                                                      decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),



                    ],
                  ),
                ),

                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
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
                            top: 68.0, right: 50, left: 30),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 53.0, bottom: 10),
                              child: Text("Vidhaan",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)),
                            ),
                            Column(
                              children: [
                                Text(
                                  "Your Learning Partner",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 33.0, top: 20,bottom:4),
                                      child: Text(
                                        "Lorem Ipsum is simply dummy text of the",
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Color(0xffFFFFFF)),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 53.0,bottom:4),
                                          child: Text(
                                            "printing and typesetting industry.Lorem Ipsum",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Color(0xffFFFFFF)),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 48.0,bottom:4),
                                              child: Text(
                                                "has been the industry's standard dummy text",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color(0xffFFFFFF)),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 68.0),
                                              child: Text(
                                                "ever since the 1500s,",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color(0xffFFFFFF)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 48.0, right: 40),
                        child: Container(
                          child: Image.asset(
                            "assets/img.png",
                            fit: BoxFit.cover,
                          ),
                          color: Color(0xff00A0E3),
                          width: 330,
                          height: 300,
                        ),
                      )
                    ],
                  ),
                  color: Color(0xff00A0E3),
                  width: 1500,
                  height: 350,
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
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 58.0, right: 90),
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
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 160,top: 20),
                                  child: Text("Sign in",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40)),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 40.0, left: 60),
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 28.0,
                                                        right: 20),
                                                    child: Image.asset(
                                                        "assets/google.png"),
                                                  ),
                                                  Text(
                                                    "Sign in with Google",
                                                    style: TextStyle(
                                                        color:
                                                        Color(0xff4285F4)),
                                                  ),
                                                ],
                                              ),
                                              // color: Color(0xffE9F1FF),
                                              height: 50,
                                              width: 240,
                                              decoration: BoxDecoration(
                                                  color: Color(0xffE9F1FF),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      12)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 38.0),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: Image.asset(
                                                        "assets/Group3.png"),
                                                    //color: Color(0xffF6F6F6),
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color:
                                                        Color(0xffF6F6F6),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(12)),
                                                  ),
                                                ),
                                                Container(
                                                  child: Image.asset(
                                                      "assets/Group4.png"),
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffF6F6F6),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top:15.0, right: 50,bottom: 10),
                                          child: Text(
                                            "Enter your username or email address",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),

                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 58.0),
                                              child: Container(
                                                // color: Colors.grey,
                                                height: 50,
                                                width: 350,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color:Colors.grey,),borderRadius: BorderRadius.circular(12)
                                                ),
                                                child: TextField(

                                                  decoration: InputDecoration(contentPadding:EdgeInsets.only(left:29),
                                                      border: InputBorder.none,
                                                      hintText:
                                                      "Username or email address"),
                                                ),
                                              ),
                                            ),

                                            Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 18.0,right: 150,bottom: 6),
                                                  child: Text("Enter your password",style: TextStyle(fontWeight: FontWeight.bold),),
                                                ),

                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 58.0),
                                                      child: Container(
                                                        //color: Colors.grey[50],
                                                        height: 50,
                                                        width: 350,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color:Colors.grey),borderRadius: BorderRadius.circular(12)
                                                        ),
                                                        child: TextField(
                                                          decoration: InputDecoration(contentPadding:EdgeInsets.only(left:29),
                                                              border: InputBorder.none,
                                                              hintText:
                                                              "password"),
                                                        ),
                                                      ),
                                                    ),


                                                    Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 298.0,top: 8),
                                                          child: Text("Forget password",style: TextStyle(color: Color(0xff4285F4)),),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 60.0,top: 18),
                                                          child: GestureDetector(onTap: () {
                                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dashboard(),));
                                                          },
                                                            child: Container(child: Center(child: Text("Sign in",style: TextStyle(color: Colors.white),)),
                                                              // color: Color(0xff00A0E3),
                                                              height: 50,
                                                              width: 350,
                                                              decoration: BoxDecoration( color: Color(0xff00A0E3),
                                                                  borderRadius: BorderRadius.circular(12)
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 258.0,top:10),
                          child: Container(
                            child: Image.asset("assets/vidh.png"),
                            color: Colors.white,
                            height: 150,
                            width: 140,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // color: Colors.white,
                width: 470,
                height: 570,
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

