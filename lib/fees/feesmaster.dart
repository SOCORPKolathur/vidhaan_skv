import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeesMaster extends StatefulWidget {
  const FeesMaster({Key? key}) : super(key: key);

  @override
  State<FeesMaster> createState() => _FeesMasterState();
}

class _FeesMasterState extends State<FeesMaster> {

  TextEditingController name = new TextEditingController();
  TextEditingController orderno = new TextEditingController();




  getorderno() async {
    var document = await  FirebaseFirestore.instance.collection("FeesMaster").get();
    setState(() {
      orderno.text="00${document.docs.length+1}";
    });
  }

  addclass(){
    FirebaseFirestore.instance.collection("FeesMaster").doc().set({
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
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.only(left: width/68.3),
          child: Container(child: Padding(
            padding:  EdgeInsets.only(left: width/35.947368421,top: height/21.7),
            child: Text("Fees Master",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),),
          ),
            //color: Colors.white,
            width: width/1.050,
            height: height/8.212,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
          ),
        ),
        Padding(
          padding:  EdgeInsets.only(left: width/68.3,top: height/32.55),
          child: Container(
            width: width/1.050,
            height:height/1.263,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                            child: Text("Order Si.No",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: 0.0,right: width/54.64),
                            child: Container(child: TextField(
                              controller: orderno,
                              style: GoogleFonts.poppins(
                                  fontSize: width/91.066666667
                              ),
                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/81.375),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:0.0),
                            child: Text("Fees",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: 0.0,right: width/54.64),
                            child: Container(
                              child: TextField(
                              controller: name,
                              style: GoogleFonts.poppins(
                                  fontSize: width/91.066666667
                              ),
                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/81.375),
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
                    width: width/ 1.241,

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
                          child: Text("Class",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
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
                                      padding:  EdgeInsets.only(left: width/45.533333333,right: width/19.514285714),
                                      child: Text("00${value["order"].toString()}",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(left: width/170.75,right: width/170.75),
                                      child: Text(value["name"],style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w600,color: Colors.black),),
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
    );
  }
}
