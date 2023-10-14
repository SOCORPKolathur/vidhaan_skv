import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:uuid/uuid.dart';

class StudentEntry extends StatefulWidget {
  const StudentEntry({Key? key}) : super(key: key);

  @override
  State<StudentEntry> createState() => _StudentEntryState();
}

class _StudentEntryState extends State<StudentEntry> {
  TextEditingController regno=new TextEditingController();
  TextEditingController entrydate=new TextEditingController();
  TextEditingController stnamefirst=new TextEditingController();
  TextEditingController stnamemiddle=new TextEditingController();
  TextEditingController stnamelast=new TextEditingController();
  TextEditingController fathername=new TextEditingController();
  TextEditingController mothername=new TextEditingController();
  TextEditingController bloodgroup=new TextEditingController();
  TextEditingController dob=new TextEditingController();
  TextEditingController community=new TextEditingController();
  TextEditingController house=new TextEditingController();
  TextEditingController religion=new TextEditingController();
  TextEditingController mobile=new TextEditingController();
  TextEditingController email=new TextEditingController();
  TextEditingController address=new TextEditingController();
  TextEditingController identificationmark=new TextEditingController();
  TextEditingController foccupation=new TextEditingController();
  TextEditingController faddress=new TextEditingController();
  TextEditingController fmobile=new TextEditingController();
  TextEditingController femail=new TextEditingController();
  TextEditingController faadhaar=new TextEditingController();
  TextEditingController moccupation=new TextEditingController();
  TextEditingController maddress=new TextEditingController();
  TextEditingController mmobile=new TextEditingController();
  TextEditingController memail=new TextEditingController();
  TextEditingController maadhaar=new TextEditingController();
  TextEditingController income=new TextEditingController();
  TextEditingController aadhaarno=new TextEditingController();
  TextEditingController stheight=new TextEditingController();
  TextEditingController stweight=new TextEditingController();
  TextEditingController EMIS=new TextEditingController();
  TextEditingController gname=new TextEditingController();
  TextEditingController goccupation=new TextEditingController();
  TextEditingController gmobile=new TextEditingController();
  TextEditingController gemail=new TextEditingController();
  TextEditingController gaadhaar=new TextEditingController();
  TextEditingController brothername=new TextEditingController();
  TextEditingController rollno=new TextEditingController();



  //contrillers for dropdown--------------------------------------
  String? _selectedCity;
  final TextEditingController _typeAheadControllerclass = TextEditingController();
  final TextEditingController _typeAheadControllersection = TextEditingController();
  final TextEditingController _typeAheadControlleracidemic = TextEditingController();
  final TextEditingController _typeAheadControllergender = TextEditingController();
  final TextEditingController _typeAheadControllermot = TextEditingController();
  final TextEditingController _typeAheadControllerbrother = TextEditingController();

  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  static final List<String> classes = [];
  static final List<String> section = [];
  static final List<String> acidemic = [];
  static final List<String> genderlist = ["Male","Female","Others"];
  final List<String>  mot = ["Select Option","Own Transport","School Bus","Parent"];
  static final List<String> brother = ["Select Option","Yes","No"];

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
  static List<String> getSuggestionsacidemic(String query) {
    List<String> matches = <String>[];
    matches.addAll(acidemic);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionsgender(String query) {
    List<String> matches = <String>[];
    matches.addAll(genderlist);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  static List<String> getSuggestionsbro(String query) {



    List<String> matches = <String>[];
    matches.addAll(brother);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static final List<String> student = [];
  static List<String> getSuggestionsstudent(String query) {
    List<String> matches = <String>[];
    matches.addAll(student);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  final TextEditingController _typeAheadControllerstudent = TextEditingController();
String studentdocid="";
  getstaffbyid2() async {
    print("fdgggggggggg");

    var document = await FirebaseFirestore.instance.collection("Students").get();
    for(int i=0;i<document.docs.length;i++){
      if(_typeAheadControllerstudent.text==document.docs[i]["stname"]){
        setState(() {
         studentdocid= document.docs[i].id;
        }
        );
      }
    }
    var documentstudent = await FirebaseFirestore.instance.collection("Students").doc(studentdocid).get();
    Map<String, dynamic>? value= documentstudent.data();
    setState(() {
      _typeAheadControllerclass.text=value!["admitclass"];
    });

    print("fdgggggggggg");


  }
  static final List<String> regnolist = [];


  static List<String> getSuggestionsregno(String query) {
    List<String> matches = <String>[];
    matches.addAll(regnolist);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  //------------------Dropdown-------------------------------
  @override
  void initState() {
    adddropdownvalue();
    getorderno();
    setState(() {
      _typeAheadControllermot.text="Select Option";
      _typeAheadControllerbrother.text="Select Option";
        _typeAheadControllerclass.text="Select Option";
        _typeAheadControllersection.text="Select Option";
        _typeAheadControlleracidemic.text="Select Option";

    });
    // TODO: implement initState
    super.initState();
  }
  adddropdownvalue() async {
    setState(() {
      classes.clear();
      section.clear();
      acidemic.clear();
      student.clear();
      regnolist.clear();
    });
    var document = await  FirebaseFirestore.instance.collection("ClassMaster").orderBy("order").get();
    var document2 = await  FirebaseFirestore.instance.collection("SectionMaster").orderBy("order").get();
    var document3 = await  FirebaseFirestore.instance.collection("AcademicMaster").orderBy("order").get();
    setState(() {
      classes.add("Select Option");
      section.add("Select Option");
      acidemic.add("Select Option");
    });
    for(int i=0;i<document.docs.length;i++) {
      setState(() {
        classes.add(document.docs[i]["name"]);
      });

    }
    for(int i=0;i<document2.docs.length;i++) {
      setState(() {
        section.add(document2.docs[i]["name"]);
      });

    }
    for(int i=0;i<document3.docs.length;i++) {
      setState(() {
        acidemic.add(document3.docs[i]["name"]);
      });

    }
    var document4 = await  FirebaseFirestore.instance.collection("Admission").orderBy("name").get();
    var document5 = await  FirebaseFirestore.instance.collection("Students").orderBy("timestamp").get();

    for(int i=0;i<document4.docs.length;i++) {
      setState(() {
        student.add(document4.docs[i]["name"]);

      });

    }
    for(int i=0;i<document5.docs.length;i++) {
      setState(() {
        regnolist.add(document5.docs[i]["regno"]);

      });

    }
  }
  getorderno() async {
    var document = await  FirebaseFirestore.instance.collection("Students").get();
    setState(() {
      regno.text="VDRE${(document.docs.length+1).toString().padLeft(3, '0')}";
    });
  }

  final  _formkey = GlobalKey<FormState>();

  getrollno() async {
    var document = await  FirebaseFirestore.instance.collection("Students").where("admitclass",isEqualTo:_typeAheadControllerclass.text).where("section",isEqualTo:_typeAheadControllersection.text).get();

    setState(() {
      rollno.text=(document.docs.length +1).toString().padLeft(2,"0");
    });

  }


  bool mainconcent= false;
  final check = List<bool>.generate(1000, (int index) => false, growable: true);
  bool view= false;
  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
    return view==false? SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Container(child: Padding(
              padding: const EdgeInsets.only(left: 38.0,top: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Add New Students",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
               SizedBox(width:10),
               InkWell(
                 onTap:(){
                   setState(() {
                     view=true;
                   });
                 },
                 child: Stack(
                   alignment: Alignment.topRight,
                   children: [
                     Icon(Icons.notifications,color:Color(0xffFFA002),size: 30,),
                     Container(
                         width:15,
                         height: 15,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                           color:Colors.red,
                       ),
                         child:Center(child: Text("0",style: GoogleFonts.poppins(color:Colors.white,fontSize: 8),))
                     )
                   ],
                 ),
               )
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
            padding: const EdgeInsets.only(left: 20.0,top: 10),
            child: Container(
              width: width/1.050,
             
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),child: Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Form(
                  key:_formkey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right:0.0),
                                child: Text("Student First Name *",style: GoogleFonts.poppins(fontSize: 15,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 25),
                                child: Container(
                                  child: TypeAheadFormField(


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
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                      ],


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
                                    value!.isEmpty ? 'Field Cannot Be Empty' : null,
                                    onSaved: (value) => this._selectedCity = value,
                                  ),
                                  width: width/5.106,
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
                                child: Text("Middle Name",style: GoogleFonts.poppins(fontSize: 15,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 25),
                                child: Container(child: TextFormField(
                                  controller: stnamemiddle,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15
                                  ),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z -]")),
                                  ],
                                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                    border: InputBorder.none,
                                  ),
                                ),
                                  width: width/5.106,
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
                                child: Text("Last Name *",style: GoogleFonts.poppins(fontSize: 15,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 25),
                                child: Container(child: TextFormField(  inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z -]")),
                                      ],
                                  controller: stnamelast,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15
                                  ),
                                  validator: (value) =>
                                  value!.isEmpty ? 'Field Cannot Be Empty' : null,
                                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                    border: InputBorder.none,
                                  ),
                                ),

                                  width: width/5.106,
                                  height: height/16.42,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                ),
                              ),

                            ],

                          ),
                        ],
                      ),
                      SizedBox(
                        height:20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0,bottom: 10),
                                  child: Text("Student Details",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Application No. * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: regno,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                            border: InputBorder.none,

                                          ),

                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),

                                      ),
                                        width: width/5.464,
                                        height: height/16.42,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Entry Date * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller:  entrydate,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        onTap: () async {
                                          DateTime? pickedDate = await showDatePicker(
                                              context: context, initialDate: DateTime.now(),
                                              firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime(2101)
                                          );

                                          if(pickedDate != null ){
                                            print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                            String formattedDate = DateFormat('dd / M / yyyy').format(pickedDate);
                                            print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                            //you can implement different kind of Date Format here according to your requirement

                                            setState(() {

                                              entrydate.text = formattedDate;

                                              //set output date to TextField value.
                                            });




                                          }else{
                                            print("Date is not selected");
                                          }
                                        },
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,top: 8),
                                          border: InputBorder.none,
                                          hintText: "12/12/2023",

                                          suffixIcon: Icon(Icons.calendar_month),
                                        ),

                                      ),
                                        width: width/5.464,
                                        height: height/16.42,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Academic Year * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
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
                                          items: acidemic
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
                                          value:  _typeAheadControlleracidemic.text,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _typeAheadControlleracidemic.text = value!;
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
                                        width:  width/5.464,
                                        height: height/16.42,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Admit Class * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
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
                                        width: width/5.464,
                                        height: height/16.42,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Section * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
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
                                            getrollno();
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
                                        width: width/5.464,
                                        height: height/16.42,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Roll No * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(

                                        controller: rollno,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        readOnly: true,
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Blood Group * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(
                                        controller: bloodgroup,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Date of Birth * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(
                                        controller: dob,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
                                        onTap: () async {
                                          DateTime? pickedDate = await showDatePicker(
                                              context: context, initialDate: DateTime.now(),
                                              firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime(2101)
                                          );

                                          if(pickedDate != null ){
                                            print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                            String formattedDate = DateFormat('dd / M / yyyy').format(pickedDate);
                                            print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                            //you can implement different kind of Date Format here according to your requirement

                                            setState(() {

                                              dob.text = formattedDate;

                                              //set output date to TextField value.
                                            });




                                          }else{
                                            print("Date is not selected");
                                          }
                                        },
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Gender * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
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
                                          controller: this._typeAheadControllergender,
                                        ),
                                        suggestionsCallback: (pattern) {
                                          return getSuggestionsgender(pattern);
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
                                          this._typeAheadControllergender.text = suggestion;
                                        },
                                        suggestionsBoxController: suggestionBoxController,
                                        validator: (value) =>
                                        value!.isEmpty ? 'Please select a gender' : null,
                                        onSaved: (value) => this._selectedCity = value,
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                                            child: Text("Residential Address * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child:
                                      Padding(
                                        padding: const EdgeInsets.only(top:8.0),
                                        child: TextFormField(
                                          controller:  address,
                                          style: GoogleFonts.poppins(
                                              fontSize: 15
                                          ),
                                          maxLines: 5,
                                          validator: (value) =>
                                          value!.isEmpty ? 'Field Cannot Be Empty' : null,
                                          decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,top: 8),
                                            border: InputBorder.none,
                                            hintText: "",


                                          ),

                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/7.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Community * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(  inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z -]")),
                                      ],
                                        controller: community,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("House & Color :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(  inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z -]")),
                                      ],
                                        controller: house,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Religion * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(  inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z -]")),
                                      ],
                                        controller: religion,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Mobile No * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(
                                        controller: mobile,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                        ],
                                        validator: (value) {
                                          if(value!.isEmpty){
                                        return 'Field Cannot Be Empty';
                                          }
                                          else if(value.characters.length!=10){
                                            return 'Enter the phone number correctly';
                                          }
                                          else{
                                            return null;
                                          }
                                          },
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Email * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(
                                        controller: email,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Aadhaar No * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(
                                        controller: aadhaarno,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                        ],
                                        validator: (value) {
                                          if(value!.isEmpty){
                                            return 'Field Cannot Be Empty';
                                          }
                                           if(value.characters.length!=12){
                                            return 'Enter the Aadhaar number correctly';
                                          }
                                          else{
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Height in cms :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(
                                        controller: stheight,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Weight kg :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(
                                        controller: stweight,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("EMIS No :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(
                                        controller: EMIS,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("M.O.Transport * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
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
                                                  'Select Item',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          items: mot
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
                                          value:  _typeAheadControllermot.text,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _typeAheadControllermot.text = value!;
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
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 0.0),
                                            child: Text("Identification Mark :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(  inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z -]")),
                                      ],
                                        controller: identificationmark,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                              ],
                            ),
                          ),
                          SizedBox(width: 35,),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0,bottom: 10),
                                  child: Text("Parent Details",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Father Name * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(  inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z -]")),
                                      ],
                                       controller: fathername,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.42,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Occupation * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(  inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z -]")),
                                      ],
                                        controller:  foccupation,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,top: 8),
                                          border: InputBorder.none,
                                          hintText: "",

                                          //suffixIcon: Icon(Icons.calendar_month),
                                        ),

                                      ),
                                        width: width/5.464,
                                        height: height/16.42,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Office Address :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child:
                                      TextFormField(  inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z -]")),
                                      ],
                                        controller:  faddress,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),

                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,top: 8),
                                          border: InputBorder.none,



                                        ),

                                      ),
                                        width: width/5.464,
                                        height: height/16.42,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Mobile No :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child:
                                      TextFormField(
                                        controller:  fmobile,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                        ],
                                        validator: (value) {


                                          if(value!.isNotEmpty) {
                                            if (value.characters.length !=
                                                10) {
                                              return 'Enter the number correctly';
                                            }
                                            else{
                                              return null;
                                            }
                                          }
                                          else{
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,top: 8),
                                          border: InputBorder.none,



                                        ),

                                      ),
                                        width: width/5.464,
                                        height: height/16.42,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Email :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child:
                                      TextFormField(
                                        controller:  femail,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),

                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,top: 8),
                                          border: InputBorder.none,



                                        ),

                                      ),
                                        width:  width/5.464,
                                        height: height/16.42,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Aadhaar No  :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right:25),
                                      child: Container(child: TextFormField(
                                     controller: faadhaar,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                        ],
                                        validator: (value) {
                                          if(value!.isNotEmpty) {
                                            if (value.characters.length !=
                                                12) {
                                              return 'Enter the aadhaar number correctly';
                                            }
                                            else{
                                              return null;
                                            }
                                          }
                                          else{
                                            return null;
                                          }
                                        },


                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom:8),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Mother Name * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(  inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z -]")),
                                      ],
                                        controller: mothername,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Occupation * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(  inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z -]")),
                                      ],
                                        controller: moccupation,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        validator: (value) =>
                                        value!.isEmpty ? 'Field Cannot Be Empty' : null,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Office Address :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child:
                                      TextFormField(  inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z -]")),
                                      ],
                                        controller:  maddress,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),

                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,top: 8),
                                          border: InputBorder.none,



                                        ),

                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Mobile No :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(
                                        controller: mmobile,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                        ],
                                        validator: (value) {

                                          if(value!.isNotEmpty) {
                                            if (value.characters.length !=
                                                10) {
                                              return 'Enter the number correctly';
                                            }
                                            else{
                                              return null;
                                            }
                                          }
                                          else{
                                            return null;
                                          }
                                        },

                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Email :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(
                                        controller: memail,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Aadhaar No  :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(
                                        controller: maadhaar,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                        ],
                                        validator: (value) {

                                          if(value!.isNotEmpty) {
                                            if (value.characters.length != 12) {
                                              return 'Enter the aadhaar number correctly';
                                            }
                                            else{
                                              return null;
                                            }
                                          }
                                          else{
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0,bottom: 10),
                                  child: Text("Other Details",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
                                ),

                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Guardian's Name :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z -]")),
                                        ],
                                        controller: gname,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Occupation :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(  inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z -]")),
                                      ],
                                        controller: goccupation,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Mobile No :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(
                                        controller: gmobile,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                        ],
                                        validator: (value) {

                                          if(value!.isNotEmpty) {
                                            if (value.characters.length !=
                                                10) {
                                              return 'Enter the number correctly';
                                            }
                                            else{
                                              return null;
                                            }
                                          }
                                          else{
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Email :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(
                                        controller: gemail,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Aadhaar No  :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(child: TextFormField(
                                        controller: gaadhaar,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15
                                        ),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                        ],
                                        validator: (value) {

                                          if(value!.isNotEmpty) {
                                            if (value.characters.length !=
                                                12) {
                                              return 'Enter the aadhaar number correctly';
                                            }
                                            else{
                                              return null;
                                            }
                                          }
                                          else{
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                          border: InputBorder.none,



                                        ),
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/15.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                                            child: Text("Brother/Sister Studying Here * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
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
                                          items: brother
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
                                          value:  _typeAheadControllerbrother.text,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _typeAheadControllerbrother.text = value!;
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
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                _typeAheadControllerbrother.text=="Yes" ?     Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: Container(
                                          width: width/10.106,
                                          height: height/16.42,

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                                            child: Text("If Yes, Reg ID * :",style: GoogleFonts.poppins(fontSize: 15,)),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
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
                                          controller: brothername,
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
                                            brothername.text = suggestion;
                                          });

                                          // getstaffbyid();
                                          // getorderno();



                                        },
                                        suggestionsBoxController: suggestionBoxController,
                                        validator: (value) =>
                                        value!.isEmpty ? 'Please select a class' : null,
                                        onSaved: (value) => this._selectedCity = value,
                                      ),
                                        width: width/5.464,
                                        height: height/16.425,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ),
                                  ],
                                ): Container(),
                                SizedBox(
                                  height: 10,
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:8.0,left:50,right:10),
                            child: Container(

                              child: isloading==false ?imgUrl==""?   Center(
                                child: Icon(Icons.upload,size: 40,),
                              )
                                  :
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(52),
                                  child: Image.network(imgUrl,fit: BoxFit.cover,)) : Center(
                                child: CircularProgressIndicator(),
                              ),
                              width: width/13.66,
                              height: height/6.57,
                              //color: Color(0xffDDDEEE),
                              decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(52)),

                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:48.0),
                                child: Text("Upload Student Photo(150pxX150px)",style: GoogleFonts.poppins(fontSize: 15),),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        isloading=true;
                                      });
                                      uploadToStorage();
                                    },
                                    child: Container(child: Center(child: Text("Choose file",style: GoogleFonts.poppins(fontSize: 16))),
                                      width: width/10.507,
                                      height: height/16.425,
                                      // color: Color(0xffDDDEEE),
                                      decoration: BoxDecoration(border: Border.all(color: Colors.black),color: Color(0xffDDDEEE)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("No file chosen",style: GoogleFonts.poppins(fontSize: 13),),
                                  )
                                ],
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left:28.0,right:20),
                            child: GestureDetector(
                              onTap: (){
                                if(_typeAheadControllermot.text=="Select Option" ||
                                _typeAheadControllerbrother.text=="Select Option"||

                                _typeAheadControllerclass.text=="Select Option"||
                                _typeAheadControllersection.text=="Select Option"||
                                _typeAheadControlleracidemic.text=="Select Option"

                                ){
                                  Successdialog3();
                                }
                                else {
                                  final isvalid = _formkey.currentState!
                                      .validate();
                                  print(isvalid);
                                  if (_formkey.currentState!.validate()) {
                                    print("fghdddddddddddddd");
                                    already();
                                  }
                                }


                              },
                              child: Container(child: Center(child: Text("Save ",style: GoogleFonts.poppins(color:Colors.white),)),
                                width: width/10.507,
                                height: height/16.425,
                                //color:Color(0xffD60A0B),
                                decoration: BoxDecoration(color: Color(0xffD60A0B),borderRadius: BorderRadius.circular(5)),

                              ),
                            ),
                          ),
                          Container(child: Center(child: Text("Reset ",style: GoogleFonts.poppins(color:Colors.white),)),
                            width: width/10.507,
                            height: height/16.425,
                            // color:Color(0xff00A0E3),
                            decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                          ),
                        ],
                      ),
                      SizedBox(height:50)
                    ],
                  ),
                ),
              ),

            ),
          )
        ],
      ),
    ) :
    SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 0.0, bottom: 20),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                            onTap:(){
                              setState(() {
                                view=false;
                              });
                            },

                            child: Icon(Icons.arrow_back_rounded)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 38.0, right: 30),
                        child: Text("Admissions Waiting for Verification",
                            style: GoogleFonts.poppins(
                                color: Color(0xff000000),
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                     ],
                  ),
                ),

                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Checkbox(
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
                        padding: const EdgeInsets.only(left: 8.0, right: 60),
                        child: Text(
                          "Date",
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "Student Name",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0, right: 40),
                        child: Text(
                          "Class",
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "Phone no",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 45),
                        child: Text(
                          "Parent name",
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "Previous School",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Text(
                          "Actions",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  //color: Colors.pink,
                  width: width/1.366,
                  height: height/18.771,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0,),
                  child: Container(

                    width: width/1.366,
                    height: height/13.14,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(

                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Admission").orderBy("timestamp",descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData==null){
                              return Container();
                            }
                            if(!snapshot.hasData){
                              return Container();
                            }
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return  Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
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
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 19),
                                      child: Text(snapshot.data!.docs[index]
                                      ["date"],selectionColor: Color(0xff109CF1),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 36.0,left: 20),
                                      child: Text(snapshot.data!.docs[index]
                                      ["name"]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 45.0),
                                      child: Text(snapshot.data!.docs[index]
                                      ["class"]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 50.0, right: 30),
                                      child: Text(snapshot.data!.docs[index]
                                      ["phone"]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18.0,right: 50),
                                      child: Text(snapshot.data!.docs[index]
                                      ["parent"]),
                                    ),
                                    Text(snapshot.data!.docs[index]
                                    ["lastschool"]),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 50.0, right: 20, top: 3),
                                      child: ElevatedButton(


                                        onPressed: () => _dialogBuilder(context),
                                        child:  Text('View'),

                                      ),


                                    ),

                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),


              ],
            ),
            width: width/0.9927,

            color: Color(0xffF5F5F5),
          )
        ],
      ),
    );

  }
  String imgUrl="";
  String fileName = Uuid().v1();
  bool  isloading = false;
  Future<void> _dialogBuilder(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return showDialog(

      context: context,

      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('Admissions Details',style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold),
          ),
          content: Container(child:
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name:",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 12),),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                    child: Text("Class:",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 12),),
                  ),
                  Text("Phone:",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 12),),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                    child: Text("Father Name:",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 12),),
                  ),
                  Text("Mother Name:",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 12),),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                    child: Text("Religion:",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 12),),
                  ),
                  Text("Community:",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 12),),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                    child: Text("D.O.B:",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 12),),
                  ),
                  Text("Student Adhaar Number:",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 12),),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 148.0,right: 18),
                child: Image.asset("assets/line.png"),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                    child: Text(
                      "School Last studied:",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "% of Marks obtained:",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Name Of Board:",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                    child: Text(
                      "Parent Occupation:",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Annual Income:",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                    child: Text(
                      "Residential Address:",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(onTap: () {
                        Navigator.of(context).pop();
                        Successdialog();
                      },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20,right: 20),
                          child: Container(
                            // color: Colors.yellow,
                            width: width/6.209,
                            height: height/21.9,
                            child: Center(child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Send Enrollment Link",style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(Icons.send,color: Colors.white,),
                                )
                              ],
                            )),
                            decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(7)),

                          ),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              Successdialog2();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                // color: Colors.yellow,
                                width: width/12.209,
                                height: height/21.9,
                                child: Center(child: Text("Waiting List",style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),)),
                                decoration: BoxDecoration(color: Color(0xffFFA002),borderRadius: BorderRadius.circular(7)),

                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              Successdialog3();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10,left: 20),
                              child: Container(
                                // color: Colors.yellow,
                                width: width/12.209,
                                height: height/21.9,
                                child: Center(child: Text("Reject",style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),)),
                                decoration: BoxDecoration(color: Color(0xffD60A0B),borderRadius: BorderRadius.circular(7)),

                              ),
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
            width: width/2.1682,
            height: height/2.628,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),

          ),


        );
      },
    );
  }

  uploadToStorage() async{

    InputElement input = FileUploadInputElement()as InputElement ..accept = 'image/*';
    FirebaseStorage fs = FirebaseStorage.instance;
    input.click();
    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) async {
        var snapshot = await fs.ref().child('studentsimages').child("${file.name}").putBlob(file);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imgUrl = downloadUrl;
          isloading=false;
        });

        print(imgUrl);
      });
    });
    print(imgUrl);
  }
  Successdialog(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Student Added Successfully',
      desc: 'Student - ${stnamefirst.text} is been added',

      btnCancelOnPress: () {

      },

      btnOkText: "Ok",
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
      title: 'Data has been Already Exits',


      btnCancelOnPress: () {

      },
      btnCancelText: "Cancel",
      btnOkText: "Ok",
      btnOkOnPress: () {

      },
    )..show();
  }
  Successdialog3(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Enter the details correctly',
      desc: "Select all the value in  drop down",



      btnOkText: "Ok",
      btnOkOnPress: () {

      },
    )..show();
  }
  String studentid = "";

  already() async {
    var document= await FirebaseFirestore.instance.collection("Students").where("mobile",isEqualTo: mobile.text).get();
    if(document.docs.length>0){
      Successdialog2();
    }
    else{
      uploadstudent();
      Successdialog();
    }
  }


  uploadstudent(){

    setState(() {
      studentid=randomAlphaNumeric(16);
    });
    FirebaseFirestore.instance.collection("Students").doc(studentid).set({
      "stname": _typeAheadControllerstudent.text,
      "stmiddlename": stnamemiddle.text,
      "stlastname": stnamelast.text,
      "regno": regno.text,
      "rollno":rollno.text,
      "studentid": studentid,
      "entrydate": entrydate.text,
      "admitclass": _typeAheadControllerclass.text,
      "section": _typeAheadControllersection.text,
      "academic": _typeAheadControlleracidemic.text,
      "bloodgroup": bloodgroup.text,
      "dob": dob.text,
      "gender": _typeAheadControllergender.text,
      "address": address.text,
      "community": community.text,
      "house": house.text,
      "religion": religion.text,
      "mobile": mobile.text,
      "email": email.text,
      "aadhaarno": aadhaarno.text,
      "sheight": stheight.text,
      "stweight": stweight.text,
      "EMIS": EMIS.text,
      "transport": _typeAheadControllermot.text,
      "identificatiolmark": identificationmark.text,

      "fathername": fathername.text,
      "fatherOccupation": foccupation.text,
      "fatherOffice": faddress.text,
      "fatherMobile": fmobile.text,
      "fatherEmail": femail.text,
      "fatherAadhaar": faadhaar.text,

      "mothername": mothername.text,
      "motherOccupation": moccupation.text,
      "motherOffice": maddress.text,
      "motherMobile": mmobile.text,
      "motherEmail": memail.text,
      "motherAadhaar": maadhaar.text,

      "guardianname": gname.text,
      "guardianOccupation": goccupation.text,
      "guardianMobile": gmobile.text,
      "guardianEmail": gemail.text,
      "guardianAadhaar": gaadhaar.text,

      "brother studying here": _typeAheadControllerbrother.text,
      "brothername": brothername.text,

      "imgurl":imgUrl,
      "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "time": "${DateTime.now().hour}:${DateTime.now().minute}",
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      "absentdays":0,
      "behaviour":0,
    });
    FirebaseFirestore.instance.collection("Classstudents").doc("${_typeAheadControllerclass.text}${_typeAheadControllersection.text}").set({
      "name":"${_typeAheadControllerclass.text}${_typeAheadControllersection.text}",
    });
    FirebaseFirestore.instance.collection("Classstudents").doc("${_typeAheadControllerclass.text}${_typeAheadControllersection.text}").collection("Students").doc(studentid).set({
      "regno": regno.text,
      "studentid": studentid,
      "admitclass": _typeAheadControllerclass.text,
      "section": _typeAheadControllerclass.text,
      "stname": stnamefirst.text,
      "absentdays":0,
      "behaviour":0,
    });

    clearall();

  }
  
  
  
  clearall(){
    setState(() {


     regno.clear();
     entrydate.clear();
     stnamefirst.clear();
     stnamemiddle.clear();
     stnamelast.clear();
     fathername.clear();
     mothername.clear();
     bloodgroup.clear();
     dob.clear();
     community.clear();
     house.clear();
     religion.clear();
     mobile.clear();
     email.clear();
     address.clear();
     identificationmark.clear();
     foccupation.clear();
     faddress.clear();
     fmobile.clear();
     femail.clear();
     faadhaar.clear();
     moccupation.clear();
     maddress.clear();
     mmobile.clear();
     memail.clear();
     maadhaar.clear();
     income.clear();
     aadhaarno.clear();
     stheight.clear();
     stweight.clear();
     EMIS.clear();
     gname.clear();
     goccupation.clear();
     gmobile.clear();
     gemail.clear();
     gaadhaar.clear();
     brothername.clear();
     rollno.clear();
     _typeAheadControllerstudent.text="";
     _typeAheadControllermot.text="Select Option";
     _typeAheadControllerbrother.text="Select Option";
     _typeAheadControllerclass.text="Select Option";
     _typeAheadControllersection.text="Select Option";
     _typeAheadControlleracidemic.text="Select Option";
     _typeAheadControllergender.text="Select Option";
     imgUrl="";
    });
     getorderno();
  }
}
