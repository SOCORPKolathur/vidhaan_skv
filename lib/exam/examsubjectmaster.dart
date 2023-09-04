import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:lottie/lottie.dart';


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
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Subject Added Successfully',
      desc: 'Subject - ${name.text} is been added',

      btnCancelOnPress: () {

      },
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
  String classid="";
  String feesid="";
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


  addsubject(subname) async {

      FirebaseFirestore.instance.collection("ExamMaster").doc(feesid).collection(_typeAheadControllerclass.text).doc()
          .set({
        "name": subname,
        "exam": _typeAheadControllerexam.text,
        "class": _typeAheadControllerclass.text,
        "timestamp": DateTime.now().microsecondsSinceEpoch,
        "date":""
      });

  }
  @override
  void initState() {
    getorderno();
    firstcall();
    adddropvalue();
    // TODO: implement initState
    super.initState();
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
    }
    print("fdgggggggggg");


  }

  Errordialog(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Field cannot be empty',


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
            padding: const EdgeInsets.only(left: 5.0),
            child: Container(child: Padding(
              padding: const EdgeInsets.only(left: 38.0,top: 30),
              child: Text("Exam Subjects Masters",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
            ),
              //color: Colors.white,
              width: width/1.050,
              height: height/8.212,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0.0,right:0,top: 20),
            child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: width/1.050,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0,top: 0),
                        child: Container(
                          width: width/2.609,

                          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                          child:  SingleChildScrollView(
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
                                            child: Text("Si.No",style: GoogleFonts.poppins(fontSize: 15,)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0.0,right: 10),
                                            child: Container(
                                              child: TextField(
                                                readOnly: true,
                                                controller: orderno,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15
                                                ),
                                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                              width: width/7.902,
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
                                            child: Text("Subject",style: GoogleFonts.poppins(fontSize: 15,)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0.0,right: 10),
                                            child: Container(child: TextField(
                                              controller: name,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15
                                              ),
                                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                              width: width/7.902,
                                              height: height/16.425,
                                              //color: Color(0xffDDDEEE),
                                              decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

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
                                        child: Container(child: Center(child: Text("Save",style: GoogleFonts.poppins(color:Colors.white),)),
                                          width: width/9.307,
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
                                    width: width/ 1.241,

                                    decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 20.0),
                                          child: Text("Si.no",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                          child: Text("Subject",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                        ),
                                      ],
                                    ),

                                  ),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("SubjectMaster").orderBy("order").snapshots(),

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
                                            return  Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(

                                                width: width/ 1.241,

                                                decoration: BoxDecoration(color:Colors.white60,borderRadius: BorderRadius.circular(12)

                                                ),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 30.0,right: 70.0),
                                                      child: Text("00${(index+1).toString()}",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                                    ),
                                                    Padding(

                                                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                      child: Container(
                                                          width: 100,
                                                          child: Text(value["name"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),)),
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        addsubject(value["name"]);

                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                        child: Container(

                                                          width: 40,
                                                          height: 20,
                                                          decoration: BoxDecoration(
                                                              color:Color(0xff00A0E3),
                                                              borderRadius: BorderRadius.circular(5)
                                                          ),
                                                          child: Center(
                                                            child: Icon(Icons.add_circle,color: Colors.white,size: 15,),
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    InkWell(
                                                      onTap: (){
                                                        deletestudent2(value.id);
                                                      },
                                                      child: Padding(
                                                          padding:
                                                          const EdgeInsets.only(left: 100.0),
                                                          child: Container(
                                                              width: 30,

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

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,top: 0),
                        child: Container(
                          width:width/2.550,

                          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                          child:  SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0,top:20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Text("Exam",style: GoogleFonts.poppins(fontSize: 15,)),
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
                                                items: exams
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
                                                value:  _typeAheadControllerexam.text,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    _typeAheadControllerexam.text = value!;
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


                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: height/13.14,
                                    width: width/ 1.241,

                                    decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                          child: Text("Si.No",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 28.0,right: 8.0),
                                          child: Text("Subjects",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                        ),
                                      ],
                                    ),

                                  ),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("ExamMaster").doc(feesid).collection(_typeAheadControllerclass.text).orderBy("timestamp").snapshots(),

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
                                            return  Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: height/ 21.9,
                                                width: width/ 1.241,

                                                decoration: BoxDecoration(color:Colors.white60,borderRadius: BorderRadius.circular(12)

                                                ),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 30.0,right: 70.0),
                                                      child: Text("${(index+1).toString()}",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                      child: Container(
                                                          width: 150,

                                                          child: Text(value["name"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),)),
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        deletestudent1(value.id);
                                                      },
                                                      child: Padding(
                                                          padding:
                                                          const EdgeInsets.only(left: 100.0),
                                                          child: Container(
                                                              width: 30,

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

                        ),
                      ),
                    ],
                  ),
                )),
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
