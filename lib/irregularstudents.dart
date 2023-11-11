import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IrregularStudents extends StatefulWidget {
  const IrregularStudents({Key? key}) : super(key: key);

  @override
  State<IrregularStudents> createState() => _IrregularStudentsState();
}

class _IrregularStudentsState extends State<IrregularStudents> {
  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(child: Padding(
            padding: const EdgeInsets.only(left: 38.0,top: 30),
            child: Text("Staff Attendance Register",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),),
          ),
            //color: Colors.white,
            width: width/1.050,
            height: height/8.212,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0,top: 20),
          child: Container(width: width/8.212,
            height:height/1.263,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: height/13.14,
                            width: width/1.300,

                            decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 20.0),
                                  child: Text("Reg No",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40.0,right: 8.0),
                                  child: Text("Student Name",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 80.0,right: 8.0),
                                  child: Text("Attendance",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 80.0,right: 8.0),
                                  child: Text("Mobile No",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 80.0,right: 8.0),
                                  child: Text("No.of.Days",style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.w700,color: Colors.white),),
                                ),
                              ],
                            ),

                          ),
                        ),
                        Container(
                          width: width/1.300,
                          child: StreamBuilder<QuerySnapshot>(
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
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context,index){
                                      var value = snapshot.data!.docs[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: height/21.9,
                                          width: width/2.101,

                                          decoration: BoxDecoration(color:Colors.white60,borderRadius: BorderRadius.circular(12)

                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5.0,right: 0.0),
                                                child: Container(
                                                    width: width/11.383,

                                                    child: Text("SBVD001",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500,color: Colors.black),)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                                                child: Container(

                                                    width: width/6.209,
                                                    child: Text("Sam Jeba",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500,color: Colors.black),)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                                                child: Container(

                                                    width: width/8.035,
                                                    child: Text("Present",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500,color: Colors.green),)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                                                child: Container(

                                                    width: width/13.66,
                                                    child: Text("7894561237",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500,color: Colors.black),)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 80.0,right: 0.0),
                                                child: Container(

                                                    width: width/13.66,
                                                    child: Text("20 Days",style: GoogleFonts.poppins(fontSize: width/91.066666667,fontWeight: FontWeight.w500,color: Colors.black),)),
                                              ),
                                            ],
                                          ),

                                        ),
                                      );
                                    });

                              }),
                        ),
                      ],
                    ),

                  ],
                ),



              ],
            ),

          ),
        )
      ],
    );
  }
}
