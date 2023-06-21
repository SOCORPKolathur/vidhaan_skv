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
          apiKey: "AIzaSyB1o7D8smMCkCIQMYygxf4VkUx4JpNdl84",
          authDomain: "vidhaan-4aee7.firebaseapp.com",
          projectId: "vidhaan-4aee7",
          storageBucket: "vidhaan-4aee7.appspot.com",
          messagingSenderId: "520373612125",
          appId: "1:520373612125:web:69e23416a1f0f51747e7b4",
          measurementId: "G-C4334JYZV6"
      ));
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: Color(0xff00A0E3),
        ),
      ),
      debugShowCheckedModeBanner: false,
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
                              height: 20,
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

                            Padding(
                              padding: const EdgeInsets.only(top: 18.0,right: 0,bottom: 6,left:60),
                              child: Text("Enter your password",style: TextStyle(fontWeight: FontWeight.bold),),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 60.0),
                              child: Container(
                                //color: Colors.grey[50],
                                height: 50,
                                width: 350,
                                decoration: BoxDecoration(
                                    border: Border.all(color:Colors.grey),borderRadius: BorderRadius.circular(12)
                                ),
                                child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(contentPadding:EdgeInsets.only(left:29),
                                      border: InputBorder.none,
                                      hintText:
                                      "password"),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 20,
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

