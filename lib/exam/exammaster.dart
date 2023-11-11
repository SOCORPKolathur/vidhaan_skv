import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:random_string/random_string.dart';

class ExamMaster extends StatefulWidget {
  const ExamMaster({Key? key}) : super(key: key);

  @override
  State<ExamMaster> createState() => _ExamMasterState();
}

class _ExamMasterState extends State<ExamMaster> {

  TextEditingController name = new TextEditingController();
  TextEditingController orderno = new TextEditingController();

  String docid ="";

  addclass() async {
    setState(() {
      docid=randomAlphaNumeric(16);
    });
    FirebaseFirestore.instance.collection("ExamMaster").doc(docid).set({
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
      title: 'Exam Added Successfully',
      desc: 'Exam - ${name.text} is been added',
      btnCancelOnPress: () {

      },
      btnOkOnPress: () {
        name.clear();
        orderno.clear();
        getorderno();

      },
    )..show();
  }

  getorderno() async {
    var document = await  FirebaseFirestore.instance.collection("ExamMaster").get();
    setState(() {
      orderno.text="00${document.docs.length+1}";
    });
  }

  Errordialog(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555556,
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Field cannot be empty',
      btnOkOnPress: () {
      },
    )..show();
  }


  Future<void> deletestudent(coll,id) async {
    return showDialog<void>(
      context: context,

      builder: (BuildContext context) {
        double width=MediaQuery.of(context).size.width;
        double height=MediaQuery.of(context).size.height;
        return StatefulBuilder(
            builder: (context,setState) {
              return AlertDialog(
                title:  Text(
                  'Are you Sure of Deleting',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                      fontSize:width/75.888888889,
                      fontWeight: FontWeight.w600,
                  ),
                ),
                content:  SizedBox(
                    width: width/3.902857143,
                    height: height/2.604,
                    child: Lottie.asset("assets/delete file.json"),
                ),
                actions: <Widget>[
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(width/273.2),
                      elevation: 7,
                      child: Container(
                        width: width/10.507,
                        height: height/20.425,
                        decoration: BoxDecoration(
                            color:  Colors.red,
                            borderRadius: BorderRadius.circular(width/273.2),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.only(right: width/170.75),
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Cancel",
                                style: GoogleFonts.poppins(
                                    color:Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                      borderRadius: BorderRadius.circular(width/273.2),
                      elevation: 7,
                      child: Container(width: width/10.507,
                        height: height/20.425,
                        decoration: BoxDecoration(
                            color:  Colors.green,
                            borderRadius: BorderRadius.circular(width/273.2),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Ok",
                                style: GoogleFonts.poppins(
                                  color:Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
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

  @override
  void initState() {
    getorderno();
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
                padding:  EdgeInsets.only(
                  left: width/35.947368421,
                  top: height/21.7,
                ),
                child: Text(
                  "Exam Masters",
                  style: GoogleFonts.poppins(
                    fontSize: width/75.888888889,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0,top: 20),
            child: GestureDetector(
              onTap: (){},
              child: Container(
                width: width/1.138333333,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width/113.833333333),
                ),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: width/136.6, top:height/32.55),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right:0.0),
                                child: Text(
                                    "Order Si.No",
                                    style: GoogleFonts.poppins(
                                      fontSize: width/91.066666667,
                                    ),
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(left: 0.0,right: width/136.6),
                                child: Container(
                                  width: width/12.902,
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
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                        left: width/136.6,
                                        bottom: height/81.375,
                                      ),
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
                                padding:  const EdgeInsets.only(right:0.0),
                                child: Text(
                                    "Class",
                                    style: GoogleFonts.poppins(
                                      fontSize: width/91.066666667,
                                    ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 0.0,right: width/136.6),
                                child: Container(
                                  width: width/4.902,
                                  height: height/16.425,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffDDDEEE),
                                      borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextField(
                                    controller: name,
                                    style: GoogleFonts.poppins(
                                      fontSize: width/91.066666667
                                  ),
                                    decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: width/136.6,
                                      bottom: height/81.375,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:  EdgeInsets.only(bottom: height/93),
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
                              child: Container(
                                width: width/45.533333333,
                                height: height/21.7,
                                decoration: BoxDecoration(
                                    color: const Color(0xff00A0E3),
                                    borderRadius: BorderRadius.circular(width/34.15),
                                ),
                                child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: width/68.3,
                                    ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width/170.75,vertical: height/81.375),
                      child: Container(
                        height: height/13.14,
                        width: width/1.138333333,
                        decoration: BoxDecoration(
                            color: const Color(0xff00A0E3),
                            borderRadius: BorderRadius.circular(width/113.833333333),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: width/170.75, right: width/68.3),
                              child: Text(
                                "Order Si.no",
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
                                "Class",
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
                        stream: FirebaseFirestore.instance.collection("ExamMaster").orderBy("order").snapshots(),
                        builder: (context,snapshot){
                          if(!snapshot.hasData) {
                            return   const Center(
                              child:  CircularProgressIndicator(),
                            );
                          }
                          if(snapshot.hasData==null) {
                            return   const Center(
                              child:  CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context,index){
                                var value = snapshot.data!.docs[index];
                                return  MouseRegion(
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: width/170.75, vertical:  height/81.375),
                                    child: Container(
                                      height: height/ 21.9,
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
                                              "00${value["order"].toString()}",
                                              style: GoogleFonts.poppins(
                                                  fontSize: width/91.066666667,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.only(left: width/170.75,right: width/170.75),
                                            child: Text(
                                              value["name"],
                                              style: GoogleFonts.poppins(
                                                  fontSize: width/91.066666667,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              deletestudent("ExamMaster",value.id);
                                            },
                                            child: Padding(
                                              padding:  EdgeInsets.only(left: width/91.066666667),
                                              child: SizedBox(
                                                width: width/45.533333333,
                                                child: Image.asset("assets/delete.png"),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
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
    );
  }
}
