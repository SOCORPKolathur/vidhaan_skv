import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                width: 360,
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
                      height: 30,
                    ),
                    Text(
                      "Send Circulars to Staffs and Students",
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    SvgPicture.asset("assets/notification.svg",fit: BoxFit.fill,width: 300,),

                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / 16),
              child: Container(
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Send To",style: GoogleFonts.poppins(
                        fontSize: width/68.3,
                      fontWeight: FontWeight.w700
                    ),),
                    Container(
                      width: 1200,

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
                                width: 4,
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
                            height: 50,
                            width: 160,
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
                            maxHeight: 200,
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
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 1200,

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


                    SizedBox(height: 30),
                    Container(
                      width: 1200,
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
                    SizedBox(height: 40),
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
                            height: 50,
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
                    SizedBox(height: 40),
                    Row(children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey[300],
                          height: 50,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Kindly Recheck before sending",textAlign: TextAlign.center,),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey[400],
                          height: 50,
                        ),
                      ),
                    ]),
                    SizedBox(height: 40),

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
                  width: 40,height: 140,
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


  final List<String>  sendto = ["All","Student","Staff"];
  String droupvalue ="All";


}