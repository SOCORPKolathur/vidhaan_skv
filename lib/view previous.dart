import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Previous extends StatefulWidget {
  const Previous({Key? key}) : super(key: key);

  @override
  State<Previous> createState() => _PreviousState();
}

class _PreviousState extends State<Previous> {
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(child: Padding(
                padding: const EdgeInsets.only(left: 38.0,top: 30),
                child: Text(" View Previous Circulars",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
              ),
                //color: Colors.white,
                width: width/1.050,
                height: height/8.212,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("Circulars").orderBy("timestamp",descending: true).snapshots(),

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

                            width: width/1.241,
                            decoration: BoxDecoration(
                                color:Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.black
                              )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Title :${value["reason"]}",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.left),
                                  Container(
                                    width: width/1.841,
                                    child: Divider(
                                      thickness: 2,
                                    ),
                                  ),
                                  Text("Des: ${value["Descr"]}",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600,),textAlign: TextAlign.left,),

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("Date: ${value["Date"]}",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600,color: Color(0xff00A0E3)),textAlign: TextAlign.left,),

                                      SizedBox(width: 40,),

                                      Text("Time: ${value["Time"]}",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600,color: Color(0xff00A0E3)),textAlign: TextAlign.left,),
                                    ],
                                  ),
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
    );
  }
}
