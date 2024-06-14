import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ClassIncharge extends StatefulWidget {
  const ClassIncharge({Key? key}) : super(key: key);

  @override
  State<ClassIncharge> createState() => _ClassInchargeState();
}

class _ClassInchargeState extends State<ClassIncharge> {
  String? _selectedCity;
  final TextEditingController _typeAheadControllerclass = TextEditingController();
  final TextEditingController _typeAheadControllersection = TextEditingController();
  final TextEditingController _typeAheadControllerstaffid = TextEditingController();
  final TextEditingController _typeAheadControllerstaffname = TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  static final List<String> classes = [];
  static final List<String> section = [];
  static final List<String> staffid = [];
  static final List<String> staffnamelist = [];
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
  @override
  void initState() {
    adddropdownvalue();
    setState(() {
      _typeAheadControllerclass.text="Select Option";
      _typeAheadControllersection.text="Select Option";
    });

    // TODO: implement initState
    super.initState();
  }
  adddropdownvalue() async {
    setState(() {
      classes.clear();
      section.clear();
      staffid.clear();
      staffnamelist.clear();
    });
    var document = await  FirebaseFirestore.instance.collection("ClassMaster").orderBy("order").get();
    var document2 = await  FirebaseFirestore.instance.collection("SectionMaster").orderBy("order").get();
    var document3 = await  FirebaseFirestore.instance.collection("Staffs").orderBy("timestamp").get();
    setState(() {
      classes.add("Select Option");
      section.add("Select Option");
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
        staffid.add(document3.docs[i]["regno"]);
        staffnamelist.add(document3.docs[i]["stname"]);
      });

    }
  }

  String staffdocid="";
  String staffname="";
  getstaffbyid() async {
    print("fdgggggggggg");
   print(_typeAheadControllerstaffid.text);
    var document = await FirebaseFirestore.instance.collection("Staffs").get();
    for(int i=0;i<document.docs.length;i++){
      if(_typeAheadControllerstaffid.text==document.docs[i]["regno"] ||  _typeAheadControllerstaffname.text== document.docs[i]["stname"]){
        setState(() {
          staffdocid= document.docs[i].id;
        }
        );
      }
    }
    print("fdgggggggggg");
    print(staffdocid);
    var staffdocument = await FirebaseFirestore.instance.collection("Staffs").doc(staffdocid).get();
    Map<String, dynamic>? value = staffdocument.data();
    setState(() {
      staffname=value!["stname"];
    });
    print("fdgggggggggg");
    print(staffname);

  }

  getstudentbyregno(value) async {
    print("fdgggggggggg");

    var document = await FirebaseFirestore.instance.collection("Staffs").get();
    for(int i=0;i<document.docs.length;i++){
      if(value==document.docs[i]["regno"]){
        setState(() {
          _typeAheadControllerstaffname.text= document.docs[i]["stname"];
          staffdocid= document.docs[i].id;
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
        }
        );
      }
    }
    print("fdgggggggggg");


  }
  Successdialog2(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555555555556,
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Teacher has already assigned for the selected class',


      btnCancelOnPress: () {

      },
      btnCancelText: "Cancel",
      btnOkText: "Ok",
      btnOkOnPress: () {

      },
    )..show();
  }
  already() async {
    var document= await FirebaseFirestore.instance.collection("Incharge").where("class",isEqualTo: _typeAheadControllerclass.text).where("section",isEqualTo: _typeAheadControllersection.text).get();
    if(document.docs.length>0){
      Successdialog2();
    }
    else{
      saveincharge();
      Successdialog();
    }
  }

  saveincharge() async {


    var document = await FirebaseFirestore.instance.collection("Incharge").get();
    var document2 = await FirebaseFirestore.instance.collection("Staffs").get();

    FirebaseFirestore.instance.collection("Incharge").doc().set({
      "class":_typeAheadControllerclass.text,
      "section":_typeAheadControllersection.text,
      "staffid":_typeAheadControllerstaffid.text,
      "staffname": staffname,
      "orderno":document.docs.length+1,
    });
    for(int i=0;i<document2.docs.length;i++){
      if(document2.docs[i]["regno"]==_typeAheadControllerstaffid.text){
        FirebaseFirestore.instance.collection("Staffs").doc(document2.docs[i].id).update({
          "incharge":_typeAheadControllerclass.text,
          "inchargesec":_typeAheadControllersection.text,
        });
      }
    }
    setState(() {
      _typeAheadControllerclass.text="Select Option";
      _typeAheadControllersection.text="Select Option";
      _typeAheadControllerstaffid.text="";
      _typeAheadControllerstaffname.text="";
      staffdocid="";
    });
  }
  Successdialog(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.0355,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'In-charge Staff Added Successfully',
      desc: 'For class - ${_typeAheadControllerclass.text} ${_typeAheadControllersection.text} is been added',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {


      },
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Container(child: Padding(
              padding: const EdgeInsets.only(left: 38.0,top: 30),
              child: Text("Class Teacher/ Incharge",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),),
            ),
              //color: Colors.white,
              width: width/1.050,
              height: height/8.212,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0,top: 20),
            child: Container(
              width: width/1.050,

              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                                        width: width/341.5,
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
                                width: width/6.83,
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
                                        width: width/341.5,
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
                                width: width/6.83,
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
                                      fontSize: 15
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
                                  getstaffbyid();
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
                                  getstaffbyid();
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


                            if(_typeAheadControllerclass.text=="Select Option"||_typeAheadControllersection.text=="Select Option"||_typeAheadControllerstaffid.text==""||_typeAheadControllerstaffname.text==""){
                              Error2();
                            }
                            else {
                              already();
                            }
                          },
                          child: Container(child: Center(child: Text("Save",style: GoogleFonts.poppins(color:Colors.white),)),
                            width: width/10.507,
                            height: height/16.425,
                            // color:Color(0xff00A0E3),
                            decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: height/13.14,
                      width: width/1.241,

                      decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 20.0),
                            child: Text("Class",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0,right: 8.0),
                            child: Text("Section",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 80.0,right: 8.0),
                            child: Text("Staff ID",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 80.0,right: 8.0),
                            child: Text("Staff Name",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                          ),
                        ],
                      ),

                    ),
                  ),

                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("Incharge").orderBy("orderno").snapshots(),

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
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: height/21.9,
                                  width: width/1.241,

                                  decoration: BoxDecoration(color:Colors.white60,borderRadius: BorderRadius.circular(12)

                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0,right: 0.0),
                                        child: Container(
                                            width: width/13.66,

                                            child: Text(value["class"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15.0,right: 8.0),
                                        child: Text(value["section"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 100.0,right: 8.0),
                                        child: Text(value["staffid"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 110.0,right: 8.0),
                                        child: Text(value["staffname"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          deletestudent(value.id);
                                        },
                                        child: Padding(
                                            padding:
                                            const EdgeInsets.only(left: 15.0),
                                            child: Container(
                                                width: width/45.53333333333333,

                                                child: Image.asset("assets/delete.png"))
                                        ),
                                      ),
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
    );
  }
  Error2(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555555555556,
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Field cannot be empty ',


      btnCancelOnPress: () {

      },
      btnCancelText: "Cancel",
      btnOkText: "Ok",
      btnOkOnPress: () {

      },
    )..show();
  }
  Future<void> deletestudent(id) async {
    return showDialog<void>(
      context: context,

      builder: (BuildContext context) {

        double width=MediaQuery.of(context).size.width;
        double height=MediaQuery.of(context).size.height;
        return StatefulBuilder(
            builder: (context,setState) {
              return AlertDialog(
                title:  Text('Are you Sure of Deleting In Charge',style: GoogleFonts.poppins(
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
                      FirebaseFirestore.instance.collection("Incharge").doc(id).delete();
                      Navigator.of(context).pop();
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
}
