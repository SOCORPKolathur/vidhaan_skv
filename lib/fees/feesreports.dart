import 'package:awesome_dialog/awesome_dialog.dart';
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
      pos1.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
      pos2.text = DateFormat('dd/MM/yyyy').format(DateTime.now().subtract(Duration(days: 30)));
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
    var document = await FirebaseFirestore.instance.collection("Students").get();
    for(int i=0;i<document.docs.length;i++){
      if(_typeAheadControllerregno.text==document.docs[i]["regno"]){
        setState(() {
          studentid= document.docs[i].id;
          _typeAheadControllerstudent.text=document.docs[i]["stname"];
        }
        );
      }
    }
    setState(() {
      search=true;
      byclass=false;
    });


  }
  getstaffbyid2() async {
    var document = await FirebaseFirestore.instance.collection("Students").get();
    for(int i=0;i<document.docs.length;i++){
      if(_typeAheadControllerstudent.text==document.docs[i]["stname"]){
        setState(() {
          _typeAheadControllerregno.text= document.docs[i]["regno"];
          studentid= document.docs[i].id;
        }
        );
      }
    }
    setState(() {
      search=true;
      byclass=false;
    });


  }
  TextEditingController pos1=new TextEditingController();
  TextEditingController pos2=new TextEditingController();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
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

  List<String> studentsListForNotification = [];
  bool isAllStudentForNotification = false;

  @override
  void initState() {
    adddropdownvalue();
    setState(() {
      type.text="Select Option";
      _typeAheadControllerfees.text="Select Option";
    });
    getadmin();
    // TODO: implement initState
    super.initState();
  }
  bool search= false;
  bool byclass = false;

  bool single= false;
  bool married= false;
  bool married2= false;
  bool mainconcent= false;
  final check = List<bool>.generate(1000, (int index) => false, growable: true);
  
  List<DocumentSnapshot> students = [];
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
              padding:  EdgeInsets.only(left: width/136.6,top: height/21.7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Fees Reports",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),),

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
                            child: Text("Fees:",style: GoogleFonts.poppins(fontSize: width/91.066666667,),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 0.0,right: width/54.64),
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
                                        size: width/85.375,
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
                                  items: fees
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
                                  value:  _typeAheadControllerfees.text,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _typeAheadControllerfees.text = value!;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: height/13.02,
                                    width: width/8.5375,
                                    padding:  EdgeInsets.only(left: width/97.571428571, right: width/97.571428571),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),

                                      color: Color(0xffDDDEEE),
                                    ),

                                  ),
                                  iconStyleData:  IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                    ),
                                    iconSize: width/97.571428571,
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
                                  menuItemStyleData:  MenuItemStyleData(
                                    height: height/16.275,
                                    padding: EdgeInsets.only(left: width/97.571428571, right: width/97.571428571),
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
                            child: Text("Fees Reports For :",style: GoogleFonts.poppins(fontSize: width/91.066666667,),),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: 0.0,right: width/54.64),
                            child: Container(
                              width: width/6.83,
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
                                        size: width/85.375,
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
                                  items: typeclass
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
                                  value:  type.text,
                                  onChanged: (String? value) {
                                    setState(() {
                                      type.text = value!;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: height/13.02,
                                    width: width/8.5375,
                                    padding:  EdgeInsets.only(left: width/97.571428571, right: width/97.571428571),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),

                                      color: Color(0xffDDDEEE),
                                    ),

                                  ),
                                  iconStyleData:  IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                    ),
                                    iconSize: width/97.571428571,
                                    iconEnabledColor: Colors.black,
                                    iconDisabledColor: Colors.grey,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: height/3.255,
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
                                  menuItemStyleData:  MenuItemStyleData(
                                    height: height/16.275,
                                    padding: EdgeInsets.only(left: width/97.571428571, right: width/97.571428571),
                                  ),
                                ),
                              ),

                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left:width/19.514285714,bottom:0),
                        child: Row(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(right:width/136.6),
                              child: Container(
                                  height: height/16.42,

                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text("Pending :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                  )),
                            ),
                            Padding(
                                padding:  EdgeInsets.only(left: 0.0,right: width/136.6),
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
                              padding:  EdgeInsets.only(left: width/30.355555556,right: width/136.6),
                              child: Container(

                                  height: height/16.42,

                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text("OverDue :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                  )),
                            ),
                            Padding(
                                padding:  EdgeInsets.only(left: 0.0,right: width/136.6),
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
                              padding:  EdgeInsets.only(left:width/30.355555556,right: width/136.6),
                              child: Container(

                                  height: height/16.42,

                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text("Paid :",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                  )),
                            ),
                            Padding(
                                padding:  EdgeInsets.only(left: 0.0,right: width/136.6),
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
                            SizedBox(width: width/136.6,),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  search=false;
                                  byclass=false;
                                  single=false;
                                  married=false;
                                  married2=false;
                                  _typeAheadControllerfees.text = "Select Option";
                                  type.text="Select Option";
                                });
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(5),
                                elevation: 7,
                                child: Container(child: Center(child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: width/170.75),
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

                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 00,top:height/32.55,bottom: height/32.55),
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
                                  child: Text("Register Number",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 0.0,right: width/136.6),
                                  child: Container(
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
                                      decoration:  InputDecoration(
                                        contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/81.375),
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

                                      getstaffbyid();



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
                                  child: Text("Student Name",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 0.0,right: width/136.6),
                                  child: Container(
                                    width: width/8.902,
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
                                        decoration:  InputDecoration(
                                          contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/81.375),
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
                        ):
                      type.text=="Class"? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:0.0),
                            child: Text("By Class",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: 0.0,right: width/54.64),
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
                                    fontSize: width/91.066666667
                                ),
                                decoration:  InputDecoration(
                                  contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/81.375),
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

                      ): type.text=="Section"?
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right:0.0),
                                child: Text("By Class",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(left: 0.0,right: width/136.6),
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
                                    decoration:  InputDecoration(
                                      contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/81.375),
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
                                  width: width/8.902,
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
                                padding:  EdgeInsets.only(left: 0.0,right: width/136.6),
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
                                        fontSize: width/91.066666667
                                    ),
                                    decoration:  InputDecoration(
                                      contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/81.375),
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
                                  width: width/8.902,
                                  height: height/16.42,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                ),
                              ),

                            ],

                          ),
                        ],
                      )
                          :Container(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right:0.0),
                                  child: Text("From Date",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 0.0,right: width/54.64),
                                  child: Container(child:  TextField(
                                    controller: pos2,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(bottom: width/136.6, left: width/91.06),
                                      hintText: "dd/MM/yyyy",
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
                                        String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                                       //you can implement different kind of Date Format here according to your requirement

                                        setState(() {
                                          year2= pickedDate.year;
                                          day2= pickedDate.day;
                                          month2= pickedDate.month;
                                          pos2.text = formattedDate;

                                          //set output date to TextField value.
                                        });
                                        DateTime startDate = DateTime.utc(year1, month1, day1);
                                        DateTime endDate = DateTime.utc(year2, month2, day2);
                                        getDaysInBetween() {
                                          final int difference = endDate.difference(startDate).inDays;
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

                                      }else{
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
                                  child: Text("To Date",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 0.0,right: width/136.6),
                                  child: Container(child:  TextField(
                                    controller: pos1,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(bottom: width/136.6, left: width/91.06),
                                      hintText: "dd/MM/yyyy",
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
                                        String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                                        //you can implement different kind of Date Format here according to your requirement

                                        setState(() {
                                          year1= pickedDate.year;
                                          day1= pickedDate.day;
                                          month1= pickedDate.month;
                                          pos1.text = formattedDate;
                                          //set output date to TextField value.
                                        });
                                      }else{
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
                        SizedBox(width:width/54.64),
                        InkWell(
                          onTap: (){
                           // getstaffbyid();
                            //sendEmail(docid, to, subject, description);
                            if(!married2){
                              sendNotificationsToStudents(
                                //married ? 'overdue' : single ? 'pending' : ''
                              );
                              setState(() {
                                studentsListForNotification.clear();
                              });
                            }
                          },
                          child: Container(child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.send,color:Colors.white),
                              SizedBox(width:width/136.6),
                              Text("Send Remainder",style: GoogleFonts.poppins(color:Colors.white),),
                            ],
                          )),
                            width: width/8.507,
                            height: height/16.425,
                            // color:Color(0xff00A0E3),
                            decoration: BoxDecoration(color: const Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                          ),
                        ),
                        SizedBox(width: width/91.066666667),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height:height/32.55),
        Container(
          height:height/13.14,
          width: width/1.366,
          decoration: BoxDecoration(
              color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(left: width/136.6),
                child: Checkbox(
                    checkColor: Colors.white,
                    value: mainconcent,
                    onChanged: (value){
                      if(value!){
                        setState(() {
                          mainconcent = value;
                          for(int i=0;i<students.length;i++) {
                            studentsListForNotification.add(students[i].get("stRegNo"));
                          }
                        });
                      }else{
                        setState(() {
                          mainconcent = value;
                          for(int i=0;i<students.length;i++) {
                            studentsListForNotification.clear();
                          }
                        });
                      }
                    }
                ),
              ),
              Container(
                width:width/10.507692308,
                child: Text('Student Name',style: GoogleFonts.montserrat(
                    fontWeight:FontWeight.bold,color: Colors.white,fontSize:width/81.13
                ),),
              ),
              Container(
                width:width/10.507692308,
                child: Text('Fees Name',style: GoogleFonts.montserrat(
                    fontWeight:FontWeight.bold,color: Colors.white,fontSize:width/81.13
                ),),
              ),
              Container(
                width:width/10.507692308,
                child: Text('Amount',style: GoogleFonts.montserrat(
                    fontWeight:FontWeight.bold,color: Colors.white,fontSize:width/81.13
                ),),
              ),
              Container(
                width:width/10.507692308,
                child: Text('Status',style: GoogleFonts.montserrat(
                    fontWeight:FontWeight.bold,color: Colors.white,fontSize:width/81.13
                ),),
              ),
              Container(
                width:width/10.507692308,
                child: Text('Date',style: GoogleFonts.montserrat(
                    fontWeight:FontWeight.bold,color: Colors.white,fontSize:width/81.13
                ),),
              ),
              Container(
                width:width/10.507692308,
                  child: Text('Time',style: GoogleFonts.montserrat(
                    fontWeight:FontWeight.bold,color: Colors.white,fontSize:width/81.13
                ),),
              ),
            ],
          ),
        ),
        Container(
          height: height/2.1,
          width: width/1.366,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('FeesCollection').orderBy("stRegNo",).snapshots(),
            builder: (ctx,snap){
              if(snap.hasData){
                students.clear();
                List<DocumentSnapshot> filterList1 = [];
                List<DocumentSnapshot> filterList2 = [];
                if(_typeAheadControllerfees.text != "Select Option"){
                  snap.data!.docs.forEach((element) {
                    if(element.get("timestamp") < DateFormat("dd/MM/yyyy").parse(pos1.text).add(const Duration(days: 1)).millisecondsSinceEpoch && element.get("timestamp") >= DateFormat("dd/MM/yyyy").parse(pos2.text).millisecondsSinceEpoch){
                        if(_typeAheadControllerfees.text.toLowerCase() == "all fees"){
                          filterList1.add(element);
                        }else if(element.get("feesname").toString().toLowerCase() == _typeAheadControllerfees.text.toLowerCase()){
                          filterList1.add(element);
                        }
                    }
                  });
                }
                else{
                  snap.data!.docs.forEach((element) {
                    if(element.get("timestamp") < DateFormat("dd/MM/yyyy").parse(pos1.text).add(const Duration(days: 1)).millisecondsSinceEpoch && element.get("timestamp") >= DateFormat("dd/MM/yyyy").parse(pos2.text).millisecondsSinceEpoch){
                      filterList1.add(element);
                    }
                  });
                }
                filterList1.forEach((element) {
                  if(type.text.toLowerCase() == 'school'){
                    filterList2.add(element);
                  }
                  else if(type.text.toLowerCase() == 'class'){
                    if(element.get("class") == _typeAheadControllerclass.text){
                      filterList2.add(element);
                    }
                  }
                  else if(type.text.toLowerCase() == 'section'){
                    if(element.get("class") == _typeAheadControllerclass.text && element.get("section") == _typeAheadControllersection.text){
                      filterList2.add(element);
                    }
                  }
                  else if(type.text.toLowerCase() == 'student'){
                    if(element.get("stRegNo") == _typeAheadControllerregno.text || element.get("stName").toString().toLowerCase() == _typeAheadControllerstudent.text.toLowerCase()){
                      filterList2.add(element);
                    }
                  }
                  else{
                    filterList2.add(element);
                  }
                });
                filterList2.forEach((element) {
                  //over due
                  if(married){
                    if(element.get("status") == false && differenceDatefunction(element.get('duedate')) < 0){
                      students.add(element);
                    }
                  }
                  // paid
                  if(married2){
                    if(element.get('status')==true){
                      students.add(element);
                    }
                  }
                  // pending
                  if(single){
                    if(element.get("status") == false && differenceDatefunction(element.get('duedate')) >= 0){
                      students.add(element);
                    }
                  }
                  if(!married && !single && !married2){
                    students.add(element);
                  }
                });
                return ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (ctx,i){
                    var data = students[i];
                    return Container(
                      height: height/9.3,
                      width: width/1.366,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: width/17.075,
                            child: Checkbox(
                              value: studentsListForNotification.contains(data.get("stRegNo")),
                              onChanged: (val){
                                if(!studentsListForNotification.contains(data.get("stRegNo"))){
                                  setState(() {
                                    studentsListForNotification.add(data.get("stRegNo"));
                                  });
                                }else{
                                  setState(() {
                                    studentsListForNotification.remove(data.get("stRegNo"));
                                  });
                                }
                              },
                            ),
                          ),
                          Container(
                            width: width/9.106666667,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.get("stName"),
                                  style: GoogleFonts.montserrat(
                                      fontWeight:FontWeight.bold,
                                      fontSize: width/97.571428571,
                                  ),
                                ),
                                Text(
                                  data.get("stRegNo"),
                                  style: GoogleFonts.montserrat(
                                    color: Colors.grey,
                                    fontWeight:FontWeight.normal,
                                    fontSize: width/113.833333333,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: width/8.5375,
                            child: Text(
                              data.get("feesname"),
                              style: GoogleFonts.montserrat(
                                fontWeight:FontWeight.normal,
                                  fontSize: width/97.571428571
                            ),),
                          ),
                          Container(
                            width: width/9.106666667,
                            child: Text(
                              data.get("amount").toString(),
                              style: GoogleFonts.montserrat(
                                fontWeight:FontWeight.normal,fontSize:width/81.13
                            ),),
                          ),
                          Container(
                            width: width/9.106666667,
                            child: Text(
                              data.get("status") == true ? 'Paid' : (differenceDatefunction(data.get('duedate')) < 0) ? 'Over Due'   : 'Pending',
                              style: GoogleFonts.montserrat(
                                fontWeight:FontWeight.normal,
                                  color: data.get("status") == true ? Colors.green : (differenceDatefunction(data.get('duedate')) < 0) ? Colors.red :  Colors.black,
                                  fontSize:width/81.13
                            ),),
                          ),
                          Container(
                            width: width/8.5375,
                            child: Text(
                              data.get("date")==""?"-":data.get("date"),
                              style: GoogleFonts.montserrat(
                                fontWeight:FontWeight.normal,fontSize:width/81.13
                            ),
                            ),
                          ),
                          Container(
                            width: width/10.507692308,
                            child: Text(
                              data.get("time")==""?"-":data.get("time"),
                              style: GoogleFonts.montserrat(
                                fontWeight:FontWeight.normal,fontSize:width/81.13
                            ),),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        )

      ],
    );
  }
  String schoolname="";
  String schooladdress="";
  String schoollogo="";
  String idcarddesign="";
  String solgan="";
  String imgurl="";
  getadmin() async {
    var document = await FirebaseFirestore.instance.collection("Admin").get();
    setState(() {
      schoolname=document.docs[0]["schoolname"];
      schooladdress=
      "${document.docs[0]["area"]} ${document.docs[0]["city"]} ${document.docs[0]["pincode"]}";
      schoollogo=document.docs[0]["logo"];
      idcarddesign=document.docs[0]["idcard"].toString();
      solgan=document.docs[0]["solgan"];
      imgurl=document.docs[0]["logo"];
    });
  }
  sendNotificationsToStudents(){
    String subjectForPending = 'Gentle remainder for fee';
    String subjectForOverDue = 'Outstanding School Fees Notice';
    List<DocumentSnapshot> snaps = [];
    studentsListForNotification.forEach((element) {
      students.forEach((student) { 
        if(student.get("stRegNo") == element){
          snaps.add(student);
        }
      });
    });
    snaps.forEach((element) {
      if(element.get("email") != null){
        print(element.get("email"));
        sendEmail(
          element.get("email"),
          (differenceDatefunction(element.get('duedate')) < 0) ? subjectForOverDue : subjectForPending,
          (differenceDatefunction(element.get('duedate')) > 0)
              ? 'Secure your child"s bright academic journey! Just a friendly reminder that the school fee payment is due soon. Your timely action is greatly appreciated. Thank you for your ongoing support'
              : ''' Dear Parent,

I hope this email finds you well. We appreciate your ongoing support in providing a conducive learning environment for your child at ${schoolname}. We would like to bring to your attention that there is an outstanding balance of ${element.get("amount")} for your child's school fees.

It is crucial to maintain up-to-date payments to ensure the seamless continuation of educational services. We kindly request you to settle the overdue amount at your earliest convenience.

Here are the details for the pending payment:

Student Name: ${element.get('stName')}
Student Id: ${element.get('stRegNo')}
Due Amount: ${element.get('amount')}
Due Date: ${element.get('duedate')}

You can make the payment through online or offline. If you have already made the payment, please accept our apologies for any inconvenience and provide the transaction details for verification.

Your prompt attention to this matter is greatly appreciated. If you have any questions or concerns regarding the payment, feel free to contact our finance department at School Admin.

Thank you for your cooperation.

Best regards,
${schoolname},
              ''',
        );
      }
    });
    Successdialog();
  }

  Successdialog(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555556,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Email Sent Sucessfully',
      desc: '',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {


      },
    )..show();
  }

  sendEmail(String to, String subject, String description) async {
    DocumentReference documentReferencer = FirebaseFirestore.instance.collection('mail').doc();
    var json = {
      "to": to,
      "message": {
        "subject": subject,
        "text": description,
      },
    };
    var result = await documentReferencer.set(json).whenComplete(() {
      //Successdialog();
    }).catchError((e) {

    });
  }

  differenceDatefunction(date1) {
    if(date1!="") {
      int diffrencedays = DateFormat('dd/MM/yyyy')
          .parse(date1)
          .difference(DateTime.now())
          .inDays;
      return diffrencedays;
    }
    return 0;
  }

  Future<FeesDetailsModel> getFeesDetails() async {

    List<StudentFeesModel> paidStudentsList = [];
    List<StudentFeesModel> pendingStudentsList = [];
    List<StudentFeesModel> overDuestudentsList = [];

    var studentDocument = await FirebaseFirestore.instance.collection('Students').get();
    studentDocument.docs.forEach((student) async {
      var studentFeesDocument = await FirebaseFirestore.instance.collection('Students').doc(student.id).collection('Fees').orderBy("timestamp",descending: true).get();
      studentFeesDocument.docs.forEach((fees) {
        if(fees.get("status") == true){
          paidStudentsList.add(
                StudentFeesModel(
                    studentName: student.get("stname"),
                    amount: double.parse(fees.get("amount").toString()),
                    feesName: fees.get("feesname"),
                    date: fees.get("date"),
                    time: fees.get("time"),
                    status: fees.get("status")
                )
            );
        }
        else if(fees.get("status") == false &&
            (DateFormat('dd/MM/yyyy').parse(fees.get('duedate')!=""?fees.get('duedate'):pos1.text).difference(DateTime.now()).inDays + 1 <= 0)){
          overDuestudentsList.add(
              StudentFeesModel(
                  studentName: student.get("stname"),
                  amount: double.parse(fees.get("amount").toString()),
                  feesName: fees.get("feesname"),
                  date: fees.get("date"),
                  time: fees.get("time"),
                  status: fees.get("status")
              )
          );
        }
        else{
          pendingStudentsList.add(
              StudentFeesModel(
                  studentName: student.get("stname"),
                  amount: double.parse(fees.get("amount").toString()),
                  feesName: fees.get("feesname"),
                  date: fees.get("date"),
                  time: fees.get("time"),
                  status: fees.get("status")
              )
          );
        }
      });
    });
    await Future.delayed(Duration(seconds: 3));
    FeesDetailsModel feesDetails = FeesDetailsModel(
      overDueStudents: overDuestudentsList,
      paidStudents: paidStudentsList,
      pendingStudents: pendingStudentsList
    );

    print(paidStudentsList.length.toString() + "000000000000000000000000000000000");
    print(pendingStudentsList.length.toString() + "000000000000000000000000000000000");
    print(overDuestudentsList.length.toString() + "000000000000000000000000000000000");
    return feesDetails;
  }


  sendMail(){

  }

}

class FeesDetailsModel{
  FeesDetailsModel({required this.overDueStudents, required this.paidStudents, required this.pendingStudents});
  List<StudentFeesModel> paidStudents = [];
  List<StudentFeesModel> pendingStudents = [];
  List<StudentFeesModel> overDueStudents = [];
}

class StudentFeesModel {
  StudentFeesModel({
    required this.studentName,
    required this.amount,
    required this.feesName,
    required this.date,
    required this.time,
    required this.status,
  });
  String studentName;
  double amount;
  String feesName;
  String date;
  String time;
  bool status;
}

class StudentListForNotification{
  StudentListForNotification({required this.selected,required this.student});
  bool selected;
  DocumentSnapshot student;
}