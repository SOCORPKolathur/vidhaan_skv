import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:show_up_animation/show_up_animation.dart';

class StaffList extends StatefulWidget {
  const StaffList({Key? key}) : super(key: key);

  @override
  State<StaffList> createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {
  String studentid= "";
  bool view=false;

  String? _selectedCity;
  final TextEditingController _typeAheadControllerclass = TextEditingController();
  final TextEditingController _typeAheadControllersection = TextEditingController();
  final TextEditingController _typeAheadControllerstaffid = TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  static final List<String> classes = [];
  static final List<String> section = [];
  static final List<String> staffid = [];

  static List<String> getSuggestionsclass(String query) {
    List<String> matches = <String>[];
    matches.addAll(classes);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionssection(String query) {
    List<String> matches = <String>[];
    matches.addAll(section);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionsstaffid(String query) {
    List<String> matches = <String>[];
    matches.addAll(staffid);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  @override
  void initState() {
    adddropdownvalue();

    // TODO: implement initState
    super.initState();
  }
  String staffregno="";
  adddropdownvalue() async {
    setState(() {
      classes.clear();
      section.clear();
      staffid.clear();
    });
    var document = await  FirebaseFirestore.instance.collection("ClassMaster").orderBy("order").get();
    var document2 = await  FirebaseFirestore.instance.collection("SectionMaster").orderBy("order").get();
    var document3 = await  FirebaseFirestore.instance.collection("Staffs").orderBy("timestamp").get();
    for(int i=0;i<document.docs.length;i++) {
      setState(() {
        classes.add(document.docs[i]["name"]);
      });

    }
    for(int i=0;i<document2.docs.length;i++) {
      setState(() {
        section.add(document2.docs[i]["name"]);
      });

    }
    for(int i=0;i<document3.docs.length;i++) {
      setState(() {
        staffid.add(document3.docs[i]["regno"]);
      });

    }
  }


  bool mainconcent= false;
  final check = List<bool>.generate(1000, (int index) => false, growable: true);

  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
    return view==false? SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Container(child: Padding(
              padding: const EdgeInsets.only(left: 38.0,top: 30),
              child: Text("Staffs List",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
            ),
              //color: Colors.white,
              width: width/1.050,
              height: height/8.212,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0,top:15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right:0.0),
                      child: Text("Staff ID",style: GoogleFonts.poppins(fontSize: 15,)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0,right: 25),
                      child: Container(child:
                      TypeAheadFormField(

                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                            color: Color(0xffDDDEEE),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            )
                        ),

                        textFieldConfiguration: TextFieldConfiguration(
                          style:  GoogleFonts.poppins(
                              fontSize: 15
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10,bottom: 8),
                            border: InputBorder.none,
                          ),
                          controller: this._typeAheadControllerstaffid,
                        ),
                        suggestionsCallback: (pattern) {
                          return getSuggestionsstaffid(pattern);
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

                          this._typeAheadControllerstaffid.text = suggestion;
                        },
                        suggestionsBoxController: suggestionBoxController,
                        validator: (value) =>
                        value!.isEmpty ? 'Please select a section' : null,
                        onSaved: (value) => this._selectedCity = value,
                      ),
                        width: width/6.83,
                        height: height/16.425,
                        //color: Color(0xffDDDEEE),
                        decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                      ),
                    ),


                  ],

                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      staffregno=_typeAheadControllerstaffid.text;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Container(child: Center(child: Text("Search",style: GoogleFonts.poppins(color:Colors.white),)),
                      width: width/10.507,
                      height: height/16.425,
                      // color:Color(0xff00A0E3),
                      decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      staffregno="";
                      _typeAheadControllerstaffid.text="";
                    });
                  },
                  child: Container(child: Center(child: Text("Clear Search",style: GoogleFonts.poppins(color:Colors.white),)),
                    width: width/10.507,
                    height: height/16.425,
                    // color:Color(0xff00A0E3),
                    decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(5)),

                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0,top: 20),
            child: Container(
              width:  width/1.050,

              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height:height/13.14,
                      width: width/1.266,
                      decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Checkbox(
                                checkColor: Colors.white,
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
                            padding: const EdgeInsets.only(left: 35.0, right: 40),
                            child: Text(
                              "Reg NO",
                              style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                          ),
                          Text(
                            "Staff Name",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0, right: 40,),
                            child: Text(
                              "In Charge",
                              style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                          ),
                          Text(
                            "In Charge \n Section",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 80.0, right: 45),
                            child: Text(
                              "Email",
                              style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Text(
                              "Phone Number",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                            ),
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
                      stream: staffregno==""? FirebaseFirestore.instance.collection("Staffs").orderBy("timestamp").snapshots():
                      FirebaseFirestore.instance.collection("Staffs").where("regno",isEqualTo:staffregno).snapshots(),

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
                                  width: width/1.366,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
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
                                        padding: const EdgeInsets.only(left: 10.0, right: 0),
                                        child: Container(
                                          width: width/13.66,

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
                                          width: width/9.757,


                                          child: Text(
                                            value["stname"],
                                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0.0, right: 0),
                                        child: Container(
                                          width: width/22.766,

                                          child: Text(
                                            value["incharge"],
                                            style:
                                            GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 13.0),
                                        child: Container(
                                          width:width/22.766,

                                          alignment: Alignment.center,
                                          child: Text(
                                            value["inchargesec"],
                                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 50, right: 0),
                                        child: Container(
                                          width: width/7.207,
                                          child: Text(
                                            value["email"],
                                            style:
                                            GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:7.0),
                                        child: Container(
                                          width: width/9.7571,

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
                                          width: width/17.075,

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
                                            width: width/22.76,
                                            height: height/21.9,
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
          ),
        ],
      ),
    ) :  SingleChildScrollView(
      child: ShowUpAnimation(
        curve: Curves.fastOutSlowIn,
        direction: Direction.horizontal,
        delayStart: Duration(milliseconds: 200),
        child:
        FutureBuilder<dynamic>(
          future: FirebaseFirestore.instance.collection('Staffs').doc(studentid).get(),
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
                                    backgroundImage:NetworkImage(value!['imgurl']==""?"https://firebasestorage.googleapis.com/v0/b/vidhaan-4aee7.appspot.com/o/teacher.jpg?alt=media&token=1782c5a6-34c3-42ab-819f-07d52ea06014"
                                        :value['imgurl']),

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
                                    Text('Staff ID :',style: GoogleFonts.montserrat(
                                        fontWeight:FontWeight.w500,color: Colors.black,fontSize: width/124.4
                                    ),),
                                    Text(value['regno'],style: GoogleFonts.montserrat(
                                        fontWeight:FontWeight.w500,color: Colors.black,fontSize: width/124.4
                                    ),),
                                  ],
                                ),
                                SizedBox(height:height/52.15,),
                                GestureDetector(
                                  onTap: (){

                                  },

                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffFFB946),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    width: width/7.46,
                                    height:height/28,
                                    child: Center(child: Text("View Payroll",style: GoogleFonts.montserrat(
                                        fontWeight:FontWeight.bold,color: Colors.white,fontSize:width/103.6
                                    ),)),
                                  ),
                                ),


                                SizedBox(height:height/52.15),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height:height/20.86),
                                    SizedBox(width:width/62.2),
                                    Text('In Charge Class',style: GoogleFonts.montserrat(
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

                                              label: Text("    ${value["incharge"]} / ${value["inchargesec"]}    ",style: TextStyle(color: Colors.white),),


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
                                  Text('Staff  Details',style: GoogleFonts.montserrat(
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
                                  SizedBox(height:15,),
                                  Row(

                                    children: [
                                      InkWell(
                                        onTap: (){
                                          setState(() {
                                            //view1=3;
                                          });

                                        },
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(left: 0.0),
                                          child: Container(
                                            width: width/20.76,
                                            height: height/21.9,
                                            //color: Color(0xffD60A0B),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              color: Color(0xff53B175),
                                            ),
                                            child: Center(
                                                child: Text(
                                                  "Edit",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white),
                                                )),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          //deletestudent(studentid);
                                        },
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(left: 45.0),
                                          child: Container(
                                            width: width/20.76,
                                            height: height/21.9,
                                            //color: Color(0xffD60A0B),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              color: Colors.red,
                                            ),
                                            child: Center(
                                                child: Text(
                                                  "Delete",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),


                                  SizedBox(height:height/30,),
                                  Container(
                                    child:  Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text("Joined Date: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),),
                                                  Text(value["entrydate"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12),),
                                                ],
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Address: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 13,
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
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Community: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["community"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Phone Number: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["mobile"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Religion: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["religion"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text("Aadhaar No: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),),
                                                  Text(value["aadhaarno"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12),),
                                                ],
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Marital Status: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["Maritalstatus"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            value["Maritalstatus"]=="Single"    ?
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Parent Name: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["Spousename"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ):
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Spouse Name: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["Spousename"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Phone No: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["Spousephone"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Office Address: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["Spouseoffice"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Email: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["Spouseemail"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Aadhaar: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["Spouseaadhaar"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500),
                                                  ),
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
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20.0),
                                              child: Row(
                                                children: [
                                                  Text("Work Experience: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),),
                                                  Text(value["Work Experience"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12),),

                                                ],
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                                              child: Row(
                                                children: [
                                                  Text("Language Known: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),),
                                                  Text(value["Language Known"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12),),

                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text("Specialisation: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),),
                                                Text(value["Specialisation"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12),),

                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20.0,bottom: 0),
                                              child: Row(
                                                children: [
                                                  Text("School Last: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),),
                                                  Text(value["School Last"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12),),

                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20.0,bottom: 0),
                                              child: Row(
                                                children: [
                                                  Text("Handling Subject: ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),),
                                                  Text(value["Subject"],style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12),),

                                                ],
                                              ),
                                            ),



                                            Padding(
                                              padding: const EdgeInsets.only(top:20.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Seminar/Workshop: ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    value["Seminar/Workshop"],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height:height/30,),

                                            Container(
                                              child: Row(
                                                children: [
                                                  Column(
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
                                                      SizedBox(height:20,),
                                                      Text('Performance ',style: GoogleFonts.montserrat(
                                                          fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                      ),),
                                                    ],),
                                                  SizedBox(width:width/14.35,),
                                                  Column(
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
                                                      SizedBox(height:20,),
                                                      Text('Attendance',style: GoogleFonts.montserrat(
                                                          fontWeight:FontWeight.bold,color: Colors.black,fontSize:width/81.13
                                                      ),),
                                                    ],),
                                                ],),
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
