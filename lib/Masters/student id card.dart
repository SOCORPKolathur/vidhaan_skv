import 'dart:convert';
import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:screenshot/screenshot.dart';

class StudentID extends StatefulWidget {
  const StudentID({Key? key}) : super(key: key);

  @override
  State<StudentID> createState() => _StudentIDState();
}

class _StudentIDState extends State<StudentID> {
  bool view=false;
  String studentid="xpp6E6zMjHmlrEws7DC0";
  int gtcount= 36;
  String? _selectedCity;
  final TextEditingController _typeAheadControllerregno = TextEditingController();
  final TextEditingController _typeAheadControllerstudent = TextEditingController();
  final TextEditingController _typeAheadControllerclass = TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  final TextEditingController _typeAheadControllersection = TextEditingController();
  static final List<String> regno = [];
  static final List<String> student = [];
  static final List<String> section = [];


  static List<String> getSuggestionsregno(String query) {
    List<String> matches = <String>[];
    matches.addAll(regno);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionsstudent(String query) {
    List<String> matches = <String>[];
    matches.addAll(student);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static final List<String> classes = [];

  static List<String> getSuggestionsclass(String query) {
    List<String> matches = <String>[];
    matches.addAll(classes);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionssection(String query) {
    List<String> matches = <String>[];
    matches.addAll(section);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  adddropdownvalue() async {
    setState(() {
      regno.clear();
      student.clear();
      classes.clear();
      section.clear();
    });
    var document = await  FirebaseFirestore.instance.collection("Students").orderBy("timestamp").get();
    var document2 = await  FirebaseFirestore.instance.collection("Students").orderBy("stname").get();
    for(int i=0;i<document.docs.length;i++) {
      setState(() {
        regno.add(document.docs[i]["regno"]);
      });

    }
    for(int i=0;i<document2.docs.length;i++) {
      setState(() {
        student.add(document2.docs[i]["stname"]);
      });

    }
    setState(() {
      classes.add("Select Option");
      section.add("Select Option");
    });
    var document3 = await  FirebaseFirestore.instance.collection("ClassMaster").orderBy("order").get();
    for(int i=0;i<document3.docs.length;i++) {
      setState(() {
        classes.add(document3.docs[i]["name"]);
      });

    }
    var document4 = await  FirebaseFirestore.instance.collection("SectionMaster").orderBy("order").get();
    for(int i=0;i<document4.docs.length;i++) {
      setState(() {
        section.add(document4.docs[i]["name"]);
      });

    }

  }

  getstaffbyid() async {
    print("fdgggggggggg");
    print(_typeAheadControllerregno.text);
    var document = await FirebaseFirestore.instance.collection("Students").get();
    for(int i=0;i<document.docs.length;i++){
      if(_typeAheadControllerregno.text==document.docs[i]["regno"]){
        setState(() {
          studentid= document.docs[i].id;
        }
        );
      }
    }
    print("fdgggggggggg");


  }
  getstaffbyid2() async {
    print("fdgggggggggg");
    print(_typeAheadControllerregno.text);
    var document = await FirebaseFirestore.instance.collection("Students").get();
    for(int i=0;i<document.docs.length;i++){
      if(_typeAheadControllerstudent.text==document.docs[i]["stname"]){
        setState(() {
          _typeAheadControllerregno.text= document.docs[i]["regno"];
        }
        );
      }
    }
    print("fdgggggggggg");


  }
  getstaffbyid2a() async {
    print("fdgggggggggg");
    print(_typeAheadControllerregno.text);
    var document = await FirebaseFirestore.instance.collection("Students").get();
    for(int i=0;i<document.docs.length;i++){
      if(_typeAheadControllerregno.text==document.docs[i]["regno"]){
        setState(() {
          _typeAheadControllerstudent.text= document.docs[i]["stname"];
        }
        );
      }
    }
    print("fdgggggggggg");


  }
  @override
  void initState() {
    adddropdownvalue();
    getadmin();
    setState(() {
      _typeAheadControllerclass.text="Select Option";
      _typeAheadControllersection.text="Select Option";
    });
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
  final screenshotController = List<ScreenshotController>.generate(1000, (int index) => ScreenshotController(), growable: true);
int j=0;
  Future<void> _downloadImage() async {
    var document = await FirebaseFirestore.instance.collection("Students").orderBy("timestamp").get();
    for(int i=0;i<document.docs.length;i++){
      setState(() {
        expand[i]=true;
      });
    }
    await  Future.delayed(Duration(seconds: 20),() async {
      for(int i=0;i<document.docs.length;i++) {
        await  Future.delayed(Duration(seconds: 10),(){
          print("Scren Shoot Started");
        screenshotController[i]
            .capture(delay: Duration(seconds: 5))
            .then((capturedImage) async {
          await  Future.delayed(Duration(seconds: 15),() async {
          await WebImageDownloader.downloadImageFromUInt8List(
              uInt8List: capturedImage!, name: "ID CARD F${i.toString()}");
          setState(() {

          });
          print(i);
          });
        }).catchError((onError) {
          print(onError);
        });

      });
      }
    });


  }
  
  bool search= false;
  bool byclass = false;

  bool viewtem = false;

  bool mainconcent= false;
  final check = List<bool>.generate(1000, (int index) => false, growable: true);
  final expand = List<bool>.generate(1000, (int index) => false, growable: true);
// create some values
  Color pickerColor = Color(0xff00A0E3);
  Color currentColor = Color(0xff00A0E3);

  Color pickerColor2 = Color(0xff90C01F);
  Color currentColor2 = Color(0xff90C01F);

  Color pickerColor3 = Color(0xffD62F5E);
  Color currentColor3 = Color(0xffD62F5E);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }
  void changeColor2(Color color) {
    setState(() => pickerColor2 = color);
  }
  void changeColor3(Color color) {
    setState(() => pickerColor3 = color);
  }

  GlobalKey _globalKey = new GlobalKey();


  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: viewtem ==false? Scaffold(

        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(width: width/1.050,

                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),child: Padding(
                  padding: const EdgeInsets.only(left: 10.0,top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Generate Student ID Cards",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(width: 280,),
                          Padding(
                            padding: const EdgeInsets.only(right:8.0),
                            child: Icon(Icons.filter_list_sharp),
                          ),
                          Text("Filters",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(width: 10,),
                          InkWell(
                            onTap: (){
                              setState(() {
                                byclass=false;
                                search=false;
                              });
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(5),
                              elevation: 7,
                              child: Container(child: Center(child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(Icons.cancel,color: Colors.white,),
                                  ),
                                  Text("Clear Filter",style: GoogleFonts.poppins(color:Colors.white),),
                                ],
                              )),
                                width: width/10.507,
                                height: height/20.425,
                                // color:Color(0xff00A0E3),
                                decoration: BoxDecoration(color:  Colors.red,borderRadius: BorderRadius.circular(5)),

                              ),
                            ),
                          ),


                          SizedBox(width: 60,),
                          InkWell(
                            onTap: (){
                              // getstaffbyid();
                              setState(() {
                                viewtem=true;
                              });
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(5),
                              elevation: 7,
                              child: Container(child: Center(child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(Icons.image_aspect_ratio,color: Colors.white,),
                                  ),
                                  Text("View Templates",style: GoogleFonts.poppins(color:Colors.white),),
                                ],
                              )),
                                width: width/8.507,
                                height: height/16.425,
                                // color:Color(0xff00A0E3),
                                decoration: BoxDecoration(color: const Color(0xff53B175),borderRadius: BorderRadius.circular(5)),

                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 00,top:20,bottom: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(right:0.0),
                                  child: Text("Register Number",style: GoogleFonts.poppins(fontSize: 15,)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0,right: 25),
                                  child: Container(child:
                                  TypeAheadFormField(


                                    suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                                        color: Color(0xffDDDEEE),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        )
                                    ),

                                    textFieldConfiguration: TextFieldConfiguration(
                                      style:  GoogleFonts.poppins(
                                          fontSize: 15
                                      ),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                        border: InputBorder.none,
                                      ),
                                      controller: this._typeAheadControllerregno,
                                    ),
                                    suggestionsCallback: (pattern) {
                                      return getSuggestionsregno(pattern);
                                    },
                                    itemBuilder: (context, String suggestion) {
                                      return ListTile(
                                        title: Text(suggestion),
                                      );
                                    },

                                    transitionBuilder: (context, suggestionsBox, controller) {
                                      return suggestionsBox;
                                    },
                                    onSuggestionSelected: (String suggestion) {
                                      setState(() {
                                        this._typeAheadControllerregno.text = suggestion;
                                      });
                                      getstaffbyid2a();
                                      // getstaffbyid();
                                      // getorderno();



                                    },
                                    suggestionsBoxController: suggestionBoxController,
                                    validator: (value) =>
                                    value!.isEmpty ? 'Please select a class' : null,
                                    onSaved: (value) => this._selectedCity = value,
                                  ),
                                    width: width/8.902,
                                    height: height/16.425,
                                    //color: Color(0xffDDDEEE),
                                    decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                  ),
                                ),

                              ],

                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right:0.0),
                                  child: Text("Student Name",style: GoogleFonts.poppins(fontSize: 15,)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0,right: 10),
                                  child: Container(
                                    width: width/6.902,
                                    height: height/16.425,
                                    //color: Color(0xffDDDEEE),
                                    decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                    child:
                                    TypeAheadFormField(


                                      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                                          color: Color(0xffDDDEEE),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          )
                                      ),

                                      textFieldConfiguration: TextFieldConfiguration(
                                        style:  GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,
                                        ),
                                        controller: this._typeAheadControllerstudent,
                                      ),
                                      suggestionsCallback: (pattern) {
                                        return getSuggestionsstudent(pattern);
                                      },
                                      itemBuilder: (context, String suggestion) {
                                        return ListTile(
                                          title: Text(suggestion),
                                        );
                                      },

                                      transitionBuilder: (context, suggestionsBox, controller) {
                                        return suggestionsBox;
                                      },
                                      onSuggestionSelected: (String suggestion) {
                                        setState(() {
                                          this._typeAheadControllerstudent.text = suggestion;
                                        });

                                        getstaffbyid2();




                                      },
                                      suggestionsBoxController: suggestionBoxController,
                                      validator: (value) =>
                                      value!.isEmpty ? 'Please select a class' : null,
                                      onSaved: (value) => this._selectedCity = value,
                                    ),

                                  ),
                                ),

                              ],

                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  search=true;
                                });
                                getstaffbyid();
                              },
                              child: Container(child: Center(child: Text("Search",style: GoogleFonts.poppins(color:Colors.white),)),
                                width: width/10.507,
                                height: height/16.425,
                                // color:Color(0xff00A0E3),
                                decoration: BoxDecoration(color: const Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                              ),
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right:0.0),
                                  child: Text("By Class",style: GoogleFonts.poppins(fontSize: 15,)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0,right: 25),
                                  child: Container(child:

                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint:  Row(
                                        children: [
                                          Icon(
                                            Icons.list,
                                            size: 16,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Select Option',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: classes
                                          .map((String item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style:  GoogleFonts.poppins(
                                              fontSize: 15
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value:  _typeAheadControllerclass.text,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _typeAheadControllerclass.text = value!;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 50,
                                        width: 160,
                                        padding: const EdgeInsets.only(left: 14, right: 14),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),

                                          color: Color(0xffDDDEEE),
                                        ),

                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                        ),
                                        iconSize: 14,
                                        iconEnabledColor: Colors.black,
                                        iconDisabledColor: Colors.grey,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200,
                                        width: width/5.464,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
                                          color: Color(0xffDDDEEE),
                                        ),

                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(7),
                                          thickness: MaterialStateProperty.all<double>(6),
                                          thumbVisibility: MaterialStateProperty.all<bool>(true),
                                        ),
                                      ),
                                      menuItemStyleData: const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(left: 14, right: 14),
                                      ),
                                    ),
                                  ),
                                    width: width/6.902,
                                    height: height/16.42,
                                    //color: Color(0xffDDDEEE),
                                    decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                  ),
                                ),

                              ],

                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right:0.0),
                                  child: Text("By Section",style: GoogleFonts.poppins(fontSize: 15,)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0,right: 10),
                                  child: Container(child:   DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint:  Row(
                                        children: [
                                          Icon(
                                            Icons.list,
                                            size: 16,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Select Option',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: section
                                          .map((String item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style:  GoogleFonts.poppins(
                                              fontSize: 15
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value:  _typeAheadControllersection.text,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _typeAheadControllersection.text = value!;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 50,
                                        width: 160,
                                        padding: const EdgeInsets.only(left: 14, right: 14),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),

                                          color: Color(0xffDDDEEE),
                                        ),

                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                        ),
                                        iconSize: 14,
                                        iconEnabledColor: Colors.black,
                                        iconDisabledColor: Colors.grey,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200,
                                        width: width/5.464,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
                                          color: Color(0xffDDDEEE),
                                        ),

                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(7),
                                          thickness: MaterialStateProperty.all<double>(6),
                                          thumbVisibility: MaterialStateProperty.all<bool>(true),
                                        ),
                                      ),
                                      menuItemStyleData: const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(left: 14, right: 14),
                                      ),
                                    ),
                                  ),
                                    width: width/6.902,
                                    height: height/16.42,
                                    //color: Color(0xffDDDEEE),
                                    decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                  ),
                                ),

                              ],

                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  byclass=true;
                                });

                                getstaffbyid();
                              },
                              child: Container(child: Center(child: Text("By Class",style: GoogleFonts.poppins(color:Colors.white),)),
                                width: width/10.507,
                                height: height/16.425,
                                // color:Color(0xff00A0E3),
                                decoration: BoxDecoration(color: const Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0,top: 20),
                child: Container(
                  width:  width/1.050,

                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                  child:  Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height:height/13.14,
                          width: width/1.366,
                          decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Checkbox(
                                    checkColor: Colors.white,
                                    value: mainconcent,
                                    onChanged: (value){
                                      setState(() {
                                        mainconcent = value!;
                                        for(int i=0;i<1000;i++) {
                                          check[i] = value!;
                                        }

                                      });

                                    }
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 35.0, right: 40),
                                child: Text(
                                  "Reg NO",
                                  style:
                                  GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ),
                              Text(
                                "Student Name",
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 40.0, right: 40,),
                                child: Text(
                                  "Class",
                                  style:
                                  GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ),
                              Text(
                                "Section",
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 40.0, right: 45),
                                child: Text(
                                  "Parent name",
                                  style:
                                  GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ),
                              Text(
                                "Phone Number",
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 55.0, right: 62),
                                child: Text(
                                  "Gender",
                                  style:
                                  GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ),
                              Text(
                                "Actions",
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                            ],
                          ),
                          //color: Colors.pink,


                        ),
                      ),

                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection("Students").orderBy("timestamp").snapshots(),

                          builder: (context,snapshot){
                            if(!snapshot.hasData)
                            {
                              return   Center(
                                child:  CircularProgressIndicator(),
                              );}
                            if(snapshot.hasData==null)
                            {
                              return   Center(
                                child:  CircularProgressIndicator(),
                              );}
                            return ListView.builder(

                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context,index){
                                  var value = snapshot.data!.docs[index];
                                  return  search==true? value.id==studentid? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AnimatedContainer(
                                      duration: Duration(seconds: 1),
                                      width: width/1.366,
                                      height: expand[index]==false?50:500,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10.0),
                                                child: Checkbox(

                                                    value: check[index],

                                                    onChanged: (bool? value){
                                                      print(value);
                                                      setState(() {
                                                        check[index] = value!;
                                                      });

                                                    }
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10.0, right: 0),
                                                child: Container(
                                                  width: width/13.66,

                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    value["regno"],
                                                    style:
                                                    GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 30.0),
                                                child: Container(
                                                  width: width/9.757,


                                                  child: Text(
                                                    value["stname"],
                                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0.0, right: 0),
                                                child: Container(
                                                  width: width/22.766,

                                                  child: Text(
                                                    value["admitclass"],
                                                    style:
                                                    GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 13.0),
                                                child: Container(
                                                  width:width/22.766,

                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    value["section"],
                                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 50, right: 0),
                                                child: Container(
                                                  width: width/10.507,

                                                  child: Text(
                                                    value["fathername"],
                                                    style:
                                                    GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left:7.0),
                                                child: Container(
                                                  width: width/9.7571,

                                                  child: Text(
                                                    value["mobile"],
                                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500,color:Colors.indigoAccent),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 3.0, right: 0),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: width/17.075,

                                                  child: Row(
                                                    children: [
                                                      value["gender"]=="Male"?  Padding(
                                                        padding: const EdgeInsets.only(right: 6.0),
                                                        child: Icon(Icons.male_rounded,size: 20,),
                                                      ):Padding(
                                                        padding: const EdgeInsets.only(right: 6.0),
                                                        child: Icon(Icons.female_rounded,size: 20,),
                                                      ),
                                                      Text(
                                                        value["gender"],
                                                        style:
                                                        GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  if(expand[index]==true) {
                                                    setState(() {
                                                      expand[index] = false;
                                                    });
                                                  }else{
                                                    setState(() {
                                                      expand[index] = true;
                                                    });
                                                  }
                                                },
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.only(left: 45.0),
                                                  child: expand[index]==false? Container(
                                                    width: width/22.76,
                                                    height: height/21.9,
                                                    //color: Color(0xffD60A0B),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      color: Color(0xff53B175),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                          "View",
                                                          style: GoogleFonts.poppins(
                                                              color: Colors.white),
                                                        )),
                                                  ) :
                                                  Container(
                                                    width: width/22.76,
                                                    height: height/21.9,
                                                    //color: Color(0xffD60A0B),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      color: Colors.red,
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                          "Close",
                                                          style: GoogleFonts.poppins(
                                                              color: Colors.white),
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          expand[index]!=false? idcarddesign=="1"? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Material(

                                                  child: Container(
                                                    width: 260,
                                                    height: 410,

                                                    child: Stack(
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Image.asset("assets/idbg4.png",color: pickerColor,),
                                                            Image.asset("assets/idbg6.png",color: pickerColor,),

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
                                                                      color: pickerColor,
                                                                      borderRadius: BorderRadius.circular(60)
                                                                  ),


                                                                ),
                                                                Container(
                                                                  width: 112,
                                                                  height: 112,
                                                                  decoration: BoxDecoration(
                                  color:Colors.white,
                                                                      borderRadius: BorderRadius.circular(50)
                                                                  ),
                                                                  child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(60),
                                                                      child: Image.network(value!['imgurl']==""?"https://firebasestorage.googleapis.com/v0/b/vidhaan-4aee7.appspot.com/o/360_F_270188580_YDUEwBmDIxBMvCQxkcunmEkm93VqOgqm.jpg?alt=media&token=fe18ba43-4a31-4b53-9523-42bb4241d9a1"
                                        :value['imgurl'],),),
                                                                ),

                                                              ],
                                                            ),
                                                            SizedBox(height: 15,),
                                                            Text(value["stname"],style: GoogleFonts.poppins(
                                                                color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                                            Text("ID: ${value["regno"]}",style: GoogleFonts.poppins(
                                                                color:  pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                            SizedBox(height: 10,),
                                                            Row(
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Text("Class       : ",style: GoogleFonts.poppins(
                                                                    color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                Text("${value["admitclass"]} ${value["section"]}",style: GoogleFonts.poppins(
                                                                    color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Text("DOB          : ",style: GoogleFonts.poppins(

                                                                    color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                Text(value["dob"].toString().substring(0,10),style: GoogleFonts.poppins(
                                                                    color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Text("Blood Group       : ",style: GoogleFonts.poppins(
                                                                    color:pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                Text(value["bloodgroup"],style: GoogleFonts.poppins(
                                                                    color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Text("Emergency Contact No    : ",style: GoogleFonts.poppins(
                                                                    color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                Text(value["mobile"],style: GoogleFonts.poppins(
                                                                    color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ],
                                                            ),

                                                          ],
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 50,),
                                                Container(
                                                  width: 260,
                                                  height: 410,
                                                  child: Stack(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Image.asset("assets/idbg7.png",color: pickerColor,),
                                                          Image.asset("assets/idbg6.png",color: pickerColor,),

                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,

                                                        children: [
                                                          SizedBox(height: 20,),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 25.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                    width:60,
                                                                    height:60, decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(30),
                                                                    color:Colors.white
                                                                ),
                                                                    child: Image.network(schoollogo)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 70,),

                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 20.0),
                                                            child: Text("Emergency Contact",style: GoogleFonts.poppins(
                                                                color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                                          ),
                                                          Text("",style: GoogleFonts.poppins(
                                                              color: Color(0xff0271C5), fontSize: 12,fontWeight: FontWeight.w600),),
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            children: [
                                                              SizedBox(width: 20,),
                                                              Container(
                                                                width: 110,
                                                                child: Text("Emergency Contact No : ",style: GoogleFonts.poppins(
                                                                    color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ),
                                                              Text(value["fatherMobile"],style: GoogleFonts.poppins(
                                                                  color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(width: 20,),
                                                              Container(
                                                                width: 110,
                                                                child: Text("Address : ",style: GoogleFonts.poppins(

                                                                    color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ),
                                                              Container(
                                                                width:100,
                                                                child: Text(value["address"],style: GoogleFonts.poppins(
                                                                    color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ),
                                                            ],
                                                          ),

                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 0.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    SizedBox(height:5),
                                                                    Container(
                                                                        width: 75,
                                                                        height: 75,
                                                                        child: Image.asset("assets/VIDHAANLOGO.png",fit: BoxFit.contain,)),

                                                                    Text("e    d    u    c    a    r    e",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: 7),),
                                                                    SizedBox(height:7),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          )

                                                        ],
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ) :

                                          idcarddesign=="2"?
                                          Row(
                                            children: [

                                            Material(

                                              child: Container(
                                                width: 260,
                                                height: 410,

                                                child: Stack(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Image.asset("assets/id2bg7.png",color: pickerColor2,),


                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,

                                                      children: [

                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(width:10),
                                                            Column(
                                                              children: [
                                                                SizedBox(height:15),
                                                                Container(
                                                                    width:50,
                                                                    height:50, decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(25),
                                                                    color:Colors.white
                                                                ),
                                                                    child: Image.network(schoollogo)),
                                                              ],
                                                            ),
                                                            SizedBox(width:10),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(height:7),
                                                                Container(
                                                                  width:180,
                                                                  child: Text(schoolname,style: GoogleFonts.poppins(
                                                                      color: Colors.white, fontSize: 14,fontWeight: FontWeight.w600),),
                                                                ),
                                                                Text("Phone: +91 ${schoolphone}",style: GoogleFonts.poppins(
                                                                    color: Colors.white, fontSize: 8,fontWeight: FontWeight.w400),),
                                                                Text(schooladdress,style: GoogleFonts.poppins(
                                                                    color: Colors.white, fontSize: 8,fontWeight: FontWeight.w400),),
                                                              ],
                                                            ),
                                                          ],
                                                        ),



                                                        SizedBox(height: 40,),
                                                        Stack(
                                                          alignment: Alignment.center,
                                                          children: [
                                                            Container(
                                                              width: 120,
                                                              height: 120,
                                                              decoration: BoxDecoration(
                                                                  color: pickerColor2,
                                                                  borderRadius: BorderRadius.circular(12)
                                                              ),


                                                            ),
                                                            Container(
                                                              width: 115,
                                                              height: 115,
                                                              decoration: BoxDecoration(
                                                                      color:Colors.white,
                                                                  borderRadius: BorderRadius.circular(12)
                                                              ),
                                                              child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(12),
                                                                  child: Image.network(value!['imgurl']==""?"https://firebasestorage.googleapis.com/v0/b/vidhaan-4aee7.appspot.com/o/360_F_270188580_YDUEwBmDIxBMvCQxkcunmEkm93VqOgqm.jpg?alt=media&token=fe18ba43-4a31-4b53-9523-42bb4241d9a1"
                                        :value['imgurl'],),),
                                                            ),

                                                          ],
                                                        ),
                                                        SizedBox(height: 15,),
                                                        Text(value["stname"],style: GoogleFonts.poppins(
                                                            color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                                        Text("ID: ${value["regno"]}",style: GoogleFonts.poppins(
                                                            color:  pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                        SizedBox(height: 10,),
                                                        Stack(

                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(width:50),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,

                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("Class       : ",style: GoogleFonts.poppins(
                                                                            color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text("${value["admitclass"]} ${value["section"]}",style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("DOB          : ",style: GoogleFonts.poppins(

                                                                            color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text(value["dob"],style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("Blood Group       : ",style: GoogleFonts.poppins(
                                                                            color:pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text(value["bloodgroup"],style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("Phone No    : ",style: GoogleFonts.poppins(
                                                                            color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text(value["mobile"],style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:  EdgeInsets.only(top:50.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      Container(
                                                                          width:37,


                                                                          child: Image.asset("assets/sign.png")),
                                                                      Text("Principle",style: GoogleFonts.poppins(
                                                                          color: Colors.black, fontSize: 10,fontWeight: FontWeight.w700),),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),




                                                      ],
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 50,),
                                            Container(
                                              width: 260,
                                              height: 410,
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [

                                                      Image.asset("assets/id2bg2.png",color: pickerColor2,),

                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,

                                                    children: [
                                                      SizedBox(height: 20,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 10.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                                width:60,
                                                                height:60,
                                                                child: Image.network(schoollogo)),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 10.0),
                                                        child: Text(schoolname,style: GoogleFonts.poppins(
                                                            color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 10.0),
                                                        child: Text(solgan,style: GoogleFonts.poppins(
                                                            color: pickerColor2, fontSize: 8,fontWeight: FontWeight.w400),),
                                                      ),
                                                      SizedBox(height: 40,),

                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 20.0),
                                                        child: Text("",style: GoogleFonts.poppins(
                                                            color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                                      ),
                                                      Text("",style: GoogleFonts.poppins(
                                                          color: Color(0xff0271C5), fontSize: 12,fontWeight: FontWeight.w600),),
                                                      SizedBox(height: 10,),
                                                      Row(
                                                        children: [
                                                          SizedBox(width: 20,),
                                                          Container(
                                                            width: 110,
                                                            child: Text("Emergency Contact No : ",style: GoogleFonts.poppins(
                                                                color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                          ),
                                                          Text(value["fatherMobile"],style: GoogleFonts.poppins(
                                                              color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                        ],
                                                      ),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          SizedBox(width: 20,),
                                                          Container(
                                                            width: 110,
                                                            child: Text("Address : ",style: GoogleFonts.poppins(

                                                                color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                          ),
                                                          Container(
                                                            width:120,
                                                            child: Text(value["address"],style: GoogleFonts.poppins(
                                                                color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                          ),
                                                        ],
                                                      ),

                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 20.0),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                    width: 75,
                                                                    height: 75,
                                                                    child: Image.asset("assets/VIDHAANLOGO.png",fit: BoxFit.contain,)),
                                                                Text("e    d    u    c    a    r    e",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: 7),),


                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )

                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ],)   :
                                          Row(
                                            children: [
                                              Material(

                                                child: Container(
                                                  width: 410,
                                                  height: 260,

                                                  child: Stack(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Image.asset("assets/id3bg1.png",color: pickerColor3,),
                                                          Image.asset("assets/id3bg2.png",color: pickerColor3,),


                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,

                                                        children: [
                                                          SizedBox(height: 7,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              SizedBox(width:30),
                                                              Container(
                                                                  width:60,
                                                                  height:60,
                                                                  child: Image.network(schoollogo)),
                                                              SizedBox(width:5),
                                                              Column(
                                                                crossAxisAlignment:CrossAxisAlignment.start,
                                                                children: [
                                                                  Container(
                                                                    width:250,
                                                                    child: Text(schoolname,style: GoogleFonts.poppins(
                                                                        color: pickerColor3, fontSize: 15,fontWeight: FontWeight.w600),),
                                                                  ),
                                                                  Text("Phone: +91 ${schoolphone}",style: GoogleFonts.poppins(
                                                                      color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),
                                                                  Text(schooladdress,style: GoogleFonts.poppins(
                                                                      color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),
                                                                  Text(schoolweb,style: GoogleFonts.poppins(
                                                                      color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),


                                                                ],
                                                              ),

                                                            ],
                                                          ),
                                                          SizedBox(height: 0,),

                                                          Row(
                                                            children: [
                                                              SizedBox(width:10),
                                                              Stack(
                                                                alignment: Alignment.center,
                                                                children: [
                                                                  Container(
                                                                    width: 120,
                                                                    height: 120,
                                                                    decoration: BoxDecoration(
                                                                        color: pickerColor3,
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
                                                                        child: Image.network(value!['imgurl']==""?"https://firebasestorage.googleapis.com/v0/b/vidhaan-4aee7.appspot.com/o/360_F_270188580_YDUEwBmDIxBMvCQxkcunmEkm93VqOgqm.jpg?alt=media&token=fe18ba43-4a31-4b53-9523-42bb4241d9a1"
                                        :value['imgurl'],fit:BoxFit.cover),),
                                                                  ),

                                                                ],
                                                              ),
                                                              Column(
                                                                  crossAxisAlignment:CrossAxisAlignment.start,
                                                                  children:[
                                                                    SizedBox(height: 5,),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(left:15.0),
                                                                      child: Text(value["stname"],style: GoogleFonts.poppins(
                                                                          color: pickerColor3, fontSize: 15,fontWeight: FontWeight.w700),),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(left:15.0),
                                                                      child: Text("ID: ${value["regno"]}",style: GoogleFonts.poppins(
                                                                          color:  pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                    ),
                                                                    SizedBox(height: 10,),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("Class       : ",style: GoogleFonts.poppins(
                                                                            color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text("${value["admitclass"]} ${value["section"]}",style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("DOB          : ",style: GoogleFonts.poppins(

                                                                            color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text(value["dob"],style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("Blood Group       : ",style: GoogleFonts.poppins(
                                                                            color:pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text(value["bloodgroup"],style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("Phone No    : ",style: GoogleFonts.poppins(
                                                                            color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text(value["mobile"],style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                  ]
                                                              )
                                                            ],
                                                          ),


                                                        ],
                                                      ),


                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 30,),
                                              Material(

                                                child: Container(
                                                  width: 410,
                                                  height: 260,

                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 100.0,left:250),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                SizedBox(height:5),
                                                                Opacity(
                                                                  opacity:0.39,
                                                                  child: Container(
                                                                      width: 75,
                                                                      height: 75,
                                                                      child: Image.asset("assets/VIDHAANLOGO.png",fit: BoxFit.contain,)),
                                                                ),

                                                                Opacity(
                                                                    opacity:0.39,
                                                                    child: Text("e    d    u    c    a    r    e",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: 7),)),
                                                                SizedBox(height:7),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Image.asset("assets/id3bg3.png",color: pickerColor3,),
                                                          Image.asset("assets/id3bg2.png",color: pickerColor3,),


                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top:30.0),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                SizedBox(width:15),
                                                                Container(
                                                                    width:60,
                                                                    height:60,
                                                                    child: Image.network(schoollogo)),
                                                                SizedBox(width:0),
                                                                Column(
                                                                  crossAxisAlignment:CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(schoolname,style: GoogleFonts.poppins(
                                                                        color: pickerColor3, fontSize: 15,fontWeight: FontWeight.w600),),
                                                                    Text("Phone: +91 ${schoolphone}",style: GoogleFonts.poppins(
                                                                        color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),
                                                                    Text(schooladdress,style: GoogleFonts.poppins(
                                                                        color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),
                                                                    Text(schoolweb,style: GoogleFonts.poppins(
                                                                        color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),


                                                                  ],
                                                                ),

                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 20.0,top:20),
                                                                  child: Text("",style: GoogleFonts.poppins(
                                                                      color:  pickerColor3, fontSize: 15,fontWeight: FontWeight.w700),),
                                                                ),
                                                              ],
                                                            ),

                                                            SizedBox(height: 5,),
                                                            Row(
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Container(
                                                                  width: 110,
                                                                  child: Text("Emergency Contact No : ",style: GoogleFonts.poppins(
                                                                      color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                ),
                                                                Text(value["fatherMobile"],style: GoogleFonts.poppins(
                                                                    color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ],
                                                            ),
                                                            Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Container(
                                                                  width: 110,
                                                                  child: Text("Address : ",style: GoogleFonts.poppins(

                                                                      color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                ),
                                                                Text(value["address"],style: GoogleFonts.poppins(
                                                                    color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ],
                                                            ),


                                                          ],
                                                        ),
                                                      ),




                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ): Container(),
                                        ],
                                      ),



                                    ),
                                  ) : Container(): byclass==true?
                                  "${value["admitclass"]}${value["section"]}"=="${_typeAheadControllerclass.text}${_typeAheadControllersection.text}"?
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AnimatedContainer(
                                      duration: Duration(seconds: 1),
                                      width: width/1.366,
                                      height: expand[index]==false?50:500,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10.0),
                                                child: Checkbox(

                                                    value: check[index],

                                                    onChanged: (bool? value){
                                                      print(value);
                                                      setState(() {
                                                        check[index] = value!;
                                                      });

                                                    }
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10.0, right: 0),
                                                child: Container(
                                                  width: width/13.66,

                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    value["regno"],
                                                    style:
                                                    GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 30.0),
                                                child: Container(
                                                  width: width/9.757,


                                                  child: Text(
                                                    value["stname"],
                                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0.0, right: 0),
                                                child: Container(
                                                  width: width/22.766,

                                                  child: Text(
                                                    value["admitclass"],
                                                    style:
                                                    GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 13.0),
                                                child: Container(
                                                  width:width/22.766,

                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    value["section"],
                                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 50, right: 0),
                                                child: Container(
                                                  width: width/10.507,

                                                  child: Text(
                                                    value["fathername"],
                                                    style:
                                                    GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left:7.0),
                                                child: Container(
                                                  width: width/9.7571,

                                                  child: Text(
                                                    value["mobile"],
                                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500,color:Colors.indigoAccent),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 3.0, right: 0),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: width/17.075,

                                                  child: Row(
                                                    children: [
                                                      value["gender"]=="Male"?  Padding(
                                                        padding: const EdgeInsets.only(right: 6.0),
                                                        child: Icon(Icons.male_rounded,size: 20,),
                                                      ):Padding(
                                                        padding: const EdgeInsets.only(right: 6.0),
                                                        child: Icon(Icons.female_rounded,size: 20,),
                                                      ),
                                                      Text(
                                                        value["gender"],
                                                        style:
                                                        GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  if(expand[index]==true) {
                                                    setState(() {
                                                      expand[index] = false;
                                                    });
                                                  }else{
                                                    setState(() {
                                                      expand[index] = true;
                                                    });
                                                  }
                                                },
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.only(left: 45.0),
                                                  child: expand[index]==false? Container(
                                                    width: width/22.76,
                                                    height: height/21.9,
                                                    //color: Color(0xffD60A0B),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      color: Color(0xff53B175),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                          "View",
                                                          style: GoogleFonts.poppins(
                                                              color: Colors.white),
                                                        )),
                                                  ) :
                                                  Container(
                                                    width: width/22.76,
                                                    height: height/21.9,
                                                    //color: Color(0xffD60A0B),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      color: Colors.red,
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                          "Close",
                                                          style: GoogleFonts.poppins(
                                                              color: Colors.white),
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          expand[index]!=false? idcarddesign=="1"? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Material(

                                                  child: Container(
                                                    width: 260,
                                                    height: 410,

                                                    child: Stack(
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Image.asset("assets/idbg4.png",color: pickerColor,),
                                                            Image.asset("assets/idbg6.png",color: pickerColor,),

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
                                                                      color: pickerColor,
                                                                      borderRadius: BorderRadius.circular(60)
                                                                  ),


                                                                ),
                                                                Container(
                                                                  width: 112,
                                                                  height: 112,
                                                                  decoration: BoxDecoration(
                                                                          color:Colors.white,
                                                                      borderRadius: BorderRadius.circular(50)
                                                                  ),
                                                                  child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(60),
                                                                      child: Image.network(value!['imgurl']==""?"https://firebasestorage.googleapis.com/v0/b/vidhaan-4aee7.appspot.com/o/360_F_270188580_YDUEwBmDIxBMvCQxkcunmEkm93VqOgqm.jpg?alt=media&token=fe18ba43-4a31-4b53-9523-42bb4241d9a1"
                                        :value['imgurl']),),
                                                                ),

                                                              ],
                                                            ),
                                                            SizedBox(height: 15,),
                                                            Text(value["stname"],style: GoogleFonts.poppins(
                                                                color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                                            Text("ID: ${value["regno"]}",style: GoogleFonts.poppins(
                                                                color:  pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                            SizedBox(height: 10,),
                                                            Row(
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Text("Class       : ",style: GoogleFonts.poppins(
                                                                    color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                Text("${value["admitclass"]} ${value["section"]}",style: GoogleFonts.poppins(
                                                                    color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Text("DOB          : ",style: GoogleFonts.poppins(

                                                                    color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                Text(value["dob"].toString().substring(0,10),style: GoogleFonts.poppins(
                                                                    color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Text("Blood Group       : ",style: GoogleFonts.poppins(
                                                                    color:pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                Text(value["bloodgroup"],style: GoogleFonts.poppins(
                                                                    color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Text("Phone No    : ",style: GoogleFonts.poppins(
                                                                    color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                Text(value["mobile"],style: GoogleFonts.poppins(
                                                                    color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ],
                                                            ),

                                                          ],
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 50,),
                                                Container(
                                                  width: 260,
                                                  height: 410,
                                                  child: Stack(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Image.asset("assets/idbg7.png",color: pickerColor,),
                                                          Image.asset("assets/idbg6.png",color: pickerColor,),

                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,

                                                        children: [
                                                          SizedBox(height: 20,),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 25.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                    width:60,
                                                                    height:60, decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(30),
                                                                    color:Colors.white
                                                                ),
                                                                    child: Image.network(schoollogo)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 70,),

                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 20.0),
                                                            child: Text("",style: GoogleFonts.poppins(
                                                                color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                                          ),
                                                          Text("",style: GoogleFonts.poppins(
                                                              color: Color(0xff0271C5), fontSize: 12,fontWeight: FontWeight.w600),),
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            children: [
                                                              SizedBox(width: 20,),
                                                              Container(
                                                                width: 110,
                                                                child: Text("Emergency Contact No : ",style: GoogleFonts.poppins(
                                                                    color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ),
                                                              Text(value["fatherMobile"],style: GoogleFonts.poppins(
                                                                  color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(width: 20,),
                                                              Container(
                                                                width: 110,
                                                                child: Text("Address : ",style: GoogleFonts.poppins(

                                                                    color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ),
                                                              Container(
                                                                width:100,
                                                                child: Text(value["address"],style: GoogleFonts.poppins(
                                                                    color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ),
                                                            ],
                                                          ),

                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 0.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    SizedBox(height:5),
                                                                    Container(
                                                                        width: 75,
                                                                        height: 75,
                                                                        child: Image.asset("assets/VIDHAANLOGO.png",fit: BoxFit.contain,)),

                                                                    Text("e    d    u    c    a    r    e",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: 7),),
                                                                    SizedBox(height:7),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          )

                                                        ],
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ) :

                                          idcarddesign=="2"?
                                          Row(children: [

                                            Material(

                                              child: Container(
                                                width: 260,
                                                height: 410,

                                                child: Stack(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Image.asset("assets/id2bg7.png",color: pickerColor2,),


                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,

                                                      children: [

                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(width:10),
                                                            Column(
                                                              children: [
                                                                SizedBox(height:15),
                                                                Container(
                                                                    width:50,
                                                                    height:50, decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(25),
                                                                    color:Colors.white
                                                                ),
                                                                    child: Image.network(schoollogo)),
                                                              ],
                                                            ),
                                                            SizedBox(width:10),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(height:7),
                                                                Container(
                                                                  width:180,
                                                                  child: Text(schoolname,style: GoogleFonts.poppins(
                                                                      color: Colors.white, fontSize: 14,fontWeight: FontWeight.w600),),
                                                                ),
                                                                Text("Phone: +91 ${schoolphone}",style: GoogleFonts.poppins(
                                                                    color: Colors.white, fontSize: 8,fontWeight: FontWeight.w400),),
                                                                Text(schooladdress,style: GoogleFonts.poppins(
                                                                    color: Colors.white, fontSize: 8,fontWeight: FontWeight.w400),),
                                                              ],
                                                            ),
                                                          ],
                                                        ),



                                                        SizedBox(height: 40,),
                                                        Stack(
                                                          alignment: Alignment.center,
                                                          children: [
                                                            Container(
                                                              width: 120,
                                                              height: 120,
                                                              decoration: BoxDecoration(
                                                                  color: pickerColor2,
                                                                  borderRadius: BorderRadius.circular(12)
                                                              ),


                                                            ),
                                                            Container(
                                                              width: 115,
                                                              height: 115,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(12)
                                                              ),
                                                              child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(12),
                                                                  child: Image.network(value!['imgurl']==""?"https://firebasestorage.googleapis.com/v0/b/vidhaan-4aee7.appspot.com/o/360_F_270188580_YDUEwBmDIxBMvCQxkcunmEkm93VqOgqm.jpg?alt=media&token=fe18ba43-4a31-4b53-9523-42bb4241d9a1"
                                        :value['imgurl'],fit:BoxFit.cover),),
                                                            ),

                                                          ],
                                                        ),
                                                        SizedBox(height: 15,),
                                                        Text(value["stname"],style: GoogleFonts.poppins(
                                                            color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                                        Text("ID: ${value["regno"]}",style: GoogleFonts.poppins(
                                                            color:  pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                        SizedBox(height: 10,),
                                                        Stack(

                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(width:50),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,

                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("Class       : ",style: GoogleFonts.poppins(
                                                                            color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text("${value["admitclass"]} ${value["section"]}",style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("DOB          : ",style: GoogleFonts.poppins(

                                                                            color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text(value["dob"],style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("Blood Group       : ",style: GoogleFonts.poppins(
                                                                            color:pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text(value["bloodgroup"],style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("Phone No    : ",style: GoogleFonts.poppins(
                                                                            color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text(value["mobile"],style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:  EdgeInsets.only(top:50.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      Container(
                                                                          width:37,


                                                                          child: Image.asset("assets/sign.png")),
                                                                      Text("Principle",style: GoogleFonts.poppins(
                                                                          color: Colors.black, fontSize: 10,fontWeight: FontWeight.w700),),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),




                                                      ],
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 50,),
                                            Container(
                                              width: 260,
                                              height: 410,
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [

                                                      Image.asset("assets/id2bg2.png",color: pickerColor2,),

                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,

                                                    children: [
                                                      SizedBox(height: 20,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 10.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                                width:60,
                                                                height:60,
                                                                child: Image.network(schoollogo)),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 10.0),
                                                        child: Text(schoolname,style: GoogleFonts.poppins(
                                                            color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 10.0),
                                                        child: Text(solgan,style: GoogleFonts.poppins(
                                                            color: pickerColor2, fontSize: 8,fontWeight: FontWeight.w400),),
                                                      ),
                                                      SizedBox(height: 40,),

                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 20.0),
                                                        child: Text("",style: GoogleFonts.poppins(
                                                            color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                                      ),
                                                      Text("",style: GoogleFonts.poppins(
                                                          color: Color(0xff0271C5), fontSize: 12,fontWeight: FontWeight.w600),),
                                                      SizedBox(height: 10,),
                                                      Row(
                                                        children: [
                                                          SizedBox(width: 20,),
                                                          Container(
                                                            width: 110,
                                                            child: Text("Emergency Contact No : ",style: GoogleFonts.poppins(
                                                                color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                          ),
                                                          Text(value["fatherMobile"],style: GoogleFonts.poppins(
                                                              color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                        ],
                                                      ),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          SizedBox(width: 20,),
                                                          Container(
                                                            width: 110,
                                                            child: Text("Address : ",style: GoogleFonts.poppins(

                                                                color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                          ),
                                                          Container(
                                                            width:120,
                                                            child: Text(value["address"],style: GoogleFonts.poppins(
                                                                color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                          ),
                                                        ],
                                                      ),

                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 20.0),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                    width: 75,
                                                                    height: 75,
                                                                    child: Image.asset("assets/VIDHAANLOGO.png",fit: BoxFit.contain,)),
                                                                Text("e    d    u    c    a    r    e",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: 7),),


                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )

                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ],
                                          )   :
                                          Row(
                                            children: [
                                              Material(

                                                child: Container(
                                                  width: 410,
                                                  height: 260,

                                                  child: Stack(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Image.asset("assets/id3bg1.png",color: pickerColor3,),
                                                          Image.asset("assets/id3bg2.png",color: pickerColor3,),


                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,

                                                        children: [
                                                          SizedBox(height: 7,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              SizedBox(width:30),
                                                              Container(
                                                                  width:60,
                                                                  height:60,
                                                                  child: Image.network(schoollogo)),
                                                              SizedBox(width:5),
                                                              Column(
                                                                crossAxisAlignment:CrossAxisAlignment.start,
                                                                children: [
                                                                  Container(
                                                                    width:250,
                                                                    child: Text(schoolname,style: GoogleFonts.poppins(
                                                                        color: pickerColor3, fontSize: 15,fontWeight: FontWeight.w600),),
                                                                  ),
                                                                  Text("Phone: +91 ${schoolphone}",style: GoogleFonts.poppins(
                                                                      color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),
                                                                  Text(schooladdress,style: GoogleFonts.poppins(
                                                                      color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),
                                                                  Text(schoolweb,style: GoogleFonts.poppins(
                                                                      color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),


                                                                ],
                                                              ),

                                                            ],
                                                          ),
                                                          SizedBox(height: 0,),

                                                          Row(
                                                            children: [
                                                              SizedBox(width:10),
                                                              Stack(
                                                                alignment: Alignment.center,
                                                                children: [
                                                                  Container(
                                                                    width: 120,
                                                                    height: 120,
                                                                    decoration: BoxDecoration(
                                                                        color: pickerColor3,
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
                                                                        child: Image.network(value!['imgurl']==""?"https://firebasestorage.googleapis.com/v0/b/vidhaan-4aee7.appspot.com/o/360_F_270188580_YDUEwBmDIxBMvCQxkcunmEkm93VqOgqm.jpg?alt=media&token=fe18ba43-4a31-4b53-9523-42bb4241d9a1"
                                        :value['imgurl'],fit:BoxFit.cover),),
                                                                  ),

                                                                ],
                                                              ),
                                                              Column(
                                                                  crossAxisAlignment:CrossAxisAlignment.start,
                                                                  children:[
                                                                    SizedBox(height: 5,),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(left:15.0),
                                                                      child: Text(value["stname"],style: GoogleFonts.poppins(
                                                                          color: pickerColor3, fontSize: 15,fontWeight: FontWeight.w700),),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(left:15.0),
                                                                      child: Text("ID: ${value["regno"]}",style: GoogleFonts.poppins(
                                                                          color:  pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                    ),
                                                                    SizedBox(height: 10,),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("Class       : ",style: GoogleFonts.poppins(
                                                                            color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text("${value["admitclass"]} ${value["section"]}",style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("DOB          : ",style: GoogleFonts.poppins(

                                                                            color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text(value["dob"],style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("Blood Group       : ",style: GoogleFonts.poppins(
                                                                            color:pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text(value["bloodgroup"],style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("Phone No    : ",style: GoogleFonts.poppins(
                                                                            color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text(value["mobile"],style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                  ]
                                                              )
                                                            ],
                                                          ),


                                                        ],
                                                      ),


                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 30,),
                                              Material(

                                                child: Container(
                                                  width: 410,
                                                  height: 260,

                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 100.0,left:250),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                SizedBox(height:5),
                                                                Opacity(
                                                                  opacity:0.39,
                                                                  child: Container(
                                                                      width: 75,
                                                                      height: 75,
                                                                      child: Image.asset("assets/VIDHAANLOGO.png",fit: BoxFit.contain,)),
                                                                ),

                                                                Opacity(
                                                                    opacity:0.39,
                                                                    child: Text("e    d    u    c    a    r    e",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: 7),)),
                                                                SizedBox(height:7),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Image.asset("assets/id3bg3.png",color: pickerColor3,),
                                                          Image.asset("assets/id3bg2.png",color: pickerColor3,),


                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top:30.0),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                SizedBox(width:15),
                                                                Container(
                                                                    width:60,
                                                                    height:60,
                                                                    child: Image.network(schoollogo)),
                                                                SizedBox(width:0),
                                                                Column(
                                                                  crossAxisAlignment:CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(schoolname,style: GoogleFonts.poppins(
                                                                        color: pickerColor3, fontSize: 15,fontWeight: FontWeight.w600),),
                                                                    Text("Phone: +91 ${schoolphone}",style: GoogleFonts.poppins(
                                                                        color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),
                                                                    Text(schooladdress,style: GoogleFonts.poppins(
                                                                        color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),
                                                                    Text(schoolweb,style: GoogleFonts.poppins(
                                                                        color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),


                                                                  ],
                                                                ),

                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 20.0,top:20),
                                                                  child: Text("",style: GoogleFonts.poppins(
                                                                      color:  pickerColor3, fontSize: 15,fontWeight: FontWeight.w700),),
                                                                ),
                                                              ],
                                                            ),

                                                            SizedBox(height: 5,),
                                                            Row(
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Container(
                                                                  width: 110,
                                                                  child: Text("Emergency Contact No : ",style: GoogleFonts.poppins(
                                                                      color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                ),
                                                                Text(value["fatherMobile"],style: GoogleFonts.poppins(
                                                                    color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ],
                                                            ),
                                                            Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Container(
                                                                  width: 110,
                                                                  child: Text("Address : ",style: GoogleFonts.poppins(

                                                                      color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                ),
                                                                Text(value["address"],style: GoogleFonts.poppins(
                                                                    color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ],
                                                            ),


                                                          ],
                                                        ),
                                                      ),




                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ): Container(),
                                        ],
                                      ),



                                    ),
                                  ) : Container() :
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AnimatedContainer(
                                      duration: Duration(seconds: 1),
                                      width: width/1.366,
                                      height: expand[index]==false?50:500,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10.0),
                                                child: Checkbox(

                                                    value: check[index],

                                                    onChanged: (bool? value){
                                                      print(value);
                                                      setState(() {
                                                        check[index] = value!;
                                                      });

                                                    }
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10.0, right: 0),
                                                child: Container(
                                                  width: width/13.66,

                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    value["regno"],
                                                    style:
                                                    GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 30.0),
                                                child: Container(
                                                  width: width/9.757,


                                                  child: Text(
                                                    value["stname"],
                                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0.0, right: 0),
                                                child: Container(
                                                  width: width/22.766,

                                                  child: Text(
                                                    value["admitclass"],
                                                    style:
                                                    GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 13.0),
                                                child: Container(
                                                  width:width/22.766,

                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    value["section"],
                                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 50, right: 0),
                                                child: Container(
                                                  width: width/10.507,

                                                  child: Text(
                                                    value["fathername"],
                                                    style:
                                                    GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left:7.0),
                                                child: Container(
                                                  width: width/9.7571,

                                                  child: Text(
                                                    value["mobile"],
                                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500,color:Colors.indigoAccent),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 3.0, right: 0),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: width/17.075,

                                                  child: Row(
                                                    children: [
                                                      value["gender"]=="Male"?  Padding(
                                                        padding: const EdgeInsets.only(right: 6.0),
                                                        child: Icon(Icons.male_rounded,size: 20,),
                                                      ):Padding(
                                                        padding: const EdgeInsets.only(right: 6.0),
                                                        child: Icon(Icons.female_rounded,size: 20,),
                                                      ),
                                                      Text(
                                                        value["gender"],
                                                        style:
                                                        GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  if(expand[index]==true) {
                                                    setState(() {
                                                      expand[index] = false;
                                                    });
                                                  }else{
                                                    setState(() {
                                                      expand[index] = true;
                                                    });
                                                  }
                                                },
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.only(left: 45.0),
                                                  child: expand[index]==false? Container(
                                                    width: width/22.76,
                                                    height: height/21.9,
                                                    //color: Color(0xffD60A0B),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      color: Color(0xff53B175),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                          "View",
                                                          style: GoogleFonts.poppins(
                                                              color: Colors.white),
                                                        )),
                                                  ) :
                                                  Container(
                                                    width: width/22.76,
                                                    height: height/21.9,
                                                    //color: Color(0xffD60A0B),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      color: Colors.red,
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                          "Close",
                                                          style: GoogleFonts.poppins(
                                                              color: Colors.white),
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          expand[index]!=false? idcarddesign=="1"? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Material(

                                                  child: Screenshot(
                                                    controller: screenshotController[index],
                                                    child: Container(
                                                      width: 260,
                                                      height: 410,
                                                      color:Colors.white,

                                                      child: Stack(
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Image.asset("assets/idbg4.png",color: pickerColor,),
                                                              Image.asset("assets/idbg6.png",color: pickerColor,),

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
                                                                        color: pickerColor,
                                                                        borderRadius: BorderRadius.circular(60)
                                                                    ),


                                                                  ),
                                                                  Container(
                                                                    width: 112,
                                                                    height: 112,
                                                                    decoration: BoxDecoration(
                                                                            color:Colors.white,
                                                                        borderRadius: BorderRadius.circular(60)
                                                                    ),
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(60),
                                                                        child: Image.network(value!['imgurl']==""?"https://firebasestorage.googleapis.com/v0/b/vidhaan-4aee7.appspot.com/o/360_F_270188580_YDUEwBmDIxBMvCQxkcunmEkm93VqOgqm.jpg?alt=media&token=fe18ba43-4a31-4b53-9523-42bb4241d9a1"
                                        :value['imgurl'],),),
                                                                  ),

                                                                ],
                                                              ),
                                                              SizedBox(height: 15,),
                                                              Text(value["stname"],style: GoogleFonts.poppins(
                                                                  color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                                              Text("ID: ${value["regno"]}",style: GoogleFonts.poppins(
                                                                  color:  pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              SizedBox(height: 10,),
                                                              Row(
                                                                children: [
                                                                  SizedBox(width: 20,),
                                                                  Text("Class       : ",style: GoogleFonts.poppins(
                                                                      color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                  Text("${value["admitclass"]} ${value["section"]}",style: GoogleFonts.poppins(
                                                                      color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SizedBox(width: 20,),
                                                                  Text("DOB          : ",style: GoogleFonts.poppins(

                                                                      color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                  Text(value["dob"].toString().substring(0,10),style: GoogleFonts.poppins(
                                                                      color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SizedBox(width: 20,),
                                                                  Text("Blood Group       : ",style: GoogleFonts.poppins(
                                                                      color:pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                  Text(value["bloodgroup"],style: GoogleFonts.poppins(
                                                                      color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SizedBox(width: 20,),
                                                                  Text("Phone No    : ",style: GoogleFonts.poppins(
                                                                      color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                  Text(value["mobile"],style: GoogleFonts.poppins(
                                                                      color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                ],
                                                              ),

                                                            ],
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 50,),
                                                Container(
                                                  width: 260,
                                                  height: 410,
                                                  child: Stack(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Image.asset("assets/idbg7.png",color: pickerColor,),
                                                          Image.asset("assets/idbg6.png",color: pickerColor,),

                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,

                                                        children: [
                                                          SizedBox(height: 20,),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 25.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                    width:60,
                                                                    height:60, decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(30),
                                                                    color:Colors.white
                                                                ),
                                                                    child: Image.network(schoollogo)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 70,),

                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 20.0),
                                                            child: Text("",style: GoogleFonts.poppins(
                                                                color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                                          ),
                                                          Text("",style: GoogleFonts.poppins(
                                                              color: Color(0xff0271C5), fontSize: 12,fontWeight: FontWeight.w600),),
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            children: [
                                                              SizedBox(width: 20,),
                                                              Container(
                                                                width: 110,
                                                                child: Text("Emergency Contact No : ",style: GoogleFonts.poppins(
                                                                    color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ),
                                                              Text(value["fatherMobile"],style: GoogleFonts.poppins(
                                                                  color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(width: 20,),
                                                              Container(
                                                                width: 110,
                                                                child: Text("Address : ",style: GoogleFonts.poppins(

                                                                    color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ),
                                                              Container(
                                                                width:100,
                                                                child: Text(value["address"],style: GoogleFonts.poppins(
                                                                    color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ),
                                                            ],
                                                          ),

                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 0.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    SizedBox(height:5),
                                                                    Container(
                                                                        width: 75,
                                                                        height: 75,
                                                                        child: Image.asset("assets/VIDHAANLOGO.png",fit: BoxFit.contain,)),

                                                                    Text("e    d    u    c    a    r    e",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: 7),),
                                                                    SizedBox(height:7),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          )

                                                        ],
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ) :

                                          idcarddesign=="2"?
                                          Row(children: [

                                            Material(

                                              child: Container(
                                                width: 260,
                                                height: 410,

                                                child: Stack(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Image.asset("assets/id2bg7.png",color: pickerColor2,),


                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,

                                                      children: [

                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(width:10),
                                                            Column(
                                                              children: [
                                                                SizedBox(height:15),
                                                                Container(
                                                                    width:50,
                                                                    height:50, decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(25),
                                                                    color:Colors.white
                                                                ),
                                                                    child: Image.network(schoollogo)),
                                                              ],
                                                            ),
                                                            SizedBox(width:10),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(height:7),
                                                                Container(
                                                                  width:180,
                                                                  child: Text(schoolname,style: GoogleFonts.poppins(
                                                                      color: Colors.white, fontSize: 14,fontWeight: FontWeight.w600),),
                                                                ),
                                                                Text("Phone: +91 ${schoolphone}",style: GoogleFonts.poppins(
                                                                    color: Colors.white, fontSize: 8,fontWeight: FontWeight.w400),),
                                                                Text(schooladdress,style: GoogleFonts.poppins(
                                                                    color: Colors.white, fontSize: 8,fontWeight: FontWeight.w400),),
                                                              ],
                                                            ),
                                                          ],
                                                        ),



                                                        SizedBox(height: 40,),
                                                        Stack(
                                                          alignment: Alignment.center,
                                                          children: [
                                                            Container(
                                                              width: 120,
                                                              height: 120,
                                                              decoration: BoxDecoration(
                                                                  color: pickerColor2,
                                                                  borderRadius: BorderRadius.circular(12)
                                                              ),


                                                            ),
                                                            Container(
                                                              width: 115,
                                                              height: 115,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(12)
                                                              ),
                                                              child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(12),
                                                                  child: Image.network(value!['imgurl']==""?"https://firebasestorage.googleapis.com/v0/b/vidhaan-4aee7.appspot.com/o/360_F_270188580_YDUEwBmDIxBMvCQxkcunmEkm93VqOgqm.jpg?alt=media&token=fe18ba43-4a31-4b53-9523-42bb4241d9a1"
                                        :value['imgurl'],fit:BoxFit.cover),),
                                                            ),

                                                          ],
                                                        ),
                                                        SizedBox(height: 15,),
                                                        Text(value["stname"],style: GoogleFonts.poppins(
                                                            color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                                        Text("ID: ${value["regno"]}",style: GoogleFonts.poppins(
                                                            color:  pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                        SizedBox(height: 10,),
                                                        Stack(

                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(width:50),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,

                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("Class       : ",style: GoogleFonts.poppins(
                                                                            color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text("${value["admitclass"]} ${value["section"]}",style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("DOB          : ",style: GoogleFonts.poppins(

                                                                            color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text(value["dob"],style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("Blood Group       : ",style: GoogleFonts.poppins(
                                                                            color:pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text(value["bloodgroup"],style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("Phone No    : ",style: GoogleFonts.poppins(
                                                                            color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text(value["mobile"],style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:  EdgeInsets.only(top:50.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      Container(
                                                                          width:37,


                                                                          child: Image.asset("assets/sign.png")),
                                                                      Text("Principle",style: GoogleFonts.poppins(
                                                                          color: Colors.black, fontSize: 10,fontWeight: FontWeight.w700),),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),




                                                      ],
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 50,),
                                            Container(
                                              width: 260,
                                              height: 410,
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [

                                                      Image.asset("assets/id2bg2.png",color: pickerColor2,),

                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,

                                                    children: [
                                                      SizedBox(height: 20,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 10.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                                width:60,
                                                                height:60,
                                                                child: Image.network(schoollogo)),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 10.0),
                                                        child: Text(schoolname,style: GoogleFonts.poppins(
                                                            color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 10.0),
                                                        child: Text(solgan,style: GoogleFonts.poppins(
                                                            color: pickerColor2, fontSize: 8,fontWeight: FontWeight.w400),),
                                                      ),
                                                      SizedBox(height: 40,),

                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 20.0),
                                                        child: Text("",style: GoogleFonts.poppins(
                                                            color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                                      ),
                                                      Text("",style: GoogleFonts.poppins(
                                                          color: Color(0xff0271C5), fontSize: 12,fontWeight: FontWeight.w600),),
                                                      SizedBox(height: 10,),
                                                      Row(
                                                        children: [
                                                          SizedBox(width: 20,),
                                                          Container(
                                                            width: 110,
                                                            child: Text("Emergency Contact No : ",style: GoogleFonts.poppins(
                                                                color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                          ),
                                                          Text(value["fatherMobile"],style: GoogleFonts.poppins(
                                                              color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                        ],
                                                      ),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          SizedBox(width: 20,),
                                                          Container(
                                                            width: 110,
                                                            child: Text("Address : ",style: GoogleFonts.poppins(

                                                                color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                          ),
                                                          Container(
                                                            width:120,
                                                            child: Text(value["address"],style: GoogleFonts.poppins(
                                                                color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                          ),
                                                        ],
                                                      ),

                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 20.0),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                    width: 75,
                                                                    height: 75,
                                                                    child: Image.asset("assets/VIDHAANLOGO.png",fit: BoxFit.contain,)),
                                                                Text("e    d    u    c    a    r    e",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: 7),),


                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )

                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                            ],
                                          )   :
                                          Row(
                                            children: [
                                              Material(

                                                child: Container(
                                                  width: 410,
                                                  height: 260,

                                                  child: Stack(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Image.asset("assets/id3bg1.png",color: pickerColor3,),
                                                          Image.asset("assets/id3bg2.png",color: pickerColor3,),


                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,

                                                        children: [
                                                          SizedBox(height: 7,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              SizedBox(width:30),
                                                              Container(
                                                                  width:60,
                                                                  height:60,
                                                                  child: Image.network(schoollogo)),
                                                              SizedBox(width:5),
                                                              Column(
                                                                crossAxisAlignment:CrossAxisAlignment.start,
                                                                children: [
                                                                  Container(
                                                                    width:250,
                                                                    child: Text(schoolname,style: GoogleFonts.poppins(
                                                                        color: pickerColor3, fontSize: 15,fontWeight: FontWeight.w600),),
                                                                  ),
                                                                  Text("Phone: +91 ${schoolphone}",style: GoogleFonts.poppins(
                                                                      color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),
                                                                  Text(schooladdress,style: GoogleFonts.poppins(
                                                                      color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),
                                                                  Text(schoolweb,style: GoogleFonts.poppins(
                                                                      color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),


                                                                ],
                                                              ),

                                                            ],
                                                          ),
                                                          SizedBox(height: 0,),

                                                          Row(
                                                            children: [
                                                              SizedBox(width:10),
                                                              Stack(
                                                                alignment: Alignment.center,
                                                                children: [
                                                                  Container(
                                                                    width: 120,
                                                                    height: 120,
                                                                    decoration: BoxDecoration(
                                                                        color: pickerColor3,
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
                                                                        child: Image.network(value!['imgurl']==""?"https://firebasestorage.googleapis.com/v0/b/vidhaan-4aee7.appspot.com/o/360_F_270188580_YDUEwBmDIxBMvCQxkcunmEkm93VqOgqm.jpg?alt=media&token=fe18ba43-4a31-4b53-9523-42bb4241d9a1"
                                        :value['imgurl'],fit:BoxFit.cover),),
                                                                  ),

                                                                ],
                                                              ),
                                                              Column(
                                                                  crossAxisAlignment:CrossAxisAlignment.start,
                                                                  children:[
                                                                    SizedBox(height: 5,),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(left:15.0),
                                                                      child: Text(value["stname"],style: GoogleFonts.poppins(
                                                                          color: pickerColor3, fontSize: 15,fontWeight: FontWeight.w700),),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(left:15.0),
                                                                      child: Text("ID: ${value["regno"]}",style: GoogleFonts.poppins(
                                                                          color:  pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                    ),
                                                                    SizedBox(height: 10,),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("Class       : ",style: GoogleFonts.poppins(
                                                                            color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text("${value["admitclass"]} ${value["section"]}",style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("DOB          : ",style: GoogleFonts.poppins(

                                                                            color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text(value["dob"],style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("Blood Group       : ",style: GoogleFonts.poppins(
                                                                            color:pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text(value["bloodgroup"],style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(width: 20,),
                                                                        Text("Phone No    : ",style: GoogleFonts.poppins(
                                                                            color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                        Text(value["mobile"],style: GoogleFonts.poppins(
                                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ],
                                                                    ),
                                                                  ]
                                                              )
                                                            ],
                                                          ),


                                                        ],
                                                      ),


                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 30,),
                                              Material(

                                                child: Container(
                                                  width: 410,
                                                  height: 260,

                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 100.0,left:250),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                SizedBox(height:5),
                                                                Opacity(
                                                                  opacity:0.39,
                                                                  child: Container(
                                                                      width: 75,
                                                                      height: 75,
                                                                      child: Image.asset("assets/VIDHAANLOGO.png",fit: BoxFit.contain,)),
                                                                ),

                                                                Opacity(
                                                                    opacity:0.39,
                                                                    child: Text("e    d    u    c    a    r    e",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: 7),)),
                                                                SizedBox(height:7),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Image.asset("assets/id3bg3.png",color: pickerColor3,),
                                                          Image.asset("assets/id3bg2.png",color: pickerColor3,),


                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top:30.0),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                SizedBox(width:15),
                                                                Container(
                                                                    width:60,
                                                                    height:60,
                                                                    child: Image.network(schoollogo)),
                                                                SizedBox(width:0),
                                                                Column(
                                                                  crossAxisAlignment:CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(schoolname,style: GoogleFonts.poppins(
                                                                        color: pickerColor3, fontSize: 15,fontWeight: FontWeight.w600),),
                                                                    Text("Phone: +91 ${schoolphone}",style: GoogleFonts.poppins(
                                                                        color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),
                                                                    Text(schooladdress,style: GoogleFonts.poppins(
                                                                        color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),
                                                                    Text(schoolweb,style: GoogleFonts.poppins(
                                                                        color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),


                                                                  ],
                                                                ),

                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 20.0,top:20),
                                                                  child: Text("",style: GoogleFonts.poppins(
                                                                      color:  pickerColor3, fontSize: 15,fontWeight: FontWeight.w700),),
                                                                ),
                                                              ],
                                                            ),

                                                            SizedBox(height: 5,),
                                                            Row(
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Container(
                                                                  width: 110,
                                                                  child: Text("Emergency Contact No : ",style: GoogleFonts.poppins(
                                                                      color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                ),
                                                                Text(value["fatherMobile"],style: GoogleFonts.poppins(
                                                                    color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ],
                                                            ),
                                                            Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Container(
                                                                  width: 110,
                                                                  child: Text("Address : ",style: GoogleFonts.poppins(

                                                                      color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                                ),
                                                                Text(value["address"],style: GoogleFonts.poppins(
                                                                    color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                              ],
                                                            ),


                                                          ],
                                                        ),
                                                      ),




                                                    ],
                                                  ),
                                                ),
                                              ),
                                              ],
                                          ): Container(),
                                        ],
                                      ),



                                    ),
                                  );
                                });

                          }),
                    ],
                  ),

                ),
              ) 
            
            ],
          ),
        ),
          floatingActionButton: mainconcent==true || check.contains(true)? InkWell(
            onTap: (){
              _downloadImage();
            },
            child: Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Material(
                borderRadius: BorderRadius.circular(5),
                elevation: 7,
                child: Container(child: Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.print,color: Colors.white,),
                    ),
                    Text("Print",style: GoogleFonts.poppins(color:Colors.white),textAlign: TextAlign.center,),
                  ],
                )),
                  width: width/13.507,
                  height: height/16.425,
                  // color:Color(0xff00A0E3),
                  decoration: BoxDecoration(color: const Color(0xff53B175),borderRadius: BorderRadius.circular(5)),

                ),
              ),
            ),
          ) : Container()

      )
          :
      Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:20.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          viewtem=false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                    Text("Select Templates",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation:7,
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Material(

                              child: RepaintBoundary(
                                child: Container(
                                  width: 260,
                                  height: 410,

                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset("assets/idbg4.png",color: pickerColor,),
                                          Image.asset("assets/idbg6.png",color: pickerColor,),

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
                                                    color: pickerColor,
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
                                              color:  pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                          SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              SizedBox(width: 20,),
                                              Text("Class       : ",style: GoogleFonts.poppins(
                                                  color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                              Text("LKG A",style: GoogleFonts.poppins(
                                                  color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(width: 20,),
                                              Text("DOB          : ",style: GoogleFonts.poppins(

                                                  color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                              Text("05/05/2002",style: GoogleFonts.poppins(
                                                  color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(width: 20,),
                                              Text("Blood Group       : ",style: GoogleFonts.poppins(
                                                  color:pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                              Text("B+ve",style: GoogleFonts.poppins(
                                                  color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(width: 20,),
                                              Text("Emergency Contact No    : ",style: GoogleFonts.poppins(
                                                  color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
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
                            ),
                            SizedBox(width: 50,),
                            Container(
                              width: 260,
                              height: 410,
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset("assets/idbg7.png",color: pickerColor,),
                                      Image.asset("assets/idbg6.png",color: pickerColor,),

                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      SizedBox(height: 20,),
                                      Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        width:60,
                                        height:60, decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color:Colors.white
                                    ),
                                        child: Image.network(schoollogo)),
                                  ],
                                ),
                              ),
                                      SizedBox(height: 70,),

                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                        child: Text("Emergency Contact",style: GoogleFonts.poppins(
                                            color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                      ),
                                      Text("",style: GoogleFonts.poppins(
                                          color: Color(0xff0271C5), fontSize: 12,fontWeight: FontWeight.w600),),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          SizedBox(width: 20,),
                                          Container(
                                            width: 110,
                                            child: Text("Emergency Contact No : ",style: GoogleFonts.poppins(
                                                color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                          ),
                                          Text("9944861235",style: GoogleFonts.poppins(
                                              color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 20,),
                                          Container(
                                            width: 110,
                                            child: Text("Address : ",style: GoogleFonts.poppins(

                                                color: pickerColor, fontSize: 12,fontWeight: FontWeight.w600),),
                                          ),
                                          Text("No120/2 Kolathur \nChennai",style: GoogleFonts.poppins(
                                              color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                        ],
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(left: 0.0),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(height:5),
                                                Container(
                                                    width: 75,
                                                    height: 75,
                                                    child: Image.asset("assets/VIDHAANLOGO.png",fit: BoxFit.contain,)),

                                                Text("e    d    u    c    a    r    e",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: 7),),
                                                SizedBox(height:7),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )

                                    ],
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(width: 50,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10,),
                                Text("Card Design 1",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20),),
                                Text("Change Color:",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 15),),

                                Container(
                                  width: 465,
                                  child: ColorPicker(
                                    colorPickerWidth: 120,
                                    pickerColor: pickerColor,
                                    onColorChanged: changeColor,
                                    hexInputBar: true,
                                    enableAlpha: false,
                                    displayThumbColor: false,

                                    onHistoryChanged: (value)  {
                                      print(value);
                                    },

                                    onHsvColorChanged: (value)  {
                                      print(value);
                                    },

                                  ),
                                ),
                                SizedBox(height: 10,),
                                InkWell(
                                  onTap: (){
                                    selectdesign("1");
                                    Successdialog();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Center(
                                          child: Text(
                                            "Select Design",
                                            style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),
                                          )),
                                      width: width/6.83,
                                      //color: Color(0xff00A0E3),
                                      height: height/16.425,
                                      decoration: BoxDecoration(
                                          color: Color(0xff53B175),
                                          borderRadius: BorderRadius.circular(6)),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 55,),
                        Row(
                          children: [
                            Material(

                              child: Container(
                                width: 260,
                                height: 410,

                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image.asset("assets/id2bg7.png",color: pickerColor2,),


                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: [

                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(width:10),
                                            Column(
                                              children: [
                                                SizedBox(height:15),
                                                Container(
                                                    width:50,
                                                    height:50, decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(25),
                                                    color:Colors.white
                                                ),
                                                    child: Image.network(schoollogo)),
                                              ],
                                            ),
                                            SizedBox(width:10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height:7),
                                                Container(
                                                  width:180,
                                                  child: Text(schoolname,style: GoogleFonts.poppins(
                                                      color: Colors.white, fontSize: 14,fontWeight: FontWeight.w600),),
                                                ),
                                                Text("Phone: +91 ${schoolphone}",style: GoogleFonts.poppins(
                                                    color: Colors.white, fontSize: 8,fontWeight: FontWeight.w400),),
                                                Text(schooladdress,style: GoogleFonts.poppins(
                                                    color: Colors.white, fontSize: 8,fontWeight: FontWeight.w400),),
                                              ],
                                            ),
                                          ],
                                        ),



                                        SizedBox(height: 40,),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              width: 120,
                                              height: 120,
                                              decoration: BoxDecoration(
                                                  color: pickerColor2,
                                                  borderRadius: BorderRadius.circular(12)
                                              ),


                                            ),
                                            Container(
                                              width: 115,
                                              height: 115,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12)
                                              ),
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(12),
                                                  child: Image.asset("assets/profile.jpg")),
                                            ),

                                          ],
                                        ),
                                        SizedBox(height: 15,),
                                        Text("Sam Jebaseelan",style: GoogleFonts.poppins(
                                            color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                        Text("ID: VBSB004",style: GoogleFonts.poppins(
                                            color:  pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                        SizedBox(height: 10,),
                                        Stack(

                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(width:50),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,

                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(width: 20,),
                                                        Text("Class       : ",style: GoogleFonts.poppins(
                                                            color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                        Text("LKG A",style: GoogleFonts.poppins(
                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(width: 20,),
                                                        Text("DOB          : ",style: GoogleFonts.poppins(

                                                            color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                        Text("05/05/2002",style: GoogleFonts.poppins(
                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                      ],),
                                                    Row(
                                                      children: [
                                                        SizedBox(width: 20,),
                                                        Text("Blood Group       : ",style: GoogleFonts.poppins(
                                                            color:pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                        Text("B+ve",style: GoogleFonts.poppins(
                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(width: 20,),
                                                        Text("Emergency Contact No    : ",style: GoogleFonts.poppins(
                                                            color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                                        Text("789456213",style: GoogleFonts.poppins(
                                                            color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(top:50.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                          width:37,


                                                          child: Image.asset("assets/sign.png")),
                                                      Text("Principle",style: GoogleFonts.poppins(
                                                          color: Colors.black, fontSize: 10,fontWeight: FontWeight.w700),),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),

                                        


                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 50,),
                            Container(
                              width: 260,
                              height: 410,
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [

                                      Image.asset("assets/id2bg2.png",color: pickerColor2,),

                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,

                                    children: [
                                      SizedBox(height: 20,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                width:60,
                                                height:60,
                                                child: Image.network(schoollogo)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Text(schoolname,style: GoogleFonts.poppins(
                                            color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Text(solgan,style: GoogleFonts.poppins(
                                            color: pickerColor2, fontSize: 8,fontWeight: FontWeight.w400),),
                                      ),
                                      SizedBox(height: 40,),

                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                        child: Text("Emergency Contact",style: GoogleFonts.poppins(
                                            color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                      ),
                                      Text("",style: GoogleFonts.poppins(
                                          color: Color(0xff0271C5), fontSize: 12,fontWeight: FontWeight.w600),),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          SizedBox(width: 20,),
                                          Container(
                                            width: 110,
                                            child: Text("Emergency Contact No : ",style: GoogleFonts.poppins(
                                                color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                          ),
                                          Text("9944861235",style: GoogleFonts.poppins(
                                              color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 20,),
                                          Container(
                                            width: 110,
                                            child: Text("Address : ",style: GoogleFonts.poppins(

                                                color: pickerColor2, fontSize: 12,fontWeight: FontWeight.w600),),
                                          ),
                                          Text("No120/2 Kolathur \nChennai",style: GoogleFonts.poppins(
                                              color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20.0),
                                            child: Column(
                                              children: [
                                                Container(
                                                    width: 75,
                                                    height: 75,
                                                    child: Image.asset("assets/VIDHAANLOGO.png",fit: BoxFit.contain,)),
                                                Text("e    d    u    c    a    r    e",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: 7),),

                                                
 ],
                                            ),
                                          ),
                                        ],
                                      )

                                    ],
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(width: 50,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10,),
                                Text("Card Design 2",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20),),
                                Text("Change Color:",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 15),),

                                Container(
                                  width: 465,
                                  child: ColorPicker(
                                    colorPickerWidth: 120,
                                    pickerColor: pickerColor2,
                                    onColorChanged: changeColor2,
                                    hexInputBar: true,
                                    enableAlpha: false,
                                    displayThumbColor: false,

                                    onHistoryChanged: (value)  {
                                      print(value);
                                    },

                                    onHsvColorChanged: (value)  {
                                      print(value);
                                    },

                                  ),
                                ),
                                SizedBox(height: 10,),
                                InkWell(
                                  onTap: (){
                                    selectdesign("2");
                                    Successdialog();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Center(
                                          child: Text(
                                            "Select Design",
                                            style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),
                                          )),
                                      width: width/6.83,
                                      //color: Color(0xff00A0E3),
                                      height: height/16.425,
                                      decoration: BoxDecoration(
                                          color: Color(0xff53B175),
                                          borderRadius: BorderRadius.circular(6)),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 55,),
                        Row(
                          children: [
                            Column(
                              children: [
                                Material(

                                  child: Container(
                                    width: 410,
                                    height: 260,

                                    child: Stack(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset("assets/id3bg1.png",color: pickerColor3,),
                                            Image.asset("assets/id3bg2.png",color: pickerColor3,),


                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,

                                          children: [
                                            SizedBox(height: 7,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(width:30),
                                                Container(
                                                    width:60,
                                                    height:60,
                                                    child: Image.network(schoollogo)),
                                                SizedBox(width:5),
                                                Column(
                                                  crossAxisAlignment:CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                width:250,
                                                      child: Text(schoolname,style: GoogleFonts.poppins(
                                                          color: pickerColor3, fontSize: 15,fontWeight: FontWeight.w600),),
                                                    ),
                                                    Text("Phone: +91 ${schoolphone}",style: GoogleFonts.poppins(
                                                        color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),
                                                    Text(schooladdress,style: GoogleFonts.poppins(
                                                        color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),
                                                    Text(schoolweb,style: GoogleFonts.poppins(
                                                        color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),


                                                  ],
                                                ),

                                              ],
                                            ),
                                            SizedBox(height: 0,),

                                            Row(
                                              children: [
                                                SizedBox(width:10),
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Container(
                                                      width: 120,
                                                      height: 120,
                                                      decoration: BoxDecoration(
                                                          color: pickerColor3,
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
                                                Column(
                                                    crossAxisAlignment:CrossAxisAlignment.start,
                                                    children:[
                                                      SizedBox(height: 5,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left:15.0),
                                                        child: Text("Sam Jebaseelan",style: GoogleFonts.poppins(
                                                            color: pickerColor3, fontSize: 15,fontWeight: FontWeight.w700),),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left:15.0),
                                                        child: Text("ID: VBSB004",style: GoogleFonts.poppins(
                                                            color:  pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                      ),
                                                      SizedBox(height: 10,),
                                                      Row(
                                                        children: [
                                                          SizedBox(width: 20,),
                                                          Text("Class       : ",style: GoogleFonts.poppins(
                                                              color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                          Text("LKG A",style: GoogleFonts.poppins(
                                                              color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(width: 20,),
                                                          Text("DOB          : ",style: GoogleFonts.poppins(

                                                              color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                          Text("05/05/2002",style: GoogleFonts.poppins(
                                                              color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(width: 20,),
                                                          Text("Blood Group       : ",style: GoogleFonts.poppins(
                                                              color:pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                          Text("B+ve",style: GoogleFonts.poppins(
                                                              color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(width: 20,),
                                                          Text("Emergency Contact No    : ",style: GoogleFonts.poppins(
                                                              color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                          Text("789456213",style: GoogleFonts.poppins(
                                                              color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                        ],
                                                      ),
                                                    ]
                                                )
                                              ],
                                            ),


                                          ],
                                        ),


                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30,),
                                Material(

                                  child: Container(
                                    width: 410,
                                    height: 260,

                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 100.0,left:250),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(height:5),
                                                  Opacity(
                                                    opacity:0.39,
                                                    child: Container(
                                                        width: 75,
                                                        height: 75,
                                                        child: Image.asset("assets/VIDHAANLOGO.png",fit: BoxFit.contain,)),
                                                  ),

                                                  Opacity(
                                                      opacity:0.39,
                                                      child: Text("e    d    u    c    a    r    e",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: 7),)),
                                                  SizedBox(height:7),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset("assets/id3bg3.png",color: pickerColor3,),
                                            Image.asset("assets/id3bg2.png",color: pickerColor3,),


                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:30.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(width:15),
                                                  Container(
                                                      width:60,
                                                      height:60,
                                                      child: Image.network(schoollogo)),
                                                  SizedBox(width:0),
                                                  Column(
                                                    crossAxisAlignment:CrossAxisAlignment.start,
                                                    children: [
                                                      Text(schoolname,style: GoogleFonts.poppins(
                                                          color: pickerColor3, fontSize: 15,fontWeight: FontWeight.w600),),
                                                      Text("Phone: +91 ${schoolphone}",style: GoogleFonts.poppins(
                                                          color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),
                                                      Text(schooladdress,style: GoogleFonts.poppins(
                                                          color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),
                                                      Text(schoolweb,style: GoogleFonts.poppins(
                                                          color: pickerColor3, fontSize: 9,fontWeight: FontWeight.w400),),


                                                    ],
                                                  ),

                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20.0,top:20),
                                                    child: Text("Emergency Contact",style: GoogleFonts.poppins(
                                                        color:  pickerColor3, fontSize: 15,fontWeight: FontWeight.w700),),
                                                  ),
                                                ],
                                              ),
                                           
                                              SizedBox(height: 5,),
                                              Row(
                                                children: [
                                                  SizedBox(width: 20,),
                                                  Container(
                                                    width: 110,
                                                    child: Text("Emergency Contact No : ",style: GoogleFonts.poppins(
                                                        color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                  ),
                                                  Text("9944861235",style: GoogleFonts.poppins(
                                                      color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: 20,),
                                                  Container(
                                                    width: 110,
                                                    child: Text("Address : ",style: GoogleFonts.poppins(

                                                        color: pickerColor3, fontSize: 12,fontWeight: FontWeight.w600),),
                                                  ),
                                                  Text("No120/2 Kolathur \nChennai",style: GoogleFonts.poppins(
                                                      color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
                                                ],
                                              ),

                                             
                                            ],
                                          ),
                                        ),




                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(width: 150,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10,),
                                Text("Card Design 3",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20),),
                                Text("Change Color:",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 15),),

                                Container(
                                  width: 465,
                                  child: ColorPicker(
                                    colorPickerWidth: 120,
                                    pickerColor: pickerColor3,
                                    onColorChanged: changeColor3,
                                    hexInputBar: true,
                                    enableAlpha: false,
                                    displayThumbColor: false,

                                    onHistoryChanged: (value)  {
                                      print(value);
                                    },

                                    onHsvColorChanged: (value)  {
                                      print(value);
                                    },

                                  ),
                                ),
                                SizedBox(height: 10,),
                                InkWell(
                                  onTap: (){
                                    selectdesign("3");
                                    Successdialog();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Center(
                                          child: Text(
                                            "Select Design",
                                            style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),
                                          )),
                                      width: width/6.83,
                                      //color: Color(0xff00A0E3),
                                      height: height/16.425,
                                      decoration: BoxDecoration(
                                          color: Color(0xff53B175),
                                          borderRadius: BorderRadius.circular(6)),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20,)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
  Successdialog(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Design Changed Successfully',
      desc: '',


      btnOkText: "Ok",
      btnOkOnPress: () {

      },
    )..show();
  }
  selectdesign(value) async {
    var document = await FirebaseFirestore.instance.collection("Admin").get();
    FirebaseFirestore.instance.collection("Admin").doc(document.docs[0].id).update({

      "idcard":value
    });
    getadmin();
  }

}
