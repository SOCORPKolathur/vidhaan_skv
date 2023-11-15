import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:lottie/lottie.dart';
import 'package:random_string/random_string.dart';


class ExamsubjectMaster extends StatefulWidget {
  const ExamsubjectMaster({Key? key}) : super(key: key);

  @override
  State<ExamsubjectMaster> createState() => _ExamsubjectMasterState();
}

class _ExamsubjectMasterState extends State<ExamsubjectMaster> {

  TextEditingController name = new TextEditingController();
  TextEditingController name2 = new TextEditingController();
  TextEditingController name3 = new TextEditingController();
  TextEditingController orderno = new TextEditingController();
  TextEditingController orderno2 = new TextEditingController();
  TextEditingController orderno3 = new TextEditingController();

  final TextEditingController _typeAheadControllerclass = TextEditingController();
  final TextEditingController _typeAheadControllerexam = TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();

  static final List<String> classes = [];
  static final List<String> exams = [];

  static List<String> getSuggestionsclass(String query) {
    List<String> matches = <String>[];
    matches.addAll(classes);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  String classid="";
  String feesid="";
  String docid ="";

  getorderno() async {
    var document = await  FirebaseFirestore.instance.collection("SubjectMaster").get();
    setState(() {
      orderno.text="00${document.docs.length+1}";
    });
    var document2 = await  FirebaseFirestore.instance.collection("SectionMaster").get();
    setState(() {
      orderno2.text="00${document2.docs.length+1}";
    });
    var document3 = await  FirebaseFirestore.instance.collection("AcademicMaster").get();
    setState(() {
      orderno3.text="00${document3.docs.length+1}";
    });
  }

  addclass(){
    FirebaseFirestore.instance.collection("SubjectMaster").doc().set({
      "name": name.text,
      "order": int.parse(orderno.text),
    });
  }

  Successdialog(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555556,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Subject Added Successfully',
      desc: 'Subject - ${name.text} is been added',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        name.clear();
        orderno.clear();
        getorderno();
      },
    )..show();
  }

  adddropvalue() async {
    setState(() {
      classes.clear();
    });
    var document3 = await  FirebaseFirestore.instance.collection("ClassMaster").orderBy("order").get();
    var document2 = await  FirebaseFirestore.instance.collection("ExamMaster").orderBy("order").get();
    setState(() {
      classes.add("Select Option");
      exams.add("Select Option");
    });
    for(int i=0;i<document3.docs.length;i++) {
      setState(() {
        classes.add(document3.docs[i]["name"]);
      });
    }
    for(int i=0;i<document2.docs.length;i++) {
      setState(() {
        exams.add(document2.docs[i]["name"]);
      });
    }
  }

  firstcall() async {
    var document3 = await  FirebaseFirestore.instance.collection("ClassMaster").orderBy("order").get();
    var document2 = await  FirebaseFirestore.instance.collection("ExamMaster").orderBy("order").get();
    setState(() {
      _typeAheadControllerclass.text=document3.docs[0]["name"];
      _typeAheadControllerexam.text=document2.docs[0]["name"];
      classid=document3.docs[0].id;
      feesid=document2.docs[0].id;
    });

  }

  getfeesid(val) async {
    var document2 = await  FirebaseFirestore.instance.collection("ExamMaster").get();
    for(int i=0;i<document2.docs.length;i++){
      if(document2.docs[i]["name"]==val){
        setState(() {
          feesid = document2.docs[i].id;
        });
      }
    }


  }

  addsubject(subname) async {
    setState(() {
      docid=randomAlphaNumeric(16);
    });

      FirebaseFirestore.instance.collection("ExamMaster").doc(feesid).collection(_typeAheadControllerclass.text).doc(docid)
          .set({
        "name": subname,
        "exam": _typeAheadControllerexam.text,
        "class": _typeAheadControllerclass.text,
        "timestamp": DateTime.now().microsecondsSinceEpoch,
        "date":"",
        "timestamp2": ""
          });

      var docu = await FirebaseFirestore.instance.collection("Students").orderBy("regno").get();
      for(int i=0;i<docu.docs.length;i++){
        if(docu.docs[i]["admitclass"]==_typeAheadControllerclass.text){
          FirebaseFirestore.instance.collection("Students").doc(docu.docs[i].id).collection("Exams").doc(feesid).set({
            "name":_typeAheadControllerexam.text
          });
          FirebaseFirestore.instance.collection("Students").doc(docu.docs[i].id).collection("Exams").doc(feesid).collection("Timetable").doc(docid)
              .set({
            "name": subname,
            "exam": _typeAheadControllerexam.text,
            "class": _typeAheadControllerclass.text,
            "timestamp": DateTime.now().microsecondsSinceEpoch,
            "date":"",
            "timestamp2": "",
            "mark":"",
            "total":"",
            "percentage":""
              });
        }
      }
  }

  getstaffbyid() async {
    var document = await FirebaseFirestore.instance.collection("ClassMaster").get();
    for(int i=0;i<document.docs.length;i++){
      if(_typeAheadControllerclass.text==document.docs[i]["name"]){
        setState(() {
          classid= document.docs[i].id;
        }
        );
      }
    }
  }

  Errordialog(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555556,
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Field cannot be empty',
      btnOkOnPress: () {},
    )..show();
  }

  @override
  void initState() {
    getorderno();
    firstcall();
    adddropvalue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(left: width/273.2),
            child: Container(
              width: width/1.050,
              height: height/8.212,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width/113.833333333),
              ),
              child: Padding(
                padding:  EdgeInsets.only(left: width/35.947368421,top: height/21.7),
                child: Text(
                  "Exam Subjects Masters",
                  style: GoogleFonts.poppins(
                      fontSize: width/75.888888889,
                      fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 0.0,right:0,top: height/32.55),
            child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(width/113.833333333),
                child: Container(
                  width: width/1.050,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width/113.833333333),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0,top: 0),
                        child: Container(
                          width: width/2.609,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width/113.833333333),
                          ),
                          child:  SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: width/136.6,top: height/32.55),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Text(
                                                "Si.No",
                                                style: GoogleFonts.poppins(
                                                  fontSize: width/91.066666667,
                                                ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 0.0,right: width/136.6),
                                            child: Container(
                                              width: width/7.902,
                                              height: height/16.425,
                                              decoration: BoxDecoration(
                                                  color: const Color(0xffDDDEEE),
                                                  borderRadius: BorderRadius.circular(width/273.2),
                                              ),
                                              child: TextField(
                                                readOnly: true,
                                                controller: orderno,
                                                style: GoogleFonts.poppins(
                                                    fontSize: width/91.066666667
                                                ),
                                                decoration:  InputDecoration(
                                                  contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/81.375),
                                                  border: InputBorder.none,
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
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Text(
                                                "Subject",
                                                style: GoogleFonts.poppins(
                                                  fontSize: width/91.066666667,
                                                ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 0.0,right: width/136.6),
                                            child: Container(
                                              width: width/7.902,
                                              height: height/16.425,
                                              decoration: BoxDecoration(
                                                  color: const Color(0xffDDDEEE),
                                                  borderRadius: BorderRadius.circular(width/273.2),
                                              ),
                                              child: TextField(
                                              controller: name,
                                              style: GoogleFonts.poppins(
                                                  fontSize: width/91.066666667
                                              ),
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/81.375),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          if(name.text!="") {
                                            addclass();
                                            Successdialog();
                                          }
                                          else{
                                            Errordialog();
                                          }
                                        },
                                        child: Container(
                                          width: width/9.307,
                                          height: height/16.425,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff00A0E3),
                                              borderRadius: BorderRadius.circular(width/273.2),
                                          ),
                                          child: Center(
                                              child: Text(
                                                "Save",
                                                style: GoogleFonts.poppins(
                                                    color:Colors.white,
                                                ),
                                              ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width/170.75, vertical: height/81.375),
                                  child: Container(
                                    height: height/13.14,
                                    width: width/ 1.241,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff00A0E3),
                                        borderRadius: BorderRadius.circular(width/113.833333333),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: width/170.75,right: width/68.3),
                                          child: Text(
                                            "Si.no",
                                            style: GoogleFonts.poppins(
                                                fontSize: width/85.375,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: width/170.75,right: width/170.75),
                                          child: Text(
                                            "Subject",
                                            style: GoogleFonts.poppins(
                                                fontSize: width/85.375,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("SubjectMaster").orderBy("order").snapshots(),
                                    builder: (context,snapshot){
                                      if(!snapshot.hasData) {
                                        return   Center(
                                          child:  CircularProgressIndicator(),
                                        );
                                      }
                                      if(snapshot.hasData==null) {
                                        return   Center(
                                          child:  CircularProgressIndicator(),
                                        );
                                      }
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context,index){
                                            var value = snapshot.data!.docs[index];
                                            return  Padding(
                                              padding: EdgeInsets.symmetric(horizontal: width/170.75, vertical: height/81.375),
                                              child: Container(
                                                width: width/ 1.241,
                                                decoration: BoxDecoration(
                                                    color:Colors.white60,
                                                    borderRadius: BorderRadius.circular(width/113.833333333),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width/45.533333333,right: width/19.514285714),
                                                      child: Text(
                                                        "00${(index+1).toString()}",
                                                        style: GoogleFonts.poppins(
                                                            fontSize: width/91.066666667,
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width/170.75,right: width/170.75),
                                                      child: SizedBox(
                                                          width: width/13.66,
                                                          child: Text(
                                                            value["name"],
                                                            style: GoogleFonts.poppins(
                                                                fontSize: width/91.066666667,
                                                                fontWeight: FontWeight.w600,
                                                                color: Colors.black,
                                                            ),
                                                          ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        addsubject(value["name"]);
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets.only(left: width/170.75,right: width/170.75),
                                                        child: Container(
                                                          width: width/34.15,
                                                          height: height/32.55,
                                                          decoration: BoxDecoration(
                                                              color: const Color(0xff00A0E3),
                                                              borderRadius: BorderRadius.circular(width/273.2)
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.add_circle,
                                                              color: Colors.white,
                                                              size: width/91.066666667,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        deletestudent2(value.id);
                                                      },
                                                      child: Padding(
                                                          padding:  EdgeInsets.only(left: width/13.66),
                                                          child: SizedBox(
                                                              width: width/45.533333333,
                                                              child: Image.asset("assets/delete.png"),
                                                          )
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width/68.3,top: 0),
                        child: Container(
                          width:width/2.550,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width/113.833333333),
                          ),
                          child:  SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: width/136.6,top: height/32.55),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Text(
                                                "Exam",
                                                style: GoogleFonts.poppins(
                                                  fontSize: width/91.066666667,
                                                ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 0.0,right: width/54.64),
                                            child: Container(
                                              width: width/6.902,
                                              height: height/16.42,
                                              //color: Color(0xffDDDEEE),
                                              decoration: BoxDecoration(
                                                  color: const Color(0xffDDDEEE),
                                                  borderRadius: BorderRadius.circular(width/273.2),
                                              ),
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButton2<String>(
                                                  isExpanded: true,
                                                  hint:  Row(
                                                    children: [
                                                      Icon(
                                                      Icons.list,
                                                      size: width/85.375,
                                                      color: Colors.black,
                                                    ),
                                                      SizedBox(width: width/341.5),
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
                                                  items: exams.map((String item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style:  GoogleFonts.poppins(
                                                              fontSize: width/91.066666667
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                  ).toList(),
                                                  value:  _typeAheadControllerexam.text,
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      _typeAheadControllerexam.text = value!;
                                                    });
                                                    getfeesid(value);
                                                    },
                                                  buttonStyleData: ButtonStyleData(
                                                  height: height/13.02,
                                                  width: width/8.5375,
                                                  padding: EdgeInsets.only(left: width/97.571428571, right: width/97.571428571),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(width/273.2),
                                                    color: const Color(0xffDDDEEE),
                                                  ),
                                                ),
                                                  iconStyleData:  IconStyleData(
                                                  icon: const Icon(Icons.arrow_forward_ios_outlined),
                                                  iconSize: width/97.571428571,
                                                  iconEnabledColor: Colors.black,
                                                  iconDisabledColor: Colors.grey,
                                                ),
                                                  dropdownStyleData: DropdownStyleData(
                                                  maxHeight: height/3.255,
                                                  width: width/5.464,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(width/97.571428571),
                                                    color: const Color(0xffDDDEEE),
                                                  ),
                                                  scrollbarTheme: ScrollbarThemeData(
                                                    radius: Radius.circular(width/195.142857143),
                                                    thickness: MaterialStateProperty.all<double>(6),
                                                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                                                  ),
                                                  ),
                                                  menuItemStyleData: MenuItemStyleData(
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
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Text(
                                                "Class",
                                                style: GoogleFonts.poppins(
                                                  fontSize: width/91.066666667,
                                                ),
                                            ),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.only(left: 0.0,right: width/54.64),
                                            child: Container(
                                              width: width/6.902,
                                              height: height/16.42,
                                              decoration: BoxDecoration(
                                                  color: const Color(0xffDDDEEE),
                                                  borderRadius: BorderRadius.circular(width/273.2),
                                              ),
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButton2<String>(
                                                  isExpanded: true,
                                                  hint:  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.list,
                                                        size: width/85.375,
                                                        color: Colors.black,
                                                    ),
                                                      SizedBox(width: width/341.5),
                                                      Expanded(
                                                        child: Text(
                                                          'Select Option',
                                                          style: GoogleFonts.poppins(
                                                              fontSize: width/91.066666667,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    ],
                                                  ),
                                                  items: classes.map((String item) => DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style:  GoogleFonts.poppins(
                                                          fontSize: width/91.066666667
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),).toList(),
                                                  value:  _typeAheadControllerclass.text,
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      _typeAheadControllerclass.text = value!;
                                                    });
                                                    },
                                                  buttonStyleData: ButtonStyleData(
                                                    height: height/13.02,
                                                    width: width/8.5375,
                                                    padding: EdgeInsets.only(left: width/97.571428571, right: width/97.571428571),
                                                    decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(width/273.2),
                                                    color: const Color(0xffDDDEEE),
                                                  ),
                                                  ),
                                                  iconStyleData: IconStyleData(
                                                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                                                    iconSize: width/97.571428571,
                                                    iconEnabledColor: Colors.black,
                                                    iconDisabledColor: Colors.grey,
                                                  ),
                                                dropdownStyleData: DropdownStyleData(
                                                  maxHeight: height/3.255,
                                                  width: width/5.464,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(width/97.571428571),
                                                    color: const Color(0xffDDDEEE),
                                                  ),
                                                  scrollbarTheme: ScrollbarThemeData(
                                                    radius: Radius.circular(width/195.142857143),
                                                    thickness: MaterialStateProperty.all<double>(6),
                                                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                                                  ),
                                                ),
                                                menuItemStyleData: MenuItemStyleData(
                                                  height: height/16.275,
                                                  padding: EdgeInsets.only(left: width/97.571428571, right: width/97.571428571),
                                                ),
                                              ),
                                            ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width/170.75, vertical: height/81.375),
                                  child: Container(
                                    height: height/13.14,
                                    width: width/ 1.241,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff00A0E3),
                                        borderRadius: BorderRadius.circular(width/113.833333333),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: width/170.75,right: width/170.75),
                                          child: Text(
                                            "Si.No",
                                            style: GoogleFonts.poppins(
                                                fontSize: width/85.375,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: width/48.785714286,right: width/170.75),
                                          child: Text(
                                            "Subjects",
                                            style: GoogleFonts.poppins(
                                                fontSize: width/85.375,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("ExamMaster").doc(feesid).collection(_typeAheadControllerclass.text).orderBy("timestamp").snapshots(),
                                    builder: (context,snapshot){
                                      if(!snapshot.hasData) {
                                        return   Center(
                                          child:  CircularProgressIndicator(),
                                        );
                                      }
                                      if(snapshot.hasData==null) {
                                        return   Center(
                                          child:  CircularProgressIndicator(),
                                        );
                                      }
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context,index){
                                            var value = snapshot.data!.docs[index];
                                            return  Padding(
                                              padding: EdgeInsets.symmetric(horizontal: width/170.75, vertical: height/81.375),
                                              child: Container(
                                                height: height/ 21.9,
                                                width: width/ 1.241,
                                                decoration: BoxDecoration(
                                                    color:Colors.white60,
                                                    borderRadius: BorderRadius.circular(width/113.833333333)
                                                ),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width/45.533333333,right: width/19.514285714),
                                                      child: Text(
                                                        "${(index+1).toString()}",
                                                        style: GoogleFonts.poppins(
                                                            fontSize: width/91.066666667,
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width/170.75,right: width/170.75),
                                                      child: SizedBox(
                                                          width: width/9.106666667,
                                                          child: Text(
                                                            value["name"],
                                                            style: GoogleFonts.poppins(
                                                                fontSize: width/91.066666667,
                                                                fontWeight: FontWeight.w600,
                                                                color: Colors.black,
                                                            ),
                                                          ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        deletestudent1(value.id);
                                                      },
                                                      child: Padding(
                                                          padding: EdgeInsets.only(left: width/13.66),
                                                          child: SizedBox(
                                                              width: width/45.533333333,
                                                              child: Image.asset("assets/delete.png"),
                                                          )
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> deletestudent1(id) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        double width=MediaQuery.of(context).size.width;
        double height=MediaQuery.of(context).size.height;
        return StatefulBuilder(
            builder: (context,setState) {
              return AlertDialog(
                title:  Text('Are you Sure of Deleting',style: GoogleFonts.poppins(
                    color: Colors.black, fontSize:18,fontWeight: FontWeight.w600),),
                content:  Container(
                    width: 350,
                    height: 250,

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
                    onTap: () async {

                        FirebaseFirestore.instance.collection("ExamMaster").doc(feesid).collection(_typeAheadControllerclass.text)
                            .doc(id)
                            .delete();

              var docu = await FirebaseFirestore.instance.collection("Students").orderBy("regno").get();
              for(int i=0;i<docu.docs.length;i++){
                FirebaseFirestore.instance.collection("Students").doc(docu.docs[i].id).collection("Exams").doc(feesid).collection("Timetable").doc(id)
                    .delete();
              }
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
  Future<void> deletestudent2(id) async {
    return showDialog<void>(
      context: context,

      builder: (BuildContext context) {

        double width=MediaQuery.of(context).size.width;
        double height=MediaQuery.of(context).size.height;
        return StatefulBuilder(
            builder: (context,setState) {
              return AlertDialog(
                title:  Text('Are you Sure of Deleting',style: GoogleFonts.poppins(
                    color: Colors.black, fontSize:18,fontWeight: FontWeight.w600),),
                content:  Container(
                    width: 350,
                    height: 250,

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
                      FirebaseFirestore.instance.collection("SubjectMaster").doc(id).delete();
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
