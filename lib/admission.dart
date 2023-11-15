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

  String schoolname="";
  String schoolphone="";

  String schooladdress="";
  String schoollogo="";
  String idcarddesign="";
  String solgan="";
  String imgurl="";
  getadmin() async {
    var document = await FirebaseFirestore.instance.collection("Admin").get();
    setState(() {
      schoolname=document.docs[0]["schoolname"];
      schoolphone=document.docs[0]["phone"];

      schooladdress=
      "${document.docs[0]["area"]} ${document.docs[0]["city"]} ${document.docs[0]["pincode"]}";
      schoollogo=document.docs[0]["logo"];
      idcarddesign=document.docs[0]["idcard"].toString();
      solgan=document.docs[0]["solgan"];
      imgurl=document.docs[0]["logo"];
    });
  }

  @override
  void initState() {
    getadmin();
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
                              print("hbasjdiub as");
                              sendEmail(docid,val['email'],"Complete Your Enrollment",
                                  '''Dear ${val['name']},
                                  
Congratulations on securing a place at ${schoolname}! We are excited to welcome you to our academic community.To proceed with your enrollment, please follow the steps outlined below:

Step 1: Access the Enrollment Link**
Click on the following link to access the enrollment portal: https://vidhaanadmissionform.firebaseapp.com/

Step 2: Fill in Mandatory Details**
Once logged in, you will find a section dedicated to enrollment details. Please ensure that you fill in all mandatory fields accurately. This information is crucial for our records and will help us provide you with the best possible educational experience.

Step 3: Upload Passport Size Photo**
As part of the enrollment process, we require a recent passport-size photo with a white background.

Please follow these guidelines for the photo:
- Size: Passport size
- Background: White
- Format: JPEG or PNG


Important Notes:
- Ensure all details provided are accurate and match the information in your official documents.
- Ensure the uploaded photo complies with the specified requirements.


Technical Assistance:
If you encounter any issues or require technical assistance during the enrollment process, please contact our support team at ${schoolphone}.

Your prompt attention to this matter is greatly appreciated, as it ensures a seamless start to your academic journey at ${schoolname}. We look forward to having you as part of our community.


Best regards,
${schoolname}

''');
                              Successdialog();
                              FirebaseFirestore.instance.collection('Admission').doc(docid).update({
                                "status" : "Approved"
                              });

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
                                currentIndex != 0?
                                GestureDetector(
                                  onTap: () {
                                    FirebaseFirestore.instance.collection('Admission').doc(docid).update({
                                      "status" : ""
                                    });
                                    Navigator.of(context).pop();
                                    sendEmail(docid,val['email'],"Application Status Update - Waiting List",

                                    '''Dear ${val['name']},

We hope this email finds you well. 

We would like to inform you that your application for ${val['previousclass']} Grade at ${schoolname} has been carefully reviewed. While we were impressed with your application, we regret to inform you that, at this time, your application has been placed on our waiting list.

Being on the waiting list means that we recognize your potential and would like to keep your application under consideration. As spaces become available, we will reevaluate our admissions and notify you promptly.

We appreciate your patience and understanding during this process. If you have any questions or require further information, please feel free to contact our admissions office.

Thank you for considering ${schoolname} for ${val['previousclass']} Grade. We appreciate your interest and look forward to the possibility of welcoming you to our school community.

Best regards,

Admin
${schoolname}'''
                                    );
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
                                ) : SizedBox(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    FirebaseFirestore.instance.collection('Admission').doc(docid).update({
                                      "status" : "Rejected"
                                    });
                                    sendEmail(docid,val['email'],"Application Status Update - Rejected",

                                        '''Dear ${val['name']},

We regret to inform you that after careful consideration, your application for ${val['previousclass']} Grade at ${schoolname} has been reviewed, and we are unable to offer you a placement at this time.

We appreciate the effort you put into your application and thank you for considering ${schoolname}. If you have any questions or would like feedback on your application, please feel free to reach out to Admin at ${schoolphone}.

We wish you the best in your future endeavors.

Sincerely,

Admin
${schoolname}
                                        ''');
                                    Successdialog3();
                                  },
                                  child: Padding(
                                    padding:  EdgeInsets.only(top: 10,left:  currentIndex != 0? 20 : 0),
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
    print("mail send");
    DocumentReference documentReferencer = FirebaseFirestore.instance.collection('mail').doc();
    var json = {
      "to": to,
      "message": {
        "subject": subject,
        "text": description,
      },
    };
    var result = await documentReferencer.set(json).whenComplete(() {

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
