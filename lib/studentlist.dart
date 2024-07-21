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
import 'package:vidhaan/Dashboard.dart';
import 'package:vidhaan/Masters/excelgen.dart';
import 'package:vidhaan/photoview.dart';
import 'package:vidhaan/studententryedit.dart';
import 'attendence.dart';
import 'models/student_csv_model.dart';


class StudentList extends StatefulWidget {
  const StudentList({Key? key, required this.isfromDashboard}) : super(key: key);
  
  final bool isfromDashboard;

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
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
    adddropdownvalue();
    doclength();
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
  ScrollController _scrollController = ScrollController();
  Future<void> deletestudent(id) async {
    return showDialog<void>(
      context: context,

      builder: (BuildContext context) {

        double width=MediaQuery.of(context).size.width;
        double height=MediaQuery.of(context).size.height;
        return StatefulBuilder(
            builder: (context,setState) {
              return AlertDialog(
                title:  Text('Are you Sure of Deleting Student',style: GoogleFonts.poppins(
                    color: Colors.black, fontSize: width/75.88888888888889,fontWeight: FontWeight.w600),),
                content:  Container(
                    width: width/3.902857142857143,
                    height:height/2.604,

                    child: Lottie.asset("assets/delete file.json")),
                //child:  Lottie.asset("assets/file choosing.json")),
                actions: <Widget>[
                 InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
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
                          Text("Cancel",style: GoogleFonts.poppins(color:Colors.white),),
                        ],
                      )),
                        width: width/10.507,
                        height: height/20.425,
                        // color:Color(0xff00A0E3),
                        decoration: BoxDecoration(color:  Colors.red,borderRadius: BorderRadius.circular(5)),

                      ),
                    ),
                  ),
                    InkWell(
                      onTap: (){
                        FirebaseFirestore.instance.collection("Students").doc(id).delete();
                        Navigator.of(context).pop();
                        setState((){
                          view=false;
                        });
                      },

                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 7,
                      child: Container(child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text("Ok",style: GoogleFonts.poppins(color:Colors.white),),
                        ],
                      )),
                        width: width/10.507,
                        height: height/20.425,
                        // color:Color(0xff00A0E3),
                        decoration: BoxDecoration(color:  Colors.green,borderRadius: BorderRadius.circular(5)),

                      ),
                    ),
                  )
                ],
              );
            }
        );
      },
    );
  }
  int documentlength =0 ;
  int pagecount =0 ;
  int totalMembersCount =0 ;
  int memberRemainder =0 ;
  int totalUsersCount =0 ;
  int userRemainder =0 ;
  int temp = 1;
  int shift =0;
  List list = new List<int>.generate(10000, (i) => i + 1);
  doclength() async {
    final QuerySnapshot result = await FirebaseFirestore.instance.collection('Students').get();
    final List < DocumentSnapshot > documents = result.docs;
    setState(() {
      documentlength = documents.length;
      pagecount= documentlength.remainder(10) == 0 ? (documentlength~/10) : ((documentlength~/10) + 1) as int;
    });
    print("pagecount");
    print(pagecount);
  }
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return view == false?
    Scaffold(
      backgroundColor: Colors.transparent,
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
                        Visibility(
                          visible: widget.isfromDashboard,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> Dashboard()));
                            },
                          ),
                        ),
                        Text("Students List",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),),
                        SizedBox(width: width/1.951428571428571,),

                        SizedBox(width: width/136.6,),
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
                        SizedBox(width: width/136.6,),

                        Excelsheet(check,mainconcent,studentsListForCsv),
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
                          SizedBox(width: width/91.06666666666667,),
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
                                          width: width/341.5,
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
                                      height:height/13.02,
                                      width: width/8.5375,
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
                                      maxHeight:height/3.255,
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
                                    menuItemStyleData: MenuItemStyleData(
                                      height:height/16.275,
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
                                          width: width/341.5,
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
                                      height:height/13.02,
                                      width: width/8.5375,
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
                                      maxHeight:height/3.255,
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
                                    menuItemStyleData: MenuItemStyleData(
                                      height:height/16.275,
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
                child:  Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height:height/13.14,
                        width: width/1.066,
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
                            Padding(
                              padding: const EdgeInsets.only(left: 40.0, right: 45),
                              child: Text(
                                "Parent name",
                                style:
                                GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 70),
                              child: Text(
                                "Phone Number",
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                              ),
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
                        stream: FirebaseFirestore.instance.collection("Students").orderBy("admitclass").snapshots(),

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
                          if(search==true){
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

                                              value: check[(temp*10)-10+index],

                                              onChanged: (bool? value){
                                                print(value);
                                                setState(() {
                                                  check[(temp*10)-10+index] = value!;
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
                                                width: width/27.32,
                                                height:height/13.02,
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

                                              value: check[(temp*10)-10+index],

                                              onChanged: (bool? value){
                                                print(value);
                                                setState(() {
                                                  check[(temp*10)-10+index] = value!;
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
                                                width: width/27.32,
                                                height:height/13.02,
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

                                              value: check[(temp*10)-10+index],

                                              onChanged: (bool? value){
                                                print(value);
                                                setState(() {
                                                  check[(temp*10)-10+index] = value!;
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
                                              width: width/27.32,
                                              height:height/13.02,
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
                          }
                          return ListView.builder(

                              shrinkWrap: true,
                              itemCount:
                              byclass == true ||
                              search == true ?
                              snapshot.data!.docs.length :
                              pagecount!=0? pagecount == temp ?
                              snapshot.data!.docs.length.remainder(10) == 0 ? 10 :
                              snapshot.data!.docs.length.remainder(10) : 10 :0 ,


                              itemBuilder: (context,index){
                                var value = snapshot.data!.docs[(temp*10)-10+index];
                                return  search==true? value.id==studentid? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: width/1.366,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0),
                                          child: Checkbox(

                                              value: check[(temp*10)-10+index],

                                              onChanged: (bool? value){
                                                print(value);
                                                setState(() {
                                                  check[(temp*10)-10+index] = value!;
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
                                                width: width/27.32,
                                                height:height/13.02,
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

                                              value: check[(temp*10)-10+index],

                                              onChanged: (bool? value){
                                                print(value);
                                                setState(() {
                                                  check[(temp*10)-10+index] = value!;
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
                                                width: width/27.32,
                                                height:height/13.02,
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

                                              value: check[(temp*10)-10+index],

                                              onChanged: (bool? value){
                                                print(value);
                                                setState(() {
                                                  check[(temp*10)-10+index] = value!;
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
                                                width: width/27.32,
                                                height:height/13.02,
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
                  ],
                ),

              ),
            ),

        byclass == true ||
        search == true ?
             SizedBox() : Stack(
          alignment: Alignment.centerRight,
          children: [
            Padding(
              padding: const EdgeInsets.only(right:300.0),
              child: SizedBox(
                width: width/1.5,
                height:height/13.02,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    // Update the scroll position based on the drag distance
                    _scrollController
                        .jumpTo(_scrollController.offset - details.primaryDelta!);
                  },
                  child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: pagecount,
                      itemBuilder: (context,index){
                        return InkWell(
                          onTap: (){
                            setState(() {
                              temp=list[index];
                            });
                            print(temp);
                          },
                          child: Container(
                              height:30,width:30,
                              margin: EdgeInsets.only(left:8,right:8,top:10,bottom:10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color:temp.toString() == list[index].toString() ?  Color(0xff00A0E3) : Colors.transparent
                              ),
                              child: Center(
                                child: Text(list[index].toString(),style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    color: temp.toString() == list[index].toString() ?  Colors.white : Colors.black

                                ),),
                              )
                          ),
                        );

                      }),
                ),
              ),
            ),
            temp > 1
                ?
            Padding(
              padding: const EdgeInsets.only(right: 150.0),
              child:
              InkWell(
                onTap:(){
                  setState(() {
                    temp= temp-1;
                  });
                },
                child: Container(
                    height:height/16.275,
                    width:width/11.3833,
                    decoration:BoxDecoration(
                        color:Color(0xff00A0E3),
                        borderRadius: BorderRadius.circular(80)
                    ),
                    child: Center(
                      child: Text("Previous Page",style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),),
                    )),
              ),
            )  : Container(),
            Container(
              child: temp < pagecount ?
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: InkWell(
                  onTap:(){
                    setState(() {
                      temp= temp+1;
                    });
                  },
                  child:
                  Container(
                      height:height/16.275,
                      width:width/11.3833,
                      decoration:BoxDecoration(
                          color:Color(0xff00A0E3),
                          borderRadius: BorderRadius.circular(80)
                      ),
                      child: Center(
                        child: Text("Next Page",style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),),
                      )),
                ),
              )  : Container(),
            )
          ],
        ),
            SizedBox(height:height/26.04,)
          ],
        ),
      ),

    ) :
    SingleChildScrollView(
      child: ShowUpAnimation(
        curve: Curves.fastOutSlowIn,
        direction: Direction.horizontal,
        delayStart: Duration(milliseconds: 200),
        child:
        FutureBuilder<dynamic>(
          future: FirebaseFirestore.instance.collection('Students').doc(studentid).get(),
          builder: (context, snapshot) {
            if(snapshot.hasData==null)
            {
              return Container(
                  width: width/17.075,
                  height: height/8.212,
                  child: Center(child:CircularProgressIndicator(),));
            }
            Map<String,dynamic>?value = snapshot.data!.data();
            return
              Padding(
                padding:EdgeInsets.only(left: width/93.3,top:0),
                child: Row(
                  children: [
                    Column(
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
                            width: width/4.44,
                            height: height/1.050,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text('Current Class',style: GoogleFonts.montserrat(
                                        fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                    ),),
                                  ],
                                ),
                                SizedBox(height: height/65.7,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Material(
                                        elevation: 7,
                                        borderRadius: BorderRadius.circular(12),
                                        shadowColor:  Color(0xff53B175),
                                        child: Container(
                                          height: height/8.212,
                                          width: width/7.588,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                              border:Border.all(color: Color(0xff53B175))
                                          ),
                                          child:  Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Class / Section",style:GoogleFonts.montserrat(
                                                  fontWeight:FontWeight.w600,color: Colors.black,fontSize:width/98.13
                                              ),),
                                              SizedBox(height: height/65.7,),
                                              ChoiceChip(

                                                label: Text("    ${value["admitclass"]} / ${value["section"]}    ",style: TextStyle(color: Colors.white),),


                                                onSelected: (bool selected) {

                                                  setState(() {

                                                  });
                                                },
                                                selectedColor: Color(0xff53B175),
                                                shape: StadiumBorder(
                                                    side: BorderSide(
                                                        color: Color(0xff53B175))),
                                                backgroundColor: Colors.white,
                                                labelStyle: TextStyle(color: Colors.black),

                                                elevation: 1.5, selected: true,),
                                            ],
                                          ),

                                        ),


                                    ),
                                  ],
                                ),
                                Divider(),
                                SizedBox(height:height/32.85,),
                                Row(children: [
                                  SizedBox(width:width/62.2),
                                  Icon(Icons.email_outlined,),
                                  SizedBox(width:width/373.2),
                                  GestureDetector(onTap: (){

                                  },
                                    child: Text('${value["email"]}',style: GoogleFonts.montserrat(
                                        fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/124.4
                                    ),),
                                  ),
                                ],),
                                SizedBox(height:height/34.76,),
                                Row(children: [
                                  SizedBox(width:width/62.2),
                                  Icon(Icons.call,),
                                  SizedBox(width:width/373.2),
                                  GestureDetector(onTap: (){

                                  },
                                    child: Text('${value["mobile"]}',style: GoogleFonts.montserrat(
                                        fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/124.4
                                    ),),
                                  ),
                                ],),
                                SizedBox(height:height/34.76,),
                                Row(children: [
                                  SizedBox(width:width/62.2),
                                  Icon(Icons.calendar_month_sharp,),
                                  SizedBox(width:width/373.2),
                                  GestureDetector(onTap: (){

                                  },
                                    child: Text(value["dob"]!="Null"?value["dob"].toString().length>15?'${value["dob"].toString().substring(0,10)}':'${value["dob"].toString().replaceAll(" ", "")}':"Null",style: GoogleFonts.montserrat(
                                        fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/124.4
                                    ),),
                                  ),
                                ],),
                                SizedBox(height:height/34.76,),
                                Row(children: [
                                  SizedBox(width:width/62.2),
                                  value["gender"]=="Male"? Icon(Icons.male_rounded,) :Icon(Icons.female_rounded,),
                                  SizedBox(width:width/373.2),
                                  GestureDetector(onTap: (){

                                  },
                                    child: Text('${value["gender"]}',style: GoogleFonts.montserrat(
                                        fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/124.4
                                    ),),
                                  ),
                                ],),
                                

                                SizedBox(height:height/34.76,),
                                Row(children: [
                                  SizedBox(width:width/62.2),
                                   Icon(Icons.bloodtype_rounded,) ,
                                  SizedBox(width:width/373.2),
                                  GestureDetector(onTap: (){

                                  },
                                    child: Text('${value["bloodgroup"]}',style: GoogleFonts.montserrat(
                                        fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/124.4
                                    ),),
                                  ),
                                ],),
                                SizedBox(height:height/84.76,),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: (){

                                        setState(() {
                                          view1=3;
                                        });

                                      },
                                      child: Container(width: width/9.464,
                                        height: height/16.425,
                                        // color:Color(0xff00A0E3),
                                        decoration: BoxDecoration(color: Color(0xffFFA002),borderRadius: BorderRadius.circular(5)),child: Center(child: Text("Fees Reports",style: GoogleFonts.poppins(color:Colors.white,fontWeight: FontWeight.w600,fontSize: 12),)),

                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    GestureDetector(
                                      onTap: (){

                                        setState(() {
                                          view1=4;
                                        });

                                      },
                                      child: Container(width: width/9.464,
                                        height: height/16.425,
                                        // color:Color(0xff00A0E3),
                                        decoration: BoxDecoration(color: Color(0xff53B175),borderRadius: BorderRadius.circular(5)),child: Center(child: Text("Attendance Reports",style: GoogleFonts.poppins(color:Colors.white,fontWeight: FontWeight.w600,fontSize: 12),)),

                                      ),
                                    ),
                                  ],
                                ),




                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width:width/62.2,),
                    Column(
                      children: [
                        Material(
                          elevation: 15,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight:Radius.circular(15)  ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight:Radius.circular(15)  ),
                              color: Colors.white,
                            ),
                            width:width/1.8600,
                            height:height/19,
                            child: Padding(
                              padding: EdgeInsets.only(left:width/62.2,right:width/62.2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(view1 ==3? 'Fees Reports':view1 ==4? 'Attendance Reports':'Student  Details',style: GoogleFonts.montserrat(
                                    fontSize:width/81.13,fontWeight: FontWeight.bold,
                                  ),),
                                  InkWell(
                                      onTap: (){
                                        if(view1 ==3 || view1==4){
                                          setState(() {
                                            view1=0;
                                          });
                                        }
                                        else {
                                          setState(() {
                                            view = false;
                                          });
                                        }
                                      },

                                      child: Icon(Icons.cancel,color: Colors.red,))
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height:height/58,),
                        view1 ==3 ? Material(
                          elevation: 15,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15)  ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15)  ),
                                color:Colors.white
                            ),
                            width:width/1.86,
                            height: height/1.140,
                            child: Padding(
                              padding: EdgeInsets.only(left:width/62.2,right:width/62.2),
                              child: SingleChildScrollView(
                                child: Column(
                                    children:[
                                      SizedBox(height:height/43.4,),
                                      Row(
                                        children: [
                                          Container(

                                            child: Text('Previous Payments',style: GoogleFonts.montserrat(
                                                fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                            ),),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height:height/43.4,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: width/10.50769230769231,
                                            child: Text('Fees Name',style: GoogleFonts.montserrat(
                                                fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                            ),),
                                          ),
                                          Container(
                                            width: width/10.50769230769231,
                                            child: Text('Amount',style: GoogleFonts.montserrat(
                                                fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                            ),),
                                          ),

                                          Container(
                                            width: width/10.50769230769231,
                                            child: Text('Due Date',style: GoogleFonts.montserrat(
                                                fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                            ),),
                                          ),
                                          Container(
                                            width: width/10.50769230769231,
                                            child: Text('Paid Date \nTime',
                                            textAlign: TextAlign.center,

                                              style: GoogleFonts.montserrat(
                                                fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                            ),),
                                          ),
                                          Container(
                                            width: width/10.50769230769231,
                                            child: Text('Status',style: GoogleFonts.montserrat(
                                                fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                            ),),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Divider(),
                                      ),
                                      StreamBuilder(
                                          stream: FirebaseFirestore.instance.collection("Students").doc(studentid).collection("Fees").orderBy("timestamp").snapshots(),
                                          builder: (context,snapshot){
                                            return ListView.builder(
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                itemCount: snapshot.data!.docs.length,
                                                itemBuilder: (context,index){

                                                  return
                                                    snapshot.data!.docs[index]["status"]==true?
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 10.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Container(
                                                            width: width/10.50769230769231,
                                                            child: Text(snapshot.data!.docs[index]["feesname"],style: GoogleFonts.montserrat(
                                                                fontWeight:FontWeight.w600,color: Colors.black,fontSize:width/91.13
                                                            ),),
                                                          ),
                                                          Container(
                                                            width: width/10.50769230769231,
                                                            child: Text(snapshot.data!.docs[index]["amount"].toString(),style: GoogleFonts.montserrat(
                                                                fontWeight:FontWeight.w600,color: Colors.black,fontSize:width/91.13
                                                            ),),
                                                          ),
                                                          Container(
                                                            width: width/10.50769230769231,
                                                            child: Text(snapshot.data!.docs[index]["status"]==true?"Paid": "Unpaid",style: GoogleFonts.montserrat(
                                                                fontWeight:FontWeight.bold,color:snapshot.data!.docs[index]["status"]==true? Color(0xff53B175):Colors.red,fontSize:width/91.13
                                                            ),),
                                                          ),
                                                          Container(
                                                            width: width/10.50769230769231,
                                                            child: Text(snapshot.data!.docs[index]["date"],style: GoogleFonts.montserrat(
                                                                fontWeight:FontWeight.w600,color: Colors.black,fontSize:width/91.13
                                                            ),),
                                                          ),
                                                          Container(
                                                            width: width/10.50769230769231,
                                                            child: Text(snapshot.data!.docs[index]["time"],style: GoogleFonts.montserrat(
                                                                fontWeight:FontWeight.w600,color: Colors.black,fontSize:width/91.13
                                                            ),),
                                                          ),
                                                        ],
                                                      ),
                                                    )  : Container();
                                                });

                                          })
                                    ]
                                ),
                              )
                            ),
                          ),
                        ) :  view1==4?   Material(
                          elevation: 15,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15)  ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15)  ),
                                color:Colors.white
                            ),
                            width:width/1.86,
                            height: height/1.140,
                            child: Padding(
                              padding: EdgeInsets.only(left:width/62.2,right:width/62.2),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: width/1.7075,
                                        child: FutureBuilder<StudentAttendanceReportModel>(
                                          future: getMonthlyAttendanceReportForStudent(studentid),
                                          builder: (ctx,snapshot){
                                            if(snapshot.hasData){
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(15.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          'Total Working Days : ${((getStudentAttendancePersantage(snapshot.data!).present * getStudentAttendancePersantage(snapshot.data!).total)) + (getStudentAttendancePersantage(snapshot.data!).absent * getStudentAttendancePersantage(snapshot.data!).total)}',
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.black,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height:height/2.604,
                                                    width: width/1.751282051282051,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          height:height/2.604,
                                                          width: width/2.845833333333333,
                                                          child: sfc.SfCartesianChart(

                                                              primaryXAxis: sfc.CategoryAxis(),

                                                              title: sfc.ChartTitle(
                                                                  text: '   OverAll Present Reports',
                                                                  textStyle: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w600,
                                                                    color: Colors.black,
                                                                  ),
                                                                  alignment: sfc.ChartAlignment.near
                                                              ),
                                                              legend: sfc.Legend(isVisible: true),
                                                              tooltipBehavior: sfc.TooltipBehavior(enable: true),
                                                              series: <sfc.LineSeries<SalesData, String>>[
                                                                sfc.LineSeries<SalesData, String>(
                                                                  name: "",
                                                                  dataSource: snapshot.data!.presentReport,
                                                                  xValueMapper: (SalesData sales, _) => sales.year,
                                                                  yValueMapper: (SalesData sales, _) => sales.sales,
                                                                  // Enable data label
                                                                  dataLabelSettings: sfc.DataLabelSettings(isVisible: true),
                                                                  color: Colors.green,
                                                                  width: 5,
                                                                  animationDuration: 2000,
                                                                )
                                                              ]
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisAlignment : MainAxisAlignment.center,
                                                          children: [
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
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height:height/2.604,
                                                    width: width/1.751282051282051,
                                                    child: Row(
                                                      mainAxisAlignment : MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          height:height/2.604,
                                                          width: width/2.845833333333333,
                                                          child: sfc.SfCartesianChart(
                                                              primaryXAxis: sfc.CategoryAxis(),
                                                              title: sfc.ChartTitle(
                                                                  text: '   OverAll Absent Reports',
                                                                  textStyle: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w600,
                                                                    color: Colors.black,
                                                                  ),
                                                                  alignment: sfc.ChartAlignment.near
                                                              ),
                                                              legend: sfc.Legend(isVisible: true),
                                                              tooltipBehavior: sfc.TooltipBehavior(enable: true),
                                                              series: <sfc.LineSeries<SalesData, String>>[
                                                                sfc.LineSeries<SalesData, String>(
                                                                  name: '',
                                                                  dataSource: snapshot.data!.absentReport,
                                                                  xValueMapper: (SalesData sales, _) => sales.year,
                                                                  yValueMapper: (SalesData sales, _) => sales.sales,
                                                                  // Enable data label
                                                                  dataLabelSettings: sfc.DataLabelSettings(isVisible: true),
                                                                  color: Colors.red,
                                                                  width: 5,
                                                                  animationDuration: 2000,
                                                                )
                                                              ]
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisAlignment : MainAxisAlignment.center,
                                                          children: [
                                                            CircularPercentIndicator(
                                                              circularStrokeCap: CircularStrokeCap.round,
                                                              radius: 45.0,
                                                              lineWidth: 10.0,
                                                              percent: getStudentAttendancePersantage(snapshot.data!).absent,
                                                              center:  Text("${((getStudentAttendancePersantage(snapshot.data!).absent * 100).toInt())}%",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500)),
                                                              progressColor: Colors.red,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all( 8.0),
                                                              child:  ChoiceChip(
                                                                label: Text("${(getStudentAttendancePersantage(snapshot.data!).absent * getStudentAttendancePersantage(snapshot.data!).total)} Absent  ",style: TextStyle(color: Colors.white),),
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
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height:height/32.55),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Absent Days",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(height:height/32.55),
                                                      Container(
                                                        height:height/2.17,
                                                        child: ListView.builder(
                                                          itemCount: snapshot.data!.absentDays.length,
                                                          itemBuilder: (ctx, i){
                                                            return Card(
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: width/27.32,
                                                                      child: Text(
                                                                        'Date : ',
                                                                        style: TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "${snapshot.data!.absentDays[i]} / ${DateFormat('EEEE').format(DateFormat('dd-M-yyyy').parse(snapshot.data!.absentDays[i]))}",
                                                                      style: const TextStyle(
                                                                        fontWeight: FontWeight.normal,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              );
                                            }return sfc.SfCartesianChart(
                                                primaryXAxis: sfc.CategoryAxis(),
                                                title: sfc.ChartTitle(
                                                    text: '   Monthly Student Reports',
                                                    textStyle: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                    alignment: sfc.ChartAlignment.near
                                                ),
                                                legend: sfc.Legend(isVisible: true),
                                                tooltipBehavior: sfc.TooltipBehavior(enable: true),
                                                series: <sfc.LineSeries<SalesData, String>>[
                                                  sfc.LineSeries<SalesData, String>(
                                                    name: "Students \nAttendance",
                                                    dataSource: [],
                                                    xValueMapper: (SalesData sales, _) => sales.year,
                                                    yValueMapper: (SalesData sales, _) => sales.sales,
                                                    // Enable data label
                                                    dataLabelSettings: sfc.DataLabelSettings(isVisible: true),
                                                    color: Colors.green,
                                                    width: 5,
                                                    animationDuration: 2000,
                                                  )
                                                ]
                                            );
                                          },
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ) :
                       Material(
                          elevation: 15,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15)  ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15)  ),
                                color:Colors.white
                            ),
                            width:width/1.86,
                            height: height/1.140,
                            child: Padding(
                              padding: EdgeInsets.only(left:width/62.2,right:width/62.2),
                              child: Column(
                                children: [
                                /*  SizedBox(height:height/40,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Performance',style: GoogleFonts.montserrat(
                                          fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                      ),),
                                    ],
                                  ),
                                  SizedBox(height:height/30,),

                                  SizedBox(height:height/26.07,),

                                  Container(
                                    width: width/2.276,
                                    child: Divider(

                                      thickness: 2,
                                    ),
                                  ),
                                  */

                                  SizedBox(height:height/100,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Personal Information',style: GoogleFonts.montserrat(
                                          fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                      ),),
                                      InkWell(
                                        onTap: (){
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context)=>StudentEdit(studentid))
                                          );
                                        },
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(left: 445.0),
                                          child: Container(
                                            width: width/20.76,
                                            height: height/21.9,
                                            //color: Color(0xffD60A0B),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              color: Color(0xff53B175),
                                            ),
                                            child: Center(
                                                child: Text(
                                                  "Edit",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white),
                                                )),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(height:height/30,),
                                  Container(
                                    child:  Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 0.0),
                                              child: Row(
                                                children: [
                                                  Text("Sibling Studying Here: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/105.076923077),),
                                                  Text(value["brother studying here"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),),

                                                ],
                                              ),
                                            ),
                                            value["brother studying here"]=="Yes"    ?  Padding(
                                              padding: const EdgeInsets.only(top: 20.0,bottom: 0),
                                              child: Row(
                                                children: [
                                                  Text("Sibling Reg No: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/105.076923077),),
                                                  Text(value["brothername"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),),

                                                ],
                                              ),
                                            ) :Container(),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text("Religion: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/105.076923077),),
                                                  Text(value["religion"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),),

                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text("Community: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/105.076923077),),
                                                Text(value["community"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),),

                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20.0,bottom: 0),
                                              child: Row(
                                                children: [
                                                  Text("Student Aadhaar Number: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/105.076923077),),
                                                  Text(value["aadhaarno"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),),

                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20.0,bottom: 0),
                                              child: Row(
                                                children: [
                                                  Text("Height in cms: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/105.076923077),),
                                                  Text(value["sheight"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),),

                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20.0,bottom: 0),
                                              child: Row(
                                                children: [
                                                  Text("Weight in Kg: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/105.076923077),),
                                                  Text(value["stweight"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),),

                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20.0,bottom: 0),
                                              child: Row(
                                                children: [
                                                  Text("EMIS NO: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/105.076923077),),
                                                  Text(value["EMIS"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),),

                                                ],
                                              ),
                                            ),


                                            Padding(
                                              padding: const EdgeInsets.only(top:20.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Identification Mark: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: width/113.833333333,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["identificatiolmark"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: width/113.833333333,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top:20.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "M.O.Transport: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: width/113.833333333,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["transport"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: width/113.833333333,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20.0,bottom: 8),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Home Address: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: width/113.833333333,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Container(
                                                    width: width/6.83,
                                                    child: Text(
                                                      value["address"],
                                                      style: GoogleFonts.poppins(
                                                          fontSize: width/113.833333333,
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),


                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 70.0,right: 18),
                                          child: Image.asset("assets/line.png"),
                                        ),
                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Father Details ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/97.571428571),),
                                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Container(
                                                  width: width/6.83,
                                                    child: Divider()),
                                              ),
                                              Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text("Name: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/105.076923077),),
                                                  Text(value["fathername"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Occupation: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: width/105.076923077,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["fatherOccupation"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: width/113.833333333,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Office Address: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: width/105.076923077,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Container(
                                                    width: width/6.5047619047619050,
                                                    child: Text(
                                                      value["fatherOffice"],
                                                      style: GoogleFonts.poppins(
                                                          fontSize: width/113.833333333,
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Phone Number: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: width/105.076923077,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["fatherMobile"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: width/113.833333333,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Aadhaar Number: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: width/105.076923077,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["fatherAadhaar"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: width/113.833333333,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text("Mother Details ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/97.571428571),),
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container(
                                                  width: width/6.83,
                                                  child: Divider()),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text("Name: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/105.076923077),),
                                                  Text(value["mothername"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Occupation: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: width/105.076923077,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["motherOccupation"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: width/113.833333333,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Office Address: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: width/105.076923077,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Container(
                                                    width: width/6.2090909090909090,
                                                    child: Text(
                                                      value["motherOffice"],
                                                      style: GoogleFonts.poppins(
                                                          fontSize: width/113.833333333,
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Phone Number: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: width/105.076923077,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["motherMobile"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: width/113.833333333,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Aadhaar Number: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: width/105.076923077,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["motherAadhaar"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: width/113.833333333,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),




                                          ],
                                        ),



                                      ],
                                    ),
                                  ),
                                  SizedBox(height:height/26.07,),


                                ],
                              ),
                            ),
                          ),
                        )
                      ],)
                  ],),
              );
          },
        ),
      ),
    );
  }

  Future<StudentAttendanceReportModel> getMonthlyAttendanceReportForClass() async {
    var snapshot = await FirebaseFirestore.instance.collection("Attendance").get();
    var admin = await FirebaseFirestore.instance.collection("Admin").get();
    int totalWorkingDays = admin.docs.first.get("days");
    List<SalesData> attendanceData = [];
    List<SalesData> attendanceData1 = [];
    List<SalesData> absentData = [];
    List<SalesData> absentData1 = [];
    snapshot.docs.forEach((standard) async {
      int presentCount = 0;
      int absentCount = 0;
      DateTime startDate = DateFormat("dd-M-yyyy").parse('01-06-2023');
      Duration dur =  DateTime.now().difference(startDate);
      try{
        for(int i =0; i < dur.inDays.abs()+1; i++){
          var document1 = await FirebaseFirestore.instance.collection("Attendance").doc(standard.id).collection(DateFormat('dd-M-yyyy').format(startDate.add(Duration(days: i+1)))).get();
          for (var element in document1.docs) {
            if(element.get("present")){
              presentCount++;
              String month = await getMonthForData(startDate.add(Duration(days: i+1)).month);
              SalesData sale = SalesData(month, presentCount.toDouble(),'','');
              attendanceData.add(sale);
            }
            if(!element.get("present")){
              absentCount++;
              String month = await getMonthForData(startDate.add(Duration(days: i+1)).month);
              SalesData sale = SalesData(month, presentCount.toDouble(),'','');
              absentData.add(sale);
            }
          }
        }
      }catch(e){
      }
    });
    await Future.delayed(Duration(seconds: 30));
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

    // print("fetcjhed");
    // return attendanceData1;
    StudentAttendanceReportModel studentReport = StudentAttendanceReportModel(
      absentReport: absentData1,
      presentReport: attendanceData1,
      absentDays: [],
      presentDays: [],
    );
    return studentReport;
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


  getstudents() async {

    var doceumenttotal= await FirebaseFirestore.instance.collection("Attendance").doc("${_typeAheadControllerclass.text}""${_typeAheadControllersection.text}").collection(selecteddate).orderBy("order").get();
    var doceumentpresent= await FirebaseFirestore.instance.collection("Attendance").doc("${_typeAheadControllerclass.text}""${_typeAheadControllersection.text}").collection(selecteddate).where("present",isEqualTo: true).get();
    var doceumentabsent= await FirebaseFirestore.instance.collection("Attendance").doc("${_typeAheadControllerclass.text}""${_typeAheadControllersection.text}").collection(selecteddate).where("present",isEqualTo: false).get();

    setState(() {
      total=doceumenttotal.docs.length;
      present=doceumentpresent.docs.length;
      absent=doceumentabsent.docs.length;
    });


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


  ClassAttendancePercentage getClassRegularPercentage(StudentAttendanceReportModel report){
    double regulatPersantage = 0.0;
    double irregularPersantage = 0.0;
    double totalPersantage = 0.0;
    report.presentReport.forEach((element) {
      regulatPersantage = regulatPersantage + element.sales;
      totalPersantage = totalPersantage + element.sales;
    });
    report.absentReport.forEach((element) {
      irregularPersantage = irregularPersantage + element.sales;
      totalPersantage = totalPersantage + element.sales;
    });
    ClassAttendancePercentage percentage = ClassAttendancePercentage(
        regular: (regulatPersantage/totalPersantage) * 100,
        irregular: (irregularPersantage/totalPersantage) * 100,
        total: totalPersantage
    );
    print(regulatPersantage);
    print(irregularPersantage);
    print(totalPersantage);
    return percentage;
  }


  int total=0;
  int present=0;
  int absent=0;
  int schooltotal=0;
  String selecteddate="";

}
