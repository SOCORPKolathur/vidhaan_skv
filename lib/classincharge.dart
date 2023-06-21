import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';

class ClassIncharge extends StatefulWidget {
  const ClassIncharge({Key? key}) : super(key: key);

  @override
  State<ClassIncharge> createState() => _ClassInchargeState();
}

class _ClassInchargeState extends State<ClassIncharge> {


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
  adddropdownvalue() async {
    var document = await  FirebaseFirestore.instance.collection("ClassMaster").orderBy("order").get();
    var document2 = await  FirebaseFirestore.instance.collection("SectionMaster").orderBy("order").get();
    var document3 = await  FirebaseFirestore.instance.collection("Staffs").orderBy("entryno").get();
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




  saveincharge() async {


    var document = await FirebaseFirestore.instance.collection("Incharge").get();

    FirebaseFirestore.instance.collection("Incharge").doc().set({
      "class":_typeAheadControllerclass.text,
      "section":_typeAheadControllersection.text,
      "staffid":_typeAheadControllerstaffid.text,
      "staffname": staffname,
      "orderno":document.docs.length+1,
    });
  }
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(child: Padding(
            padding: const EdgeInsets.only(left: 38.0,top: 30),
            child: Text("Class Teacher/ Incharge",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
                            child: Text("Class",style: GoogleFonts.poppins(fontSize: 15,)),
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

                                this._typeAheadControllerclass.text = suggestion;


                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a class' : null,
                              onSaved: (value) => this._selectedCity = value,
                            ),
                              width: 200,
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
                            child: Text("Section",style: GoogleFonts.poppins(fontSize: 15,)),
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
                                this._typeAheadControllersection.text = suggestion;
                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,
                              onSaved: (value) => this._selectedCity = value,
                            ),
                              width: 200,
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
                                getstaffbyid();
                                this._typeAheadControllerstaffid.text = suggestion;
                              },
                              suggestionsBoxController: suggestionBoxController,
                              validator: (value) =>
                              value!.isEmpty ? 'Please select a section' : null,
                              onSaved: (value) => this._selectedCity = value,
                            ),
                              width: 200,
                              height: 40,
                              //color: Color(0xffDDDEEE),
                              decoration: BoxDecoration(color: Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                            ),
                          ),

                        ],

                      ),
                      GestureDetector(
                        onTap: (){
                          saveincharge();
                          Successdialog();
                        },
                        child: Container(child: Center(child: Text("Save",style: GoogleFonts.poppins(color:Colors.white),)),
                          width: 130,
                          height: 40,
                          // color:Color(0xff00A0E3),
                          decoration: BoxDecoration(color: Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 1100,

                    decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 20.0),
                          child: Text("Class",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0,right: 8.0),
                          child: Text("Section",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80.0,right: 8.0),
                          child: Text("Staff ID",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80.0,right: 8.0),
                          child: Text("Staff Name",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                        ),
                      ],
                    ),

                  ),
                ),

                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("Incharge").orderBy("orderno").snapshots(),

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
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 30,
                                width: 1100,

                                decoration: BoxDecoration(color:Colors.white60,borderRadius: BorderRadius.circular(12)

                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0,right: 0.0),
                                      child: Container(
                                          width: 100,

                                          child: Text(value["class"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0,right: 8.0),
                                      child: Text(value["section"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 100.0,right: 8.0),
                                      child: Text(value["staffid"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 70.0,right: 8.0),
                                      child: Text(value["staffname"],style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                                    ),
                                  ],
                                ),

                              ),
                            );
                          });

                    }),

              ],
            ),

          ),
        )
      ],
    );
  }
}
