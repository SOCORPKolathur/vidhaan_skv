import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/widgets.dart' as p;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:vidhaan/demopdf.dart';
import '../print/time_table_print.dart';

class ClassWiseTimeTable extends StatefulWidget {
  const ClassWiseTimeTable({Key? key}) : super(key: key);

  @override
  State<ClassWiseTimeTable> createState() => _ClassWiseTimeTableState();
}

class _ClassWiseTimeTableState extends State<ClassWiseTimeTable> {


  final texteditingmonday = List<TextEditingController>.generate(200, (int index) => TextEditingController(), growable: true);
  final textediting2 = List<TextEditingController>.generate(200, (int index) => TextEditingController(), growable: true);


  final TextEditingController _typeAheadControllerclass = TextEditingController();
  final TextEditingController _typeAheadControllersection = TextEditingController();


  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();

  static final List<String> classes = [];
  static List<String> getSuggestionsclass(String query) {
    List<String> matches = <String>[];
    matches.addAll(classes);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }


  static final List<String> subject = [];

  static List<String> getSuggestionsubject(String query) {
    List<String> matches = <String>[];
    matches.addAll(subject);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  String classid="";

  firstcall() async {
    var document3 = await  FirebaseFirestore.instance.collection("ClassMaster").orderBy("order").get();
    var document2 = await  FirebaseFirestore.instance.collection("SectionMaster").orderBy("order").get();
    setState(() {
      _typeAheadControllerclass.text=document3.docs[0]["name"];
      _typeAheadControllersection.text=document2.docs[0]["name"];
      classid=document3.docs[0].id;
    });
    subjectdrop();
    settimestable();

  }
  adddropvalue() async {
    setState(() {
      classes.clear();
      section.clear();
    });
    var document3 = await  FirebaseFirestore.instance.collection("ClassMaster").orderBy("order").get();
    var document2 = await  FirebaseFirestore.instance.collection("SectionMaster").orderBy("order").get();
    setState(() {
      classes.add("Select Option");
      section.add("Select Option");
    });
    for(int i=0;i<document3.docs.length;i++) {
      setState(() {
        classes.add(document3.docs[i]["name"]);
      });

    }
    for(int i=0;i<document2.docs.length;i++) {
      setState(() {
        section.add(document2.docs[i]["name"]);
      });

    }

  }
  subjectdrop() async {
    setState(() {
      subject.clear();
    });
    var document = await  FirebaseFirestore.instance.collection("ClassMaster").doc(classid).collection("Sections").doc("${_typeAheadControllerclass.text}${_typeAheadControllersection.text}").collection("Subjects").orderBy("timestamp").get();
    for(int i=0;i<document.docs.length;i++) {
      setState(() {
        subject.add(document.docs[i]["name"]);
      });
    }
  }

  static final List<String> section = [];
  static List<String> getSuggestionssection(String query) {
    List<String> matches = <String>[];
    matches.addAll(section);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  addtimetable() async {
    var documents= await FirebaseFirestore.instance.collection("ClassMaster").doc(classid).collection("Sections").doc("${_typeAheadControllerclass.text}${_typeAheadControllersection.text}").collection("Subjects").orderBy("timestamp").get();
    var documentstecher= await FirebaseFirestore.instance.collection("Staffs").get();


    for(int i=0;i<8;i++) {
      for(int j=0;j<documents.docs.length;j++) {
        if (texteditingmonday[i].text == documents.docs[j]["name"]) {
          FirebaseFirestore.instance.collection("ClassTimeTable").doc("${_typeAheadControllerclass.text}${_typeAheadControllersection.text}")
              .collection("TimeTable").doc("monday${i}").set({
            "subject": texteditingmonday[i].text,
            "staff": documents.docs[j]["staffname"],
            "order":i
          });
          for(int k=0;k<documentstecher.docs.length;k++){
            if(documents.docs[j]["staffid"]==documentstecher.docs[k]["regno"]){
              FirebaseFirestore.instance.collection("Staffs").doc(documentstecher.docs[k].id).collection("Timetable").doc("monday${i}").set({
                "subject": texteditingmonday[i].text,
                "class": _typeAheadControllerclass.text,
                "section": _typeAheadControllersection.text,
                "period":i,
                "day":"Monday",
              });
            }
          }
        }
      }
    }
    for(int i=8;i<16;i++) {
      for(int j=0;j<documents.docs.length;j++) {
        if (texteditingmonday[i].text == documents.docs[j]["name"]) {
          FirebaseFirestore.instance.collection("ClassTimeTable").doc("${_typeAheadControllerclass.text}${_typeAheadControllersection.text}")
              .collection("TimeTable").doc("tuesday${i}").set({
            "subject": texteditingmonday[i].text,
            "staff": documents.docs[j]["staffname"],
            "order":i
          });
          for(int k=0;k<documentstecher.docs.length;k++){
            if(documents.docs[j]["staffid"]==documentstecher.docs[k]["regno"]){
              FirebaseFirestore.instance.collection("Staffs").doc(documentstecher.docs[k].id).collection("Timetable").doc("tuesday${i}").set({
                "subject": texteditingmonday[i].text,
                "class": _typeAheadControllerclass.text,
                "section": _typeAheadControllersection.text,
                "period":i,
                "day":"Tuesday",
              });
            }
          }
        }
      }
    }
    for(int i=16;i<24;i++) {
      for(int j=0;j<documents.docs.length;j++) {
        if (texteditingmonday[i].text == documents.docs[j]["name"]) {
          FirebaseFirestore.instance.collection("ClassTimeTable").doc("${_typeAheadControllerclass.text}${_typeAheadControllersection.text}")
              .collection("TimeTable").doc("wednesday${i}").set({
            "subject": texteditingmonday[i].text,
            "staff": documents.docs[j]["staffname"],
            "order":i
          });
          for(int k=0;k<documentstecher.docs.length;k++){
            if(documents.docs[j]["staffid"]==documentstecher.docs[k]["regno"]){
              FirebaseFirestore.instance.collection("Staffs").doc(documentstecher.docs[k].id).collection("Timetable").doc("tuesday${i}").set({
                "subject": texteditingmonday[i].text,
                "class": _typeAheadControllerclass.text,
                "section": _typeAheadControllersection.text,
                "period":i,
                "day":"Wednesday",
              });
            }
          }
        }
      }
    }
    for(int i=24;i<32;i++) {
      for(int j=0;j<documents.docs.length;j++) {
        if (texteditingmonday[i].text == documents.docs[j]["name"]) {
          FirebaseFirestore.instance.collection("ClassTimeTable").doc("${_typeAheadControllerclass.text}${_typeAheadControllersection.text}")
              .collection("TimeTable").doc("thursday${i}").set({
            "subject": texteditingmonday[i].text,
            "staff": documents.docs[j]["staffname"],
            "staffid": documents.docs[j]["staffid"],
            "order":i
          });
          for(int k=0;k<documentstecher.docs.length;k++){
            if(documents.docs[j]["staffid"]==documentstecher.docs[k]["regno"]){
              FirebaseFirestore.instance.collection("Staffs").doc(documentstecher.docs[k].id).collection("Timetable").doc("tuesday${i}").set({
                "subject": texteditingmonday[i].text,
                "class": _typeAheadControllerclass.text,
                "section": _typeAheadControllersection.text,
                "period":i,
                "day":"Thursday",
              });
            }
          }
        }
      }
    }
    for(int i=32;i<40;i++) {
      for(int j=0;j<documents.docs.length;j++) {
        if (texteditingmonday[i].text == documents.docs[j]["name"]) {
          FirebaseFirestore.instance.collection("ClassTimeTable").doc("${_typeAheadControllerclass.text}${_typeAheadControllersection.text}")
              .collection("TimeTable").doc("friday${i}").set({
            "subject": texteditingmonday[i].text,
            "staff": documents.docs[j]["staffname"],
            "order":i
          });
          for(int k=0;k<documentstecher.docs.length;k++){
            if(documents.docs[j]["staffid"]==documentstecher.docs[k]["regno"]){
              FirebaseFirestore.instance.collection("Staffs").doc(documentstecher.docs[k].id).collection("Timetable").doc("tuesday${i}").set({
                "subject": texteditingmonday[i].text,
                "class": _typeAheadControllerclass.text,
                "section": _typeAheadControllersection.text,
                "period":i,
                "day":"Friday",
              });
            }
          }
        }
      }
    }
    for(int i=40;i<48;i++) {
      for(int j=0;j<documents.docs.length;j++) {
        if (texteditingmonday[i].text == documents.docs[j]["name"]) {
          FirebaseFirestore.instance.collection("ClassTimeTable").doc("${_typeAheadControllerclass.text}${_typeAheadControllersection.text}")
              .collection("TimeTable").doc("saturday${i}").set({
            "subject": texteditingmonday[i].text,
            "staff": documents.docs[j]["staffname"],
            "order":i
          });
          for(int k=0;k<documentstecher.docs.length;k++){
            if(documents.docs[j]["staffid"]==documentstecher.docs[k]["regno"]){
              FirebaseFirestore.instance.collection("Staffs").doc(documentstecher.docs[k].id).collection("Timetable").doc("tuesday${i}").set({
                "subject": texteditingmonday[i].text,
                "class": _typeAheadControllerclass.text,
                "section": _typeAheadControllersection.text,
                "period":i,
                "day":"Saturday",
              });
            }
          }
        }
      }
    }
  }
  getstaffbyid() async {
    print("fdgggggggggg");

    var document = await FirebaseFirestore.instance.collection("ClassMaster").get();
    for(int i=0;i<document.docs.length;i++){
      if(_typeAheadControllerclass.text==document.docs[i]["name"]){
        setState(() {
          classid= document.docs[i].id;
        }
        );
      }
      print("Class id: ${classid}");
    }
    print("fdgggggggggg");


  }
  Successdialog(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Time Table Assigned Successfully',
      desc: '',


      btnOkOnPress: () {

      },
    )..show();
  }
  Successdialog2(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Time Table cannot have null values',
      desc: '',


      btnOkOnPress: () {

      },
    )..show();
  }
  @override
  void initState() {
    setState(() {
      _typeAheadControllerclass.text="Select Option";
      _typeAheadControllersection.text="Select Option";
    });
    firstcall();
    adddropvalue();
    // TODO: implement initState
    super.initState();
  }


  settimestable() async {
    var snap = await FirebaseFirestore.instance.collection("ClassTimeTable").doc("${_typeAheadControllerclass.text}${_typeAheadControllersection.text}").collection("TimeTable").orderBy("order").get();
    var value=snap.docs;
    setState(() {
      texteditingmonday[0].text=snap.docs.length<1?"":value[0]["subject"];
      texteditingmonday[1].text=snap.docs.length<2?"":value[1]["subject"];
      texteditingmonday[2].text=snap.docs.length<3?"":value[2]["subject"];
      texteditingmonday[3].text=snap.docs.length<4?"":value[3]["subject"];
      texteditingmonday[4].text=snap.docs.length<5?"":value[4]["subject"];
      texteditingmonday[5].text=snap.docs.length<6?"":value[5]["subject"];
      texteditingmonday[6].text=snap.docs.length<7?"":value[6]["subject"];
      texteditingmonday[7].text=snap.docs.length<8?"":value[7]["subject"];
      texteditingmonday[8].text=snap.docs.length<9?"":value[8]["subject"];
      texteditingmonday[9].text=snap.docs.length<10?"":value[9]["subject"];
      texteditingmonday[10].text=snap.docs.length<11?"":value[10]["subject"];
      texteditingmonday[11].text=snap.docs.length<12?"":value[11]["subject"];
      texteditingmonday[12].text=snap.docs.length<13?"":value[12]["subject"];
      texteditingmonday[13].text=snap.docs.length<14?"":value[13]["subject"];
      texteditingmonday[14].text=snap.docs.length<15?"":value[14]["subject"];
      texteditingmonday[15].text=snap.docs.length<16?"":value[15]["subject"];
      texteditingmonday[16].text=snap.docs.length<17?"":value[16]["subject"];
      texteditingmonday[17].text=snap.docs.length<18?"":value[17]["subject"];
      texteditingmonday[18].text=snap.docs.length<19?"":value[18]["subject"];
      texteditingmonday[19].text=snap.docs.length<20?"":value[19]["subject"];
      texteditingmonday[20].text=snap.docs.length<21?"":value[20]["subject"];
      texteditingmonday[21].text=snap.docs.length<22?"":value[21]["subject"];
      texteditingmonday[22].text=snap.docs.length<23?"":value[22]["subject"];
      texteditingmonday[23].text=snap.docs.length<24?"":value[23]["subject"];
      texteditingmonday[24].text=snap.docs.length<25?"":value[24]["subject"];
      texteditingmonday[25].text=snap.docs.length<26?"":value[25]["subject"];
      texteditingmonday[26].text=snap.docs.length<27?"":value[26]["subject"];
      texteditingmonday[27].text=snap.docs.length<28?"":value[27]["subject"];
      texteditingmonday[28].text=snap.docs.length<29?"":value[28]["subject"];
      texteditingmonday[29].text=snap.docs.length<30?"":value[29]["subject"];
      texteditingmonday[30].text=snap.docs.length<31?"":value[30]["subject"];
      texteditingmonday[31].text=snap.docs.length<32?"":value[31]["subject"];
      texteditingmonday[32].text=snap.docs.length<33?"":value[32]["subject"];
      texteditingmonday[33].text=snap.docs.length<34?"":value[33]["subject"];
      texteditingmonday[34].text=snap.docs.length<35?"":value[34]["subject"];
      texteditingmonday[35].text=snap.docs.length<36?"":value[35]["subject"];
      texteditingmonday[36].text=snap.docs.length<37?"":value[36]["subject"];
      texteditingmonday[37].text=snap.docs.length<38?"":value[37]["subject"];
      texteditingmonday[38].text=snap.docs.length<39?"":value[38]["subject"];
      texteditingmonday[39].text=snap.docs.length<40?"":value[39]["subject"];
      texteditingmonday[40].text=snap.docs.length<41?"":value[40]["subject"];
      texteditingmonday[41].text=snap.docs.length<42?"":value[41]["subject"];
      texteditingmonday[42].text=snap.docs.length<43?"":value[42]["subject"];
      texteditingmonday[43].text=snap.docs.length<44?"":value[43]["subject"];
      texteditingmonday[44].text=snap.docs.length<45?"":value[44]["subject"];
      texteditingmonday[45].text=snap.docs.length<46?"":value[45]["subject"];
      texteditingmonday[46].text=snap.docs.length<47?"":value[46]["subject"];
      texteditingmonday[47].text=snap.docs.length<48?"":value[47]["subject"];
    });

  }
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Container(child: Padding(
              padding: const EdgeInsets.only(left: 38.0,top: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Time Table",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(width:10),
                ],
              ),
            ),
              //color: Colors.white,
              width: width/1.050,
              height: height/8.212,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20.0,top:20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,top:20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:0.0),
                            child: Text("Class",style: GoogleFonts.poppins(fontSize: 15,)),
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
                                  subjectdrop();
                                  settimestable();
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
                            child: Text("Section",style: GoogleFonts.poppins(fontSize: 15,)),
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
                                  subjectdrop();
                                  settimestable();
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
                              width: width/6.83,
                              height: height/16.42,
                              //color: Color(0xffDDDEEE),
                              decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                            ),
                          ),

                        ],

                      ),


                      GestureDetector(
                        onTap: (){
                          int count =0;
                          setState(() {
                            count=0;
                          });
                          for(int i=0;i<47;i++) {
                            if(texteditingmonday[i].text==""){
                              setState(() {
                                count=count+1;
                              });
                            }

                          }
                          if(count==0) {
                            addtimetable();
                            Successdialog();
                          }
                          else{
                            Successdialog2();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Container(child: Center(child: Text("Save",style: GoogleFonts.poppins(color:Colors.white),)),
                            width: width/10.507,
                            height: height/16.425,
                            // color:Color(0xff00A0E3),
                            decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          printTimeTable();
                          //getvalue();
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 7,
                          child: Container(child: Center(
                            child:

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right:8.0),
                                  child: Icon(Icons.print,color:Colors.white),
                                ),
                                Text("Print Table",style: GoogleFonts.poppins(color:Colors.white),),
                              ],
                            ),
                          ),
                            width: width/6.507,
                            height: height/16.425,
                            // color:Color(0xff00A0E3),
                            decoration: BoxDecoration(color: const Color(0xff53B175),borderRadius: BorderRadius.circular(5)),

                          ),
                        ),
                      ),


                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                      ),
                      child: Center(child: Text("Day/Period",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600),)),
                    ),
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                      ),
                      child: Center(child: Text("Period -01",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600),)),
                    ),
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                      ),
                      child: Center(child: Text("Period -02",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600),)),
                    ),
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                      ),
                      child: Center(child: Text("Period -03",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600),)),
                    ),
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                      ),
                      child: Center(child: Text("Period -04",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600),)),
                    ),
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                      ),
                      child: Center(child: Text("Period -05",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600),)),
                    ),
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                      ),
                      child: Center(child: Text("Period -06",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600),)),
                    ),
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                      ),
                      child: Center(child: Text("Period -07",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600),)),
                    ),
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                      ),
                      child: Center(child: Text("Period -08",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600),)),
                    ),
                  ],
                ),
                StreamBuilder(
                    stream:            FirebaseFirestore.instance.collection("ClassTimeTable").doc("${_typeAheadControllerclass.text}${_typeAheadControllersection.text}").collection("TimeTable").orderBy("order").snapshots(),
                    builder:(context,snap) {
                      var value = snap.data!.docs;
                      return Row(
                        children: [
                          Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Monday",
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w600),)),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),

                                decoration: InputDecoration(

                                  hintText: snap.data!.docs.length<1?"":value[0]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[0],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[0].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<2?"":value[1]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[1],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[1].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<3?"":value[2]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[2],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[2].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<4?"":value[3]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[3],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[3].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<5?"":value[4]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[4],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[4].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<6?"":value[5]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[5],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[5].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<7?"":value[6]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[6],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[6].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<8?"":value[7]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[7],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[7].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                        ],
                      );

                    }
                ),
                StreamBuilder(
                    stream:  FirebaseFirestore.instance.collection("ClassTimeTable").doc("${_typeAheadControllerclass.text}${_typeAheadControllersection.text}").collection("TimeTable").orderBy("order").snapshots(),
                    builder:(context,snap) {
                      var value = snap.data!.docs;
                      return Row(
                        children: [
                          Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Tuesday",
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w600),)),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<9?"":value[8]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[8],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[8].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<10?"":value[9]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[9],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[9].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<11?"":value[10]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[10],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[10].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<12?"":value[11]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[11],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[11].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<13?"":value[12]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[12],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[12].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<14?"":value[13]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[13],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[13].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<15?"":value[14]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[14],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[14].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<16?"":value[15]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[15],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[15].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                        ],
                      );

                    }
                ),
                StreamBuilder(
                    stream:  FirebaseFirestore.instance.collection("ClassTimeTable").doc("${_typeAheadControllerclass.text}${_typeAheadControllersection.text}").collection("TimeTable").orderBy("order").snapshots(),
                    builder:(context,snap) {
                      var value = snap.data!.docs;
                      return Row(
                        children: [
                          Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Wednesday",
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w600),)),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<17?"":value[16]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[16],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[16].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<18?"":value[17]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[17],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[17].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<19?"":value[18]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[18],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[18].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<20?"":value[19]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[19],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[19].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<21?"":value[20]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[20],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[20].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<22?"":value[21]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[21],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[21].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<23?"":value[22]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[22],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[22].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<24?"":value[23]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[23],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[23].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                        ],
                      );

                    }
                ),
                StreamBuilder(
                    stream:  FirebaseFirestore.instance.collection("ClassTimeTable").doc("${_typeAheadControllerclass.text}${_typeAheadControllersection.text}").collection("TimeTable").orderBy("order").snapshots(),
                    builder:(context,snap) {
                      var value = snap.data!.docs;
                      return Row(
                        children: [
                          Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Thursday",
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w600),)),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<25?"":value[24]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[24],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[24].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<26?"":value[25]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[25],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[25].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<27?"":value[26]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[26],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[26].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<28?"":value[27]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[27],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[27].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<29?"":value[28]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[28],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[28].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<30?"":value[29]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[29],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[29].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<31?"":value[30]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[30],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[30].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<32?"":value[31]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[31],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[31].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                        ],
                      );

                    }
                ),
                StreamBuilder(
                    stream:  FirebaseFirestore.instance.collection("ClassTimeTable").doc("${_typeAheadControllerclass.text}${_typeAheadControllersection.text}").collection("TimeTable").orderBy("order").snapshots(),
                    builder:(context,snap) {
                      var value = snap.data!.docs;
                      return Row(
                        children: [
                          Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Friday",
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w600),)),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<33?"":value[32]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[32],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[32].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<34?"":value[33]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[33],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[33].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<35?"":value[34]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[34],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[34].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<36?"":value[35]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[35],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[35].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<37?"":value[36]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[36],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[36].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<38?"":value[37]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[37],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[37].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<39?"":value[38]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[38],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[38].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<40?"":value[39]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[39],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[39].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                        ],
                      );

                    }
                ),
                StreamBuilder(
                    stream:  FirebaseFirestore.instance.collection("ClassTimeTable").doc("${_typeAheadControllerclass.text}${_typeAheadControllersection.text}").collection("TimeTable").orderBy("order").snapshots(),
                    builder:(context,snap) {
                      var value = snap.data!.docs;
                      return Row(
                        children: [
                          Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Saturday",
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w600),)),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<41?"":value[40]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[40],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[40].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<42?"":value[41]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[41],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[41].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<43?"":value[42]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[42],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[42].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<44?"":value[43]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[43],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[43].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<45?"":value[44]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[44],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[44].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<46?"":value[45]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[45],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[45].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<47?"":value[46]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[46],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[46].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                decoration: InputDecoration(
                                  hintText: snap.data!.docs.length<48?"":value[47]["subject"],
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this.texteditingmonday[47],
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsubject(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },

                              transitionBuilder: (context, suggestionsBox,
                                  controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this.texteditingmonday[47].text = suggestion;

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,

                            ),
                          ),
                        ],
                      );

                    }
                ),

              ],
            ),
          )

        ],
      ),
    );
  }

  printTimeTable() {
    TimeTablePrintModel timeTable = TimeTablePrintModel(
        mondayFirst: texteditingmonday[0].text,
        mondaySecond: texteditingmonday[1].text,
        mondayThird: texteditingmonday[2].text,
        mondayFourth: texteditingmonday[3].text,
        mondayFifth: texteditingmonday[4].text,
        mondaySixth: texteditingmonday[5].text,
        mondaySeventh: texteditingmonday[6].text,
        mondayEighth: texteditingmonday[7].text,
        tuesdayFirst: texteditingmonday[8].text,
        tuesdaySecond: texteditingmonday[9].text,
        tuesdayThird: texteditingmonday[10].text,
        tuesdayFourth: texteditingmonday[11].text,
        tuesdayFifth: texteditingmonday[12].text,
        tuesdaySixth: texteditingmonday[13].text,
        tuesdaySeventh: texteditingmonday[14].text,
        tuesdayEighth: texteditingmonday[15].text,
        wednesdayFirst: texteditingmonday[16].text,
        wednesdaySecond: texteditingmonday[17].text,
        wednesdayThird: texteditingmonday[18].text,
        wednesdayFourth: texteditingmonday[19].text,
        wednesdayFifth: texteditingmonday[20].text,
        wednesdaySixth: texteditingmonday[21].text,
        wednesdaySeventh: texteditingmonday[22].text,
        wednesdayEighth: texteditingmonday[23].text,
        thursdayFirst: texteditingmonday[24].text,
        thursdaySecond: texteditingmonday[25].text,
        thursdayThird: texteditingmonday[26].text,
        thursdayFourth: texteditingmonday[27].text,
        thursdayFifth: texteditingmonday[28].text,
        thursdaySixth: texteditingmonday[29].text,
        thursdaySeventh: texteditingmonday[30].text,
        thursdayEighth: texteditingmonday[31].text,
        fridayFirst: texteditingmonday[32].text,
        fridaySecond: texteditingmonday[33].text,
        fridayThird: texteditingmonday[34].text,
        fridayFourth: texteditingmonday[35].text,
        fridayFifth: texteditingmonday[36].text,
        fridaySixth: texteditingmonday[37].text,
        fridaySeventh: texteditingmonday[38].text,
        fridayEighth: texteditingmonday[39].text,
        saturdayFirst: texteditingmonday[40].text,
        saturdaySecond: texteditingmonday[41].text,
        saturdayThird: texteditingmonday[42].text,
        saturdayFourth: texteditingmonday[43].text,
        saturdayFifth: texteditingmonday[44].text,
        saturdaySixth: texteditingmonday[45].text,
        saturdaySeventh: texteditingmonday[46].text,
        saturdayEighth: texteditingmonday[47].text
    );
    //generateTimeTablePdf(PdfPageFormat.a4,timeTable);
  }

  getvalue() async {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    List<p.Widget> widgets = [];
    //container for profile image decoration
    final container = p.Center(
      child: p.Container(
          child: p.Padding(
            padding: p.EdgeInsets.only(top: 5),
            child: p.Row(mainAxisAlignment: p.MainAxisAlignment.start, children: [
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("Si.No".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),
              p.Container(
                  width: 80,
                  child: p.Center(
                    child: p.Text("Descriptions".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),

              p.SizedBox(width: width / 273.2),

              p.SizedBox(width: 200),
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("Rate".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),

              p.SizedBox(width: width / 273.2),
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("Total".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  ))
            ]),
          )),
    );
    final container2 = p.Center(
      child: p.Container(
          child: p.Padding(
            padding: p.EdgeInsets.only(top: 5),
            child: p.Row(mainAxisAlignment: p.MainAxisAlignment.start, children: [
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("001".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),
              p.Container(
                  width: 80,
                  child: p.Center(
                    child: p.Text("First Mid Term Fees".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),

              p.SizedBox(width: width / 273.2),

              p.SizedBox(width: 200),
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("15000".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),

              p.SizedBox(width: width / 273.2),
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("1500".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  ))
            ]),
          )),
    );

    final container3 = p.Center(
      child: p.Container(
          child: p.Padding(
            padding: p.EdgeInsets.only(top: 5),
            child: p.Row(mainAxisAlignment: p.MainAxisAlignment.start, children: [
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("   ".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),
              p.Container(
                  width: 80,
                  child: p.Center(
                    child: p.Text("               ".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),

              p.SizedBox(width: width / 273.2),

              p.SizedBox(width: 200),
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("Total:".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),

              p.SizedBox(width: width / 273.2),
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("1500".toString(),
                        style: p.TextStyle(color: PdfColors.black)),
                  ))
            ]),
          )),
    );
    final container4 = p.Center(
      //child:
    );

    final profileImage = p.MemoryImage((await rootBundle.load('assets/schoollogo.png')).buffer.asUint8List(),);
    final paid = p.MemoryImage((await rootBundle.load('assets/paid.png')).buffer.asUint8List(),);


    widgets.add(p.SizedBox(height: 5));
    widgets.add(p.SizedBox(height: 5));

    final pdf = p.Document();
    pdf.addPage(
      p.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => widgets, //here goes the widgets list
      ),
    );
    Printing.layoutPdf(

      onLayout: (PdfPageFormat format) async => pdf.save(),
    );


  }
}


class TimeTablePrintModel {
  TimeTablePrintModel({
    required this.mondayFirst,
    required this.mondaySecond,
    required this.mondayThird,
    required this.mondayFourth,
    required this.mondayFifth,
    required this.mondaySixth,
    required this.mondaySeventh,
    required this.mondayEighth,
    required this.tuesdayFirst,
    required this.tuesdaySecond,
    required this.tuesdayThird,
    required this.tuesdayFourth,
    required this.tuesdayFifth,
    required this.tuesdaySixth,
    required this.tuesdaySeventh,
    required this.tuesdayEighth,
    required this.wednesdayFirst,
    required this.wednesdaySecond,
    required this.wednesdayThird,
    required this.wednesdayFourth,
    required this.wednesdayFifth,
    required this.wednesdaySixth,
    required this.wednesdaySeventh,
    required this.wednesdayEighth,

    required this.thursdayFirst,
    required this.thursdaySecond,
    required this.thursdayThird,
    required this.thursdayFourth,
    required this.thursdayFifth,
    required this.thursdaySixth,
    required this.thursdaySeventh,
    required this.thursdayEighth,

    required this.fridayFirst,
    required this.fridaySecond,
    required this.fridayThird,
    required this.fridayFourth,
    required this.fridayFifth,
    required this.fridaySixth,
    required this.fridaySeventh,
    required this.fridayEighth,

    required this.saturdayFirst,
    required this.saturdaySecond,
    required this.saturdayThird,
    required this.saturdayFourth,
    required this.saturdayFifth,
    required this.saturdaySixth,
    required this.saturdaySeventh,
    required this.saturdayEighth,
  });

  String mondayFirst;
  String mondaySecond;
  String mondayThird;
  String mondayFourth;
  String mondayFifth;
  String mondaySixth;
  String mondaySeventh;
  String mondayEighth;

  String tuesdayFirst;
  String tuesdaySecond;
  String tuesdayThird;
  String tuesdayFourth;
  String tuesdayFifth;
  String tuesdaySixth;
  String tuesdaySeventh;
  String tuesdayEighth;

  String wednesdayFirst;
  String wednesdaySecond;
  String wednesdayThird;
  String wednesdayFourth;
  String wednesdayFifth;
  String wednesdaySixth;
  String wednesdaySeventh;
  String wednesdayEighth;

  String thursdayFirst;
  String thursdaySecond;
  String thursdayThird;
  String thursdayFourth;
  String thursdayFifth;
  String thursdaySixth;
  String thursdaySeventh;
  String thursdayEighth;

  String fridayFirst;
  String fridaySecond;
  String fridayThird;
  String fridayFourth;
  String fridayFifth;
  String fridaySixth;
  String fridaySeventh;
  String fridayEighth;

  String saturdayFirst;
  String saturdaySecond;
  String saturdayThird;
  String saturdayFourth;
  String saturdayFifth;
  String saturdaySixth;
  String saturdaySeventh;
  String saturdayEighth;
}