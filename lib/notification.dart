import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'modules/home/controllers/home_controller.dart';


class NotificationCus extends StatefulWidget {
  const NotificationCus({Key? key}) : super(key: key);

  @override
  State<NotificationCus> createState() => _NotificationCusState();
}

class _NotificationCusState extends State<NotificationCus> {
  final homecontroller = Get.put(HomeController());

  @override
  void initState() {
    adddropvalue();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    final focus = FocusScope.of(context);

    TextEditingController email = new TextEditingController();

    TextEditingController password = new TextEditingController();
    bool isVisible = true;


    bool obs = true;
    return Scaffold(

        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: width/3.794444444444444,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Send Circulars',
                      style: TextStyle(
                        fontSize: width/30.355555556,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height:height/21.7,
                    ),
                    Text(
                      "Send Circulars to Staffs and Students",
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height:height/65.1,
                    ),

                    SvgPicture.asset("assets/notification.svg",fit: BoxFit.fill,width: width/4.533333333333330,),

                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 16),
              child: Container(
                width: width/3.415,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Send To",style: GoogleFonts.poppins(
                        fontSize: width/68.3,
                      fontWeight: FontWeight.w700
                    ),),
                    Container(
                      width: width/1.138333333333333,

                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        border: Border.all(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint:  Row(
                            children: [
                              Icon(
                                Icons.list,
                                size: 16,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: width/341.5,
                              ),
                              Expanded(
                                child: Text(
                                  'Send to',
                                  style: GoogleFonts.poppins(
                                      fontSize: width/91.066666667
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: sendto
                              .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style:  GoogleFonts.poppins(
                                  fontSize: width/91.066666667
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                              .toList(),
                          value:  droupvalue,
                          onChanged: (String? value) {
                            setState(() {
                              droupvalue = value!;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height:height/13.02,
                            width: width/8.5375,
                            padding: const EdgeInsets.only(left: 14, right: 14),

                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade50,
                              border: Border.all(color: Colors.blueGrey.shade50),
                              borderRadius: BorderRadius.circular(15),

                            ),

                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                            ),
                            iconSize: 14,
                            iconEnabledColor: Colors.black,
                            iconDisabledColor: Colors.grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight:height/3.255,
                            width: width/5.464,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Color(0xffDDDEEE),
                            ),

                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(7),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility: MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: MenuItemStyleData(
                            height:height/16.275,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height:height/21.7),
                   droupvalue=="Class Wise"? Container(
                      width: width/1.138333333333333,

                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        border: Border.all(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:TypeAheadFormField(



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
                          decoration:  InputDecoration(
                            hintText: "Select a class",
                            contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/81.375),
                            border: InputBorder.none,
                          ),
                          controller: this._typeAheadControllerclass,
                        ),
                        suggestionsCallback: (pattern) {
                          return getSuggestionsclass(pattern);
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
                            this._typeAheadControllerclass.text = suggestion;
                          });
                        },
                        suggestionsBoxController: suggestionBoxController,
                        validator: (value) =>
                        value!.isEmpty ? 'Please select a class' : null,

                      ),
                    ) :  droupvalue=="Section Wise"?
                   Container(
                     width: width/1.138333333333333,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,

                       children: [
                         Container(
                           width: width/7.138333333333333,

                           decoration: BoxDecoration(
                             color: Colors.blueGrey.shade50,
                             border: Border.all(color: Colors.blueGrey.shade50),
                             borderRadius: BorderRadius.circular(15),
                           ),
                           child:TypeAheadFormField(


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
                               decoration:  InputDecoration(
                                 hintText: "Select a class",
                                 contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/81.375),
                                 border: InputBorder.none,
                               ),
                               controller: this._typeAheadControllerclass,
                             ),
                             suggestionsCallback: (pattern) {
                               return getSuggestionsclass(pattern);
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
                                 this._typeAheadControllerclass.text = suggestion;
                               });
                             },
                             suggestionsBoxController: suggestionBoxController,
                             validator: (value) =>
                             value!.isEmpty ? 'Please select a class' : null,

                           ),
                         ),
                         Container(
                           width: width/7.138333333333333,

                           decoration: BoxDecoration(
                             color: Colors.blueGrey.shade50,
                             border: Border.all(color: Colors.blueGrey.shade50),
                             borderRadius: BorderRadius.circular(15),
                           ),
                           child:TypeAheadFormField(


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
                               decoration:  InputDecoration(
                                 hintText: "Select a section",
                                 contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/81.375),
                                 border: InputBorder.none,
                               ),
                               controller: this._typeAheadControllersection,
                             ),
                             suggestionsCallback: (pattern) {
                               return getSuggestionssection(pattern);
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
                                 this._typeAheadControllersection.text = suggestion;
                               });
                             },
                             suggestionsBoxController: suggestionBoxController,
                             validator: (value) =>
                             value!.isEmpty ? 'Please select a class' : null,

                           ),
                         ),
                       ],
                     ),
                   ) :SizedBox(),
                    droupvalue=="Class Wise" ||  droupvalue=="Section Wise" ?   SizedBox(height:height/21.7) :SizedBox(),
                    Container(
                      width: width/1.138333333333333,

                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,

                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: title,
                        onEditingComplete: () => focus.nextFocus(),

                        decoration: InputDecoration(
                          hintText: 'Title',
                          filled: true,
                          fillColor: Colors.blueGrey.shade50,

                          labelStyle: TextStyle(fontSize: width/113.833333333),
                          contentPadding: EdgeInsets.only(left: 30),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey.shade50),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),


                    SizedBox(height:height/21.7),
                    Container(
                      width: width/1.138333333333333,
                      height: height/3.625,

                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        border: Border.all(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          controller: body,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 20,
                          decoration: InputDecoration(
                            hintText: ' Description',
                            border: InputBorder.none,
                            labelStyle: TextStyle(fontSize: width/113.833333333),
                            contentPadding: EdgeInsets.only(left: 30),

                          ),
                        ),
                      ),
                    ),
                    SizedBox(height:height/16.275),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple.shade100,
                            spreadRadius: 10,
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        child: Container(
                            width: double.infinity,
                            height:height/13.02,
                            child: Center(child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Send Now"),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.send_rounded),
                                )
                              ],
                            ))),
                        onPressed: (){
                          FirebaseFirestore.instance.collection("Circulars").doc().set({
                            "Descr":title.text,
                            "reason":body.text,
                            "type" : droupvalue,
                            "From":"Principal",
                            "Date":"${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
                            "Time":"${DateFormat('hh:mm a').format(DateTime.now())}",
                            "timestamp":DateTime.now().millisecondsSinceEpoch
                          });
                          setState(() {
                            homecontroller.body.text=title.text;
                            homecontroller.title.text="Announcement 🔔";
                          });
                          homecontroller.findusers(droupvalue);
                          _showMyDialog1();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff00A0E3),
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height:height/16.275),
                    Row(children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey[300],
                          height:height/13.02,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Kindly Recheck before sending",textAlign: TextAlign.center,),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey[400],
                          height:height/13.02,
                        ),
                      ),
                    ]),
                    SizedBox(height:height/16.275),

                  ],
                ),
              ),
            )
          ],
        )
    );

  }

  TextEditingController title = new TextEditingController();
  TextEditingController body = new TextEditingController();
  clear(){
    setState(() {
      title.text = "";
      body.text = "";

    });
  }
  Future<void> _showMyDialog1() async {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Circular Send Successfully'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Container(
                  width: width/34.15,height:height/4.65,
                  child:  SvgPicture.asset("assets/sent2.svg",fit: BoxFit.contain),),



              ],
            ),
          ),
          actions: <Widget>[

            TextButton(
              child: const Text('OK',style: TextStyle(color: Colors.blue),),
              onPressed: () {
                clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  static final List<String> classes = [];
  static final List<String> section = [];

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
  final TextEditingController _typeAheadControllerclass = TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  final TextEditingController _typeAheadControllersection = TextEditingController();
  adddropvalue() async {

    setState(() {
      classes.clear();
      section.clear();
    });
    var document3 = await FirebaseFirestore.instance.collection("ClassMaster")
        .orderBy("order")
        .get();
    for (int i = 0; i < document3.docs.length; i++) {
      setState(() {
        classes.add(document3.docs[i]["name"]);
      });
    }
    var document4 = await FirebaseFirestore.instance.collection("SectionMaster")
        .orderBy("order")
        .get();
    for (int i = 0; i < document4.docs.length; i++) {
      setState(() {
        section.add(document4.docs[i]["name"]);
      });
    }
  }

  final List<String>  sendto = ["All","All Student","All Staff","Class Wise","Section Wise"];
  String droupvalue ="All";


}