import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:show_up_animation/show_up_animation.dart';

class Studentsearch extends StatefulWidget {
  const Studentsearch({Key? key}) : super(key: key);

  @override
  State<Studentsearch> createState() => _StudentsearchState();
}

class _StudentsearchState extends State<Studentsearch> {

  String? _selectedCity;
  final TextEditingController _typeAheadControllerregno = TextEditingController();
  final TextEditingController _typeAheadControllerstudent = TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  static final List<String> regno = [];
  static final List<String> student = [];


  static List<String> getSuggestionsregno(String query) {
    List<String> matches = <String>[];
    matches.addAll(regno);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionsstudent(String query) {
    List<String> matches = <String>[];
    matches.addAll(student);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  adddropdownvalue() async {
    var document = await  FirebaseFirestore.instance.collection("Students").orderBy("timestamp").get();
    var document2 = await  FirebaseFirestore.instance.collection("Students").orderBy("stname").get();
    for(int i=0;i<document.docs.length;i++) {
      setState(() {
        regno.add(document.docs[i]["regno"]);
      });

    }
    for(int i=0;i<document2.docs.length;i++) {
      setState(() {
        student.add(document2.docs[i]["stname"]);
      });

    }

  }

  getstaffbyid() async {
    print("fdgggggggggg");
    print(_typeAheadControllerregno.text);
    var document = await FirebaseFirestore.instance.collection("Students").get();
    for(int i=0;i<document.docs.length;i++){
      if(_typeAheadControllerregno.text==document.docs[i]["regno"]){
        setState(() {
          studentid= document.docs[i].id;
        }
        );
      }
    }
    print("fdgggggggggg");


  }
  getstaffbyid2() async {
    print("fdgggggggggg");
    print(_typeAheadControllerregno.text);
    var document = await FirebaseFirestore.instance.collection("Students").get();
    for(int i=0;i<document.docs.length;i++){
      if(_typeAheadControllerstudent.text==document.docs[i]["stname"]){
        setState(() {
          _typeAheadControllerregno.text= document.docs[i]["regno"];
        }
        );
      }
    }
    print("fdgggggggggg");


  }
  @override
  void initState() {
    adddropdownvalue();
    // TODO: implement initState
    super.initState();
  }
  String studentid="";

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Container(
              width: width/1.050,
              height: height/8.212,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
              child: Padding(
              padding: const EdgeInsets.only(left: 38.0,top: 30),
              child: Text("Search Student",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),),
            ),
            ),
          ),
          Padding(
        padding: const EdgeInsets.only(left: 20.0,top: 20),
        child: Container(
          width:  width/1.050,

        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
        child:  Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0,top:20,bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:0.0),
                        child: Text("Register Number",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0,right: 25),
                        child: Container(child:
                        TypeAheadFormField(


                          suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                              color: Color(0xffDDDEEE),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              )
                          ),

                          textFieldConfiguration: TextFieldConfiguration(
                            style:  GoogleFonts.poppins(
                                fontSize: width/91.066666667
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                              border: InputBorder.none,
                            ),
                            controller: this._typeAheadControllerregno,
                          ),
                          suggestionsCallback: (pattern) {
                            return getSuggestionsregno(pattern);
                          },
                          itemBuilder: (context, String suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },

                          transitionBuilder: (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          onSuggestionSelected: (String suggestion) {
                            setState(() {
                              this._typeAheadControllerregno.text = suggestion;
                            });

                           // getstaffbyid();
                           // getorderno();



                          },
                          suggestionsBoxController: suggestionBoxController,
                          validator: (value) =>
                          value!.isEmpty ? 'Please select a class' : null,
                          onSaved: (value) => this._selectedCity = value,
                        ),
                          width: width/3.902,
                          height: height/16.425,
                          //color: Color(0xffDDDEEE),
                          decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                        ),
                      ),

                    ],

                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:0.0),
                        child: Text("Student Name",style: GoogleFonts.poppins(fontSize: width/91.066666667,)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0,right: 25),
                        child: Container(
                          width: width/3.902,
                          height: height/16.425,
                          //color: Color(0xffDDDEEE),
                          decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                          child:
                        TypeAheadFormField(


                          suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                              color: Color(0xffDDDEEE),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              )
                          ),

                          textFieldConfiguration: TextFieldConfiguration(
                            style:  GoogleFonts.poppins(
                                fontSize: width/91.066666667
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                              border: InputBorder.none,
                            ),
                            controller: this._typeAheadControllerstudent,
                          ),
                          suggestionsCallback: (pattern) {
                            return getSuggestionsstudent(pattern);
                          },
                          itemBuilder: (context, String suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },

                          transitionBuilder: (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          onSuggestionSelected: (String suggestion) {
                            setState(() {
                              this._typeAheadControllerstudent.text = suggestion;
                            });

                          getstaffbyid2();




                          },
                          suggestionsBoxController: suggestionBoxController,
                          validator: (value) =>
                          value!.isEmpty ? 'Please select a class' : null,
                          onSaved: (value) => this._selectedCity = value,
                        ),

                        ),
                      ),

                    ],

                  ),
                  InkWell(
                    onTap: (){
                      getstaffbyid();
                    },
                    child: Container(child: Center(child: Text("Search",style: GoogleFonts.poppins(color:Colors.white),)),
                      width: width/10.507,
                      height: height/16.425,
                      // color:Color(0xff00A0E3),
                      decoration: BoxDecoration(color: const Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                    ),
                  ),
                ],
              ),
            ),
            studentid==""?Container():
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: SingleChildScrollView(
                child: ShowUpAnimation(
                  curve: Curves.fastOutSlowIn,
                  direction: Direction.horizontal,
                  delayStart: Duration(milliseconds: 200),
                  child:
                  FutureBuilder<dynamic>(
                    future: FirebaseFirestore.instance.collection('Students').doc(studentid).get(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData==null)
                      {
                        return Container(
                            width: width/17.075,
                            height: height/8.212,
                            child: Center(child:CircularProgressIndicator(),));
                      }
                      Map<String,dynamic>?value = snapshot.data!.data();
                      return
                        Padding(
                          padding:EdgeInsets.only(left: width/93.3,top:0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Material(
                                    elevation: 15,
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:Colors.white,
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      width: width/4.44,
                                      height: height/1.050,
                                      child: Column(
                                        children: [
                                          SizedBox(height:height/30,),
                                          GestureDetector(
                                            onTap: (){
                                              print(width);
                                            },
                                            child: CircleAvatar(
                                              radius: width/26.6666,
                                              backgroundImage:AssetImage("assets/profile.jpg"),

                                            ),
                                          ),

                                          SizedBox(height:height/52.15,),
                                          Center(
                                            child:Text('${value!['stname']}',style: GoogleFonts.montserrat(
                                                fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                            ),),
                                          ),
                                          SizedBox(height:height/130.3,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('Student ID :',style: GoogleFonts.montserrat(
                                                  fontWeight:FontWeight.w500,color: Colors.black,fontSize: width/124.4
                                              ),),
                                              Text(value['regno'],style: GoogleFonts.montserrat(
                                                  fontWeight:FontWeight.w500,color: Colors.black,fontSize: width/124.4
                                              ),),
                                            ],
                                          ),


                                          SizedBox(height:height/52.15),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(height:height/20.86),
                                              SizedBox(width:width/62.2),
                                              Text('Current Class',style: GoogleFonts.montserrat(
                                                  fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                              ),),
                                            ],
                                          ),
                                          SizedBox(height: height/65.7,),
                                          Row(
                                            children: [
                                              SizedBox(width:width/62.2),
                                              Material(
                                                elevation: 7,
                                                borderRadius: BorderRadius.circular(12),
                                                shadowColor:  Color(0xff53B175),
                                                child: Container(
                                                  height: height/8.212,
                                                  width: width/7.588,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      border:Border.all(color: Color(0xff53B175))
                                                  ),
                                                  child:  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("Class / Section",style:GoogleFonts.montserrat(
                                                          fontWeight:FontWeight.w600,color: Colors.black,fontSize:width/98.13
                                                      ),),
                                                      SizedBox(height: height/65.7,),
                                                      ChoiceChip(

                                                        label: Text("    ${value["admitclass"]} / ${value["section"]}    ",style: TextStyle(color: Colors.white),),


                                                        onSelected: (bool selected) {

                                                          setState(() {

                                                          });
                                                        },
                                                        selectedColor: Color(0xff53B175),
                                                        shape: StadiumBorder(
                                                            side: BorderSide(
                                                                color: Color(0xff53B175))),
                                                        backgroundColor: Colors.white,
                                                        labelStyle: TextStyle(color: Colors.black),

                                                        elevation: 1.5, selected: true,),
                                                    ],
                                                  ),

                                                ),


                                              ),
                                            ],
                                          ),
                                          Divider(),
                                          SizedBox(height:height/32.85,),
                                          Row(children: [
                                            SizedBox(width:width/62.2),
                                            Icon(Icons.email_outlined,),
                                            SizedBox(width:width/373.2),
                                            GestureDetector(onTap: (){

                                            },
                                              child: Text('${value["email"]}',style: GoogleFonts.montserrat(
                                                  fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/124.4
                                              ),),
                                            ),
                                          ],),
                                          SizedBox(height:height/34.76,),
                                          Row(children: [
                                            SizedBox(width:width/62.2),
                                            Icon(Icons.call,),
                                            SizedBox(width:width/373.2),
                                            GestureDetector(onTap: (){

                                            },
                                              child: Text('${value["mobile"]}',style: GoogleFonts.montserrat(
                                                  fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/124.4
                                              ),),
                                            ),
                                          ],),
                                          SizedBox(height:height/34.76,),
                                          Row(children: [
                                            SizedBox(width:width/62.2),
                                            Icon(Icons.calendar_month_sharp,),
                                            SizedBox(width:width/373.2),
                                            GestureDetector(onTap: (){

                                            },
                                              child: Text('${value["dob"]}',style: GoogleFonts.montserrat(
                                                  fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/124.4
                                              ),),
                                            ),
                                          ],),
                                          SizedBox(height:height/34.76,),
                                          Row(children: [
                                            SizedBox(width:width/62.2),
                                            value["gender"]=="Male"? Icon(Icons.male_rounded,) :Icon(Icons.female_rounded,),
                                            SizedBox(width:width/373.2),
                                            GestureDetector(onTap: (){

                                            },
                                              child: Text('${value["gender"]}',style: GoogleFonts.montserrat(
                                                  fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/124.4
                                              ),),
                                            ),
                                          ],),
                                          SizedBox(height:height/34.76,),
                                          Row(children: [
                                            SizedBox(width:width/62.2),
                                            Icon(Icons.bloodtype_rounded,) ,
                                            SizedBox(width:width/373.2),
                                            GestureDetector(onTap: (){

                                            },
                                              child: Text('${value["bloodgroup"]}',style: GoogleFonts.montserrat(
                                                  fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/124.4
                                              ),),
                                            ),
                                          ],),
                                          SizedBox(height:height/34.76,),




                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width:width/62.2,),
                              Column(
                                children: [
                                  Material(
                                    elevation: 15,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight:Radius.circular(15)  ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight:Radius.circular(15)  ),
                                        color: Colors.white,
                                      ),
                                      width:width/1.8600,
                                      height:height/19,
                                      child: Padding(
                                        padding: EdgeInsets.only(left:width/62.2,right:width/62.2),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Student  Details',style: GoogleFonts.montserrat(
                                              fontSize:width/81.13,fontWeight: FontWeight.bold,
                                            ),),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height:height/58,),
                                  Material(
                                    elevation: 15,
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15)  ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15)  ),
                                          color:Colors.white
                                      ),
                                      width:width/1.86,
                                      height: height/1.140,
                                      child: Padding(
                                        padding: EdgeInsets.only(left:width/62.2,right:width/62.2),
                                        child: Column(
                                          children: [
                                            SizedBox(height:height/40,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text('Performance',style: GoogleFonts.montserrat(
                                                    fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                ),),
                                              ],
                                            ),
                                            SizedBox(height:height/30,),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(color: Colors.red,width:width/186),

                                                        ),
                                                        height:height/8.69,
                                                        width:width/15.55,
                                                        child: Center(child: Text("50",style: GoogleFonts.montserrat(
                                                            fontWeight:FontWeight.bold,color: Colors.red,fontSize:width/53.31
                                                        ),)),
                                                      ),
                                                      SizedBox(width:width/186,),
                                                      Text('Exam Status ',style: GoogleFonts.montserrat(
                                                          fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                      ),),
                                                    ],),
                                                  SizedBox(width:width/14.35,),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            border: Border.all(color: Colors.green,width:width/186)
                                                        ),
                                                        height:height/8.69,
                                                        width:width/15.55,
                                                        child: Center(child: Text("20",style: GoogleFonts.montserrat(
                                                            fontWeight:FontWeight.bold,color: Colors.green,fontSize:width/53.31
                                                        ),)),
                                                      ),
                                                      SizedBox(width:width/186,),
                                                      Text('Attendance',style: GoogleFonts.montserrat(
                                                          fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                      ),),
                                                    ],),
                                                ],),
                                            ),
                                            SizedBox(height:height/26.07,),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){

                                                    },
                                                    child: Container(child: Center(child: Text("View Exam Reports",style: GoogleFonts.poppins(color:Colors.white),)),
                                                      width: width/7.588,
                                                      height: height/16.425,
                                                      // color:Color(0xff00A0E3),
                                                      decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                                                    ),
                                                  ),
                                                  SizedBox(width:width/10),
                                                  GestureDetector(
                                                    onTap: (){

                                                    },
                                                    child: Container(child: Center(child: Text("View Attendance Reports",style: GoogleFonts.poppins(color:Colors.white),)),
                                                      width: width/5.464,
                                                      height: height/16.425,
                                                      // color:Color(0xff00A0E3),
                                                      decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                                                    ),
                                                  ),
                                                ],),
                                            ),
                                            SizedBox(height:height/26.07,),
                                            Container(
                                              width: width/2.276,
                                              child: Divider(

                                                thickness: 2,
                                              ),
                                            ),

                                            SizedBox(height:height/100,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text('Personal Information',style: GoogleFonts.montserrat(
                                                    fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                ),),
                                              ],
                                            ),
                                            SizedBox(height:height/30,),
                                            Container(
                                              child:  Row(
                                                children: [
                                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 8.0,bottom: 20),
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            Text("Father Name: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/105.076923077),),
                                                            Text(value["fathername"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Text("Mother Name: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/105.076923077),),
                                                          Text(value["mothername"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 20.0,bottom: 20),
                                                        child: Row(
                                                          children: [
                                                            Text("Religion: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/105.076923077),),
                                                            Text(value["religion"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),),

                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text("Community: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/105.076923077),),
                                                          Text(value["community"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),),

                                                        ],
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 20.0,bottom: 0),
                                                        child: Row(
                                                          children: [
                                                            Text("Sub Caste: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/105.076923077),),
                                                            Text(value["subcaste"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),),

                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 20.0,bottom: 0),
                                                        child: Row(
                                                          children: [
                                                            Text("Student Adhaar Number: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: width/105.076923077),),
                                                            Text(value["aadhaarno"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: width/113.833333333),),

                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 70.0,right: 18),
                                                    child: Image.asset("assets/line.png"),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [



                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Parent Occupation: ",
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: width/105.076923077,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                            Text(
                                                              value["occupation"],
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: width/113.833333333,
                                                                  fontWeight: FontWeight.w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Annual Income: ",
                                                            style: GoogleFonts.poppins(
                                                                fontSize: width/113.833333333,
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          Text(
                                                            value["income"],
                                                            style: GoogleFonts.poppins(
                                                                fontSize: width/113.833333333,
                                                                fontWeight: FontWeight.w500),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top:20.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Identification Mark: ",
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: width/113.833333333,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                            Text(
                                                              value["identificatiolmark"],
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: width/113.833333333,
                                                                  fontWeight: FontWeight.w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 20.0,bottom: 8),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Home Address: ",
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: width/113.833333333,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                            Text(
                                                              value["address"],
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: width/113.833333333,
                                                                  fontWeight: FontWeight.w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: (){

                                                        },
                                                        child: Container(child: Center(child: Text("View Fees Reports",style: GoogleFonts.poppins(color:Colors.white,fontWeight: FontWeight.w600),)),
                                                          width: width/5.464,
                                                          height: height/16.425,
                                                          // color:Color(0xff00A0E3),
                                                          decoration: BoxDecoration(color: Color(0xffFFA002),borderRadius: BorderRadius.circular(5)),

                                                        ),
                                                      ),

                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                            SizedBox(height:height/26.07,),


                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],)
                            ],),
                        );
                    },
                  ),
                ),
              ),
            )
          ],
        ),

        ),
      ),


        ],
      ),
    );
  }
}
