import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:show_up_animation/show_up_animation.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  bool view=false;
  String studentid="xpp6E6zMjHmlrEws7DC0";
  int gtcount= 36;
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return view== false?Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(child: Padding(
            padding: const EdgeInsets.only(left: 38.0,top: 30),
            child: Text("Students List",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
          ),
            //color: Colors.white,
            width: 1300,
            height: 80,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0,top: 20),
          child: Container(width: 1300,
            height:520,
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
                            child: Text("Register Number",style: GoogleFonts.poppins(fontSize: 15,)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0,right: 25),
                            child: Container(child: TextField(
                              style: GoogleFonts.poppins(
                                  fontSize: 15
                              ),
                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                border: InputBorder.none,
                              ),
                            ),
                              width: 350,
                              height: 40,
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
                            child: Text("Student Name",style: GoogleFonts.poppins(fontSize: 15,)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0,right: 25),
                            child: Container(child: TextField(
                              style: GoogleFonts.poppins(
                                  fontSize: 15
                              ),
                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                                border: InputBorder.none,
                              ),
                            ),
                              width: 350,
                              height: 40,
                              //color: Color(0xffDDDEEE),
                              decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                            ),
                          ),

                        ],

                      ),
                      Container(child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.search,color: Colors.white,size: 20,),
                          ),
                          Text("Search",style: GoogleFonts.poppins(color:Colors.white),),
                        ],
                      )),
                        width: 150,
                        height: 40,
                        // color:Color(0xff00A0E3),
                        decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height:50,
                    width: 1000,
                      decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                      ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0, right: 40),
                          child: Text(
                            "Reg NO",
                            style:
                            GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                        Text(
                          "Student Name",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, right: 40,),
                          child: Text(
                            "Class",
                            style:
                            GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                        Text(
                          "Section",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, right: 45),
                          child: Text(
                            "Father name",
                            style:
                            GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                        Text(
                          "Phone Number",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 55.0, right: 62),
                          child: Text(
                            "Gender",
                            style:
                            GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                        Text(
                          "Actions",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                      ],
                    ),
                    //color: Colors.pink,


                  ),
                ),

                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("Students").orderBy("timestamp").snapshots(),

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
                            return   Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 1000,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0, right: 0),
                                      child: Container(
                                        width: 100,

                                        alignment: Alignment.center,
                                        child: Text(
                                          value["regno"],
                                          style:
                                          GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30.0),
                                      child: Container(
                                        width: 140,


                                        child: Text(
                                          value["stname"],
                                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0, right: 0),
                                      child: Container(
                                        width: 60,

                                        child: Text(
                                          value["admitclass"],
                                          style:
                                          GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 13.0),
                                      child: Container(
                                        width: 60,

                                        alignment: Alignment.center,
                                        child: Text(
                                          value["section"],
                                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 50, right: 0),
                                      child: Container(
                                        width: 130,

                                        child: Text(
                                          value["fathername"],
                                          style:
                                          GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left:7.0),
                                      child: Container(
                                        width: 140,

                                        child: Text(
                                          value["mobile"],
                                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500,color:Colors.indigoAccent),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3.0, right: 0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 80,

                                        child: Row(
                                          children: [
                                            value["gender"]=="Male"?  Padding(
                                              padding: const EdgeInsets.only(right: 6.0),
                                              child: Icon(Icons.male_rounded,size: 20,),
                                            ):Padding(
                                              padding: const EdgeInsets.only(right: 6.0),
                                              child: Icon(Icons.female_rounded,size: 20,),
                                            ),
                                            Text(
                                              value["gender"],
                                              style:
                                              GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          studentid=value.id;
                                          view=true;
                                        });
                                      },
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(left: 45.0),
                                        child: Container(
                                          child: Center(
                                              child: Text(
                                                "View",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
                                              )),
                                          width: 60,
                                          height: 30,
                                          //color: Color(0xffD60A0B),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            color: Color(0xff53B175),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //color: Colors.pink,


                              ),
                            );
                          });

                    }),
              ],
            ),

          ),
        )
      ],
    ) :SingleChildScrollView(
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
                  width: 80,
                  height: 80,
                  child: Center(child:CircularProgressIndicator(),));
            }
            Map<String,dynamic>?value = snapshot.data!.data();
            return
              Padding(
                padding:EdgeInsets.only(left: width/93.3,top:height/50),
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
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    SizedBox(width:width/62.2),
                                    Material(
                                        elevation: 7,
                                        borderRadius: BorderRadius.circular(12),
                                        shadowColor:  Color(0xff53B175),
                                        child: Container(
                                          height: 80,
                                          width: 180,
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
                                              SizedBox(height: 10,),
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
                                SizedBox(height:height/20,),
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
                                  InkWell(
                                      onTap: (){
                                        setState(() {
                                          view=false;
                                        });
                                      },

                                      child: Icon(Icons.cancel,color: Colors.red,))
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
                                            width: 180,
                                            height: 40,
                                            // color:Color(0xff00A0E3),
                                            decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                                          ),
                                        ),
                                        SizedBox(width:width/10),
                                        GestureDetector(
                                          onTap: (){

                                          },
                                          child: Container(child: Center(child: Text("View Attendance Reports",style: GoogleFonts.poppins(color:Colors.white),)),
                                            width: 250,
                                            height: 40,
                                            // color:Color(0xff00A0E3),
                                            decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                                          ),
                                        ),
                                      ],),
                                  ),
                                  SizedBox(height:height/26.07,),
                                  Container(
                                    width: 600,
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
                                                  Text("Father Name: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),),
                                                  Text(value["fathername"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12),),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text("Mother Name: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),),
                                                Text(value["mothername"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12),),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text("Religion: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),),
                                                  Text(value["religion"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12),),

                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text("Community: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),),
                                                Text(value["community"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12),),

                                              ],
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(top: 20.0,bottom: 0),
                                              child: Row(
                                                children: [
                                                  Text("Sub Caste: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),),
                                                  Text(value["subcaste"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12),),

                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20.0,bottom: 0),
                                              child: Row(
                                                children: [
                                                  Text("Student Adhaar Number: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),),
                                                  Text(value["aadhaarno"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12),),

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
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["occupation"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
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
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  value["income"],
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
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
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["identificatiolmark"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
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
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["address"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
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
    );


  }
}
