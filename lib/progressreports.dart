import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as sfc;
import 'package:vidhaan/Masters/excelgen.dart';
import 'package:vidhaan/photoview.dart';
import 'package:vidhaan/print/fees_print.dart';
import 'package:vidhaan/print/progress_report_print.dart';
import 'package:vidhaan/studententryedit.dart';
import 'attendence.dart';
import 'models/student_csv_model.dart';
import 'package:pdf/pdf.dart';

class ProgressReport extends StatefulWidget {
  const ProgressReport({super.key});

  @override
  State<ProgressReport> createState() => _ProgressReportState();
}

class _ProgressReportState extends State<ProgressReport> {

  bool view=false;
  int view1=0;
  String studentid="";
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

  List<StudentModelForCsv> studentsListForCsv = [];


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
  static final List<String> classes = ["Select Option"];

  static List<String> getSuggestionsclass(String query) {
    List<String> matches = <String>[];
    matches.addAll(classes);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionssection(String query) {
    List<String> matches = <String>["Select Option"];
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
    setState(() {
      search=true;
      byclass=false;
    });
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
    getAdmin();
    adddropdownvalue();
    setState(() {
      _typeAheadControllerclass.text="Select Option";
      _typeAheadControllersection.text="Select Option";
    });
    // TODO: implement initState
    super.initState();
  }
  bool search= false;
  bool byclass = false;
  bool mainconcent= false;
  final check = List<bool>.generate(1000, (int index) => false, growable: true);

  getAdmin() async {
    var admin = await FirebaseFirestore.instance.collection('Admin').get();

    setState(() {
      schoolName = admin.docs.first.get("schoolname");
      schoolLogo = admin.docs.first.get("logo");
      schoolAddress = admin.docs.first.get("area")+","+admin.docs.first.get("city")+"-"+admin.docs.first.get("pincode");
    });
  }

  bool viewFullReport = false;
  String schoolName = '';
  String schoolAddress = '';
  String schoolLogo = '';

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Container(
                width: width/1.050,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),child: Padding(
                padding: const EdgeInsets.only(left: 10.0,top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Progress Reports",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),),
                        SizedBox(width: 650,),

                        SizedBox(width: 10,),
                        InkWell(
                          onTap: (){
                            setState(() {
                              search=false;
                              byclass=false;
                              _typeAheadControllerstudent.clear();
                              _typeAheadControllerregno.clear();
                              _typeAheadControllerclass.text="Select Option";
                              _typeAheadControllersection.text="Select Option";
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
                        SizedBox(width: 10,),
                        InkWell(
                          onTap: (){
                            setState(() {

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
                                  child: Icon(Icons.print,color: Colors.white,),
                                ),
                                Text("Print",style: GoogleFonts.poppins(color:Colors.white),),
                              ],
                            )),
                              width: width/10.507,
                              height: height/20.425,
                              // color:Color(0xff00A0E3),
                              decoration: BoxDecoration(color:  Color(0xff53B175),borderRadius: BorderRadius.circular(5)),

                            ),
                          ),
                        ),

                       /* Excelsheet(check,mainconcent,studentsListForCsv),*/
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
                                child: Text("Register Number",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
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
                                        fontSize: width/91.066666667
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
                                  value!.isEmpty ? 'Please select a regno' : null,
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
                                child: Text("Student Name",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
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
                                          fontSize: width/91.066666667
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
                                    value!.isEmpty ? 'Please select a option' : null,
                                    onSaved: (value) => this._selectedCity = value,
                                  ),

                                ),
                              ),

                            ],

                          ),
                          InkWell(
                            onTap: (){
                              if(_typeAheadControllerstudent.text==""||_typeAheadControllerregno.text==""){

                              }
                              else {
                                getstaffbyid();
                              }
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
                                child: Text("By Class",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
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
                                                fontSize: width/91.066666667
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
                                            fontSize: width/91.066666667
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
                                child: Text("By Section",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
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
                                                fontSize: width/91.066666667
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
                                            fontSize: width/91.066666667
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
                              if(_typeAheadControllerclass.text=="Select Option"||_typeAheadControllersection.text=="Select Option"){

                              }
                              else {
                                setState(() {
                                  byclass = true;
                                  search = false;
                                });
                              }
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
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0,top: 20),
              child: Container(
                width:  width/1.050,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                child:  Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: !viewFullReport,
                      maintainAnimation: true,
                      maintainState: true,
                      child: Padding(
                        padding: const EdgeInsets.only(top:12.0),
                        child: AnimatedOpacity(
                          opacity: !viewFullReport ? 1 : 0,
                          duration: Duration(milliseconds: 1500),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height:height/13.14,
                                  width: width/1.866,
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
                                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                                        child: Text(
                                          "Profile",
                                          style:
                                          GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 35.0, right: 40),
                                        child: Text(
                                          "App No",
                                          style:
                                          GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0.0, right: 40),
                                        child: Text(
                                          "Roll No",
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

                                      /* Padding(
                                        padding: const EdgeInsets.only(left: 55.0, right: 62),
                                        child: Text(
                                          "Gender",
                                          style:
                                          GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                        ),
                                      ),

                                      */
                                      Padding(
                                        padding: const EdgeInsets.only(left: 50),
                                        child: Text(
                                          "Actions",
                                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //color: Colors.pink,


                                ),
                              ),
                              Container(
                                width: width/1.866,
                                height: 600,
                                child: StreamBuilder<QuerySnapshot>(
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
                                      studentsListForCsv.clear();
                                      if(search == true){
                                        snapshot.data!.docs.forEach((element) {
                                          if(element.id == studentid){
                                            studentsListForCsv.add(
                                                StudentModelForCsv(
                                                  name: element.get("stname"),
                                                  clasS: element.get("admitclass"),
                                                  height:element.get("sheight"),
                                                  phone:element.get("mobile"),
                                                  email: element.get("email"),
                                                  dob: element.get("dob"),
                                                  bloodGroup: element.get("bloodgroup"),
                                                  gender: element.get("gender"),
                                                  address: element.get("address"),
                                                  aadhaarNumber: element.get("aadhaarno"),
                                                  applicationNumber: element.get("regno"),
                                                  community: element.get("community"),
                                                  emiNo: element.get("EMIS"),
                                                  weight: element.get("stweight"),
                                                  fatherAadhaar: element.get("fatherAadhaar"),
                                                  fatherName: element.get("fathername"),
                                                  fatherOccupation:element.get("fatherOccupation"),
                                                  fatherOfficeAddress: element.get("fatherOffice"),
                                                  fatherPhone: element.get("fatherMobile"),
                                                  identificationMark: element.get("identificatiolmark"),
                                                  modeOfTransport: element.get("transport"),
                                                  motherAadhaar: element.get("motherAadhaar"),
                                                  motherName: element.get("mothername"),
                                                  motherOccupation: element.get("motherOccupation"),
                                                  motherPhone:element.get("motherMobile"),
                                                  religion: element.get("religion"),
                                                  section: element.get("section"),
                                                  guardianPhone: element.get("guardianMobile"),
                                                  lastName:element.get("stlastname"),
                                                  academicYear: element.get("academic"),
                                                  brotherName: element.get("brothername"),
                                                  brotherStudyingHere: element.get("brother studying here"),
                                                  fatherEmail: element.get("fatherEmail"),
                                                  guardianAadhaar: element.get("guardianAadhaar"),
                                                  guardianEmail: element.get("guardianEmail"),
                                                  guardianName: element.get("guardianname"),
                                                  guardianOccupation: element.get("guardianOccupation"),
                                                  house: element.get("house"),
                                                  motherEmail: element.get("motherEmail"),
                                                  motherOffice: element.get("motherOffice"),
                                                )
                                            );
                                          }
                                        });
                                      }else{
                                        snapshot.data!.docs.forEach((element) {
                                          studentsListForCsv.add(
                                              StudentModelForCsv(
                                                name: element.get("stname"),
                                                clasS: element.get("admitclass"),
                                                height:element.get("sheight"),
                                                phone:element.get("mobile"),
                                                email: element.get("email"),
                                                dob: element.get("dob"),
                                                bloodGroup: element.get("bloodgroup"),
                                                gender: element.get("gender"),
                                                address: element.get("address"),
                                                aadhaarNumber: element.get("aadhaarno"),
                                                applicationNumber: element.get("regno"),
                                                community: element.get("community"),
                                                emiNo: element.get("EMIS"),
                                                weight: element.get("stweight"),
                                                fatherAadhaar: element.get("fatherAadhaar"),
                                                fatherName: element.get("fathername"),
                                                fatherOccupation:element.get("fatherOccupation"),
                                                fatherOfficeAddress: element.get("fatherOffice"),
                                                fatherPhone: element.get("fatherMobile"),
                                                identificationMark: element.get("identificatiolmark"),
                                                modeOfTransport: element.get("transport"),
                                                motherAadhaar: element.get("motherAadhaar"),
                                                motherName: element.get("mothername"),
                                                motherOccupation: element.get("motherOccupation"),
                                                motherPhone:element.get("motherMobile"),
                                                religion: element.get("religion"),
                                                section: element.get("section"),
                                                guardianPhone: element.get("guardianMobile"),
                                                lastName:element.get("stlastname"),
                                                academicYear: element.get("academic"),
                                                brotherName: element.get("brothername"),
                                                brotherStudyingHere: element.get("brother studying here"),
                                                fatherEmail: element.get("fatherEmail"),
                                                guardianAadhaar: element.get("guardianAadhaar"),
                                                guardianEmail: element.get("guardianEmail"),
                                                guardianName: element.get("guardianname"),
                                                guardianOccupation: element.get("guardianOccupation"),
                                                house: element.get("house"),
                                                motherEmail: element.get("motherEmail"),
                                                motherOffice: element.get("motherOffice"),
                                              )
                                          );
                                        });
                                      }
                                      return ListView.builder(

                                          shrinkWrap: true,
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context,index){
                                            var value = snapshot.data!.docs[index];
                                            return  search==true? value.id==studentid? Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: width/1.366,
                                                child: Row(
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
                                                      padding: const EdgeInsets.only(left:10.0),
                                                      child: Material(
                                                        elevation: 1,
                                                        borderRadius: BorderRadius.circular(50),
                                                        child: Container(
                                                            width:50,
                                                            height: 50,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(50)
                                                            ),
                                                            child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(50),
                                                                child: Image.network(value["imgurl"],fit:BoxFit.cover))
                                                        ),
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
                                                      padding: const EdgeInsets.only(left: 2.0, right: 0),
                                                      child: Container(
                                                        width: width/13.66,

                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          value["rollno"],
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
                                                          "${value["stname"]} ${value["stlastname"]}",
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

                                                    /*   Padding(
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
                                                    ), */
                                                    InkWell(
                                                      onTap: (){
                                                        setState(() {
                                                          studentid=value.id;
                                                          view=true;
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.only(left: 20.0),
                                                        child: Container(
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
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                                //color: Colors.pink,


                                              ),
                                            ) : Container(): byclass==true? "${value["admitclass"]}${value["section"]}"=="${_typeAheadControllerclass.text}${_typeAheadControllersection.text}"?
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: width/1.366,
                                                child: Row(
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
                                                      padding: const EdgeInsets.only(left:10.0),
                                                      child: Material(
                                                        elevation: 1,
                                                        borderRadius: BorderRadius.circular(50),
                                                        child: Container(
                                                            width:50,
                                                            height: 50,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(50)
                                                            ),
                                                            child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(50),
                                                                child: Image.network(value["imgurl"],fit:BoxFit.cover))
                                                        ),
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
                                                      padding: const EdgeInsets.only(left: 2.0, right: 0),
                                                      child: Container(
                                                        width: width/13.66,

                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          value["rollno"],
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
                                                          "${value["stname"]} ${value["stlastname"]}",
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


                                                    /*   Padding(
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
                                                    ), */
                                                    InkWell(
                                                      onTap: (){
                                                        setState(() {
                                                          studentid=value.id;
                                                          view=true;
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.only(left: 20.0),
                                                        child: Container(
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
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                                //color: Colors.pink,


                                              ),
                                            ) : Container() :
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: width/1.366,
                                                child: Row(
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
                                                      padding: const EdgeInsets.only(left:10.0),
                                                      child: Material(
                                                        elevation: 1,
                                                        borderRadius: BorderRadius.circular(50),
                                                        child: Container(
                                                            width:50,
                                                            height: 50,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(50)
                                                            ),
                                                            child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(50),
                                                                child: Image.network(value["imgurl"],fit:BoxFit.cover))
                                                        ),
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
                                                      padding: const EdgeInsets.only(left: 2.0, right: 0),
                                                      child: Container(
                                                        width: width/13.66,

                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          value["rollno"],
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
                                                          "${value["stname"]} ${value["stlastname"]}",
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

                                                    /*   Padding(
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
                                                    ), */
                                                    InkWell(
                                                      onTap: (){
                                                        setState(() {
                                                          studentid=value.id;
                                                          view=true;
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.only(left: 20.0),
                                                        child: Container(
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
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                                //color: Colors.pink,


                                              ),
                                            );
                                          });

                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    view==true?
                    ShowUpAnimation(
                      curve: Curves.easeInOut,
                      direction: Direction.horizontal,
                      delayStart: Duration(milliseconds: 200),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(12),
                          child: FutureBuilder(
                            future: FirebaseFirestore.instance.collection('Students').doc(studentid).get(),
                            builder: (ctx ,snap){
                              if(snap.hasData){
                                Map<String,dynamic>? value = snap.data!.data();
                                return Row(
                                  children: [
                                    Container(
                                      width: 350,
                                      height: 640,
                                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Material(
                                            elevation: 15,
                                            borderRadius: BorderRadius.circular(15),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:Colors.white,
                                                  borderRadius: BorderRadius.circular(15)
                                              ),
                                              width: 350,
                                              height: 640,
                                              child: Column(
                                                children: [
                                                  SizedBox(height:height/30,),
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(builder: (context)=>Photoviewpage(value['imgurl']))
                                                      );
                                                    },
                                                    child: CircleAvatar(

                                                      radius: width/26.6666,
                                                      backgroundImage:  NetworkImage(value!['imgurl']==""?"https://firebasestorage.googleapis.com/v0/b/vidhaan-4aee7.appspot.com/o/360_F_270188580_YDUEwBmDIxBMvCQxkcunmEkm93VqOgqm.jpg?alt=media&token=fe18ba43-4a31-4b53-9523-42bb4241d9a1"
                                                          :value['imgurl']),

                                                    ),
                                                  ),

                                                  SizedBox(height:height/52.15,),
                                                  Center(
                                                    child:Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text('${value["stname"]} ${value["stlastname"]}',style: GoogleFonts.montserrat(
                                                            fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                        ),),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height:height/130.3,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text('Application No :',style: GoogleFonts.montserrat(
                                                          fontWeight:FontWeight.w500,color: Colors.black,fontSize: width/124.4
                                                      ),),
                                                      Text(value['regno'],style: GoogleFonts.montserrat(
                                                          fontWeight:FontWeight.w500,color: Colors.black,fontSize: width/124.4
                                                      ),),
                                                    ],
                                                  ),


                                                  SizedBox(height:height/52.15),
                                                  Divider(),
                                                  SizedBox(height:height/32.85,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [

                                                      Text('Feedback History',style: GoogleFonts.montserrat(
                                                          fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                      ),),
                                                    ],
                                                  ),
                                                  SizedBox(height:height/54.76,),

                                                  StreamBuilder(
                                                      stream: FirebaseFirestore.instance.collection('Students').doc(studentid).collection("Feedback").orderBy("timestamp").limit(3).snapshots(),
                                                      builder: (context,snap){

                                                        return ListView.builder(
                                                            shrinkWrap: true,
                                                            itemCount: snap.data!.docs.length,
                                                            itemBuilder: (context,index){

                                                              return Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Material(
                                                                  elevation: 4,
                                                                  borderRadius: BorderRadius.circular(12),
                                                                  shadowColor:  Color(0xff53B175),
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(12),
                                                                        border:Border.all(color: Color(0xff53B175))
                                                                    ),
                                                                    child: ListTile(
                                                                      title: Text(snap.data!.docs[index]["remarks"],style:GoogleFonts
                                                                          .poppins(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize: width/85.375,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w600),),
                                                                      subtitle: Text("- By ${snap.data!.docs[index]["staffname"]}",style:GoogleFonts
                                                                          .poppins(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize: width/136.6,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w600),),
                                                                      trailing: Container(
                                                                        height: 27,
                                                                        width: 85,
                                                                        //   "Outstanding", "Excellent", "Good","Satisfactory", "Focus Needed"
                                                                        decoration: BoxDecoration(
                                                                            color: snap.data!.docs[index]["value"]
                                                                                == "Good" ? Colors.yellow
                                                                                : snap.data!.docs[index]["value"] == "Outstanding"
                                                                                ? Color(0xff00A99D):
                                                                            snap.data!.docs[index]["value"] == "Excellent"
                                                                                ? Colors.green:
                                                                            snap.data!.docs[index]["value"] == "Satisfactory"
                                                                                ? Colors.orange:
                                                                            snap.data!.docs[index]["value"] == "Focus Needed"
                                                                                ? Colors.red
                                                                                : Colors.orange,
                                                                            borderRadius:
                                                                            BorderRadius
                                                                                .circular(
                                                                                5)),
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                          children: [

                                                                            Text(
                                                                              snap.data!.docs[index]["value"],
                                                                              style: GoogleFonts
                                                                                  .poppins(
                                                                                  color: Colors
                                                                                      .white,
                                                                                  fontSize: width/124.181818182,
                                                                                  fontWeight:
                                                                                  FontWeight
                                                                                      .w600),
                                                                            ),
                                                                            // Icon(
                                                                            //   snapshot
                                                                            //       .data!
                                                                            //       .docs[index]["value"] ==
                                                                            //       "Good"
                                                                            //       ? Icons
                                                                            //       .thumb_up_outlined
                                                                            //       : Icons
                                                                            //       .thumb_down_alt_outlined,
                                                                            //   color: Colors
                                                                            //       .white,
                                                                            //   size: 16,),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            });

                                                      }),

                                                  SizedBox(height:height/34.76,),
                                                  GestureDetector(
                                                    onTap: (){

                                                      // setState(() {
                                                      //   view1=3;
                                                      // });
                                                      setState(() {
                                                        if(viewFullReport){
                                                          viewFullReport = false;
                                                        }else{
                                                          viewFullReport = true;
                                                        }
                                                      });

                                                    },
                                                    child: Container(width: width/5.464,
                                                      height: height/16.425,
                                                      // color:Color(0xff00A0E3),
                                                      decoration: BoxDecoration(color: Color(0xffFFA002),borderRadius: BorderRadius.circular(5)),
                                                      child: Center(
                                                          child: Text(
                                                            viewFullReport ? "Close Full Reports" : "View Full Reports",
                                                            style: GoogleFonts.poppins(color:Colors.white,fontWeight: FontWeight.w600),)),

                                                    ),
                                                  ),




                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: viewFullReport,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top:12.0),
                                        child: AnimatedOpacity(
                                          opacity: viewFullReport ? 1 : 0,
                                          duration: Duration(milliseconds: 1500),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height:height/13.14,
                                                  width: width/1.866,
                                                  decoration: BoxDecoration(
                                                    color:Color(0xff00A0E3),
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          '${value["stname"]} ${value["stlastname"]} Progress Reports',
                                                          style:
                                                          GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                                                        ),
                                                        IconButton(
                                                          onPressed: (){
                                                            setState(() {
                                                              viewFullReport = false;
                                                            });
                                                          },
                                                          icon: Icon(
                                                            Icons.cancel,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              FutureBuilder<List<ExamWithSubjectModel>>(
                                                future: getStudentReport(studentid,value['admitclass'],value['section']),
                                                builder: (ctx, snap){
                                                  if(snap.hasData){
                                                    List<ExamWithSubjectModel> exams = snap.data!;
                                                    return Container(
                                                      width: width/1.866,
                                                      height: 600,
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                        child: SingleChildScrollView(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(height: 10),

                                                              FutureBuilder(
                                                                future: getMonthlyAttendanceReportForStudent(studentid),
                                                                builder: (ctx, snapshot){
                                                                  if(snapshot.hasData){
                                                                    return Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Column(
                                                                            children: [
                                                                              Row(
                                                                                mainAxisAlignment : MainAxisAlignment.center,
                                                                                children: [
                                                                                  SizedBox(width: 50),
                                                                                  CircularPercentIndicator(
                                                                                    circularStrokeCap: CircularStrokeCap.round,
                                                                                    radius: 45.0,
                                                                                    lineWidth: 10.0,
                                                                                    percent: getStudentAttendancePersantage(snapshot.data!).present,
                                                                                    center:  Text("${((getStudentAttendancePersantage(snapshot.data!).present)*100).toInt()}%",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500)),
                                                                                    progressColor: Colors.green,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all( 8.0),
                                                                                    child:  ChoiceChip(
                                                                                      label: Text(
                                                                                        "${(getStudentAttendancePersantage(snapshot.data!).present * getStudentAttendancePersantage(snapshot.data!).total)} Present  ",style: TextStyle(color: Colors.white),),
                                                                                      onSelected: (bool selected) {
                                                                                        setState(() {

                                                                                        });
                                                                                      },
                                                                                      selectedColor: Colors.green,
                                                                                      shape: StadiumBorder(
                                                                                          side: BorderSide(
                                                                                              color: Color(0xff53B175))),
                                                                                      backgroundColor: Colors.white,
                                                                                      labelStyle: TextStyle(color: Colors.black),

                                                                                      elevation: 1.5, selected: true,),

                                                                                  ),
                                                                                  SizedBox(width: 50),
                                                                                  CircularPercentIndicator(
                                                                                    circularStrokeCap: CircularStrokeCap.round,
                                                                                    radius: 45.0,
                                                                                    lineWidth: 10.0,
                                                                                    percent: getStudentAttendancePersantage(snapshot.data!).absent,
                                                                                    center:  Text("${((getStudentAttendancePersantage(snapshot.data!).absent)*100).toInt()}%",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500)),
                                                                                    progressColor: Colors.red,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all( 8.0),
                                                                                    child:  ChoiceChip(
                                                                                      label: Text(
                                                                                        "${(getStudentAttendancePersantage(snapshot.data!).absent * getStudentAttendancePersantage(snapshot.data!).total)} Present  ",style: TextStyle(color: Colors.white),),
                                                                                      onSelected: (bool selected) {
                                                                                        setState(() {

                                                                                        });
                                                                                      },
                                                                                      selectedColor: Colors.red,
                                                                                      shape: StadiumBorder(
                                                                                          side: BorderSide(
                                                                                              color: Colors.red)),
                                                                                      backgroundColor: Colors.white,
                                                                                      labelStyle: TextStyle(color: Colors.black),

                                                                                      elevation: 1.5, selected: true,),

                                                                                  ),
                                                                                  SizedBox(width: 50),
                                                                                ],
                                                                              ),
                                                                            ]
                                                                        )
                                                                      ],
                                                                    );
                                                                  }return Container();
                                                                },
                                                              ),
                                                              SizedBox(height: 30),
                                                              Text(
                                                                "Exam Reports",
                                                                style: TextStyle(
                                                                  fontSize: width/80.352941176,
                                                                  fontWeight: FontWeight.w700,
                                                                ),
                                                              ),
                                                              SizedBox(height: 30),
                                                              Row(
                                                                children: [
                                                                  for(int i = 0; i < exams.length+1; i++)
                                                                    Column(
                                                                      children: [
                                                                        for(int j = 0; j < exams.first.subjects.length+1; j++)
                                                                         j == 0
                                                                             ? Container(
                                                                            height: j==0 ? 60 : 50,
                                                                            width: 180,
                                                                            decoration: BoxDecoration(
                                                                              color: Colors.transparent,
                                                                              //color: j == 0 ? Color(0xffF7983E) : i ==0 ? Color(0xffA75BF4) : Colors.transparent,
                                                                              border: Border.all(),
                                                                            ),
                                                                            child: Column(
                                                                              children: [
                                                                                Container(
                                                                                  height: (i == 0 && j == 0) ? 58 : 30,
                                                                                  width: 180,
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      (i == 0 && j == 0)
                                                                                          ? "Subject/Exams"
                                                                                          : j == 0
                                                                                          ? exams[i-1].examName
                                                                                          : "",
                                                                                      textAlign: TextAlign.center,
                                                                                      style: TextStyle(
                                                                                        color: Colors.black,
                                                                                        //color: (i == 0 || j == 0) ? Colors.white : Colors.black,
                                                                                        fontWeight: (i == 0 || j == 0) ? FontWeight.w900 : FontWeight.w400,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Visibility(
                                                                                  visible: i != 0,
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Container(
                                                                                        height: 28,
                                                                                        width: 60,
                                                                                        decoration: const BoxDecoration(
                                                                                          color: Colors.transparent,
                                                                                            border: Border(
                                                                                              right: BorderSide(),
                                                                                              top: BorderSide(),
                                                                                            )
                                                                                        ),
                                                                                        child: Center(
                                                                                          child: Text(
                                                                                            "Max",
                                                                                            textAlign: TextAlign.center,
                                                                                            style: TextStyle(
                                                                                              color: Colors.black,
                                                                                              //color: (i == 0 || j == 0) ? Colors.white : Colors.black,
                                                                                              fontWeight: (i == 0 || j == 0) ? FontWeight.w900 : FontWeight.w400,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        height: 28,
                                                                                        width: 59,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Colors.transparent,
                                                                                            border: Border(
                                                                                              right: BorderSide(),
                                                                                              top: BorderSide(),
                                                                                            )
                                                                                        ),
                                                                                        child: Center(
                                                                                          child: Text(
                                                                                            "Mark",
                                                                                            textAlign: TextAlign.center,
                                                                                            style: TextStyle(
                                                                                              color: Colors.black,
                                                                                              //color: (i == 0 || j == 0) ? Colors.white : Colors.black,
                                                                                              fontWeight: (i == 0 || j == 0) ? FontWeight.w900 : FontWeight.w400,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        height: 28,
                                                                                        width: 59,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Colors.transparent,
                                                                                            border: Border(
                                                                                              top: BorderSide(),
                                                                                            )
                                                                                        ),
                                                                                        child: Center(
                                                                                          child: Text(
                                                                                            "Grade",
                                                                                            textAlign: TextAlign.center,
                                                                                            style: TextStyle(
                                                                                              color: Colors.black,
                                                                                              //color: (i == 0 || j == 0) ? Colors.white : Colors.black,
                                                                                              fontWeight: (i == 0 || j == 0) ? FontWeight.w900 : FontWeight.w400,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          )
                                                                             : i == 0
                                                                             ? Container(
                                                                           height: j==0 ? 60 : 50,
                                                                           width: 180,
                                                                           decoration: BoxDecoration(
                                                                             color: Colors.transparent,
                                                                             //color: j == 0 ? Color(0xffF7983E) : i ==0 ? Color(0xffA75BF4) : Colors.transparent,
                                                                             border: Border.all(),
                                                                           ),
                                                                           child: Center(
                                                                             child: Text(
                                                                               (i == 0 && j == 0)
                                                                                   ? ""
                                                                                   : j == 0
                                                                                   ? exams[i-1].examName
                                                                                   : i == 0
                                                                                   ? exams[0].subjects[j-1].name
                                                                                   : exams[i-1].subjects[j-1].mark,
                                                                               textAlign: TextAlign.center,
                                                                               style: TextStyle(
                                                                                 color: Colors.black,
                                                                                 //color: (i == 0 || j == 0) ? Colors.white : Colors.black,
                                                                                 fontWeight: (i == 0 || j == 0) ? FontWeight.w900 : FontWeight.w400,
                                                                               ),
                                                                             ),
                                                                           ),
                                                                         )
                                                                             : Row(
                                                                               children: [
                                                                                 Container(
                                                                                   height: j==0 ? 60 : 50,
                                                                                   width: 60,
                                                                                   decoration: BoxDecoration(
                                                                                     color: Colors.transparent,
                                                                                     //color: j == 0 ? Color(0xffF7983E) : i ==0 ? Color(0xffA75BF4) : Colors.transparent,
                                                                                     border: Border.all(),
                                                                                   ),
                                                                                   child: Center(
                                                                                     child: Text(
                                                                                       (i == 0 && j == 0)
                                                                                           ? ""
                                                                                           : j == 0
                                                                                           ? exams[i-1].examName
                                                                                           : i == 0
                                                                                           ? exams[0].subjects[j-1].name
                                                                                           : exams[i-1].subjects[j-1].totalMark,
                                                                                       textAlign: TextAlign.center,
                                                                                       style: TextStyle(
                                                                                         color: Colors.black,
                                                                                         //color: (i == 0 || j == 0) ? Colors.white : Colors.black,
                                                                                         fontWeight: (i == 0 || j == 0) ? FontWeight.w900 : FontWeight.w400,
                                                                                       ),
                                                                                     ),
                                                                                   ),
                                                                                 ),
                                                                                 Container(
                                                                                     height: j==0 ? 60 : 50,
                                                                                     width: 60,
                                                                                     decoration: BoxDecoration(
                                                                                       color: Colors.transparent,
                                                                                       //color: j == 0 ? Color(0xffF7983E) : i ==0 ? Color(0xffA75BF4) : Colors.transparent,
                                                                                       border: Border.all(),
                                                                                     ),
                                                                                     child: Center(
                                                                                       child: Text(
                                                                                         (i == 0 && j == 0)
                                                                                             ? ""
                                                                                             : j == 0
                                                                                             ? exams[i-1].examName
                                                                                             : i == 0
                                                                                             ? exams[0].subjects[j-1].name
                                                                                             : exams[i-1].subjects[j-1].mark,
                                                                                         textAlign: TextAlign.center,
                                                                                         style: TextStyle(
                                                                                           color: Colors.black,
                                                                                           //color: (i == 0 || j == 0) ? Colors.white : Colors.black,
                                                                                           fontWeight: (i == 0 || j == 0) ? FontWeight.w900 : FontWeight.w400,
                                                                                         ),
                                                                                       ),
                                                                                     ),
                                                                         ),
                                                                                 Container(
                                                                                   height: j==0 ? 60 : 50,
                                                                                   width: 60,
                                                                                   decoration: BoxDecoration(
                                                                                     color: Colors.transparent,
                                                                                     //color: j == 0 ? Color(0xffF7983E) : i ==0 ? Color(0xffA75BF4) : Colors.transparent,
                                                                                     border: Border.all(),
                                                                                   ),
                                                                                   child: Center(
                                                                                     child: Text(
                                                                                       (i == 0 && j == 0)
                                                                                           ? ""
                                                                                           : j == 0
                                                                                           ? exams[i-1].examName
                                                                                           : i == 0
                                                                                           ? exams[0].subjects[j-1].name
                                                                                           : getGrade(exams[i-1].subjects[j-1].mark,exams[i-1].subjects[j-1].totalMark) ,
                                                                                       textAlign: TextAlign.center,
                                                                                       style: TextStyle(
                                                                                         color: Colors.black,
                                                                                         //color: (i == 0 || j == 0) ? Colors.white : Colors.black,
                                                                                         fontWeight: (i == 0 || j == 0) ? FontWeight.w900 : FontWeight.w400,
                                                                                       ),
                                                                                     ),
                                                                                   ),
                                                                                 ),
                                                                               ],
                                                                             )
                                                                      ],
                                                                    )
                                                                ],
                                                              ),
                                                              SizedBox(height: 30),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Container(
                                                                    height: 25,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(3),
                                                                      border: Border.all(),
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(3),
                                                                              color: Color(0xffA75BF4)
                                                                          ),
                                                                          child: Center(
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                              child: Text(
                                                                                "432",
                                                                                style: TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.w700
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                                                          child: Text(
                                                                            "Total",
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w700
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 30),
                                                                  Container(
                                                                    height: 25,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(3),
                                                                      border: Border.all(),
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(3),
                                                                              color: Color(0xffF7983E)
                                                                          ),
                                                                          child: Center(
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                              child: Text(
                                                                                "90",
                                                                                style: TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.w700
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                                                          child: Text(
                                                                            "Percentage",
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w700
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 30),
                                                                  Container(
                                                                    height: 25,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(3),
                                                                      border: Border.all(),
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(3),
                                                                              color: Color(0xff5B98F4)
                                                                          ),
                                                                          child: Center(
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                              child: Text(
                                                                                "A+",
                                                                                style: TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.w700
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                                                          child: Text(
                                                                            "Grade",
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w700
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 30),
                                                                  Container(
                                                                    height: 25,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(3),
                                                                      border: Border.all(),
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(3),
                                                                              color: Color(0xffF73E3E)
                                                                          ),
                                                                          child: Center(
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                              child: Text(
                                                                                "12",
                                                                                style: TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.w700
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                                                          child: Text(
                                                                            "Rank",
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w700
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 30),
                                                                  InkWell(
                                                                    onTap: ()  {
                                                                      print("S1");
                                                                       generateProgressReportPdf(PdfPageFormat.a4, exams, value,schoolName,schoolAddress,schoolLogo);
                                                                    },
                                                                    child: Container(
                                                                      height: 25,
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.lightBlue,
                                                                        borderRadius: BorderRadius.circular(3),
                                                                      ),
                                                                      child: Center(
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                          child: Text(
                                                                            "Print",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w700
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }return Container(
                                                    width: width/1.866,
                                                    height: 600,
                                                    child: Stack(
                                                      alignment: Alignment.center,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                          child: SingleChildScrollView(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(height: 10),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                       children: [
                                                                         Row(
                                                                           mainAxisAlignment : MainAxisAlignment.center,
                                                                           children: [
                                                                             SizedBox(width: 50),
                                                                             CircularPercentIndicator(
                                                                               circularStrokeCap: CircularStrokeCap.round,
                                                                               radius: 45.0,
                                                                               lineWidth: 10.0,
                                                                               percent: 0.0,
                                                                               center:  Text("0.0%",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500)),
                                                                               progressColor: Colors.green,
                                                                             ),
                                                                             Padding(
                                                                               padding: const EdgeInsets.all( 8.0),
                                                                               child:  ChoiceChip(
                                                                                 label: Text(
                                                                                   "0 Present  ",style: TextStyle(color: Colors.white),),
                                                                                 onSelected: (bool selected) {
                                                                                   setState(() {

                                                                                   });
                                                                                 },
                                                                                 selectedColor: Colors.green,
                                                                                 shape: StadiumBorder(
                                                                                     side: BorderSide(
                                                                                         color: Color(0xff53B175))),
                                                                                 backgroundColor: Colors.white,
                                                                                 labelStyle: TextStyle(color: Colors.black),

                                                                                 elevation: 1.5, selected: true,),

                                                                             ),
                                                                             SizedBox(width: 50),
                                                                             CircularPercentIndicator(
                                                                               circularStrokeCap: CircularStrokeCap.round,
                                                                               radius: 45.0,
                                                                               lineWidth: 10.0,
                                                                               percent: 0.0,
                                                                               center:  Text("0.0%",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500)),
                                                                               progressColor: Colors.red,
                                                                             ),
                                                                             Padding(
                                                                               padding: const EdgeInsets.all( 8.0),
                                                                               child:  ChoiceChip(
                                                                                 label: Text(
                                                                                   "0 Absent ",style: TextStyle(color: Colors.white),),
                                                                                 onSelected: (bool selected) {
                                                                                   setState(() {

                                                                                   });
                                                                                 },
                                                                                 selectedColor: Colors.red,
                                                                                 shape: StadiumBorder(
                                                                                     side: BorderSide(
                                                                                         color: Color(0xff53B175))),
                                                                                 backgroundColor: Colors.white,
                                                                                 labelStyle: TextStyle(color: Colors.black),

                                                                                 elevation: 1.5, selected: true,),

                                                                             ),
                                                                             SizedBox(width: 50),
                                                                           ],
                                                                         ),
                                                                       ]
                                                                        )
                                                                  ],
                                                                ),
                                                                SizedBox(height: 30),
                                                                Text(
                                                                  "Exam Reports",
                                                                  style: TextStyle(
                                                                    fontSize: width/80.352941176,
                                                                    fontWeight: FontWeight.w700,
                                                                  ),
                                                                ),
                                                                SizedBox(height: 30),
                                                                Row(
                                                                  children: [
                                                                    for(int i = 0; i < 8; i++)
                                                                      Column(
                                                                        children: [
                                                                          for(int j =0; j < 7; j ++)
                                                                            Container(
                                                                              height: j == 0 ? 60 : 40,
                                                                              width: 80,
                                                                              decoration: BoxDecoration(
                                                                                  color: Colors.transparent,
                                                                                  border: Border.all(
                                                                                    color: Colors.black,
                                                                                  ),
                                                                              ),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  (i==0&&j==0)
                                                                                      ? "Sub/Exam"
                                                                                      : (i == 0  && j == 1)
                                                                                      ? "Tamil"
                                                                                      : (i == 0  && j == 2)
                                                                                      ? "English"
                                                                                      : (i == 0  && j == 3)
                                                                                      ? "Maths"
                                                                                      : (i == 0  && j == 4)
                                                                                      ? "Sci"
                                                                                      : (i == 0  && j == 5)
                                                                                      ? "Soc"
                                                                                      : (i == 0  && j == 6)
                                                                                      ? "EVS"
                                                                                      : (i == 1  && j == 0)
                                                                                      ? "I\nTerm"
                                                                                      : (i == 2  && j == 0)
                                                                                      ? "Per\nTest"
                                                                                      : (i == 3  && j == 0)
                                                                                      ? "II\nTerm"
                                                                                      : (i == 4  && j == 0)
                                                                                      ? "Half\nYearly"
                                                                                      : (i == 5  && j == 0)
                                                                                      ? "III\nTerm"
                                                                                      : (i == 6  && j == 0)
                                                                                      ? "Yearly\nExam"
                                                                                      : "",
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(
                                                                                      color: Colors.black,
                                                                                      fontWeight: FontWeight.w700
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                        ],
                                                                      )
                                                                  ],
                                                                ),
                                                                SizedBox(height: 30),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Container(
                                                                      height: 25,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(3),
                                                                        border: Border.all(),
                                                                      ),
                                                                      child: Row(
                                                                        children: [
                                                                          Container(
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(3),
                                                                              color: Color(0xffA75BF4)
                                                                            ),
                                                                            child: Center(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                child: Text(
                                                                                  "432",
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.w700
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                                                            child: Text(
                                                                              "Total",
                                                                              style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.w700
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(width: 30),
                                                                    Container(
                                                                      height: 25,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(3),
                                                                        border: Border.all(),
                                                                      ),
                                                                      child: Row(
                                                                        children: [
                                                                          Container(
                                                                            decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(3),
                                                                                color: Color(0xffF7983E)
                                                                            ),
                                                                            child: Center(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                child: Text(
                                                                                  "90",
                                                                                  style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.w700
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                                                            child: Text(
                                                                              "Percentage",
                                                                              style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.w700
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(width: 30),
                                                                    Container(
                                                                      height: 25,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(3),
                                                                        border: Border.all(),
                                                                      ),
                                                                      child: Row(
                                                                        children: [
                                                                          Container(
                                                                            decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(3),
                                                                                color: Color(0xff5B98F4)
                                                                            ),
                                                                            child: Center(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                child: Text(
                                                                                  "A+",
                                                                                  style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.w700
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                                                            child: Text(
                                                                              "Grade",
                                                                              style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.w700
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(width: 30),
                                                                    Container(
                                                                      height: 25,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(3),
                                                                        border: Border.all(),
                                                                      ),
                                                                      child: Row(
                                                                        children: [
                                                                          Container(
                                                                            decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(3),
                                                                                color: Color(0xffF73E3E)
                                                                            ),
                                                                            child: Center(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                child: Text(
                                                                                  "12",
                                                                                  style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.w700
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                                                            child: Text(
                                                                              "Rank",
                                                                              style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.w700
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        CircularProgressIndicator(),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }return Container();
                            },
                          ),
                        ),
                      ),
                    ) : SizedBox(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25,)
          ],
        ),
      ),
    );
  }


  Future<List<ExamWithSubjectModel>> getStudentReport(String Studentid,String Studentclass, String Studentsec) async {

    List<ExamWithSubjectModel> examsList = [];
    List subjectsList=[];
    List examnameList=[];
    int subjectcount = 0;

    var studentdata=await FirebaseFirestore.instance.collection("ClassMaster").where("name",isEqualTo:Studentclass).get();
    var examdata = await FirebaseFirestore.instance.collection("Students").doc(Studentid).collection("Exams").get();

    for(int i=0;i<studentdata.docs.length;i++){
      var Sectiondata= await FirebaseFirestore.instance.collection("ClassMaster").doc(studentdata.docs[i].id).
      collection("Sections").doc("${Studentclass}${Studentsec}").collection("Subjects").orderBy("timestamp").get();
      //setState(() {
        subjectcount=Sectiondata.docs.length;
      //});
      for(int j=0;j<Sectiondata.docs.length;j++){
        //setState(() {
          subjectsList.add(Sectiondata.docs[j]['name']);
        //});
      }
    }



    for(int i=0;i<examdata.docs.length;i++){
        examnameList.add(examdata.docs[i]['name']);
    }

    examsList.clear();
    for(int j = 0; j < examnameList.length; j++){
      List<Subjects> subjects1 = [];
      ExamWithSubjectModel exam = ExamWithSubjectModel(
          examName: examnameList[j], subjects: [],
      );
      for(int i=0;i<subjectsList.length;i++) {
        subjects1.add(
          Subjects(
            name: subjectsList[i],
            mark: "",
            totalMark: "",
          ),
        );
      }
      exam.subjects = subjects1;
      examsList.add(exam);
    }

    var document = await FirebaseFirestore.instance.collection("Students").doc(Studentid).collection("Exams").get();
    for(int i =0; i < examsList.length; i++){
      for(int j =0; j < examsList[i].subjects.length; j++){
        for(int m = 0; m < document.docs.length; m++){
          var document2 = await FirebaseFirestore.instance.collection("Students").doc(Studentid).collection("Exams").doc(document.docs[m].id).collection("Timetable").get();
          for (int n = 0; n < document2.docs.length; n++) {
            if (document2.docs[n]['exam'] == examsList[i].examName) {
              if (document2.docs[n]['name'] == examsList[i].subjects[j].name) {
                examsList[i].subjects[j].mark = document2.docs[n]['mark'];
                examsList[i].subjects[j].totalMark = document2.docs[n]['total'];
              }
            }
          }
        }
      }
    }

    return examsList;
  }

  Future<StudentAttendanceReportModel> getMonthlyAttendanceReportForStudent(String id) async {
    var snapshot = await FirebaseFirestore.instance.collection("Students").doc(id).collection('Attendance').get();
    List<SalesData> attendanceData = [];
    List<SalesData> attendanceData1 = [];
    List<SalesData> absentData = [];
    List<SalesData> absentData1 = [];
    List<String> presentDays = [];
    List<String> absentDays = [];
    snapshot.docs.forEach((element) async {
      int presentCount = 0;
      int absentCount = 0;
      if(element.get("Attendance").toString().toLowerCase() == "present"){
        presentCount++;
        DateTime startDate = DateFormat('dd-M-yyyy').parse(element.id);
        String month = await getMonthForData(startDate.month);
        SalesData sale = SalesData(month, presentCount.toDouble(),'',element.id);
        attendanceData.add(sale);
      }
      if(element.get("Attendance").toString().toLowerCase() == "absent"){
        absentCount++;
        DateTime startDate = DateFormat('dd-M-yyyy').parse(element.id);
        String month = await getMonthForData(startDate.month);
        SalesData sale = SalesData(month, absentCount.toDouble(),element.id,'');
        absentData.add(sale);
      }
    });
    await Future.delayed(Duration(seconds: 1));

    attendanceData.forEach((element) {
      presentDays.add(element.presentDay);
    });
    absentData.forEach((element) {
      absentDays.add(element.absentDay);
    });
    attendanceData1.add(SalesData('June',attendanceData.where((element) => element.year == 'June').length.toDouble(),'',''));

    attendanceData1.add(SalesData('July',attendanceData.where((element) => element.year == 'July').length.toDouble(),'',''));

    attendanceData1.add(SalesData('Aug',attendanceData.where((element) => element.year == 'Aug').length.toDouble(),'',''));

    attendanceData1.add(SalesData('Sep',attendanceData.where((element) => element.year == 'Sep').length.toDouble(),'',''));

    attendanceData1.add(SalesData('Oct',attendanceData.where((element) => element.year == 'Oct').length.toDouble(),'',''));

    attendanceData1.add(SalesData('Nov',attendanceData.where((element) => element.year == 'Nov').length.toDouble(),'',''));

    attendanceData1.add(SalesData('Dec',attendanceData.where((element) => element.year == 'Dec').length.toDouble(),'',''));
    attendanceData1.add(SalesData('Jan',attendanceData.where((element) => element.year == 'Jan').length.toDouble(),'',''));
    attendanceData1.add(SalesData('Feb',attendanceData.where((element) => element.year == 'Feb').length.toDouble(),'',''));

    attendanceData1.add(SalesData('Mar',attendanceData.where((element) => element.year == 'Mar').length.toDouble(),'',''));

    attendanceData1.add(SalesData('Apr',attendanceData.where((element) => element.year == 'Apr').length.toDouble(),'',''));




    absentData1.add(SalesData('June',absentData.where((element) => element.year == 'June').length.toDouble(),'',''));

    absentData1.add(SalesData('July',absentData.where((element) => element.year == 'July').length.toDouble(),'',''));

    absentData1.add(SalesData('Aug',absentData.where((element) => element.year == 'Aug').length.toDouble(),'',''));

    absentData1.add(SalesData('Sep',absentData.where((element) => element.year == 'Sep').length.toDouble(),'',''));

    absentData1.add(SalesData('Oct',absentData.where((element) => element.year == 'Oct').length.toDouble(),'',''));

    absentData1.add(SalesData('Nov',absentData.where((element) => element.year == 'Nov').length.toDouble(),'',''));

    absentData1.add(SalesData('Dec',absentData.where((element) => element.year == 'Dec').length.toDouble(),'',''));

    absentData1.add(SalesData('Jan',absentData.where((element) => element.year == 'Jan').length.toDouble(),'',''));

    absentData1.add(SalesData('Feb',absentData.where((element) => element.year == 'Feb').length.toDouble(),'',''));

    absentData1.add(SalesData('Mar',absentData.where((element) => element.year == 'Mar').length.toDouble(),'',''));

    absentData1.add(SalesData('Apr',absentData.where((element) => element.year == 'Apr').length.toDouble(),'',''));

    StudentAttendanceReportModel studentReport = StudentAttendanceReportModel(
      absentReport: absentData1,
      presentReport: attendanceData1,
      absentDays: absentDays,
      presentDays: presentDays,
    );
    return studentReport;
  }

  getMonthForData(int month){
    String result = '';
    switch(month){
      case 1:
        result = 'Jan';
        break;
      case 2:
        result = 'Feb';
        break;
      case 3:
        result = 'Mar';
        break;
      case 4:
        result = 'Apr';
        break;
      case 5:
        result = 'May';
        break;
      case 6:
        result = 'June';
        break;
      case 7:
        result = 'July';
        break;
      case 8:
        result = 'Aug';
        break;
      case 9:
        result = 'Sep';
        break;
      case 10:
        result = 'Oct';
        break;
      case 11:
        result = 'Nov';
        break;
      case 12:
        result = 'Dec';
        break;

    }
    return result;
  }

  StudentAttendancePercentage getStudentAttendancePersantage(StudentAttendanceReportModel report){
    double presentPersantage = 0.0;
    double absentPersantage = 0.0;
    double totalPersantage = 0.0;
    report.presentReport.forEach((element) {
      presentPersantage = presentPersantage + element.sales;
      totalPersantage = totalPersantage + element.sales;
    });
    report.absentReport.forEach((element) {
      absentPersantage = absentPersantage + element.sales;
      totalPersantage = totalPersantage + element.sales;
    });
    StudentAttendancePercentage percentage = StudentAttendancePercentage(
        present: (presentPersantage/totalPersantage),
        absent: (absentPersantage/totalPersantage),
        total: totalPersantage
    );
    return percentage;
  }

  String getGrade(String mark, String totalMark){
    String grade = '';
    double gradeVal = (mark != '' && totalMark != '') ? (int.parse(mark)/int.parse(totalMark)) * 100 : 0.0;
    if(gradeVal == 0.0){
      grade = '';
    }else if(gradeVal >= 91){
      grade = 'A1';
    }else if(gradeVal >= 81){
      grade = 'A2';
    }else if(gradeVal >= 71){
      grade = 'B1';
    }else if(gradeVal >= 61){
      grade = 'B2';
    }else if(gradeVal >= 51){
      grade = 'C1';
    }else if(gradeVal >= 41){
      grade = 'C2';
    }else if(gradeVal >= 33){
      grade = 'D';
    }else if(gradeVal >= 21){
      grade = 'E1';
    }else if(gradeVal <= 20){
      grade = 'E2';
    }
    return grade;
  }



}

class Stafffeebackclass {
  Stafffeebackclass({
    required this.staffname,
    required this.value,
    required this.date,
    required this.remarks,
    required this.time,
});
  String staffname;
  String value;
  String date;
  String remarks;
  String time;
}

class ResultModel{
  ResultModel({required this.MainList, required this.staffFeedbackList});
  List staffFeedbackList;
  List MainList;
}


class ExamWithSubjectModel {
  ExamWithSubjectModel({required this.examName, required this.subjects});
  String examName;
  List<Subjects> subjects;
}

class Subjects{
  Subjects({required this.name, required this.mark, required this.totalMark});
  String name;
  String mark;
  String totalMark;
}