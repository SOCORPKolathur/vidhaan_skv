import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffTimeTable extends StatefulWidget {
  const StaffTimeTable({Key? key}) : super(key: key);

  @override
  State<StaffTimeTable> createState() => _StaffTimeTableState();
}

class _StaffTimeTableState extends State<StaffTimeTable> {


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
    var document3 = await  FirebaseFirestore.instance.collection("Staffs").orderBy("timestamp").get();
    setState(() {
      _typeAheadControllerstaffid.text=document3.docs[0]["regno"];
      _typeAheadControllerstaffname.text=document3.docs[0]["stname"];
      classid=document3.docs[0].id;
    });
    //subjectdrop();
    settimestable();

  }
  adddropvalue() async {
    setState(() {
      classes.clear();
      section.clear();
      staffid.clear();
      staffnamelist.clear();
    });
    var document3 = await  FirebaseFirestore.instance.collection("ClassMaster").orderBy("order").get();
    var document2 = await  FirebaseFirestore.instance.collection("SectionMaster").orderBy("order").get();
    var documentstaff3 = await  FirebaseFirestore.instance.collection("Staffs").orderBy("timestamp").get();

    for(int i=0;i<documentstaff3.docs.length;i++) {
      setState(() {
        staffid.add(documentstaff3.docs[i]["regno"]);
        staffnamelist.add(documentstaff3.docs[i]["stname"]);
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

  final TextEditingController _typeAheadControllerstaffid = TextEditingController();
  final TextEditingController _typeAheadControllerstaffname = TextEditingController();
  static final List<String> staffid = [];
  static final List<String> staffnamelist = [];
  static List<String> getSuggestionsstaffid(String query) {
    List<String> matches = <String>[];
    matches.addAll(staffid);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionsstaffname(String query) {
    List<String> matches = <String>[];
    matches.addAll(staffnamelist);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  settimestable() async {
    var snap = await FirebaseFirestore.instance.collection("Staffs").doc(classid).collection("Timetable").orderBy("period").get();
    var value=snap.docs;
    for(int i=0;i<48;i++){

        setState(() {
          texteditingmonday[i].text="";
        });


    }
    for(int i=0;i<snap.docs.length;i++) {

      print(value[i]["period"]);
      print("${value[i]["class"]} ${value[i]["section"]}");
      setState(() {
        texteditingmonday[value[i]["period"]].text = "${value[i]["class"]} ${value[i]["section"]}";
      });
    }
    for(int i=0;i<48;i++){
      if(texteditingmonday[i].text==""){
        setState(() {
          texteditingmonday[i].text="Free";
        });

      }
    }


  }
  getstudentbyregno(value) async {
    print("fdgggggggggg");

    var document = await FirebaseFirestore.instance.collection("Staffs").get();
    for(int i=0;i<document.docs.length;i++){
      if(value==document.docs[i]["regno"]){
        setState(() {
          _typeAheadControllerstaffname.text= document.docs[i]["stname"];
          classid= document.docs[i].id;
        }
        );
      }
    }
    print("fdgggggggggg");


  }
  getstudentbyname(value) async {
    print("fdgggggggggg");

    var document = await FirebaseFirestore.instance.collection("Staffs").get();
    for(int i=0;i<document.docs.length;i++){
      if(value==document.docs[i]["stname"]){
        setState(() {
          _typeAheadControllerstaffid.text= document.docs[i]["regno"];
          classid= document.docs[i].id;
        }
        );
      }
    }
    print("fdgggggggggg");


  }
  String? _selectedCity;
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
                  Text("Staff Time Table",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),),
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
                            child: Text("Staff ID",style: GoogleFonts.poppins(fontSize: 15,)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0,right: 25),
                            child: Container(child:
                            TypeAheadFormField(


                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )
                              ),

                              textFieldConfiguration: TextFieldConfiguration(
                                style:  GoogleFonts.poppins(
                                    fontSize: 15,

                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this._typeAheadControllerstaffid,
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsstaffid(pattern);
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
                                  this._typeAheadControllerstaffid.text = suggestion;
                                });
                                getstudentbyregno(_typeAheadControllerstaffid.text);
                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,
                              onSaved: (value) => this._selectedCity = value,
                            ),
                              width: width/6.83,
                              height: height/16.425,
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
                            child: Text("Staff Name",style: GoogleFonts.poppins(fontSize: 15,)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0,right: 25),
                            child: Container(child:
                            TypeAheadFormField(

                              suggestionsBoxDecoration: SuggestionsBoxDecoration(
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
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this._typeAheadControllerstaffname,
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsstaffname(pattern);
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
                                  this._typeAheadControllerstaffname.text = suggestion;
                                });
                                getstudentbyname(_typeAheadControllerstaffname.text);

                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,
                              onSaved: (value) => this._selectedCity = value,
                            ),
                              width: width/6.83,
                              height: height/16.425,
                              //color: Color(0xffDDDEEE),
                              decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                            ),
                          ),

                        ],

                      ),


                      GestureDetector(
                        onTap: (){
                         /* int count =0;
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
                          */
                          settimestable();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Container(child: Center(child: Text("Search",style: GoogleFonts.poppins(color:Colors.white),)),
                            width: width/10.507,
                            height: height/16.425,
                            // color:Color(0xff00A0E3),
                            decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                          ),
                        ),
                      ),
                    /*  InkWell(
                        onTap: (){

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
                      ),*/


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
                IgnorePointer(
                  child: StreamBuilder(
                      stream:FirebaseFirestore.instance.collection("Staffs").doc(classid).collection("Timetable").orderBy("period").snapshots(),
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
                                      fontSize: 15,
                                    color: texteditingmonday[0].text=="Free"?Colors.green :Colors.black,
                                  ),

                                  decoration: InputDecoration(

                                    hintText: snap.data!.docs.length<1?"":"${value[0]["class"]} ${value[0]["class"]}",
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
                                      fontSize: 15,
                                    color: texteditingmonday[1].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[2].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[3].text=="Free"?Colors.green :Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: snap.data!.docs.length<4?"":"${value[1]["class"]} ${value[1]["section"]}",
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
                                      fontSize: 15,
                                    color: texteditingmonday[4].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[5].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[6].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[7].text=="Free"?Colors.green :Colors.black,
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
                ),
                IgnorePointer(
                  child: StreamBuilder(
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
                                      fontSize: 15,
                                    color: texteditingmonday[8].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[9].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[10].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[11].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[12].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[13].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[14].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[15].text=="Free"?Colors.green :Colors.black,
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
                ),
                IgnorePointer(
                  child: StreamBuilder(
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
                                      fontSize: 15,
                                    color: texteditingmonday[16].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[17].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[18].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[19].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[20].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[21].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[22].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[23].text=="Free"?Colors.green :Colors.black,
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
                ),
                IgnorePointer(
                  child: StreamBuilder(
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
                                      fontSize: 15,
                                    color: texteditingmonday[24].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[25].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[26].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[27].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[28].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[29].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[30].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[31].text=="Free"?Colors.green :Colors.black,
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
                ),
                IgnorePointer(
                  child: StreamBuilder(
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
                                      fontSize: 15,
                                    color: texteditingmonday[32].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[33].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[34].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[35].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[36].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[37].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[38].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[39].text=="Free"?Colors.green :Colors.black,
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
                ),
                IgnorePointer(
                  child: StreamBuilder(
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
                                      fontSize: 15,
                                    color: texteditingmonday[40].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[41].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[42].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[43].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[44].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[45].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[46].text=="Free"?Colors.green :Colors.black,
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
                                      fontSize: 15,
                                    color: texteditingmonday[47].text=="Free"?Colors.green :Colors.black,
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
                ),

              ],
            ),
          )

        ],
      ),
    );
  }
}
