import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ExamMaster extends StatefulWidget {
  const ExamMaster({Key? key}) : super(key: key);

  @override
  State<ExamMaster> createState() => _ExamMasterState();
}

class _ExamMasterState extends State<ExamMaster> {

  TextEditingController name = new TextEditingController();
  TextEditingController orderno = new TextEditingController();
  addclass(){
    FirebaseFirestore.instance.collection("ExamMaster").doc().set({
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
  getorderno() async {
    var document = await  FirebaseFirestore.instance.collection("ExamMaster").get();
    setState(() {
      orderno.text="00${document.docs.length+1}";
    });
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
  @override
  void initState() {
    getorderno();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Container(child: Padding(
            padding: const EdgeInsets.only(left: 38.0,top: 30),
            child: Text("Exam Masters",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
          ),
            //color: Colors.white,
            width: width/1.050,
            height: height/8.212,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0,top: 20),
          child: GestureDetector(
            onTap: (){
              print(width);
            },
            child: Container(
              width: 1200,

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
                              child: Text("Order Si.No",style: GoogleFonts.poppins(fontSize: 15,)),
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
                              child: Text("Class",style: GoogleFonts.poppins(fontSize: 15,)),
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
                              width: 30,
                              height: 30,
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
                      width: 1200,

                      decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 20.0),
                            child: Text("Order Si.no",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                            child: Text("Class",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                          ),
                        ],
                      ),

                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("ExamMaster").orderBy("order").snapshots(),

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
                                          child: Text("00${value["order"].toString()}",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                          child: Container(
                                              width:width/13.66,
                                              child: Text(value["name"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),)),
                                        ),
                                         InkWell(
                                          onTap: (){
                                            deletestudent("ExamMaster",value.id);
                                          },
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.only(left: 15.0),
                                              child: Container(
                                                  width: 30,

                                                  child: Image.asset("assets/delete.png"))
                                          ),
                                        )
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

      ],
    );
  }
}
