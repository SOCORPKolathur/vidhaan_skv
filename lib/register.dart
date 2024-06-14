import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController datePickerCont = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController amountCont = TextEditingController();
  final TextEditingController remarksCon = TextEditingController();
  final TextEditingController verifierCon = TextEditingController();
  final TextEditingController sourceCon = TextEditingController();
  List<String> registerTypeList = [
    'Select Type',
    'debit',
    'credit'
  ];
  String selectedRegisType = "Select Type";


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.black),
        ),
        height: 300,
        width: double.infinity,
        child: Column(
          children: [
           /* Container(
              height: 70,
              color: Colors.grey[50],
              child:
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ADD NEW RECORD',
                      style: GoogleFonts.mulish(
                          fontWeight:
                          FontWeight.bold,
                          fontSize: width/105.076923077,
                          color: Colors.black),
                    ),
             *//*       ElevatedButton(onPressed: () {
                      if(
                      amountCont.text == '' || verifierCon.text == '' || datePickerCont.text == '' ||
                      selectedRegisType == 'Select Type'
                      ){
                        print("Select all the fields");

                      }else{
                        addRegister();
                        print("Added Successfully");


                      }

                    },
                        child: Text('Add Now'))*//*

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
                                Text("Add Now"),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.add),
                                )
                              ],
                            ))),
                        onPressed: (){
                          if(
                          amountCont.text == '' || verifierCon.text == '' || datePickerCont.text == '' ||
                              selectedRegisType == 'Select Type'
                          ){
                            print("Select all the fields");

                          }else{
                            addRegister();
                            print("Added Successfully");


                          }

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

                  ],
                ),
              ),
            ),*/
            /// Main Heading...
                 Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(child: Padding(
                          padding: const EdgeInsets.only(left: 38.0,top: 30),
                          child: Text("ADD NEW RECORD",style: GoogleFonts.poppins(fontSize: width/85.888888889,fontWeight: FontWeight.bold, color: Colors.white),),
                        ),
                          //color: Colors.white,
                          width: width/1.050,
                          height: height/8.212,
                          decoration: BoxDecoration(
                              // color: Colors.white,
                              color: Color(0xff00a0e3),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),

            SizedBox(height: 20,),
            Container(
              width: 860,
              child: Row(
                children: [
                  SizedBox(width: 30,),
                 /* Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date *',
                        style: GoogleFonts.mulish(
                            fontWeight:
                            FontWeight.bold,
                            fontSize: width/85.076923077,
                            color: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          datePicker(context);
                        },
                        child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 5.0,
                                      offset: Offset(0.0, 3.0)
                                  ),
                                ],
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.0)
                            ),
                            child: TextField(
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: InputBorder.none),
                              controller: datePickerCont,
                              readOnly: true,
                              onTap: () {
                                datePicker(context);
                              },


                            )
                        ),
                      )
                    ],
                  ),*/


                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:0.0),
                        child: Text("Date *",style: GoogleFonts.poppins(fontSize: width/91.06666666666667,)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0,right: 10),
                        child: Container(
                          child:
                          TextFormField(
                            readOnly: true,
                            onTap: (){
                              datePicker(context);
                            },
                            controller: datePickerCont,decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(left: 10,bottom: 8),),style: GoogleFonts.poppins(
                            fontSize: width/91.06666666666667,
                          ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select Date';
                              }
                              return null;
                            },
                          ),
                          width: width/5.902,
                          height: height/16.425,
                          //color: Color(0xffDDDEEE),
                          decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                        ),
                      ),

                    ],

                  ),
                  SizedBox(width: 30,),
                /*  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text('Amount *',
                        style: GoogleFonts.mulish(
                            fontWeight:
                            FontWeight.bold,
                            fontSize: width/85.076923077,
                            color: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          // datePicker(context);
                        },
                        child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 5.0,
                                      offset: Offset(0.0, 3.0)
                                  ),
                                ],
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.0)
                            ),
                            child: TextField(

                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: InputBorder.none),
                              keyboardType: TextInputType.number,
                             inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly

                              ],

                              controller: amountCont,
                              // readOnly: true,
                              onTap: () {
                                // datePicker(context);
                              },


                            )
                        ),
                      )
                    ],
                  ),*/


                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:0.0),
                        child: Text("Amount *",style: GoogleFonts.poppins(fontSize: width/91.06666666666667,)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0,right: 10),
                        child: Container(
                          child:
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly

                            ],

                            controller: amountCont,decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(left: 10,bottom: 8),),style: GoogleFonts.poppins(
                            fontSize: width/91.06666666666667,
                          ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Amount';
                              }
                              return null;
                            },
                          ),
                          width: width/5.902,
                          height: height/16.425,
                          //color: Color(0xffDDDEEE),
                          decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                        ),
                      ),

                    ],

                  ),
                  SizedBox(width: 30,),
                /*  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Select Type*',
                        style: GoogleFonts.mulish(
                            fontWeight:
                            FontWeight.bold,
                            fontSize: width/85.076923077,
                            color: Colors.black),
                      ),
                      Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5.0,
                                  offset: Offset(0.0, 3.0)
                              ),
                            ],
                            border: Border.all(color: Colors.grey),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              hint: Text(
                                'Register Type',
                                style: GoogleFonts.mulish(
                                    fontWeight:
                                    FontWeight.bold,
                                    fontSize: width/85.076923077,
                                    color: Colors.black87),
                              ),
                              items: registerTypeList.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: GoogleFonts.mulish(
                                        fontWeight:
                                        FontWeight.bold,
                                        fontSize: width/85.076923077,
                                        color: Colors.black87),
                                  ),
                                );
                              }).toList(),
                              value: selectedRegisType,
                              onChanged: (String? value) async {
                                setState(() {
                                  selectedRegisType = value!;
                                });
                                setState(() {

                                });
                              },
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),*/
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:0.0),
                        child: Text("Select Type",style: GoogleFonts.poppins(fontSize: width/91.06666666666667,)),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 0.0,right: 25),
                        child: Container(
                          // width: width/8.1,
                          width: width/5.902,
                          height: height/16.42,
                          //color: Color(0xffDDDEEE),
                          decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),child:
                          DropdownButtonHideUnderline(
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
                                      'Select Option',
                                      style: GoogleFonts.poppins(
                                          fontSize: width/91.06666666666667
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items:
                              registerTypeList.map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style:  GoogleFonts.poppins(
                                      fontSize: width/91.06666666666667
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                                  .toList(),
                              value: selectedRegisType,
                              onChanged: (String? value) {
                                setState(() {
                                 selectedRegisType = value!;
                                });

                              },
                              buttonStyleData: ButtonStyleData(
                                height:height/13.02,
                                width: width/8.5375,
                                padding: const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),

                                  color: Color(0xffDDDEEE),
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
                              menuItemStyleData:  MenuItemStyleData(
                                height:height/16.275,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),

                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 30,),
                ],
              ),
            ),
            SizedBox(height: 20,),
          /*  Container(
              width: 800,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 30,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Verifier *',
                        style: GoogleFonts.mulish(
                            fontWeight:
                            FontWeight.bold,
                            fontSize: width/85.076923077,
                            color: Colors.black),
                      ),
                      Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 5.0,
                                    offset: Offset(0.0, 3.0)
                                ),
                              ],
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.0)
                          ),
                          child: TextField(
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                border: InputBorder.none),
                            controller: verifierCon,


                          )
                      )
                    ],
                  ),
                  SizedBox(width: 30,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text('Source *',
                        style: GoogleFonts.mulish(
                            fontWeight:
                            FontWeight.bold,
                            fontSize: width/85.076923077,
                            color: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          // datePicker(context);
                        },
                        child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 5.0,
                                      offset: Offset(0.0, 3.0)
                                  ),
                                ],
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.0)
                            ),
                            child: TextField(
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: InputBorder.none),

                              controller: sourceCon,
                              // readOnly: true,
                              onTap: () {
                                // datePicker(context);
                              },


                            )
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 30,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Remarks',
                        style: GoogleFonts.mulish(
                            fontWeight:
                            FontWeight.bold,
                            fontSize: width/85.076923077,
                            color: Colors.black),
                      ),
                      Container(
                          width: 350,
                          height: 170,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 5.0,
                                    offset: Offset(0.0, 3.0)
                                ),
                              ],
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.0)
                          ),
                          child: TextField(
                            decoration: InputDecoration(border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10.0),
                            ),
                            controller: remarksCon,

                          )
                      ),
                    ],
                  ),
                  SizedBox(width: 30,),



                ],
              ),
            ),*/

            Container(
              // color: Colors.pink,
              // width: 800,
              width: width/1.70,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(width: 60,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(right:0.0),
                        child: Text("Verifier *",style: GoogleFonts.poppins(fontSize: width/91.06666666666667,)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0,right: 10),
                        child: Container(
                          child:
                          TextFormField(
                            controller: verifierCon,decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(left: 10,bottom: 8),),style: GoogleFonts.poppins(
                            fontSize: width/91.06666666666667,
                          ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Verifier';
                              }
                              return null;
                            },
                          ),
                          width: width/3.64,
                          // width: 375,
                          height: height/16.425,
                          //color: Color(0xffDDDEEE),
                          decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                        ),
                      ),

                    ],

                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:0.0),
                        child: Text("Source *",style: GoogleFonts.poppins(fontSize: width/91.06666666666667,)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Container(
                          child:
                          TextFormField(
                            controller: sourceCon,decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(left: 10,bottom: 8),),style: GoogleFonts.poppins(
                            fontSize: width/91.06666666666667,
                          ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Source';
                              }
                              return null;
                            },
                          ),
                          width: width/3.64,
                          // width: 375,
                          height: height/16.425,
                          //color: Color(0xffDDDEEE),
                          decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                        ),
                      ),

                    ],

                  ),

                ],
              ),
            ),
            SizedBox(width: 30,),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right:0.0),
                    child: InkWell(
                        onTap: (){
                          print(width);
                          print(height);
                        },
                        child: Text("Remarks",style: GoogleFonts.poppins(fontSize: width/91.06666666666667,))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0,right: 10),
                    child: Container(

                      child:
                      TextFormField(
                        controller: remarksCon,decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(left: 10,bottom: 8),),style: GoogleFonts.poppins(
                        fontSize: width/91.06666666666667,
                      ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Remarks';
                          }
                          return null;
                        },
                      ),
                      // width: width/5.902,
                      // width: width/2.732,
                      width: width/1.732,
                      // width: 500,
                      // height: height/16.425,
                      height: height/5.425,
                      //color: Color(0xffDDDEEE),
                      decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),
                    ),
                  ),

                ],

              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 45,
              width: 180,
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
                        Text("Add Records"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.add),
                        )
                      ],
                    ))),
                onPressed: (){
                  if(
                  amountCont.text == '' || verifierCon.text == '' || datePickerCont.text == '' ||
                      selectedRegisType == 'Select Type'
                  ){
                    print("Select all the fields");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please Enter all the fields'),
                        duration: const Duration(seconds: 2),
                      ),
                    );

                  }else{
                    addRegister();
                    amountCont.text= '';
                    verifierCon.text= '' ;
                    sourceCon.text = '';

                         datePickerCont.text= '';


                        selectedRegisType = 'Select Type';
                    print("Added Successfully");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Record Added Successfully'),
                        duration: const Duration(seconds: 2),
                      ),
                    );


                  }
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
          ],
        ),
      ),
    );
  }

  // DatePicker
  DateTime ? selectedDate;

  Future<void> datePicker(BuildContext context) async {
    final DateTime ? picked = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2030));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        print('normal date $selectedDate');
        datePickerCont.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
  /// Add Register
  addRegister() {
    FirebaseFirestore.instance.collection("Accounts").doc().set({
      "type": selectedRegisType,
      "amount": amountCont.text,
      'title' : sourceCon.text,
      'payee' : '',
      "receivedBy": verifierCon.text,
      "date": datePickerCont.text,
      "time":  DateFormat.jm().format(DateTime.now()),
      "timestamp": DateTime.now().microsecondsSinceEpoch,
    });
  }
  ///Success PopUp
}

