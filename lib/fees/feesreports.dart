import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Masters/excelgen.dart';

class FeesReports extends StatefulWidget {
  const FeesReports({Key? key}) : super(key: key);

  @override
  State<FeesReports> createState() => _FeesReportsState();
}

class _FeesReportsState extends State<FeesReports> {
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
      fees.clear();
    });
    var document = await FirebaseFirestore.instance.collection("Students")
        .orderBy("timestamp")
        .get();
    var document2 = await FirebaseFirestore.instance.collection("Students")
        .orderBy("stname")
        .get();
    setState(() {
      fees.add("Select Option");
    });
    for (int i = 0; i < document.docs.length; i++) {
      setState(() {
        regno.add(document.docs[i]["regno"]);
      });
    }
    for (int i = 0; i < document2.docs.length; i++) {
      setState(() {
        student.add(document2.docs[i]["stname"]);
      });
    }
    var document3 = await FirebaseFirestore.instance.collection("ClassMaster")
        .orderBy("order")
        .get();
    for (int i = 0; i < document3.docs.length; i++) {
      setState(() {
        classes.add(document3.docs[i]["name"]);
      });
    }
    var document4 = await FirebaseFirestore.instance.collection("SectionMaster")
        .orderBy("order")
        .get();
    for (int i = 0; i < document4.docs.length; i++) {
      setState(() {
        section.add(document4.docs[i]["name"]);
      });
    }

    var document5 = await FirebaseFirestore.instance.collection("FeesMaster")
        .orderBy("order")
        .get();
    setState(() {
      fees.add("All Fees");
    });
    for (int i = 0; i < document5.docs.length; i++) {
      setState(() {
        fees.add(document5.docs[i]["name"]);
      });
    }
  }
  String studentid="";

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
  TextEditingController pos1=new TextEditingController();
  TextEditingController pos2=new TextEditingController();
  final DateFormat formatter = DateFormat('dd / M / yyyy');
  int year1 =0;
  int day1= 0;
  int month1=0;
  int year2=0;
  int day2=0;
  int month2=0;
  List<String> mydate =[];

  final TextEditingController type = TextEditingController();
  final TextEditingController paytype = TextEditingController();

  static final List<String> typeclass = ["Select Option","School","Class","Section","Student"];
  static final List<String> paytypelist = ["Monthly","Admission Time","Custom",];

  static List<String> getSuggestionstype(String query) {
    List<String> matches = <String>[];
    matches.addAll(typeclass);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionstypepay(String query) {
    List<String> matches = <String>[];
    matches.addAll(paytypelist);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  final TextEditingController _typeAheadControllerfees = TextEditingController();
  static final List<String> fees = [];
  static List<String> getSuggestionsfees(String query) {
    List<String> matches = <String>[];
    matches.addAll(fees);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  void initState() {
    adddropdownvalue();
    setState(() {
      type.text="Select Option";
      _typeAheadControllerfees.text="Select Option";
    });
    // TODO: implement initState
    super.initState();
  }
  bool search= false;
  bool byclass = false;

  bool single= false;
  bool married= false;
  bool married2= true;
  bool mainconcent= false;
  final check = List<bool>.generate(1000, (int index) => false, growable: true);
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Container(width: width/1.050,

            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),child: Padding(
              padding: const EdgeInsets.only(left: 10.0,top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Fees Reports",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
                      SizedBox(width: 400,),
                      Padding(
                        padding: const EdgeInsets.only(right:8.0),
                        child: Icon(Icons.filter_list_sharp),
                      ),
                      Text("Filters",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: (){
                          setState(() {
                            search=false;
                            byclass=false;
                            single=false;
                            married=false;
                            married2=false;

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
                      SizedBox(width: 140,),
                      //Excelsheet(),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Fees:",style: GoogleFonts.poppins(fontSize: 15,),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0,right: 25),
                            child: Container(width: width/6.83,
                              height: height/16.42,
                              //color: Color(0xffDDDEEE),
                              decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),child:
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
                                  items: fees
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
                                  value:  _typeAheadControllerfees.text,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _typeAheadControllerfees.text = value!;
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

                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Fees Reports For :",style: GoogleFonts.poppins(fontSize: 15,),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0,right: 25),
                            child: Container(width: width/6.83,
                              height: height/16.42,
                              //color: Color(0xffDDDEEE),
                              decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),child:
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
                                  items: typeclass
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
                                  value:  type.text,
                                  onChanged: (String? value) {
                                    setState(() {
                                      type.text = value!;
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

                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:70.0,bottom:0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right:10.0),
                              child: Container(
                                  height: height/16.42,

                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text("Pending :",style: GoogleFonts.poppins(fontSize: 15,)),
                                  )),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 10),
                                child: Checkbox(
                                  value: single,
                                  onChanged: (value){
                                    setState(() {
                                      single=value!;
                                      if(single==true){
                                        married=false;
                                        married2=false;
                                      }
                                    });
                                  },
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:45.0,right: 10),
                              child: Container(

                                  height: height/16.42,

                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text("OverDue :",style: GoogleFonts.poppins(fontSize: 15,)),
                                  )),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 10),
                                child: Checkbox(
                                  value: married,
                                  onChanged: (value){
                                    setState(() {
                                      married=value!;
                                      if(married==true){
                                        single=false;
                                        married2=false;
                                      }
                                    });
                                  },
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:45.0,right: 10),
                              child: Container(

                                  height: height/16.42,

                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text("Paid :",style: GoogleFonts.poppins(fontSize: 15,)),
                                  )),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 10),
                                child: Checkbox(
                                  value: married2,
                                  onChanged: (value){
                                    setState(() {
                                      married2=value!;
                                      if(married2==true){
                                        single=false;
                                        married=false;
                                      }
                                    });
                                  },
                                )
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 00,top:20,bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                      type.text=="Student"?  Row(
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
                          ],
                        ):type.text=="Class"? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:0.0),
                            child: Text("By Class",style: GoogleFonts.poppins(fontSize: 15,)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0,right: 25),
                            child: Container(child:  TypeAheadFormField(


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
                                controller: this._typeAheadControllerclass,
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsclass(pattern);
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
                                  this._typeAheadControllerclass.text = suggestion;
                                });




                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a class' : null,
                              onSaved: (value) => this._selectedCity = value,
                            ),
                              width: width/6.902,
                              height: height/16.42,
                              //color: Color(0xffDDDEEE),
                              decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                            ),
                          ),

                        ],

                      ): type.text=="Section"? Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right:0.0),
                                child: Text("By Class",style: GoogleFonts.poppins(fontSize: 15,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 25),
                                child: Container(child:  TypeAheadFormField(


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
                                    controller: this._typeAheadControllerclass,
                                  ),
                                  suggestionsCallback: (pattern) {
                                    return getSuggestionsclass(pattern);
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
                                      this._typeAheadControllerclass.text = suggestion;
                                    });




                                  },
                                  suggestionsBoxController: suggestionBoxController,
                                  validator: (value) =>
                                  value!.isEmpty ? 'Please select a class' : null,
                                  onSaved: (value) => this._selectedCity = value,
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
                                child: Container(child:  TypeAheadFormField(


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
                                    controller: this._typeAheadControllersection,
                                  ),
                                  suggestionsCallback: (pattern) {
                                    return getSuggestionssection(pattern);
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
                                      this._typeAheadControllersection.text = suggestion;
                                    });




                                  },
                                  suggestionsBoxController: suggestionBoxController,
                                  validator: (value) =>
                                  value!.isEmpty ? 'Please select a section' : null,
                                  onSaved: (value) => this._selectedCity = value,
                                ),
                                  width: width/6.902,
                                  height: height/16.42,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                ),
                              ),

                            ],

                          ),
                        ],
                      ):Container(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right:0.0),
                                  child: Text("From Date",style: GoogleFonts.poppins(fontSize: 15,)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0,right: 25),
                                  child: Container(child:  TextField(
                                    controller: pos2,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(bottom: width/136.6, left: width/91.06),
                                      hintText: "mm/dd/yyyy",
                                      hintStyle: TextStyle(color: Colors.black),
                                      border: InputBorder.none,
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
                                          year2= pickedDate.year;
                                          day2= pickedDate.day;
                                          month2= pickedDate.month;
                                          pos2.text = formattedDate;

                                          //set output date to TextField value.
                                        });
                                        print(year2);
                                        print(day2);
                                        print(month2);
                                        DateTime startDate = DateTime.utc(year1, month1, day1);
                                        DateTime endDate = DateTime.utc(year2, month2, day2);
                                        print(startDate);
                                        print(endDate);
                                        getDaysInBetween() {
                                          final int difference = endDate.difference(startDate).inDays;
                                          print(difference);
                                          return difference;
                                        }
                                        final items = List<DateTime>.generate(getDaysInBetween(), (i) {
                                          DateTime date = startDate;
                                          return date.add(Duration(days: i));
                                        });
                                        setState(() {
                                          mydate.clear();
                                        });
                                        for(int i =0;i<items.length;i++) {
                                          setState(() {
                                            mydate.add(formatter.format(items[i]).toString());
                                          });

                                        }
                                        print(mydate);

                                      }else{
                                        print("Date is not selected");
                                      }
                                    },
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
                                  child: Text("To Date",style: GoogleFonts.poppins(fontSize: 15,)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0,right: 10),
                                  child: Container(child:  TextField(
                                    controller: pos1,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(bottom: width/136.6, left: width/91.06),
                                      hintText: "mm/dd/yyyy",
                                      hintStyle: TextStyle(color: Colors.black),
                                      border: InputBorder.none,
                                    ),
                                    onTap: () async {

                                      DateTime? pickedDate = await showDatePicker(
                                          context: context, initialDate: DateTime.now(),
                                          firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime.now()
                                      );

                                      if(pickedDate != null ){
                                        print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate = DateFormat('dd / M / yyyy').format(pickedDate);
                                        print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                        //you can implement different kind of Date Format here according to your requirement

                                        setState(() {
                                          year1= pickedDate.year;
                                          day1= pickedDate.day;
                                          month1= pickedDate.month;
                                          pos1.text = formattedDate;
                                          //set output date to TextField value.
                                        });
                                      }else{
                                        print("Date is not selected");
                                      }
                                    },
                                  ),
                                    width: width/6.902,
                                    height: height/16.42,
                                    //color: Color(0xffDDDEEE),
                                    decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                  ),
                                ),

                              ],

                            ),
                          ],
                        ),
                        InkWell(
                          onTap: (){
                            getstaffbyid();
                          },
                          child: Container(child: Center(child: Text("Search",style: GoogleFonts.poppins(color:Colors.white),)),
                            width: width/10.507,
                            height: height/16.425,
                            // color:Color(0xff00A0E3),
                            decoration: BoxDecoration(color: const Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                          ),
                        ),
                        SizedBox(width:25),
                        InkWell(
                          onTap: (){
                           // getstaffbyid();
                          },
                          child: Container(child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.send,color:Colors.white),
                              SizedBox(width:10),
                              Text("Send Message",style: GoogleFonts.poppins(color:Colors.white),),
                            ],
                          )),
                            width: width/8.507,
                            height: height/16.425,
                            // color:Color(0xff00A0E3),
                            decoration: BoxDecoration(color: const Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                          ),
                        ),
                        SizedBox(width: 15,),




                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height:20),
        Container(
          height:height/13.14,
          width: width/1.366,
          decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              Container(
                width:130,
                child: Text('Fees Name',style: GoogleFonts.montserrat(
                    fontWeight:FontWeight.bold,color: Colors.white,fontSize:width/81.13
                ),),
              ),
              Container(
                width:130,
                child: Text('Amount',style: GoogleFonts.montserrat(
                    fontWeight:FontWeight.bold,color: Colors.white,fontSize:width/81.13
                ),),
              ),
              Container(
                width:130,
                child: Text('Status',style: GoogleFonts.montserrat(
                    fontWeight:FontWeight.bold,color: Colors.white,fontSize:width/81.13
                ),),
              ),
              Container(
                width:130,
                child: Text('Date',style: GoogleFonts.montserrat(
                    fontWeight:FontWeight.bold,color: Colors.white,fontSize:width/81.13
                ),),
              ),
              Container(
                width:130,
                child: Text('Time',style: GoogleFonts.montserrat(
                    fontWeight:FontWeight.bold,color: Colors.white,fontSize:width/81.13
                ),),
              ),
              Container(
                width:130,
                child: Text('Student Name',style: GoogleFonts.montserrat(
                    fontWeight:FontWeight.bold,color: Colors.white,fontSize:width/81.13
                ),),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
