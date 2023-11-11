import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Subject extends StatefulWidget {
  const Subject({Key? key}) : super(key: key);

  @override
  State<Subject> createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {

  TextEditingController name = new TextEditingController();
  TextEditingController orderno = new TextEditingController();




  getorderno() async {
    var document = await  FirebaseFirestore.instance.collection("SubjectMaster").get();
    setState(() {
      orderno.text="00${document.docs.length+1}";
    });
  }

  addclass() async {
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

  @override
  void initState() {
    getorderno();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 0.0,top: 0),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: width/1.050,
                height:height/1.263,
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
                                padding: const EdgeInsets.only(left: 0.0,right: 25),
                                child: Container(child: TextField(
                                  controller: orderno,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15
                                  ),
                                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                    border: InputBorder.none,
                                  ),
                                ),
                                  width: width/3.902,
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
                                child: Text("Subject",style: GoogleFonts.poppins(fontSize: 15,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 25),
                                child: Container(child: TextField(
                                  controller: name,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15
                                  ),
                                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                    border: InputBorder.none,
                                  ),
                                ),
                                  width: width/3.902,
                                  height: height/16.425,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                ),
                              ),

                            ],

                          ),
                          GestureDetector(
                            onTap: (){
                              addclass();
                              Successdialog();
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
                              child: Text("Order Si.no",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                              child: Text("Subject",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
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
                                    height: height/21.9,
                                    width: width/1.241,

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
                                          child: Text(value["name"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
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
          )
        ],
      ),
    );
  }
}
