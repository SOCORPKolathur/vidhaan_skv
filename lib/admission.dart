import 'package:awesome_dialog/awesome_dialog.dart';
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

  bool mainconcent= false;
  final check = List<bool>.generate(1000, (int index) => false, growable: true);
  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
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
                        child: Text("Admissions Enquiries",
                            style: GoogleFonts.poppins(
                                color: Color(0xff000000),
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Center(
                              child: Text(
                                "Approved List",
                                style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),
                              )),
                          width: width/6.83,
                          //color: Color(0xff00A0E3),
                          height: height/16.425,
                          decoration: BoxDecoration(
                              color: Color(0xff53B175),
                              borderRadius: BorderRadius.circular(6)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Center(
                              child: Text(
                                "Waiting List",
                                style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),
                              )),
                          width: width/6.83,
                          //color: Color(0xff00A0E3),
                          height: height/16.425,
                          decoration: BoxDecoration(
                              color: Color(0xffFFA002),
                              borderRadius: BorderRadius.circular(6)),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          child: Center(
                              child: Text(
                                "Rejected List",
                                style:
                                GoogleFonts.poppins(color: Color(0xffFFFFFF)),
                              )),
                          width: width/6.83,
                          //color: Color(0xff00A0E3),
                          height: height/16.425,
                          decoration: BoxDecoration(
                              color: Color(0xffD60A0B),
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
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Checkbox(
                            value: mainconcent,
                            onChanged: (value){
                              setState(() {
                                mainconcent = value!;
                                for(int i=0;i<1000;i++) {
                                  check[i] = value!;
                                }

                              });

                        }
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 60),
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
                        padding: const EdgeInsets.only(left: 70.0, right: 40),
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
                        "Previous School",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Text(
                          "Actions",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  //color: Colors.pink,
                  width: width/1.366,
                  height: height/18.771,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0,),
                  child: Container(

                    width: width/1.366,
                    height: height/13.14,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(

                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Admission").orderBy("timestamp",descending: true)
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
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: Checkbox(

                                          value: check[index],

                                          onChanged: (bool? value){
                                            print(value);
                                            setState(() {
                                              check[index] = value!;
                                            });

                                          }
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 19),
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
                                      padding: const EdgeInsets.only(left: 45.0),
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
                                    ["lastschool"]),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 50.0, right: 20, top: 3),
                                     child: ElevatedButton(


                                       onPressed: () => _dialogBuilder(context),
                                       child:  Text('View'),

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
            width: width/0.9927,

            color: Color(0xffF5F5F5),
          )
        ],
      ),
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
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return showDialog(

      context: context,

      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('Admissions Details',style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold),
          ),
          content: Container(child:
          Row(
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
                  Text("Community:",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 12),),
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

                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                    child: Text(
                      "School Last studied:",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "% of Marks obtained:",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
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
                      "Residential Address:",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(onTap: () {
                        Navigator.of(context).pop();
                        Successdialog();
                      },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20,right: 20),
                          child: Container(
                            // color: Colors.yellow,
                            width: width/6.209,
                            height: height/21.9,
                            child: Center(child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Send Enrollment Link",style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(Icons.send,color: Colors.white,),
                                )
                              ],
                            )),
                            decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(7)),

                          ),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              Successdialog2();
                          },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                // color: Colors.yellow,
                                width: width/12.209,
                                height: height/21.9,
                                child: Center(child: Text("Waiting List",style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),)),
                                decoration: BoxDecoration(color: Color(0xffFFA002),borderRadius: BorderRadius.circular(7)),

                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              Successdialog3();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10,left: 20),
                              child: Container(
                                // color: Colors.yellow,
                                width: width/12.209,
                                height: height/21.9,
                                child: Center(child: Text("Reject",style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),)),
                                decoration: BoxDecoration(color: Color(0xffD60A0B),borderRadius: BorderRadius.circular(7)),

                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ],
              ),

            ],
          ),
            width: width/2.1682,
            height: height/2.628,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),

          ),


        );
      },
    );
  }
  Successdialog(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Enrollment Link has been Send Successfully',
      desc: '',


      btnOkText: "Ok",
      btnOkOnPress: () {

      },
    )..show();
  }
  Successdialog2(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: 'Admission has been assigned to waiting list ',
      desc: '',


      btnOkText: "Ok",
      btnOkOnPress: () {

      },
    )..show();
  }
  Successdialog3(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Admission has been rejected',
      desc: '',


      btnOkText: "Ok",
      btnOkOnPress: () {

      },
    )..show();
  }

}
