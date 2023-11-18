import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Desigination extends StatefulWidget {
  const Desigination({Key? key}) : super(key: key);

  @override
  State<Desigination> createState() => _DesiginationState();
}

class _DesiginationState extends State<Desigination> {

  TextEditingController name = new TextEditingController();
  TextEditingController orderno = new TextEditingController();




  getorderno() async {
    var document = await  FirebaseFirestore.instance.collection("DesignationMaster").get();
    setState(() {
      orderno.text="00${document.docs.length+1}";
    });
  }

  addclass(){
    FirebaseFirestore.instance.collection("DesignationMaster").doc().set({
      "name": name.text,
      "order": int.parse(orderno.text),
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
  Successdialog(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/3.035555556,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Designation Added Successfully',
      desc: 'Designation - ${name.text} is been added',
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
  final deletecheck4 = List<bool>.generate(1000, (int index) => false, growable: true);

  @override
  Widget build(BuildContext context) {

    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [

          Padding(
            padding:  EdgeInsets.only(left: width/68.3,top: 0,right: width/54.64),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: width/1.050,

                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding:  EdgeInsets.only(left: width/136.6,top:height/32.55),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right:0.0),
                                child: Text("Order Si.No",style: GoogleFonts.poppins(fontSize: width/91.066666667)),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(left: 0.0,right: width/54.64),
                                child: Container(child: TextField(
                                  readOnly: true,
                                  controller: orderno,
                                  style: GoogleFonts.poppins(
                                      fontSize: width/91.066666667
                                  ),
                                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/81.375),
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
                                child: Text("Designation",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(left: 0.0,right: width/54.64),
                                child: Container(child: TextField(
                                  controller: name,
                                  style: GoogleFonts.poppins(
                                      fontSize: width/91.066666667
                                  ),
                                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/81.375),
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
                          GestureDetector(
                            onTap: (){
                              if(name.text==""){
                                Errordialog();
                              }
                              else {
                                addclass();
                                Successdialog();
                              }
                            },
                            child: Container(child: Center(child: Text("Save",style: GoogleFonts.poppins(color:Colors.white),)),
                              width: width/10.507,
                              height: height/16.42,
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
                              padding:  EdgeInsets.only(left: width/170.75,right: width/68.3),
                              child: Text("Order Si.no",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: width/170.75,right: width/170.75),
                              child: Text("Designation",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                            ),
                          ],
                        ),

                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection("DesignationMaster").orderBy("order").snapshots(),

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
                                  child: MouseRegion(
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
                                    child: Container(
                                      height: height/21.9,
                                      width: width/1.241,

                                      decoration: BoxDecoration(color:Colors.white60,borderRadius: BorderRadius.circular(12)

                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(left: width/45.533333333,right: width/19.514285714),
                                            child: Text("${(index+1).toString().padLeft(3,"0")}",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.only(left: width/170.75,right: width/170.75),
                                            child: Text(value["name"],style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),),
                                          ),
                                          deletecheck4[index]==true?     InkWell(
                                            onTap: (){
                                              deletestudent("DesignationMaster",value.id);
                                            },
                                            child: Padding(
                                                padding:
                                                 EdgeInsets.only(left: width/91.066666667),
                                                child: Container(
                                                    width: width/45.533333333,

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
          )
        ],
      ),
    );
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
                    color: Colors.black, fontSize:width/75.888888889,fontWeight: FontWeight.w600),),
                content:  Container(
                    width: width/3.902857143,
                    height: height/2.604,

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
                            padding:  EdgeInsets.only(right: width/170.75),
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
}
