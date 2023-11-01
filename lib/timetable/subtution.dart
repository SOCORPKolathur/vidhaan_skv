import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vidhaan/modules/home/controllers/home_controller.dart';

class Subtution extends StatefulWidget {
  const Subtution({Key? key}) : super(key: key);

  @override
  State<Subtution> createState() => _SubtutionState();
}

class _SubtutionState extends State<Subtution>
    with SingleTickerProviderStateMixin {
  bool view = false;
  String staffid = "";
  String staffname = "";
  TabController? tabController;

  List<String> staffRegNos = [];
  List<String> staffNames = [];
  List<SubstitutionModel> substitutionsList = [];
  @override
  void initState() {
    getdate();
    firstcall();
    adddropvalue();
    tabController = TabController(length: 2, vsync: this);
    // TODO: implement initState
    super.initState();
  }
  final homecontroller = Get.put(HomeController());
  final TextEditingController _typeAheadControllerclass =
      TextEditingController();

  final textediting = List<TextEditingController>.generate(
      200, (int index) => TextEditingController(),
      growable: true);
  final textediting2 = List<TextEditingController>.generate(
      200, (int index) => TextEditingController(),
      growable: true);
  static final classes =
      List<List<String>>.generate(200, (int index) => [], growable: true);

  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();

  static List<String> getSuggestionsclass(String query, index) {
    List<String> matches = <String>[];
    matches.addAll(classes[index]);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  adddropvalue() async {
    setState(() {
      classes.clear();
      section.clear();
    });
    var document3 = await FirebaseFirestore.instance
        .collection("ClassMaster")
        .orderBy("order")
        .get();
    var document2 = await FirebaseFirestore.instance
        .collection("SectionMaster")
        .orderBy("order")
        .get();
    for (int i = 0; i < document3.docs.length; i++) {
      setState(() {
        classes.add(document3.docs[i]["name"]);
      });
    }
    for (int i = 0; i < document2.docs.length; i++) {
      setState(() {
        section.add(document2.docs[i]["name"]);
      });
    }
  }

  Future<List<String>> staffdroup(int index) async {
    print(index.toString() + "__________________________________________________________________index");
    List<String> ids = [];
    List<String> names = [];
    List<int> subtitutePeriods = [];
    var leaveAppliedStaff = await FirebaseFirestore.instance.collection("Staffs").doc(staffid).collection("Timetable").where("day", isEqualTo: day).get();
    leaveAppliedStaff.docs.forEach((element) {
      subtitutePeriods.add(element.get("period"));
    });
    var staffs = await FirebaseFirestore.instance.collection("Staffs").get();
    staffs.docs.forEach((staff) async { 
      if(staff.id != staffid){
        var timetables = await FirebaseFirestore.instance.collection("Staffs").doc(staff.id).collection('Timetable').where("day", isEqualTo: day).get();
        // timetables.docs.forEach((timetable) {
        //   ids.add(staff.get("stname"));
        //   names.add(staff.get("regno"));
        //   //}
        // });
        // if(timetables.docs.length != 8){
        //   ids.add(staff.get("stname"));
        //   names.add(staff.get("regno"));
        // }
        print(subtitutePeriods.length.toString() + "____________________________________________________length");
        print(subtitutePeriods[index].toString() + "____________________________________________________element");
        Iterable<QueryDocumentSnapshot<Map<String, dynamic>>> isHave = timetables.docs.where((element) => element.get("period") == subtitutePeriods[index]);
        if(isHave.isEmpty){
          ids.add(staff.get("stname"));
          names.add(staff.get("regno"));
        }
      }
    });
    await Future.delayed(Duration(seconds: 30));
    staffNames.addAll(names);
    staffRegNos.addAll(ids);
    setState(() {
      view = true;
    });

    return names;
    
    // var documentmain = await FirebaseFirestore.instance.collection("Staffs").doc(staffid).collection("Timetable").orderBy("period").get();
    // var document = await FirebaseFirestore.instance.collection("Staffs").orderBy("entryno").get();
    // for (int i = 0; i < documentmain.docs.length; i++) {
    //   print("Loop Ok 01");
    //   if (documentmain.docs[i]["day"] == day) {
    //     print("Loop Ok 02");
    //     for (int j = 0; j < document.docs.length; j++) {
    //       print("Loop Ok 03");
    //       if (document.docs[j]["absent"] == false) {
    //         print("Loop Ok 01");
    //         var documentmain2 = await FirebaseFirestore.instance
    //             .collection("Staffs")
    //             .doc(document.docs[j].id)
    //             .collection("Timetable")
    //             .where("day", isEqualTo: day)
    //             .where("period", isEqualTo: documentmain.docs[i]["period"])
    //             .get();
    //         if (documentmain2.docs.length > 0) {
    //           print("Staff has period");
    //         } else {
    //           setState(() {
    //             staffidn[documentmain.docs[i]["period"]].clear();
    //             staffid2[documentmain.docs[i]["period"]].clear();
    //           });
    //           print("List Cleared");
    //           setState(() {
    //             //staffidn[documentmain.docs[i]["period"]].add(document.docs[j]["regno"]);
    //             //staffid2[documentmain.docs[i]["period"]].add(document.docs[j]["stname"]);
    //           });
    //         }
    //       }
    //     }
    //   }
    //}


/*    var userdoc= await FirebaseFirestore.instance.collection('Staffs').doc("").get();
    Map<String,dynamic> ? val = userdoc.data();
    homecontroller.sendPushMessage(val!["token"],

        "Dear ${val!["stnmae"]},\nPlease be informed that your presence is required for the class ${classes} - ${textediting} and you are responsible for on  ${val["date"] ==
            "${DateTime.now().year}-${ DateTime.now().month}-${ DateTime.now().day +
                1}" ? "Tomorrow":val["date"] ==  "${DateTime.now().year}-${ DateTime.now().month}-${ DateTime.now().day}"? "Today": val["date"] }. You will be supporting the session, and your guidance or input during the class would be greatly appreciated to ensure a smooth continuation of the curriculum.",
        "Substitute Teacher Notification");*/

  }

  String classid = "";

  firstcall() async {
    var document3 = await FirebaseFirestore.instance
        .collection("ClassMaster")
        .orderBy("order")
        .get();
    var document = await FirebaseFirestore.instance
        .collection("SectionMaster")
        .orderBy("order")
        .get();
    setState(() {
      _typeAheadControllerclass.text = document3.docs[0]["name"];
      _typeAheadControllersection.text = document.docs[0]["name"];
      classid = document3.docs[0].id;
    });
  }

  getstaffbyid() async {
    print("fdgggggggggg");

    var document =
        await FirebaseFirestore.instance.collection("ClassMaster").get();
    for (int i = 0; i < document.docs.length; i++) {
      if (_typeAheadControllerclass.text == document.docs[i]["name"]) {
        setState(() {
          classid = document.docs[i].id;
        });
      }
    }
    print("fdgggggggggg");
  }

  getstaffbyid2(value, index) async {
    print("fdgggggggggg");

    var document = await FirebaseFirestore.instance.collection("Staffs").get();
    for (int i = 0; i < document.docs.length; i++) {
      if (value == document.docs[i]["regno"]) {
        setState(() {
          textediting2[index].text = document.docs[i]["stname"];
        });
      }
    }
    print("fdgggggggggg");
  }

  getstaffbyid3(value, index) async {
    print("fdgggggggggg");

    var document = await FirebaseFirestore.instance.collection("Staffs").get();
    for (int i = 0; i < document.docs.length; i++) {
      if (value == document.docs[i]["stname"]) {
        setState(() {
          textediting[index].text = document.docs[i]["regno"];
        });
      }
    }
    print("fdgggggggggg");
  }

  static final staffidn =
      List<List<String>>.generate(200, (int index) => [], growable: true);
  static final staffid2 =
      List<List<String>>.generate(200, (int index) => [], growable: true);

  List<String> getSuggestionsstaffid(String query, index) {
    List<String> matches = <String>[];
    staffNames.forEach((element) {
      if(!matches.contains(element)){
        matches.add(element);
      }
    });
    //matches.addAll(staffidn[index]);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  List<String> getSuggestionsstaffname(String query, index) {
    List<String> matches = <String>[];
    staffRegNos.forEach((element) {
      if(!matches.contains(element)){
        matches.add(element);
      }
    });
    //matches.addAll(staffid2[index]);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  static final List<String> section = [];
  final TextEditingController _typeAheadControllersection =
      TextEditingController();

  static List<String> getSuggestionssection(String query) {
    List<String> matches = <String>[];
    matches.addAll(section);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return view == false
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 38.0, top: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Substitution Teachers",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 500),
                        InkWell(
                          onTap: () {
                            // getstaffbyid();
                            setState(() {
                              //  viewtem=true;
                            });
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(5),
                            elevation: 7,
                            child: Container(
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.history,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "View Substitution History",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                ],
                              )),
                              width: width / 5.507,
                              height: height / 16.425,
                              // color:Color(0xff00A0E3),
                              decoration: BoxDecoration(
                                  color: const Color(0xff53B175),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //color: Colors.white,
                  width: width / 1.366,
                  height: height / 8.212,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: TabBar(
                  isScrollable: false,
                  controller: tabController,
                  labelColor: Color(0xff00A0E3),
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Color(0xff00A0E3),
                  indicatorPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  labelPadding: const EdgeInsets.all(0),
                  splashBorderRadius: BorderRadius.zero,
                  splashFactory: NoSplash.splashFactory,
                  labelStyle: GoogleFonts.openSans(
                    fontWeight: FontWeight.w800,
                  ),
                  unselectedLabelStyle: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                  ),
                  onTap: (index) {
                    // setState(() {
                    //   selectTabIndex = index;
                    //   isLoading = true;
                    // });
                  },
                  tabs: const [
                    Tab(
                      child: Text("Applied Leaves"),
                    ),
                    Tab(
                      child: Text("Sudden Leaves"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: width,
                  child: TabBarView(
                    controller: tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: height / 13.14,
                              width: width / 1.366,
                              decoration: BoxDecoration(
                                  color: Color(0xff00A0E3),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 35.0, right: 40),
                                    child: Text(
                                      "Reg NO",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    "Staff Name",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 40.0,
                                      right: 40,
                                    ),
                                    child: Text(
                                      "In Charge",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    "In Charge \n Section",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 80.0, right: 45),
                                    child: Text(
                                      "Today Handling hours",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    "Actions",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              //color: Colors.pink,
                            ),
                          ),
                          FutureBuilder<List<DocumentSnapshot>>(
                              future: getAppliedLeaves(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (snapshot.hasData == null) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      var value = snapshot.data![index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: width / 1.366,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 67.0, right: 0),
                                                child: Container(
                                                  width: width / 13.66,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    value["regno"],
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30.0),
                                                child: Container(
                                                  width: width / 9.757,
                                                  child: Text(
                                                    value["stname"],
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0.0, right: 0),
                                                child: Container(
                                                  width: width / 22.766,
                                                  child: Text(
                                                    value["incharge"],
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 13.0),
                                                child: Container(
                                                  width: width / 22.766,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    value["inchargesec"],
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 150, right: 0),
                                                child: Container(
                                                    child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection("Staffs")
                                                      .doc(value.id)
                                                      .collection("Timetable")
                                                      .where("day", isEqualTo: day)
                                                      .snapshots(),
                                                  builder: (context, snap) {
                                                    return Text(
                                                      snap.data!.docs.length
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    );
                                                  },
                                                )),
                                              ),
                                              value["substitutionAssigned"] == DateFormat("dd/MM/yyyy").format(DateTime.now())
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 110.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          child: Center(
                                                              child: Text(
                                                            "Staffs Assigned",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .white),
                                                          )),
                                                          width: width / 9.76,
                                                          height: height / 21.9,
                                                          //color: Color(0xffD60A0B),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: Color(
                                                                0xff53B175),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                   :  Padding(
                                      padding: const EdgeInsets.only(left: 110.0),
                                      child: InkWell(
                                      onTap: () {
                                      setState(() {
                                      staffid = value.id;
                                      staffname = value["stname"];
                                      view = true;
                                      });
                                      },
                                      child: Container(
                                      child: Center(
                                      child: Text(
                                      "Yet to Assign",
                                      style: GoogleFonts
                                          .poppins(
                                      color: Colors
                                          .white),
                                      )),
                                      width: width / 9.76,
                                      height: height / 21.9,
                                      //color: Color(0xffD60A0B),
                                      decoration:
                                      BoxDecoration(
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                      5),
                                      color: Color(0xfffcba03),
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
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: height / 13.14,
                              width: width / 1.366,
                              decoration: BoxDecoration(
                                  color: Color(0xff00A0E3),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 35.0, right: 40),
                                    child: Text(
                                      "Reg NO",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    "Staff Name",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 40.0,
                                      right: 40,
                                    ),
                                    child: Text(
                                      "In Charge",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    "In Charge \n Section",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 80.0, right: 45),
                                    child: Text(
                                      "Today Handling hours",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    "Actions",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              //color: Colors.pink,
                            ),
                          ),
                          FutureBuilder<List<DocumentSnapshot>>(
                              future: getSuddenLeaves(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (snapshot.hasData == null) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      var value = snapshot.data![index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: width / 1.366,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 0),
                                                child: Container(
                                                  width: width / 13.66,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    value["regno"],
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30.0),
                                                child: Container(
                                                  width: width / 9.757,
                                                  child: Text(
                                                    value["stname"],
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0.0, right: 0),
                                                child: Container(
                                                  width: width / 22.766,
                                                  child: Text(
                                                    value["incharge"],
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 13.0),
                                                child: Container(
                                                  width: width / 22.766,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    value["inchargesec"],
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 150, right: 0),
                                                child: Container(
                                                    child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection("Staffs")
                                                      .doc(value.id)
                                                      .collection("Timetable")
                                                      .where("day",
                                                          isEqualTo: day)
                                                      .snapshots(),
                                                  builder: (context, snap) {
                                                    return Text(
                                                      snap.data!.docs.length
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    );
                                                  },
                                                )),
                                              ),
                                              value["classasigned"] == true
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 130.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            staffid = value.id;
                                                            staffname =
                                                                value["stname"];
                                                            view = true;
                                                          });
                                                          //staffdroup();
                                                        },
                                                        child: Container(
                                                          child: Center(
                                                              child: Text(
                                                            "Assign Staffs",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .white),
                                                          )),
                                                          width: width / 9.76,
                                                          height: height / 21.9,
                                                          //color: Color(0xffD60A0B),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 130.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          child: Center(
                                                              child: Text(
                                                            "Staffs Assigned",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .white),
                                                          )),
                                                          width: width / 9.76,
                                                          height: height / 21.9,
                                                          //color: Color(0xffD60A0B),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: Color(
                                                                0xff53B175),
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
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 38.0, top: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Assign Teachers",
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    //color: Colors.white,
                    width: width / 1.050,
                    height: height / 8.212,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                view = false;
                              });
                            },
                            child: Icon(Icons.arrow_back_rounded)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 0),
                        child: Text(
                          staffname,
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 550,
                      ),
                      GestureDetector(
                        onTap: () {
                          updateSubstitutionTeachers(substitutionsList);
                        },
                        child: Container(
                          child: Center(
                              child: Text(
                            "Save",
                            style: GoogleFonts.poppins(color: Colors.white),
                          )),
                          width: width / 10.507,
                          height: height / 16.425,
                          // color:Color(0xff00A0E3),
                          decoration: BoxDecoration(
                              color: Color(0xff00A0E3),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: height / 13.14,
                    width: width / 1.366,
                    decoration: BoxDecoration(
                        color: Color(0xff00A0E3),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0, right: 40),
                          child: Text(
                            "Period No:",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          "Class",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 40.0,
                            right: 40,
                          ),
                          child: Text(
                            "Section",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          "Subject",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 80.0, right: 145),
                          child: Text(
                            "Staff ID",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          "Staff Name",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                    //color: Colors.pink,
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Staffs")
                        .doc(staffid)
                        .collection("Timetable")
                        .orderBy("period")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      List<DocumentSnapshot> snaps = [];
                      snapshot.data!.docs.forEach((element) {
                        if(element.get("day") == day){
                          snaps.add(element);
                        }
                      });
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snaps.length,
                          itemBuilder: (context, index) {
                            var value = snaps[index];
                            return
                              // value["day"] == day
                              //   ?
                            Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: width / 1.366,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 0),
                                            child: Container(
                                              width: width / 13.66,
                                              alignment: Alignment.center,
                                              child: Text(
                                                ((value["period"]
                                                            .remainder(8)) +
                                                        1)
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30.0),
                                            child: Container(
                                              width: width / 13.757,
                                              child: Text(
                                                value["class"],
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0.0, right: 0),
                                            child: Container(
                                              width: width / 22.766,
                                              child: Text(
                                                value["section"],
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 13.0),
                                            child: Container(
                                              width: width / 22.766,
                                              alignment: Alignment.center,
                                              child: Text(
                                                value["subject"],
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30.0),
                                            child: Container(
                                              width: width / 6.83,
                                              height: height / 16.425,
                                              //color: Color(0xffDDDEEE),
                                              decoration: BoxDecoration(
                                                  color: Color(0xffDDDEEE),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),

                                              child: TypeAheadFormField(
                                                suggestionsBoxDecoration:
                                                    SuggestionsBoxDecoration(
                                                        color:
                                                            Color(0xffDDDEEE),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5),
                                                        )),
                                                textFieldConfiguration:
                                                    TextFieldConfiguration(
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15),
                                                  decoration: InputDecoration(
                                                    hintText: "",
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 10,
                                                            bottom: 8),
                                                    border: InputBorder.none,
                                                  ),
                                                  controller: this.textediting[index],
                                                ),
                                                suggestionsCallback: (pattern) {
                                                  return staffdroup(index);//getSuggestionsstaffid(pattern, value["period"]);
                                                },
                                                itemBuilder: (context,
                                                    String suggestion) {
                                                  return ListTile(
                                                    title: Text(suggestion),
                                                  );
                                                },
                                                transitionBuilder: (context,
                                                    suggestionsBox,
                                                    controller) {
                                                  return suggestionsBox;
                                                },
                                                onSuggestionSelected:
                                                    (String suggestion) async {
                                                  this.textediting[index].text = suggestion;
                                                  getstaffbyid2(textediting[index].text,index);
                                                  substitutionsList.add(
                                                        SubstitutionModel(
                                                          timestamp: DateTime.now().millisecondsSinceEpoch,
                                                          date: DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),
                                                          day: value.get("day").toString(),
                                                          period: value.get("period").toString(),
                                                          section: value.get("section").toString(),
                                                          subject: value.get("subject").toString(),
                                                          className: value.get("class").toString(),
                                                          regNo: textediting[index].text,
                                                          docId: '',
                                                        )
                                                    );
                                                },
                                                suggestionsBoxController:
                                                    suggestionBoxController,
                                                validator: (value) => value!
                                                        .isEmpty
                                                    ? 'Please select a section'
                                                    : null,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 30),
                                            child: Container(
                                              width: width / 6.83,
                                              height: height / 16.425,
                                              //color: Color(0xffDDDEEE),
                                              decoration: BoxDecoration(
                                                  color: Color(0xffDDDEEE),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),

                                              child: TypeAheadFormField(
                                                suggestionsBoxDecoration:
                                                    SuggestionsBoxDecoration(
                                                        color:
                                                            Color(0xffDDDEEE),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5),
                                                        )),
                                                textFieldConfiguration:
                                                    TextFieldConfiguration(
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15),
                                                  decoration: InputDecoration(
                                                    hintText: "",
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 10,
                                                            bottom: 8),
                                                    border: InputBorder.none,
                                                  ),
                                                  controller:
                                                      this.textediting2[index],
                                                ),
                                                suggestionsCallback: (pattern) {
                                                  return getSuggestionsstaffname(
                                                      pattern, value["period"]);
                                                },
                                                itemBuilder: (context,
                                                    String suggestion) {
                                                  return ListTile(
                                                    title: Text(suggestion),
                                                  );
                                                },
                                                transitionBuilder: (context,
                                                    suggestionsBox,
                                                    controller) {
                                                  return suggestionsBox;
                                                },
                                                onSuggestionSelected:
                                                    (String suggestion) {
                                                  getstaffbyid();
                                                  this
                                                      .textediting2[index]
                                                      .text = suggestion;
                                                  getstaffbyid3(
                                                      textediting2[index].text,
                                                      index);
                                                },
                                                suggestionsBoxController:
                                                    suggestionBoxController,
                                                validator: (value) => value!
                                                        .isEmpty
                                                    ? 'Please select a section'
                                                    : null,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      //color: Colors.pink,
                                    ),
                                  );
                                // : Container();
                          });
                    }),
              ],
            ),
          );
  }

  String day = "";

  getdate() {
    setState(() {
      day = DateFormat('EEEE').format(DateTime.now());
    });
  }

  Future<List<DocumentSnapshot>> getAppliedLeaves() async {
    List<String> staffRegNos = [];
    List<DocumentSnapshot> staffs = [];
    var leaveDocument = await FirebaseFirestore.instance.collection('Leave').get();
    leaveDocument.docs.forEach((element) {
      if (element.get("leaveon") == DateFormat('dd-MM-yyyy').format(DateTime.now()) && element.get("status").toString().toLowerCase() == "approved") {
        staffRegNos.add(element.get("regno"));
      }
    });

    var staffDocument = await FirebaseFirestore.instance.collection('Staffs').get();
    staffDocument.docs.forEach((staff) {
      staffRegNos.forEach((regNo) {
        if (regNo == staff.get("regno")) {
          staffs.add(staff);
        }
      });
    });

    return staffs;
  }

  Future<List<DocumentSnapshot>> getSuddenLeaves() async {
    List<String> staffRegNos = [];
    List<DocumentSnapshot> staffs = [];
    var staffDocument =
        await FirebaseFirestore.instance.collection('Staffs').get();
    staffDocument.docs.forEach((staff) {
      if (staff.get("absent") == true) {
        staffRegNos.add(staff.get("regno"));
      }
    });
    var leaveDocument = await FirebaseFirestore.instance.collection('Leave').get();
    leaveDocument.docs.forEach((leave) {
      staffRegNos.forEach((regno) {
        if (leave.get("regno") == regno) {
          staffRegNos.remove(regno);
        }
      });
    });
    staffDocument.docs.forEach((staff) {
      staffRegNos.forEach((regno) {
        if (staff.get("regno") == regno) {
          staffs.add(staff);
        }
      });
    });
    return staffs;
  }

  updateSubstitutionTeachers(List<SubstitutionModel> susbstitutionStaffs) async {

    var staffs = await FirebaseFirestore.instance.collection('Staffs').get();
    susbstitutionStaffs.forEach((subStaff) { 
      staffs.docs.forEach((staff) { 
        if(subStaff.regNo == staff.get("regno")){
          subStaff.docId = staff.id;
        }
      });
    });

    await Future.delayed(Duration(seconds: 10));

    susbstitutionStaffs.forEach((element) {

      FirebaseFirestore.instance.collection('Staffs').doc(element.docId).collection('Subtitution').doc().set({
        "class" : element.className,
        "date" : element.date,
        "day" : element.day,
        "period" : element.period,
        "section" : element.section,
        "subject" : element.subject,
        "timestamp" : DateTime.now().millisecondsSinceEpoch,
      });
      FirebaseFirestore.instance.collection('Staffs').doc(staffid).update({
        "substitutionAssigned": DateFormat('dd/MM/yyyy').format(DateTime.now())
      });
      setState(() {
        view = false;
        setState(() {
          staffid = '';
          staffname = '';
          textediting.clear();
          textediting2.clear();
        });
      });
    });
    
  }
}

class SubstitutionModel{
  SubstitutionModel({
    required this.timestamp,
    required this.date,
    required this.day,
    required this.period,
    required this.section,
    required this.subject,
    required this.className,
    required this.regNo,
    required this.docId,
});

  String regNo;
  String docId;

  String className;
  String date;
  String day;
  String period;
  String section;
  String subject;
  num timestamp;
}
