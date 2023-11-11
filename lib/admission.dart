import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaan/profiledw.dart';


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

  List<DocumentSnapshot> pendingSnaps = [];
  List<DocumentSnapshot> approvedSnaps = [];
  List<DocumentSnapshot> rejectedSnaps = [];
  List<DocumentSnapshot> waitingListSnaps = [];
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

  int currentIndex = 0;
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
                                fontSize: width/68.3,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              currentIndex = 0;
                            });
                          },
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
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all( color: currentIndex == 0 ? Colors.white : Colors.transparent,width: 5),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              currentIndex = 1;
                            });
                          },
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
                                borderRadius: BorderRadius.circular(6),
                              border: Border.all( color: currentIndex == 1 ? Colors.white : Colors.transparent,width: 5),
                            ),
                          ),
                        ),
                      ),



                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              currentIndex = 2;
                            });
                          },
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
                                borderRadius: BorderRadius.circular(6),
                              border: Border.all( color: currentIndex == 2 ? Colors.white : Colors.transparent,width: 5),
                            ),
                          ),
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
                        padding: const EdgeInsets.only(left: 55.0, right: 80),
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
                        padding: const EdgeInsets.only(left: 60.0, right: 45),
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
                             pendingSnaps = [];
                            approvedSnaps = [];
                            rejectedSnaps = [];
                            waitingListSnaps = [];
                            snapshot.data!.docs.forEach((element) {
                              if(element.get("status").toString().toLowerCase() == "approved"){
                                approvedSnaps.add(element);
                              }else if(element.get("status").toString().toLowerCase() == "rejected"){
                                rejectedSnaps.add(element);
                              }else if(element.get("status").toString().toLowerCase() == "waiting"){
                                rejectedSnaps.add(element);
                              }else{
                                pendingSnaps.add(element);
                              }
                            });
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: currentIndex == 1 ? approvedSnaps.length : currentIndex == 2 ? rejectedSnaps.length : pendingSnaps.length,
                              itemBuilder: (context, index) {
                                var data = currentIndex == 1 ? approvedSnaps[index] : currentIndex == 2 ? rejectedSnaps[index] : pendingSnaps[index];
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
                                      padding: const EdgeInsets.only(),
                                      child: Container(
                                        width:120,
                                        child: Text(data["date"],selectionColor: Color(0xff109CF1),),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          ),
                                      child: Container(
                                        width:150,
                                        child: Text(data["name"]),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(),
                                      child: Container(
                                        width:100,
                                        child: Text(data["previousclass"]),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          ),
                                      child: Container(
                                        width:140,
                                        child: Text(data["contact"]),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(),
                                      child: Container(
                                        width:160,
                                        child: Text(data["father"]),
                                      ),
                                    ),
                                    Container(
                                      width:120,
                                      child: Text(data["previousschool"]),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 40.0, right: 20, top: 3),
                                     child: ElevatedButton(
                                       style: ButtonStyle(
                                backgroundColor:currentIndex == 1? MaterialStateProperty.all<Color>(Colors.green) : currentIndex == 0? MaterialStateProperty.all<Color>(Colors.blue)
                                    :MaterialStateProperty.all<Color>(Colors.red)
                                ),
                                       onPressed: () => _dialogBuilder(context,data.id),
                                       child:  Text(currentIndex == 1? 'Approved' :currentIndex == 0? 'View':"Rejected"),

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
  Future<void> _dialogBuilder(BuildContext context,docid) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('Admissions Details',style: GoogleFonts.poppins(fontSize: width/68.3,fontWeight: FontWeight.bold),
          ),
          content: FutureBuilder(
            future:  FirebaseFirestore.instance.collection("Admission").doc(docid).get(),
            builder: (context,snap)
            {
              Map<String,dynamic> ? val = snap.data!.data();
              return Container(
                width: width/1.5682,
                height: height/1.828,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child:
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 180,
                                child: Text(
                                  "Name:  ",
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),
                                ),
                            ),
                            Text(
                              ":   ",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),
                            ),
                            Container(
                                width: 200,
                                child: Text(val!["name"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 180,
                                  child: Text("DOB",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),)),
                              Text(
                                ":   ",
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),
                              ),
                              Container(
                                  width: 200,
                                  child: Text(val["dob"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),)),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 180,
                                child: Text("Previous Class",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),)),
                            Text(
                              ":   ",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),
                            ),
                            Container(
                                width: 200,
                                child: Text(val["previousclass"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),)),

                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 180,
                                  child: Text("Previous School",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),)),
                              Text(
                                ":   ",
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),
                              ),
                              Container(
                                  width: 200,
                                  child: Text(val["previousschool"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),)),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 180,
                                child: Text("Curriculum",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),)),
                            Text(
                              ":   ",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),
                            ),
                            Container(

                                width: 200,
                                child: Text(val["curriculum"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 180,
                                  child: Text("Reason for transfer",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),)),
                              Text(
                                ":   ",
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),
                              ),
                              Container(

                                  width: 200,
                                  child: Text(val["reason"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),)),

                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 180,
                                child: Text("Contact number",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),)),
                            Text(
                              ":   ",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),
                            ),
                            Container(

                                width: 200,
                                child: Text(val["contact"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),)),

                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 180,
                                child: Text("Email",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),)),
                            Text(
                              ":   ",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),
                            ),
                            Container(

                                width: 200,
                                child: Text(val["email"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),)),

                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 180,
                                child: Text("Residential address",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),)),
                            Text(
                              ":   ",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),
                            ),
                            Container(
                                width: 200,
                                child: Text(val["address"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),)),

                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 18),
                      child: Image.asset("assets/line.png"),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 180,
                                child: Text(
                                  "Father name",
                                  style: GoogleFonts.poppins(
                                      fontSize: width/113.833333333,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                ":   ",
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),
                              ),
                              Container(
                                  width: 200,
                                  child: Text(val["father"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),)),

                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 180,
                              child: Text(
                                "Occupation",
                                style: GoogleFonts.poppins(
                                    fontSize: width/113.833333333,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              ":   ",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),
                            ),
                            Container(

                                width: 200,
                                child: Text(val["fatheroccupation"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),)),

                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                width: 180,
                                child: Text(
                                  "Qualification",
                                  style: GoogleFonts.poppins(
                                      fontSize: width/113.833333333,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Text(
                              ":   ",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),
                            ),
                            Container(

                                width: 200,
                                child: Text(val["fatherqualification"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),)),

                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 180,
                              child: Text(
                                "Mother name",
                                style: GoogleFonts.poppins(
                                    fontSize: width/113.833333333,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              ":   ",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),
                            ),
                            Container(
                                width: 200,

                                child: Text(val["mother"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),)),

                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                width: 180,
                                child: Text(
                                  "Occupation",
                                  style: GoogleFonts.poppins(
                                      fontSize: width/113.833333333,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Text(
                              ":   ",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),
                            ),
                            Container(

                                width: 200,
                                child: Text(val["motheroccupation"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),)),

                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                width: 180,
                                child: Text(
                                  "Qualification",
                                  style: GoogleFonts.poppins(
                                      fontSize: width/113.833333333,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Text(
                              ":   ",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),
                            ),
                            Container(

                                width: 200,
                                child: Text(val["motherqualification"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),)),

                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                width: 180,
                                child: Text(
                                  "Annual income",
                                  style: GoogleFonts.poppins(
                                      fontSize: width/113.833333333,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Text(
                              ":   ",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/113.833333333),
                            ),
                            Container(
                                width: 200,
                                child: Text(val["annualincome"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),)),

                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            currentIndex != 1 ?  GestureDetector(
                              onTap: () {
                              Navigator.of(context).pop();
                              sendEmail(docid,val['email'],"Enrollment link - Vidhaan","https://vidhaanadmissionform.web.app \n Please click the above link to enroll");
                            },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20,right: 20),
                                child: Container(
                                  // color: Colors.yellow,
                                  width: width/5.705,
                                  height: height/21.9,
                                  child: Center(child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Send Enrollment Link",style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15.0),
                                        child: Icon(Icons.send,color: Colors.white,),
                                      )
                                    ],
                                  )),
                                  decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(7)),

                                ),
                              ),
                            ) :SizedBox(),
                            currentIndex != 2 ?    Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    sendEmail(docid,val['email'],"Your Application is on waiting list - Vidhaan","Please wait your application on waiting list");
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
                                    FirebaseFirestore.instance.collection('Admission').doc(docid).update({
                                      "status" : "Rejected"
                                    });
                                    sendEmail(docid,val['email'],"Your Application Rejected - Vidhaan","Sorry, Your application was rejected");
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
                            ) : SizedBox()

                          ],
                        ),
                      ],
                    ),

                  ],
                ),

              );
            }
          ),


        );
      },
    );
  }

  sendEmail(String docid,String to, String subject, String description) async {
    DocumentReference documentReferencer = FirebaseFirestore.instance.collection('mail').doc();
    var json = {
      "to": to,
      "message": {
        "subject": subject,
        "text": description,
      },
    };
    var result = await documentReferencer.set(json).whenComplete(() {
      Successdialog();
      FirebaseFirestore.instance.collection('Admission').doc(docid).update({
        "status" : "Approved"
      });
    }).catchError((e) {

    });
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
