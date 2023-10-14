import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class StaffAttendence extends StatefulWidget {
  const StaffAttendence({Key? key}) : super(key: key);

  @override
  State<StaffAttendence> createState() => _StaffAttendenceState();
}

class _StaffAttendenceState extends State<StaffAttendence> {


  String? _selectedCity;
  final TextEditingController _typeAheadControllerclass = TextEditingController();
  final TextEditingController _typeAheadControllersection = TextEditingController();
  final TextEditingController _typeAheadControllerstaffid = TextEditingController();
  TextEditingController date = new TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  static final List<String> classes = ["Select Option"];
  static final List<String> section = ["Select Option"];
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
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    setState(() {
      _typeAheadControllerclass.text="Select Option";
      _typeAheadControllersection.text="Select Option";
    });
    _tooltipBehavior = TooltipBehavior(enable: true);
    adddropdownvalue();

    // TODO: implement initState
    super.initState();
  }
  adddropdownvalue() async {
    var sudentsdocument = await  FirebaseFirestore.instance.collection("Staffs").get();
    setState(() {
      schooltotal=sudentsdocument.docs.length;
      classes.clear();
      section..clear();
    });
    var document = await  FirebaseFirestore.instance.collection("ClassMaster").orderBy("order").get();
    var document2 = await  FirebaseFirestore.instance.collection("SectionMaster").orderBy("order").get();
    var document3 = await  FirebaseFirestore.instance.collection("Staffs").orderBy("entryno").get();
    setState(() {
      classes.add("Select Option");
      section.add("Select Option");
    });
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

  String staffdocid="";
  String staffname="";
  getstaffbyid() async {
    print("fdgggggggggg");
    print(_typeAheadControllerstaffid.text);
    var document = await FirebaseFirestore.instance.collection("Staffs").get();
    for(int i=0;i<document.docs.length;i++){
      if(_typeAheadControllerstaffid.text==document.docs[i]["regno"]){
        setState(() {
          staffdocid= document.docs[i].id;
        }
        );
      }
    }
    print("fdgggggggggg");
    print(staffdocid);
    var staffdocument = await FirebaseFirestore.instance.collection("Staffs").doc(staffdocid).get();
    Map<String, dynamic>? value = staffdocument.data();
    setState(() {
      staffname=value!["stname"];
    });
    print("fdgggggggggg");
    print(staffname);

  }
  String selecteddate="";




  Successdialog(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'In-charge Staff Added Successfully',
      desc: 'For class - ${_typeAheadControllerclass.text} ${_typeAheadControllersection.text} is been added',

      btnCancelOnPress: () {

      },
      btnOkOnPress: () {


      },
    )..show();
  }

  final DateFormat formatter = DateFormat('dd.MM.yyy');


  int total=0;
  int present=0;
  int absent=0;
  int schooltotal=0;

  gettotal() async {
    var document=await FirebaseFirestore.instance.collection("Staffs").get();

    setState(() {
      total= document.docs.length;
      present=0;
      absent=0;
    });
    for(int i=0;i<document.docs.length;i++) {
      var document2=await FirebaseFirestore.instance.collection("Staffs").doc(document.docs[i].id).collection("Attendance").where("Date",isEqualTo: selecteddate).get();
      if(document2.docs.length>0){
        setState(() {
          present=present+1;

        });
        print("present");
      }
      else{
        print("absent");
        setState(() {

          absent=absent+1;
        });

      }

    }

  }


  bool view= false;
  bool absentonly= false;

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Container(child: Padding(
              padding: const EdgeInsets.only(left: 38.0,top: 30),
              child: Text("Staff Attendance Register",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
            ),
              //color: Colors.white,
              width: width/1.050,
              height: height/8.212,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
            ),
          ),

          Row(
            children: [
              SizedBox(width: 20,),
              Container(
                  width: 450,
                  child: SfCartesianChart(


                      primaryXAxis: CategoryAxis(),
                      // Chart title
                      title: ChartTitle(text: '       Monthly Staff Reports',textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black),alignment: ChartAlignment.near),
                      // Enable legend
                      legend: Legend(isVisible: true),
                      // Enable tooltip
                      tooltipBehavior: _tooltipBehavior,



                      series: <LineSeries<SalesData, String>>[

                        LineSeries<SalesData, String>(
                          name: "Staffs \nAttendance",
                          dataSource:  <SalesData>[
                         /*   SalesData('Jan', 35),
                            SalesData('Feb', 28),
                            SalesData('Mar', 34),
                            SalesData('Apr', 32),
                            SalesData('May', 40),
                            SalesData('June', 50),
                            SalesData('July', 50),
                            */
                          ],
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          color: Colors.green,
                          width: 5,
                          animationDuration: 2000,


                        )
                      ]
                  )
              ),
              Column(
                children: [
                  SizedBox(height: height/32.85,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  Column(
                          children: [
                            CircularPercentIndicator(
                              circularStrokeCap: CircularStrokeCap.round,
                              radius: 50.0,
                              lineWidth: 10.0,
                              percent:  0.0,
                              center:  Text("0%",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500)),
                              progressColor: Colors.green,
                            ),
                            Padding(
                              padding: const EdgeInsets.all( 8.0),
                              child:  ChoiceChip(

                                label: Text("  Regular  ",style: TextStyle(color: Colors.white),),


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

                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  Column(
                          children: [
                            CircularPercentIndicator(
                              circularStrokeCap: CircularStrokeCap.round,
                              radius: 50.0,
                              lineWidth: 10.0,
                              percent: 0.00,
                              center:  Text("0%",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500)),
                              progressColor: Colors.red,
                            ),
                            Padding(
                              padding: const EdgeInsets.all( 8.0),
                              child: ChoiceChip(

                                label: const Text("  Ir-regular  ",style: TextStyle(color: Colors.white),),


                                onSelected: (bool selected) {

                                  setState(() {

                                  });
                                },
                                selectedColor: Colors.red,
                                shape: StadiumBorder(
                                    side: BorderSide(
                                        color: Colors.red)),
                                backgroundColor: Colors.white,
                                labelStyle: TextStyle(color: Colors.black),

                                elevation: 1.5, selected: true,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height/32.85),

                ],
              ),
              SizedBox(width: 20,),
              Material(
                elevation: 7,
                borderRadius: BorderRadius.circular(12),
                shadowColor:  Color(0xff53B175),
                child: Container(
                  height: height/7.3,
                  width: width/5.464,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border:Border.all(color: Color(0xff53B175))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Total No.of Staffs",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),),
                      ChoiceChip(

                        label: Text("${schooltotal.toString()} Staffs",style: TextStyle(color: Colors.white),),


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
          Padding(
            padding: const EdgeInsets.only(left: 20.0,top: 20),
            child: Container(
              width: width/1.050,

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
                              child: Text("Date",style: GoogleFonts.poppins(fontSize: 15,)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0,right: 25),
                              child: Container(child:
                              TextField(
                                style:  GoogleFonts.poppins(
                                    fontSize: 15
                                ),
                                controller: date,
                                decoration: InputDecoration(


                                  prefixIcon: Icon(Icons.calendar_today,size: 17,),
                                  hintText: 'Date',


                                  contentPadding: EdgeInsets.only(left: 10,top: 8),
                                  border: InputBorder.none,
                                  //editing controller of this TextField
                                ),
                                readOnly: true,  //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context, initialDate: DateTime.now(),
                                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime.now()
                                  );

                                  if(pickedDate != null ){
                                    print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate = DateFormat('dd.MM.yyyy').format(pickedDate);
                                    String formattedDate2 = DateFormat('dd/M/yyyy').format(pickedDate);
                                    print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                    setState(() {
                                      date.text = formattedDate;
                                      selecteddate= formattedDate2;
                                      //set output date to TextField value.
                                    });
                                    print(selecteddate);
                                    gettotal();
                                    print("${_typeAheadControllerclass.text}""${_typeAheadControllerclass.text}");
                                  }else{
                                    print("Date is not selected");
                                  }
                                },
                              ),
                                width: width/6.83,
                                height: height/16.42,
                                //color: Color(0xffDDDEEE),
                                decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                              ),
                            ),

                          ],

                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              view=true;
                              absentonly=false;
                            });

                          },
                          child: Container(child: Center(child: Text("View All",style: GoogleFonts.poppins(color:Colors.white),)),
                            width: width/10.507,
                            height: height/16.425,
                            // color:Color(0xff00A0E3),
                            decoration: BoxDecoration(color: Color(0xff53B175),borderRadius: BorderRadius.circular(5)),

                          ),
                        ),
                       /* Padding(
                          padding: const EdgeInsets.only(left:25.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                absentonly=true;
                              });

                            },
                            child: Container(child: Center(child: Text("Absent only",style: GoogleFonts.poppins(color:Colors.white),)),
                              width: width/10.507,
                              height: height/16.425,
                              // color:Color(0xff00A0E3),
                              decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(5)),

                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: height/13.14,
                              width: width/2.101,

                              decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 20.0),
                                    child: Text("Staff ID",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40.0,right: 8.0),
                                    child: Text("Staff Name",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 80.0,right: 8.0),
                                    child: Text("Attendance",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                  ),
                                  /*Padding(
                                    padding: const EdgeInsets.only(left: 80.0,right: 8.0),
                                    child: Text("Time",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                  ),

                                   */
                                ],
                              ),

                            ),
                          ),
                          selecteddate!=""? view==true?  Container(
                            width: width/2.101,
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection("Staffs").orderBy("timestamp").snapshots(),

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
                                        return absentonly==false?

                                        Padding(
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

                                                      child: Text(value["regno"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                                                  child: Container(

                                                      width: width/6.2090,
                                                      child: Text(value["stname"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                                                  child: Container(

                                                      width: width/8.035,
                                                      child: StreamBuilder(
                                                        stream: FirebaseFirestore.instance.collection("Staffs").doc(value.id).collection("Attendance").where("Date",isEqualTo: selecteddate).snapshots(),
                                                        builder: (context,snap2) {
                                                          return Text(snap2.data!.docs.length==0? "Absent":"Present",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500,color: snap2.data!.docs.length==0? Colors.red:Colors.green),);
                                                        }
                                                      )),
                                                ),
                                               /* Padding(
                                                  padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                                                  child: Container(

                                                      width: width/13.66,
                                                      child: Text("View Staff",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500,color: Color(0xff00A0E3)),)),
                                                ),

                                                */
                                              ],
                                            ),

                                          ),
                                        ) : Container();
                                      });

                                }),
                          ) : Container(): Container(),
                          SizedBox(height: 20,)
                        ],
                      ),
                      Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,top:8.0),
                            child: Container(
                              height: height/13.14,
                              width: width/4.553,

                              decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                              ),
                              child: Center(child: Text("Reports",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),)),

                            ),
                          ),
                          SizedBox(height: height/32.85,),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:  Column(
                                  children: [
                                    CircularPercentIndicator(
                                      circularStrokeCap: CircularStrokeCap.round,
                                      radius: 45.0,
                                      lineWidth: 10.0,
                                      percent: total ==0? 0.70: (present/total*100)/100,
                                      center:  Text("${(present/total*100).toStringAsFixed(2)}%",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500)),
                                      progressColor: Colors.green,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all( 8.0),
                                      child:  ChoiceChip(

                                        label: Text(" ${present.toString()} Present  ",style: TextStyle(color: Colors.white),),


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

                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:  Column(
                                  children: [
                                    CircularPercentIndicator(
                                      circularStrokeCap: CircularStrokeCap.round,
                                      radius: 45.0,
                                      lineWidth: 10.0,
                                      percent: total ==0? 0.30: (absent/total*100)/100,
                                      center:  Text("${(absent/total*100).toStringAsFixed(2)}%",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500)),
                                      progressColor: Colors.red,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all( 8.0),
                                      child: ChoiceChip(

                                        label: Text(" ${absent.toString()} Absent  ",style: TextStyle(color: Colors.white),),


                                        onSelected: (bool selected) {

                                          setState(() {

                                          });
                                        },
                                        selectedColor: Colors.red,
                                        shape: StadiumBorder(
                                            side: BorderSide(
                                                color: Colors.red)),
                                        backgroundColor: Colors.white,
                                        labelStyle: TextStyle(color: Colors.black),

                                        elevation: 1.5, selected: true,),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height/32.85),
                          Material(
                            elevation: 7,
                            borderRadius: BorderRadius.circular(12),
                            shadowColor:  Color(0xff53B175),
                            child: Container(
                              height: height/7.3,
                              width: width/5.464,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border:Border.all(color: Color(0xff53B175))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Total No.of Staffs",style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),),
                                  ChoiceChip(

                                    label: Text("${total} Staffs",style: TextStyle(color: Colors.white),),


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
                    ],
                  ),



                ],
              ),

            ),
          )
        ],
      ),
    );
  }


  getstudents() async {

    var doceumenttotal= await FirebaseFirestore.instance.collection("Attendance").doc("${_typeAheadControllerclass.text}""${_typeAheadControllersection.text}").collection(selecteddate).orderBy("order").get();
    var doceumentpresent= await FirebaseFirestore.instance.collection("Attendance").doc("${_typeAheadControllerclass.text}""${_typeAheadControllersection.text}").collection(selecteddate).where("present",isEqualTo: true).get();
    var doceumentabsent= await FirebaseFirestore.instance.collection("Attendance").doc("${_typeAheadControllerclass.text}""${_typeAheadControllersection.text}").collection(selecteddate).where("present",isEqualTo: false).get();

    setState(() {
      total=doceumenttotal.docs.length;
      present=doceumentpresent.docs.length;
      absent=doceumentabsent.docs.length;
    });


  }
}
