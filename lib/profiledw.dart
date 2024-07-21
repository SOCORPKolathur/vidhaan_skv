import 'dart:html';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:vidhaan/Masters/student%20id%20card.dart';
import 'package:vidhaan/profile.dart';
import 'package:vidhaan/timetable/classsubjects.dart';
import 'package:vidhaan/timetable/subjectteacher.dart';

import 'Masters/desigination.dart';
import 'Masters/staffidcard.dart';
import 'classincharge.dart';



class ProfileDarwer extends StatefulWidget {
  const ProfileDarwer({Key? key}) : super(key: key);

  @override
  State<ProfileDarwer> createState() => _ProfileDarwerState();
}

class _ProfileDarwerState extends State<ProfileDarwer>with TickerProviderStateMixin {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();
  int page=1;


  TextEditingController name = new TextEditingController();
  TextEditingController name2 = new TextEditingController();
  TextEditingController name3 = new TextEditingController();
  TextEditingController orderno = new TextEditingController();
  TextEditingController orderno2 = new TextEditingController();
  TextEditingController orderno3 = new TextEditingController();


  TextEditingController schoolname = new TextEditingController();
  TextEditingController schoolphone = new TextEditingController();
  TextEditingController schoolweb = new TextEditingController();
  TextEditingController schooladdress = new TextEditingController();
  TextEditingController schoolbuilding = new TextEditingController();
  TextEditingController schoolstreet = new TextEditingController();
  TextEditingController schoolarea = new TextEditingController();
  TextEditingController schoolcity = new TextEditingController();
  TextEditingController schoolstate = new TextEditingController();
  TextEditingController schoolpincode = new TextEditingController();
  TextEditingController solgan = new TextEditingController();


  final check = List<bool>.generate(1000, (int index) => false, growable: true);

  getorderno() async {
    var document = await  FirebaseFirestore.instance.collection("ClassMaster").get();
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
    FirebaseFirestore.instance.collection("ClassMaster").doc().set({
      "name": name.text,
      "order": int.parse(orderno.text),
    });
  }
  addclass2() async {
    FirebaseFirestore.instance.collection("SectionMaster").doc().set({
      "name": name2.text,
      "order": int.parse(orderno2.text),
    });
    var document = await FirebaseFirestore.instance.collection("ClassMaster").get();
    for(int i=0;i<document.docs.length;i++) {
      FirebaseFirestore.instance.collection("Attendance").doc("${document.docs[i]["name"]}${name2.text}").set({
        "name": "${document.docs[i]["name"]}${name2.text}",
      });
    }
  }
  addclass3(){
    FirebaseFirestore.instance.collection("AcademicMaster").doc().set({
      "name": name3.text,
      "order": int.parse(orderno3.text),
    });
  }

  Successdialog(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555555555556,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Class Added Successfully',
      desc: 'Class - ${name.text} is been added',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {
        name.clear();
        orderno.clear();
        getorderno();

      },
    )..show();
  }
  Successdialogd(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555555555556,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Are you sure of save the Design',
      btnCancelText: "Edit",

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {


      },
    )..show();
  }
  Successdialog2(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555555555556,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Section Added Successfully',
      desc: 'Section - ${name2.text} is been added',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {
        name2.clear();
        orderno2.clear();
        getorderno();

      },
    )..show();
  }
  Successdialog3(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Academic Year Added Successfully',
      desc: 'Academic Year - ${name3.text} is been added',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {
        name3.clear();
        orderno3.clear();
        getorderno();

      },
    )..show();
  }


  bool search= false;
  bool byclass = false;

  bool viewtem = false;

  bool mainconcent= false;
  final deletecheck = List<bool>.generate(1000, (int index) => false, growable: true);
  final deletecheck2 = List<bool>.generate(1000, (int index) => false, growable: true);
  final deletecheck3 = List<bool>.generate(1000, (int index) => false, growable: true);
  final deletecheck4 = List<bool>.generate(1000, (int index) => false, growable: true);
  final expand = List<bool>.generate(1000, (int index) => false, growable: true);
// create some values
  Color pickerColor = Color(0xff00A0E3);
  Color currentColor = Color(0xff00A0E3);

  Color pickerColor2 = Color(0xff90C01F);
  Color currentColor2 = Color(0xff90C01F);

  Color pickerColor3 = Color(0xffD62F5E);
  Color currentColor3 = Color(0xffD62F5E);


  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }
  void changeColor2(Color color) {
    setState(() => pickerColor2 = color);
  }
  void changeColor3(Color color) {
    setState(() => pickerColor3 = color);
  }

  setdatas() async {
    var document = await FirebaseFirestore.instance.collection("Admin").get();
    setState(() {
      //imgUrl=document.docs[0]["logo"];
      schoolname.text=document.docs[0]["schoolname"];
      schoolphone.text=document.docs[0]["phone"];
      solgan.text=document.docs[0]["solgan"];
      schoolarea.text=document.docs[0]["area"];
      schoolbuilding.text=document.docs[0]["buildingno"];
      schoolcity.text=document.docs[0]["city"];
      schoolpincode.text=document.docs[0]["pincode"];
      schoolstate.text=document.docs[0]["state"];
      schoolstreet.text=document.docs[0]["street"];
      schoolweb.text=document.docs[0]["web"];
      design=document.docs[0]["idcard"];
    });
  }

  @override
  void initState() {

    getorderno();
    setdatas();
    // TODO: implement initState
    super.initState();
  }
  int design=1;
  int index=0;
  String rollno="";
  Future<void> deletestudent(coll,id) async {
    return showDialog<void>(
      context: context,

      builder: (BuildContext context) {

        double width=MediaQuery.of(context).size.width;
        double height=MediaQuery.of(context).size.height;
        return StatefulBuilder(
            builder: (context,setState) {
              return AlertDialog(
                title:  Text('Are you Sure of Deleting',style: GoogleFonts.poppins(
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
                      FirebaseFirestore.instance.collection(coll).doc(id).delete();
                      getorderno();
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
  bool selectfile=false;
  String studentid = "";
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(

      body: Stack(
        children:[

          Padding(
            padding: const EdgeInsets.only(top:137.0,left: 20),
            child: Container(
              height:height/1.302,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                if (!isSmallScreen) ExampleSidebarX(controller: _controller),
                Expanded(
                  child: Center(
                    child: _ScreensExample(
                      controller: _controller,
                    ),
                  ),
                ),
              ],
        ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0,top:30),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: width/1.050,
                height:height/6.51,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 38.0,top: 30),
                          child: Text("School Profile",style: GoogleFonts.poppins(fontSize: width/68.3,fontWeight:FontWeight.w700),),
                        ),
                        SizedBox(
                            width: width/1.517777777777778
                        ),


                      ],
                    ),
                    Divider(),

                  ],
                ),
              ),
            ),
          ),
    ]
      ),
    );
  }
  String imgUrl="";
  String imgUrl2="";
  String imgUrl3="";
  bool isloading=false;
  bool isloading2=false;
  bool isloading3=false;
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
          isloading= false;

        });

        print(imgUrl);
      });
    });




  }
  uploadToStorage2() async{

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
          imgUrl2 = downloadUrl;
          isloading2= false;

        });

        print(imgUrl2);
      });
    });




  }
  uploadToStorage3() async{

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
          imgUrl3 = downloadUrl;
          isloading3= false;

        });

        print(imgUrl3);
      });
    });




  }
  admin(){
    FirebaseFirestore.instance.collection("Admin").doc("AbeOpc23Rx9Z6n4fxIVw").set({
      "schoolname":schoolname.text,
      "solgan":solgan.text,
      "phone":schoolphone.text,
      "buildingno":schoolbuilding.text,
      "street":schoolstreet.text,
      "area":schoolarea.text,
      "city":schoolcity.text,
      "state":schoolstate.text,
      "pincode":schoolpincode.text,
      "idcard":design,
      "logo":imgUrl,
      "logo2":imgUrl2,
      "web":schoolweb.text,
    });
  }
  Future<void> _bulkuploadstudent() async {
    return showDialog<void>(
      context: context,

      builder: (BuildContext context) {
        double width=MediaQuery.of(context).size.width;
        double height=MediaQuery.of(context).size.height;
        return StatefulBuilder(
            builder: (context,setState) {
              return AlertDialog(
                title:  Text('Profile Updated Sucessfully',style: GoogleFonts.poppins(
                    color: Colors.black, fontSize: width/75.88888888888889,fontWeight: FontWeight.w600),),
                content:  Container(
                    width: width/3.902857142857143,
                    height:height/2.604,

                    child:  Lottie.asset("assets/uploaded.json")
                ),
                actions: [
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


class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: SidebarX(
        controller: _controller,
        theme: SidebarXTheme(

          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.circular(20),
          ),
          hoverColor: scaffoldBackgroundColor,
          textStyle: GoogleFonts.montserrat(color: Colors.black.withOpacity(0.7),fontWeight: FontWeight.w700),
          selectedTextStyle: GoogleFonts.montserrat(color: Colors.white,fontWeight: FontWeight.w700),
          itemTextPadding: const EdgeInsets.only(left: 30),
          selectedItemTextPadding: const EdgeInsets.only(left: 30),
          itemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: canvasColor),
          ),
          selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: actionColor.withOpacity(0.37),
            ),
            color: Color(0xff00A0E3),

            boxShadow: [
              BoxShadow(
                color: Color(0xff00A0E3).withOpacity(0.28),
                blurRadius: 5,
              )
            ],
          ),
          iconTheme: IconThemeData(
            color: Colors.black.withOpacity(0.7),
            size: 20,
          ),
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
            size: 20,
          ),
        ),
        extendedTheme:  SidebarXTheme(
          width: width/6.83,
          decoration: BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.circular(20)
          ),
        ),
headerBuilder: (context, extended)  {
          return Container(height:height/32.55,);
},


        items: [
          SidebarXItem(
            icon: Icons.school,
            label: 'Profile',
            onTap: () {
              debugPrint('Home');
            },
          ),
          const SidebarXItem(
            icon: Icons.storage,
            label: 'Classes',
          ),
          const SidebarXItem(
            icon: Icons.upload,
            label: 'Bulk Upload',
          ),

          const SidebarXItem(
            icon: Icons.monetization_on_outlined,
            label: 'Fees',
          ),
          const SidebarXItem(
            icon: Icons.person,
            label: 'Designation',
          ),
          const SidebarXItem(
            icon: Icons.person,
            label: 'Student ID ',
          ),
          const SidebarXItem(
            icon: Icons.person,
            label: 'Staff ID',
          ),
          const SidebarXItem(
            icon: Icons.person,
            label: 'Class In-charge',
          ),
          const SidebarXItem(
            icon: Icons.subject,
            label: 'Subjects',
          ),
          const SidebarXItem(
            icon: Icons.person,
            label: 'Subject Staffs',
          ),
        ],
      ),
    );
  }
}

class _ScreensExample extends StatefulWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  State<_ScreensExample> createState() => _ScreensExampleState();
}

class _ScreensExampleState extends State<_ScreensExample> {
  int page=1;


  TextEditingController name = new TextEditingController();
  TextEditingController name2 = new TextEditingController();
  TextEditingController name3 = new TextEditingController();
  TextEditingController orderno = new TextEditingController();
  TextEditingController orderno2 = new TextEditingController();
  TextEditingController orderno3 = new TextEditingController();
  TextEditingController ordernofees = new TextEditingController();


  TextEditingController schoolname = new TextEditingController();
  TextEditingController schoolphone = new TextEditingController();
  TextEditingController schoolweb = new TextEditingController();
  TextEditingController schooldays = new TextEditingController();
  TextEditingController schooladdress = new TextEditingController();
  TextEditingController schoolbuilding = new TextEditingController();
  TextEditingController schoolstreet = new TextEditingController();
  TextEditingController schoolarea = new TextEditingController();
  TextEditingController schoolcity = new TextEditingController();
  TextEditingController schoolstate = new TextEditingController();
  TextEditingController schoolpincode = new TextEditingController();
  TextEditingController solgan = new TextEditingController();


  final check = List<bool>.generate(1000, (int index) => false, growable: true);

  getorderno() async {
    var document = await  FirebaseFirestore.instance.collection("ClassMaster").get();
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
    var document4 = await  FirebaseFirestore.instance.collection("FeesMaster").get();
    setState(() {
      ordernofees.text="00${document4.docs.length+1}";
    });

  }

  addclass(){
    FirebaseFirestore.instance.collection("ClassMaster").doc().set({
      "name": name.text,
      "order": int.parse(orderno.text),
    });
  }
  addfees(){
    FirebaseFirestore.instance.collection("FeesMaster").doc().set({
      "name": name.text,
      "order": int.parse(orderno.text),
    });
  }
  addclass2() async {
    FirebaseFirestore.instance.collection("SectionMaster").doc().set({
      "name": name2.text,
      "order": int.parse(orderno2.text),
    });
    var document = await FirebaseFirestore.instance.collection("ClassMaster").get();
    for(int i=0;i<document.docs.length;i++) {
      FirebaseFirestore.instance.collection("Attendance").doc("${document.docs[i]["name"]}${name2.text}").set({
        "name": "${document.docs[i]["name"]}${name2.text}",
      });
    }
  }
  addclass3(){
    FirebaseFirestore.instance.collection("AcademicMaster").doc().set({
      "name": name3.text,
      "order": int.parse(orderno3.text),
    });
  }

  Successdialog(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555555555556,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Class Added Successfully',
      desc: 'Class - ${name.text} is been added',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {
        name.clear();
        orderno.clear();
        getorderno();

      },
    )..show();
  }
  Successdialogfees(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555555555556,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Fees Added Successfully',
      desc: 'Fees - ${name.text} is been added',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {
        name.clear();
        orderno.clear();
        getorderno();

      },
    )..show();
  }
  Successdialogd(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555555555556,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Are you sure of save the Design',
      btnCancelText: "Edit",

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {


      },
    )..show();
  }
  Successdialog2(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555555555556,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Section Added Successfully',
      desc: 'Section - ${name2.text} is been added',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {
        name2.clear();
        orderno2.clear();
        getorderno();

      },
    )..show();
  }
  Successdialog3(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Academic Year Added Successfully',
      desc: 'Academic Year - ${name3.text} is been added',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {
        name3.clear();
        orderno3.clear();
        getorderno();

      },
    )..show();
  }


  Errordialog(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555555555556,
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Field cannot be empty',


      btnOkOnPress: () {

      },
    )..show();
  }

  bool search= false;
  bool byclass = false;

  bool viewtem = false;

  bool mainconcent= false;
  final deletecheck = List<bool>.generate(1000, (int index) => false, growable: true);
  final deletecheck2 = List<bool>.generate(1000, (int index) => false, growable: true);
  final deletecheck3 = List<bool>.generate(1000, (int index) => false, growable: true);
  final deletecheck4 = List<bool>.generate(1000, (int index) => false, growable: true);
  final expand = List<bool>.generate(1000, (int index) => false, growable: true);
// create some values
  Color pickerColor = Color(0xff00A0E3);
  Color currentColor = Color(0xff00A0E3);

  Color pickerColor2 = Color(0xff90C01F);
  Color currentColor2 = Color(0xff90C01F);

  Color pickerColor3 = Color(0xffD62F5E);
  Color currentColor3 = Color(0xffD62F5E);


  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }
  void changeColor2(Color color) {
    setState(() => pickerColor2 = color);
  }
  void changeColor3(Color color) {
    setState(() => pickerColor3 = color);
  }

  setdatas() async {
    var document = await FirebaseFirestore.instance.collection("Admin").get();
    setState(() {
      imgUrl=document.docs[0]["logo"];
      schoolname.text=document.docs[0]["schoolname"];
      schoolphone.text=document.docs[0]["phone"];
      solgan.text=document.docs[0]["solgan"];
      schoolarea.text=document.docs[0]["area"];
      schoolbuilding.text=document.docs[0]["buildingno"];
      schoolcity.text=document.docs[0]["city"];
      schoolpincode.text=document.docs[0]["pincode"];
      schoolstate.text=document.docs[0]["state"];
      schoolstreet.text=document.docs[0]["street"];
      schoolweb.text=document.docs[0]["web"];
      schooldays.text=document.docs[0]["days"].toString();
      design=document.docs[0]["idcard"];
    });
  }
  TabController? _controller;
  @override
  void initState() {

    getorderno();
    setdatas();
    // TODO: implement initState
    super.initState();
  }
  int design=1;
  int index=0;
  String rollno="";
  Future<void> deletestudent(coll,id) async {
    return showDialog<void>(
      context: context,

      builder: (BuildContext context) {

        double width=MediaQuery.of(context).size.width;
        double height=MediaQuery.of(context).size.height;
        return StatefulBuilder(
            builder: (context,setState) {
              return AlertDialog(
                title:  Text('Are you Sure of Deleting',style: GoogleFonts.poppins(
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
                      FirebaseFirestore.instance.collection(coll).doc(id).delete();
                      getorderno();
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
  bool selectfile=false;
  String studentid = "";
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(widget.controller.selectedIndex);
        switch (widget.controller.selectedIndex) {
          case 0:
            return  Padding(
              padding: const EdgeInsets.only(left: 20.0,right:45),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: width/1.050,
                  height:height/1.302,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:28.0,left: 10),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("School Name *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: schoolname,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("School Phone Number *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: schoolphone,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("School Slogan ",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: solgan,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:28.0,left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Building No: *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: schoolbuilding,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Street Name : *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: schoolstreet,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Area : *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: schoolarea,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:28.0,left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("City /District : *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: schoolcity,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("State: *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: schoolstate,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Pincode : *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: schoolpincode,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:28.0,left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Website : *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: schoolweb,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:0.0),
                                      child: Text("Total no of working days(Monthly) : *",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                                      child: Container(child: TextFormField(
                                        controller: schooldays,
                                        style: GoogleFonts.poppins(
                                            fontSize: width/91.066666667
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:10.0,top:18),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isloading2=true;
                                    });
                                    uploadToStorage2();
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(10),
                                    dashPattern: [5,5],
                                    color: Color(0xff00A0E3),
                                    strokeWidth:2, child: Container(
                                      width:width/6.22,
                                      height:height/8.69,
                                      child:Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height:height/104.3,),
                                          imgUrl2==""? Icon(Icons.photo_library_outlined,color:Color(0xff00A0E3),size: width/46.65,): Icon(Icons.cloud_done_rounded,color:Color(0xff00A0E3),size: width/46.65,),
                                          SizedBox(height:height/104.3,),

                                          imgUrl2==""? Text('Select the Principal Sign to Upload',
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,
                                                  fontSize:width/124.4,color: Color(0xff00A0E3))) :

                                          Text('File Selected',
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,
                                                  fontSize:width/124.4,color: Color(0xff00A0E3)))

                                        ],)
                                  ),
                                  ),
                                ),
                                SizedBox(width: width/68.3,),
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isloading3=true;
                                    });
                                    uploadToStorage3();
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(10),
                                    dashPattern: [5,5],
                                    color: Color(0xff00A0E3),
                                    strokeWidth:2, child: Container(
                                      width:width/6.22,
                                      height:height/8.69,
                                      child:Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height:height/104.3,),
                                          imgUrl3==""? Icon(Icons.photo_library_outlined,color:Color(0xff00A0E3),size: width/46.65,): Icon(Icons.cloud_done_rounded,color:Color(0xff00A0E3),size: width/46.65,),
                                          SizedBox(height:height/104.3,),

                                          imgUrl3==""? Text('Select the School Seal to Upload',
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,
                                                  fontSize:width/124.4,color: Color(0xff00A0E3))) :

                                          Text('File Selected',
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,
                                                  fontSize:width/124.4,color: Color(0xff00A0E3)))

                                        ],)
                                  ),
                                  ),
                                ),


                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(100),
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    isloading=true;
                                  });
                                  uploadToStorage();
                                },
                                child: Container(
                                    width: width/8.035294117647059,
                                    height:height/3.829411764705882,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100)
                                    ),
                                    child: isloading==false?
                                    imgUrl==""?

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.camera_alt_rounded,size: 50,),
                                        Text("Select Logo",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),)
                                      ],
                                    ) : ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Container(
                                            width: width/8.035294117647059,
                                            height:height/3.829411764705882,
                                            child: Image.network(imgUrl, fit: BoxFit.cover,))): Center(
                                      child: CircularProgressIndicator(),
                                    )
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height:height/65.1,),
                          Padding(
                            padding: const EdgeInsets.only(top:30.0,left:20),
                            child: InkWell(
                              onTap: (){
                                admin();
                                // _bulkuploadstudent();
                              },
                              child: Container(child: Center(child: Text("Update Profile",style: GoogleFonts.poppins(color:Colors.white),)),
                                width: width/10.507,
                                height: height/16.425,
                                // color:Color(0xff00A0E3),
                                decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                              ),
                            ),
                          ),


                        ],
                      ),

                    ],
                  ),
                ),
              ),
            );
          case 1:
            return  SingleChildScrollView(

              child: Padding(
                padding: const EdgeInsets.only(left:20,right:45),
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
                          padding: const EdgeInsets.only(left: 5.0,top: 20),
                          child: GestureDetector(
                            onTap: (){
                              print(width);
                            },
                            child: Container(
                              width: width/4.26875,

                              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                              child:  Column(
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
                                              child: Text("Order Si.No",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 0.0,right: 10),
                                              child: Container(
                                                child: TextField(
                                                  readOnly: true,
                                                  controller: orderno,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: width/91.066666667
                                                  ),
                                                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                                width: width/10.902,
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
                                              child: Text("Class",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 0.0,right: 10),
                                              child: Container(child: TextField(
                                                controller: name,
                                                style: GoogleFonts.poppins(
                                                    fontSize: width/91.066666667
                                                ),
                                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                                width: width/10.902,
                                                height: height/16.425,
                                                //color: Color(0xffDDDEEE),
                                                decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                              ),
                                            ),

                                          ],

                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: GestureDetector(
                                            onTap: (){

                                              if(name.text!="") {
                                                addclass();
                                                Successdialog();
                                              }
                                              else{
                                                Errordialog();
                                              }
                                            },
                                            child: Container(child: Center(child: Icon(Icons.add,color: Colors.white,size: 20,)),
                                              width: width/45.53333333333333,
                                              height:height/21.7,
                                              // color:Color(0xff00A0E3),
                                              decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(40)),

                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: height/13.14,
                                      width: width/4.55333,

                                      decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0,right: 20.0),
                                            child: Text("Order Si.no",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                            child: Text("Class",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                          ),
                                        ],
                                      ),

                                    ),
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance.collection("ClassMaster").orderBy("order").snapshots(),

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
                                              return  MouseRegion(
                                                onEnter: (_){
                                                  setState(() {
                                                    deletecheck[index]=true;
                                                  });
                                                },
                                                onExit: (_){
                                                  setState(() {
                                                    deletecheck[index]=false;
                                                  });
                                                },
                                                child: Padding(
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
                                                          child: Text("00${value["order"].toString()}",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                          child: Container(
                                                              width:width/13.66,
                                                              child: Text(value["name"],style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),)),
                                                        ),
                                                        deletecheck[index]==true?     InkWell(
                                                          onTap: (){
                                                            deletestudent("ClassMaster",value.id);
                                                          },
                                                          child: Padding(
                                                              padding:
                                                              const EdgeInsets.only(left: 15.0),
                                                              child: Container(
                                                                  width: width/45.53333333333333,

                                                                  child: Image.asset("assets/delete.png"))
                                                          ),
                                                        ) : Container()
                                                      ],
                                                    ),

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
                          padding: const EdgeInsets.only(left: 5.0,top: 20),
                          child: Container(
                            width: width/4.26875,
                            height:height/1.263,
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
                                            child: Text("Order Si.No",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0.0,right: 10),
                                            child: Container(
                                              child: TextField(
                                                readOnly: true,
                                                controller: orderno2,
                                                style: GoogleFonts.poppins(
                                                    fontSize: width/91.066666667
                                                ),
                                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                              width: width/10.902,
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
                                            child: Text("Section",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0.0,right: 10),
                                            child: Container(child: TextField(

                                              controller: name2,
                                              style: GoogleFonts.poppins(
                                                  fontSize: width/91.066666667
                                              ),
                                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                              width: width/10.902,
                                              height: height/16.425,
                                              //color: Color(0xffDDDEEE),
                                              decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                            ),
                                          ),

                                        ],

                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: GestureDetector(
                                          onTap: (){
                                            if(name2.text!="") {
                                              addclass2();
                                              Successdialog2();
                                            }else{
                                              Errordialog();
                                            }
                                          },
                                          child: Container(child: Center(child: Icon(Icons.add,color: Colors.white,size: 20,)),
                                            width: width/45.53333333333333,
                                            height:height/21.7,
                                            // color:Color(0xff00A0E3),
                                            decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(40)),

                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: height/13.14,
                                    width: width/4.55333,

                                    decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 20.0),
                                          child: Text("Order Si.no",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                          child: Text("Section",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                        ),

                                      ],
                                    ),

                                  ),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("SectionMaster").orderBy("order").snapshots(),

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
                                            return  MouseRegion(
                                              onEnter: (_){
                                                setState(() {
                                                  deletecheck2[index]=true;
                                                });
                                              },
                                              onExit: (_){
                                                setState(() {
                                                  deletecheck2[index]=false;
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: height/ 21.9,
                                                  width: width/4.553333333333333,

                                                  decoration: BoxDecoration(color:Colors.white60,borderRadius: BorderRadius.circular(12)

                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 30.0,right: 70.0),
                                                        child: Text("00${value["order"].toString()}",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                        child: Container(width:width/13.66,child: Text(value["name"],style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),)),
                                                      ),
                                                      deletecheck2[index]==true?     InkWell(
                                                        onTap: (){
                                                          deletestudent("SectionMaster",value.id);
                                                        },
                                                        child: Padding(
                                                            padding:
                                                            const EdgeInsets.only(left: 15.0),
                                                            child: Container(
                                                                width: width/45.53333333333333,

                                                                child: Image.asset("assets/delete.png"))
                                                        ),
                                                      ) : Container()
                                                    ],
                                                  ),

                                                ),
                                              ),
                                            );
                                          });

                                    }),


                              ],
                            ),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0,top: 20),
                          child: Container(
                            width: width/3.650,
                            height:height/1.263,
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
                                            child: Text("Order Si.No",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0.0,right: 10),
                                            child: Container(
                                              child: TextField(
                                                readOnly: true,
                                                controller: orderno3,
                                                style: GoogleFonts.poppins(
                                                    fontSize: width/91.066666667
                                                ),
                                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                              width: width/10.902,
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
                                            child: Text("Academic Year",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0.0,right: 10),
                                            child: Container(child: TextField(
                                              controller: name3,
                                              style: GoogleFonts.poppins(
                                                  fontSize: width/91.066666667
                                              ),
                                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                              width: width/10.902,
                                              height: height/16.425,
                                              //color: Color(0xffDDDEEE),
                                              decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                            ),
                                          ),

                                        ],

                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: GestureDetector(
                                          onTap: (){
                                            if(name3.text!="") {
                                              addclass3();
                                              Successdialog3();
                                            }
                                            else{
                                              Errordialog();
                                            }
                                          },
                                          child: Container(child: Center(child: Icon(Icons.add,color: Colors.white,size: 20,)),
                                            width: width/45.53333333333333,
                                            height:height/21.7,
                                            // color:Color(0xff00A0E3),
                                            decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(40)),

                                          ),
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
                                          child: Text("Order Si.no",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                          child: Text("Academic Year",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                        ),
                                      ],
                                    ),

                                  ),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("AcademicMaster").orderBy("order").snapshots(),

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
                                            return  MouseRegion(
                                              onEnter: (_){
                                                setState(() {
                                                  deletecheck3[index]=true;
                                                });
                                              },
                                              onExit: (_){
                                                setState(() {
                                                  deletecheck3[index]=false;
                                                });
                                              },
                                              child: Padding(
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
                                                        child: Text("00${value["order"].toString()}",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                        child: Container(width: width/12.41818181818182,child: Text(value["name"],style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),)),
                                                      ),
                                                      deletecheck3[index]==true?     InkWell(
                                                        onTap: (){
                                                          deletestudent("AcademicMaster",value.id);
                                                        },
                                                        child: Padding(
                                                            padding:
                                                            const EdgeInsets.only(left: 15.0),
                                                            child: Container(
                                                                width: width/45.53333333333333,

                                                                child: Image.asset("assets/delete.png"))
                                                        ),
                                                      ) : Container()
                                                    ],
                                                  ),

                                                ),
                                              ),
                                            );
                                          });

                                    }),


                              ],
                            ),

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          case 2:
            return  BulkUploadfunction();
          case 3:
            return  Padding(
              padding: const EdgeInsets.only(left:20,right:45),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: width/1.050,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 20.0,top: 20),
                    child: Container(
                      width: width/1.050,

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
                                        child: Text("Order Si.No",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0.0,right: 25),
                                        child: Container(child: TextField(
                                          readOnly: true,
                                          controller: ordernofees,
                                          style: GoogleFonts.poppins(
                                              fontSize: width/91.066666667
                                          ),
                                          decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                          width: width/4.102,
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
                                        child: Text("Fees",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0.0,right: 25),
                                        child: Container(
                                          child: TextField(
                                            controller: name,
                                            style: GoogleFonts.poppins(
                                                fontSize: width/91.066666667
                                            ),
                                            decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                          width: width/4.102,
                                          height: height/16.425,
                                          //color: Color(0xffDDDEEE),
                                          decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                        ),
                                      ),

                                    ],

                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      if(name.text==""){
                                        Errordialog();
                                      }
                                      else{
                                      addfees();
                                      Successdialogfees();
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
                              padding: const EdgeInsets.only(left:10.0,top:10,bottom: 10),
                              child: Container(
                                height: height/13.14,
                                width: width/1.366,

                                decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,right: 20.0),
                                      child: Text("Order Si.no",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                      child: Text("Fee Name",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                    ),
                                  ],
                                ),

                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection("FeesMaster").orderBy("order").snapshots(),

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
                                        return  MouseRegion(
                                          onEnter: (_){
                                            setState(() {
                                              deletecheck4[index]=true;
                                            });
                                          },
                                          onExit: (_){
                                            setState(() {
                                              deletecheck4[index]=false;
                                            });
                                          },

                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: height/ 21.9,
                                              width: width/1.050,

                                              decoration: BoxDecoration(color:Colors.white60,borderRadius: BorderRadius.circular(12)

                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 30.0,right: 70.0),
                                                    child: Text("${(index+1).toString().padLeft(3,"0")}",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                    child: Text(value["name"],style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),),
                                                  ),
                                                  deletecheck4[index]==true?     InkWell(
                                                    onTap: (){
                                                      deletestudent("FeesMaster",value.id);
                                                    },
                                                    child: Padding(
                                                        padding:
                                                        const EdgeInsets.only(left: 15.0),
                                                        child: Container(
                                                            width: width/45.53333333333333,

                                                            child: Image.asset("assets/delete.png"))
                                                    ),
                                                  ) : Container()
                                                ],
                                              ),

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
                ),
              ),
            );
          case 4:
            return  Padding(
              padding: const EdgeInsets.only(right:25.0),
              child: Desigination(),
            );
          case 5:
            return  StudentID();
          case 6:
            return  StaffID();
          case 7:
            return  ClassIncharge();
          case 8:
            return  Padding(
              padding: const EdgeInsets.only(right:45.0,left:20),
              child: ClassSubjects(),
            );
          case 9:
            return  SubjectTeacher();
          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }

  String imgUrl="";

  String imgUrl2="";

  String imgUrl3="";

  bool isloading=false;

  bool isloading2=false;

  bool isloading3=false;

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
          isloading= false;

        });

        print(imgUrl);
      });
    });




  }

  uploadToStorage2() async{

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
          imgUrl2 = downloadUrl;
          isloading2= false;

        });

        print(imgUrl2);
      });
    });




  }

  uploadToStorage3() async{

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
          imgUrl3 = downloadUrl;
          isloading3= false;

        });

        print(imgUrl3);
      });
    });




  }

  admin() async {
    FirebaseFirestore.instance.collection("Admin").doc("AbeOpc23Rx9Z6n4fxIVw").set({
      "schoolname":schoolname.text,
      "solgan":solgan.text,
      "phone":schoolphone.text,
      "buildingno":schoolbuilding.text,
      "street":schoolstreet.text,
      "area":schoolarea.text,
      "city":schoolcity.text,
      "state":schoolstate.text,
      "pincode":schoolpincode.text,
      "idcard":design,
      "logo":imgUrl,
      "logo2":imgUrl2,
      "web":schoolweb.text,
      "days":int.parse(schooldays.text),
    });
    await _bulkuploadstudent();
  }
  Future<void> _bulkuploadstudent() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,

      builder: (BuildContext context) {
        double width=MediaQuery.of(context).size.width;
        double height=MediaQuery.of(context).size.height;
        return StatefulBuilder(
            builder: (context,setState) {
              return AlertDialog(
                title:  Text('Profile Updated Sucessfully',style: GoogleFonts.poppins(
                    color: Colors.black, fontSize: width/75.88888888888889,fontWeight: FontWeight.w600),),
                content:  Container(
                    width: width/3.902857142857143,
                    height:height/2.604,

                    child:  Lottie.asset("assets/uploaded.json")
                ),
                actions: [
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
                            // child: Icon(Icons.cancel,color: Colors.white,),
                            child: Icon(Icons.check,color: Colors.white,),
                          ),
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

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return 'Search';
    case 2:
      return 'People';
    case 3:
      return 'Favorites';
    case 4:
      return 'Custom iconWidget';
    case 5:
      return 'Profile';
    case 6:
      return 'Settings';
    default:
      return 'Not found page';
  }
}

const primaryColor = Colors.white;
const canvasColor = Colors.white;
const scaffoldBackgroundColor = Color(0xff00A0E3);
const accentCanvasColor = Colors.white;
const white = Colors.white;
final actionColor = const Color(0xff00A0E3).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);