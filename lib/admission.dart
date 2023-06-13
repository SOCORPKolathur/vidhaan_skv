import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const List<String> list = <String>['Please Select Gender', 'Two', 'Three', 'Four'];
const List<String> list1 = <String>['Please Select Class', '8th', 'Three', 'Four'];
const List<String> list2 = <String>['Please Select Religion', 'Two', 'Three', 'Four'];
const List<String> list3 = <String>['  ', 'Two', 'Three', 'Four'];

class admission extends StatefulWidget {
  const admission({Key? key}) : super(key: key);

  @override
  State<admission> createState() => _admissionState();
}

class _admissionState extends State<admission> {
  var page;
  String dropdownValue = list.first;
  String dropdownValue1 = list1.first;
  String dropdownValue2 = list2.first;
  String dropdownValue3 = list3.first;
  TextEditingController name=new TextEditingController();
  TextEditingController Date=new TextEditingController();
  TextEditingController clas=new TextEditingController();
  TextEditingController phonr=new TextEditingController();
  TextEditingController parentname=new TextEditingController();
  TextEditingController occupation=new TextEditingController();
  TextEditingController address=new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 0.0, bottom: 20),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 38.0, right: 30),
                      child: Text("Admissions",
                          style: GoogleFonts.poppins(
                              color: Color(0xff000000),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      child: Center(
                          child: Text(
                            "Add New Admission",
                            style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),
                          )),
                      width: 200,
                      //color: Color(0xff00A0E3),
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xff00A0E3),
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 38.0, left: 38),
                      child: Container(
                        child: Center(
                            child: Text(
                              "View Rejected Admission",
                              style:
                              GoogleFonts.poppins(color: Color(0xffFFFFFF)),
                            )),
                        width: 200,
                        //color: Color(0xff00A0E3),
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xffD60A0B),
                            borderRadius: BorderRadius.circular(6)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          page=4;
                        });
                      },
                      child: Container(
                        child: Center(
                            child: Text(
                              "Enroll Student",
                              style:
                              GoogleFonts.poppins(color: Color(0xffFFFFFF)),
                            )),
                        width: 200,
                        //color: Color(0xff00A0E3),
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xff4C49ED),
                            borderRadius: BorderRadius.circular(6)),

                      ),
                    ),


                  ],
                ),
              ),

              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 40),
                      child: Text(
                        "Date",
                        style:
                        GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "Student Name",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40),
                      child: Text(
                        "Class",
                        style:
                        GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "Phone no",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 45),
                      child: Text(
                        "Parent name",
                        style:
                        GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "Last School",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 55.0, right: 62),
                      child: Text(
                        "L Marks",
                        style:
                        GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "Actions",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                //color: Colors.pink,
                width: 1000,
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8.0,),
                child: Container(

                  width: 1000,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(height: 50,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Admission")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData==null){
                            return Container();
                          }
                          if(!snapshot.hasData){
                            return Container();
                          }
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return  Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 28.0, right: 19),
                                    child: Text(snapshot.data!.docs[index]
                                    ["date"],selectionColor: Color(0xff109CF1),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 36.0,left: 20),
                                    child: Text(snapshot.data!.docs[index]
                                    ["name"]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 38.0),
                                    child: Text(snapshot.data!.docs[index]
                                    ["class"]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50.0, right: 30),
                                    child: Text(snapshot.data!.docs[index]
                                    ["phone"]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0,right: 50),
                                    child: Text(snapshot.data!.docs[index]
                                    ["parent"]),
                                  ),
                                  Text(snapshot.data!.docs[index]
                                  ["occupationlastschool"]),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0,right: 10),
                                    child: Text(snapshot.data!.docs[index]
                                    ["LMarks"]),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 20, top: 3),
                                   child: ElevatedButton(


                                     onPressed: () => _dialogBuilder(context),
                                     child:  Text('View'),

                                   ),


                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 3.0),
                                    child: Container(
                                      child: Center(
                                          child: Text(
                                            "Reject",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white),
                                          )),
                                      width: 60,
                                      height: 30,
                                      //color: Color(0xffD60A0B),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        color: Color(0xffD60A0B),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),


            ],
          ),
          width: 1376,
          height: 637,
          color: Color(0xffF5F5F5),
        )
      ],
    );


  }
  admin(){
    FirebaseFirestore.instance.collection("Admission").doc().set(
        {
          "name":name.text,
          "date":Date.text,
          "phone":phonr.text,
          "parent":parentname.text,
          "class":clas.text,
          "occupationlastschool":occupation.text,
          "LMarks":address.text
        });
  }
  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(

      context: context,

      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('Admissions Details',style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold),
          ),
          content: Container(child: Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name:",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 12),),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                    child: Text("Class:",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 12),),
                  ),
                  Text("Phone:",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 12),),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                    child: Text("Father Name:",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 12),),
                  ),
                  Text("Mother Name:",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 12),),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                    child: Text("Religion:",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 12),),
                  ),
                  Text("Caste:",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 12),),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                    child: Text("D.O.B:",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 12),),
                  ),
                  Text("Student Adhaar Number:",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 12),),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 148.0,right: 18),
                child: Image.asset("assets/line.png"),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Previous Marks Grade:",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                    child: Text(
                      "Previous School:",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Name Of Board:",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                    child: Text(
                      "Parent Occupation:",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Annual Income:",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                    child: Text(
                      "Home Address:",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(onTap: () {
                        Navigator.of(context).pop();
                      },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20,right: 20),
                          child: Container(
                            // color: Colors.yellow,
                            width: 120,
                            height: 30,
                            child: Center(child: Text("Enroll Now",style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),)),
                            decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)),

                          ),
                        ),
                      ),
                      GestureDetector(onTap: () {
                        Navigator.of(context).pop();
                      },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            // color: Colors.yellow,
                            width: 120,
                            height: 30,
                            child: Center(child: Text("Wait List",style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),)),
                            decoration: BoxDecoration(color: Color(0xffFFA002),borderRadius: BorderRadius.circular(12)),

                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            ],
          ),
            width: 630,
            height: 250,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),

          ),


        );
      },
    );
  }

}
