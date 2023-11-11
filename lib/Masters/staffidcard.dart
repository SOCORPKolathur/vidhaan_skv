import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/widgets.dart' as p;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

class StaffID extends StatefulWidget {
  const StaffID({Key? key}) : super(key: key);

  @override
  State<StaffID> createState() => _StaffIDState();
}

class _StaffIDState extends State<StaffID> {


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
    getadmin();
    addinglist();
    setState(() {
      _typeAheadControllerclass.text="Select Option";
      _typeAheadControllersection.text="Select Option";
    });
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


  final expand = List<bool>.generate(1000, (int index) => false, growable: true);
  Color pickerColor = Color(0xff25507D);
  Color currentColor = Color(0xff25507D);

  Color pickerColor2 = Color(0xff90C01F);
  Color currentColor2 = Color(0xff90C01F);

  Color pickerColor3 = Color(0xffD62F5E);
  Color currentColor3 = Color(0xffD62F5E);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }
  void changeColor2(Color color) {
    setState(() => pickerColor2 = color);
  }
  void changeColor3(Color color) {
    setState(() => pickerColor3 = color);
  }


  String schoolname="";
  String schooladdress="";
  String schoolphone="";
  String schoollogo="";
  String idcarddesign="";
  String solgan="";
  String schoolweb="";

  getadmin() async {
    var document = await FirebaseFirestore.instance.collection("Admin").get();
    setState(() {
      schoolname=document.docs[0]["schoolname"];
      schooladdress="${document.docs[0]["area"]} ${document.docs[0]["city"]} ${document.docs[0]["pincode"]}";
      schoollogo=document.docs[0]["logo"];
      idcarddesign=document.docs[0]["idcard"].toString();
      solgan=document.docs[0]["solgan"];
      schoolphone=document.docs[0]["phone"];
      schoolweb=document.docs[0]["web"];
    });
  }
  getvalue() async {
    print("gbdffd");
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    List<p.Widget> widgets = [];

    final bg1 = p.MemoryImage((await rootBundle.load("assets/staffid1.png")).buffer.asUint8List(),);
   
    final bg3 = p.MemoryImage((await rootBundle.load("assets/staffid2.png")).buffer.asUint8List(),);

    final vidhaanlogo = p.MemoryImage((await rootBundle.load('assets/VIDHAANLOGO.png')).buffer.asUint8List(),);
    final plusicon = p.MemoryImage((await rootBundle.load('assets/plus.png')).buffer.asUint8List(),);
    final schoollogoii = await flutterImageProvider(NetworkImage(schoollogo));

    var fontsemipoppoins = await PdfGoogleFonts.poppinsSemiBold();
    var fontregpoppoins = await PdfGoogleFonts.poppinsRegular();
    var fontrmedpoppoins = await PdfGoogleFonts.poppinsMedium();
    var fontsemimon = await PdfGoogleFonts.montserratSemiBold();


    widgets.add(

        p.Padding(
            padding: p.EdgeInsets.only(top: 0),
            child:   p.ListView.builder(itemBuilder: (context,index){
              return
                p.Container(
                    height: 1190,
                    width:840,
                    child:
                    p.Column(children: [
                      p.Container(
                        height: 12.1,

                      ),
                      p.Padding(
                        padding: p.EdgeInsets.only(left:20),
                        child:
                        p.Row(
                            mainAxisAlignment: p.MainAxisAlignment.start,
                            children: [
                              namelist[index].length>0?
                              p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 252.35,
                                      width: 161.5,
                                      color:PdfColors.white,

                                      child: p.Stack(
                                        children: [
                                          p.Column(
                                            mainAxisAlignment: p.MainAxisAlignment.end,
                                            children: [
                                               p.Container(
                                                  width:161.5,
                                                height: 180.35, 
                                                child:
                                                p.Image(bg1,fit: p.BoxFit.fill),
                                              )
                                             
                                            ],
                                          ),
                                          p.Column(
                                            crossAxisAlignment: p.CrossAxisAlignment.center,

                                            children: [
                                              p.SizedBox(height: 16,),
                                              p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Container(
                                                    width:30,
                                                    height:30,
                                                    child:
                                                    p.ClipRRect(
                                                      verticalRadius: 18,
                                                      horizontalRadius: 18,
                                                      child: p.Image(schoollogoii),),
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              p.Text(schoolname,style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                              p.Text(schooladdress,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                              p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                              p.Text(schoolweb,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                              p.SizedBox(height: 8,),
                                              p.Stack(
                                                alignment: p.Alignment.center,
                                                children: [
                                                  p.Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration:  p.BoxDecoration(
                                                      color: PdfColor.fromHex("25507D"),

                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.Container(
                                                    width: 55,
                                                    height: 55,
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.Padding(
                                                      padding: p.EdgeInsets.only(top:0),
                                                      child:
                                                      p.ClipRRect(
                                                          horizontalRadius: 14,
                                                          verticalRadius: 20,
                                                          child:
                                                          p.Image(imglist[index][0],height: 55,width: 55))
                                                  )
                                                ],
                                              ),
                                              p.SizedBox(height: 8,),
                                              p.Text("${namelist[index][0]} ${lastnamelist[index][0]}",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color:  PdfColors.white, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                              /*p.Text("ID: ${regnolist[index][0]}",style: p.TextStyle(
                                                  font: fontrmedpoppoins,
                                                  color:  PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),*/
                                               p.SizedBox(height: 2,),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("Designation",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text("${classlist[index][0]}",style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("ID",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(regnolist[index][0],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Blood Group",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color:PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(bloodlist[index][0],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Phone No",style:  p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style:  p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(phonelist[index][0],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),]
                              ):
                              p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[
                                  p.Container(
                                    height: 16,
                                    width: 16,
                                    child: p.Image(plusicon),
                                  ),
                                  p.Container(
                                    height: 3.0,

                                  ),
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ),]
                            ),
                              namelist[index].length>1?
                              p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 252.35,
                                      width: 161.5,
                                      color:PdfColors.white,

                                      child: p.Stack(
                                        children: [
                                          p.Column(
                                            mainAxisAlignment:  p.MainAxisAlignment.end,
                                            children: [
                                               p.Container(
                                                  width:161.5,
                                                height: 180.35, 
                                                child:
                                                p.Image(bg1,fit: p.BoxFit.fill),
                                              )
                                             


                                            ],
                                          ),
                                          p.Column(
                                            crossAxisAlignment: p.CrossAxisAlignment.center,

                                            children: [
                                              p.SizedBox(height: 16,),
                                              p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Container(
                                                    width:30,
                                                    height:30,
                                                    child:   p.ClipRRect(
                                                      verticalRadius: 18,
                                                      horizontalRadius: 18,
                                                      child: p.Image(schoollogoii),),
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              p.Text(schoolname,style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                              p.Text(schooladdress,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                              p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                              p.Text(schoolweb,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                              p.SizedBox(height: 8,),
                                              p.Stack(
                                                alignment: p.Alignment.center,
                                                children: [
                                                  p.Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration:  p.BoxDecoration(
                                                      color: PdfColor.fromHex("25507D"),
                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.Container(
                                                    width: 55,
                                                    height: 55,
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.ClipRRect(
                                                      horizontalRadius: 14,
                                                      verticalRadius: 20,
                                                      child:
                                                      p.Image(imglist[index][1],height: 55,width: 55))

                                                ],
                                              ),
                                              p.SizedBox(height: 8,),
                                              p.Text("${namelist[index][1]} ${lastnamelist[index][1]}",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColors.white, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                              /*p.Text("ID: ${regnolist[index][1]}",style: p.TextStyle(
                                                  font: fontrmedpoppoins,
                                                  color:  PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),*/
                                               p.SizedBox(height: 2,),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("Designation",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text("${classlist[index][1]}",style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("ID",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(regnolist[index][1],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Blood Group",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color:PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(bloodlist[index][1],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Phone No",style:  p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style:  p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(phonelist[index][1],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),]
                              ):
                               p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[
                                  p.Container(
                                    height: 16,
                                    width: 16,
                                    child: p.Image(plusicon),
                                  ),
                                  p.Container(
                                    height: 3.0,

                                  ),
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ),]
                            ),
                              namelist[index].length>2?
                              p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 252.35,
                                      width: 161.5,
                                      color:PdfColors.white,

                                      child: p.Stack(
                                        children: [
                                          p.Column(
                                            mainAxisAlignment:  p.MainAxisAlignment.end,
                                            children: [
                                               p.Container(
                                                  width:161.5,
                                                height: 180.35, 
                                                child:
                                                p.Image(bg1,fit: p.BoxFit.fill),
                                              )
                                             


                                            ],
                                          ),
                                          p.Column(
                                            crossAxisAlignment: p.CrossAxisAlignment.center,

                                            children: [
                                              p.SizedBox(height: 16,),
                                              p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Container(
                                                    width:30,
                                                    height:30,
                                                    child:   p.ClipRRect(
                                                      verticalRadius: 18,
                                                      horizontalRadius: 18,
                                                      child: p.Image(schoollogoii),),
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              p.Text(schoolname,style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                              p.Text(schooladdress,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                              p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                              p.Text(schoolweb,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                              p.SizedBox(height: 8,),
                                              p.Stack(
                                                alignment: p.Alignment.center,
                                                children: [
                                                  p.Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration:  p.BoxDecoration(
                                                      color: PdfColor.fromHex("25507D"),
                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.Container(
                                                    width: 55,
                                                    height: 55,
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.ClipRRect(
                                                      horizontalRadius: 14,
                                                      verticalRadius: 20,
                                                      child:
                                                      p.Image(imglist[index][2],height: 55,width: 55))

                                                ],
                                              ),
                                              p.SizedBox(height: 8,),
                                              p.Text("${namelist[index][2]} ${lastnamelist[index][2]}",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColors.white, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                              /*p.Text("ID: ${regnolist[index][2]}",style: p.TextStyle(
                                                  font: fontrmedpoppoins,
                                                  color:  PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),*/
                                               p.SizedBox(height: 2,),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("Designation",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text("${classlist[index][2]}",style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("ID",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(regnolist[index][2],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Blood Group",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color:PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(bloodlist[index][2],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Phone No",style:  p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style:  p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(phonelist[index][2],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),]
                              ):
                               p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[
                                  p.Container(
                                    height: 16,
                                    width: 16,
                                    child: p.Image(plusicon),
                                  ),
                                  p.Container(
                                    height: 3.0,

                                  ),
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ),]
                            ),
                              namelist[index].length>3?
                              p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 252.35,
                                      width: 161.5,
                                      color:PdfColors.white,

                                      child: p.Stack(
                                        children: [
                                          p.Column(
                                            mainAxisAlignment:  p.MainAxisAlignment.end,
                                            children: [
                                               p.Container(
                                                  width:161.5,
                                                height: 180.35, 
                                                child:
                                                p.Image(bg1,fit: p.BoxFit.fill),
                                              )
                                             


                                            ],
                                          ),
                                          p.Column(
                                            crossAxisAlignment: p.CrossAxisAlignment.center,

                                            children: [
                                              p.SizedBox(height: 16,),
                                              p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Container(
                                                    width:30,
                                                    height:30,
                                                    child:   p.ClipRRect(
                                                      verticalRadius: 18,
                                                      horizontalRadius: 18,
                                                      child: p.Image(schoollogoii),),
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              p.Text(schoolname,style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                              p.Text(schooladdress,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                              p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                              p.Text(schoolweb,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                              p.SizedBox(height: 8,),
                                              p.Stack(
                                                alignment: p.Alignment.center,
                                                children: [
                                                  p.Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration:  p.BoxDecoration(
                                                      color: PdfColor.fromHex("25507D"),
                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.Container(
                                                    width: 55,
                                                    height: 55,
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.ClipRRect(
                                                      horizontalRadius: 14,
                                                      verticalRadius: 20,
                                                      child:
                                                      p.Image(imglist[index][3],height: 55,width: 55))

                                                ],
                                              ),
                                              p.SizedBox(height: 8,),
                                              p.Text("${namelist[index][3]} ${lastnamelist[index][3]}",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColors.white, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                              /*p.Text("ID: ${regnolist[index][3]}",style: p.TextStyle(
                                                  font: fontrmedpoppoins,
                                                  color:  PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),*/
                                               p.SizedBox(height: 2,),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("Designation",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text("${classlist[index][3]}",style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("ID",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(regnolist[index][3],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Blood Group",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color:PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(bloodlist[index][3],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Phone No",style:  p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style:  p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(phonelist[index][3],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),]
                              ):
                               p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[
                                  p.Container(
                                    height: 16,
                                    width: 16,
                                    child: p.Image(plusicon),
                                  ),
                                  p.Container(
                                    height: 3.0,

                                  ),
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ),]
                            ),
                              namelist[index].length>4?
                              p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 252.35,
                                      width: 161.5,
                                      color:PdfColors.white,

                                      child: p.Stack(
                                        children: [
                                          p.Column(
                                            mainAxisAlignment:  p.MainAxisAlignment.end,
                                            children: [
                                               p.Container(
                                                  width:161.5,
                                                height: 180.35, 
                                                child:
                                                p.Image(bg1,fit: p.BoxFit.fill),
                                              )
                                             


                                            ],
                                          ),
                                          p.Column(
                                            crossAxisAlignment: p.CrossAxisAlignment.center,

                                            children: [
                                              p.SizedBox(height: 16,),
                                              p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Container(
                                                    width:30,
                                                    height:30,
                                                    child:   p.ClipRRect(
                                                      verticalRadius: 18,
                                                      horizontalRadius: 18,
                                                      child: p.Image(schoollogoii),),
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              p.Text(schoolname,style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                              p.Text(schooladdress,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                              p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                              p.Text(schoolweb,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                              p.SizedBox(height: 8,),
                                              p.Stack(
                                                alignment: p.Alignment.center,
                                                children: [
                                                  p.Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration:  p.BoxDecoration(
                                                      color: PdfColor.fromHex("25507D"),
                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.Container(
                                                    width: 55,
                                                    height: 55,
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.ClipRRect(
                                                      horizontalRadius: 14,
                                                      verticalRadius: 20,
                                                      child:
                                                      p.Image(imglist[index][4],height: 55,width: 55))

                                                ],
                                              ),
                                              p.SizedBox(height: 8,),
                                              p.Text("${namelist[index][4]} ${lastnamelist[index][4]}",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColors.white, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                              /*p.Text("ID: ${regnolist[index][4]}",style: p.TextStyle(
                                                  font: fontrmedpoppoins,
                                                  color:  PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),*/
                                               p.SizedBox(height: 2,),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("Designation",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text("${classlist[index][4]}",style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("ID",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(regnolist[index][4],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Blood Group",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color:PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(bloodlist[index][4],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Phone No",style:  p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style:  p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(phonelist[index][4],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),]
                              ):
                               p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[
                                  p.Container(
                                    height: 16,
                                    width: 16,
                                    child: p.Image(plusicon),
                                  ),
                                  p.Container(
                                    height: 3.0,

                                  ),
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ),]
                            ),






                            ]
                        ),
                      ),
                      p.Container(
                        height: 30.1,

                      ),
                      p.Padding(
                        padding: p.EdgeInsets.only(left:20),
                        child:
                        p.Row(
                            mainAxisAlignment: p.MainAxisAlignment.start,
                            children: [
                              namelist[index].length>5?
                              p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[

                                    p.Container(
                                      height: 252.35,
                                      width: 161.5,
                                      color:PdfColors.white,

                                      child: p.Stack(
                                        children: [
                                          p.Column(
                                            mainAxisAlignment:  p.MainAxisAlignment.end,
                                            children: [
                                               p.Container(
                                                  width:161.5,
                                                height: 180.35, 
                                                child:
                                                p.Image(bg1,fit: p.BoxFit.fill),
                                              )
                                             


                                            ],
                                          ),
                                          p.Column(
                                            crossAxisAlignment: p.CrossAxisAlignment.center,

                                            children: [
                                              p.SizedBox(height: 16,),
                                              p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Container(
                                                    width:30,
                                                    height:30,
                                                    child:   p.ClipRRect(
                                                      verticalRadius: 18,
                                                      horizontalRadius: 18,
                                                      child: p.Image(schoollogoii),),
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              p.Text(schoolname,style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                              p.Text(schooladdress,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                              p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                              p.Text(schoolweb,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                              p.SizedBox(height: 8,),
                                              p.Stack(
                                                alignment: p.Alignment.center,
                                                children: [
                                                  p.Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration:  p.BoxDecoration(
                                                      color: PdfColor.fromHex("25507D"),
                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.Container(
                                                    width: 55,
                                                    height: 55,
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.ClipRRect(
                                                      horizontalRadius: 14,
                                                      verticalRadius: 20,
                                                      child:
                                                      p.Image(imglist[index][5],height: 55,width: 55))

                                                ],
                                              ),
                                              p.SizedBox(height: 8,),
                                              p.Text("${namelist[index][5]} ${lastnamelist[index][5]}",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColors.white, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                              /*p.Text("ID: ${regnolist[index][5]}",style: p.TextStyle(
                                                  font: fontrmedpoppoins,
                                                  color:  PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),*/
                                               p.SizedBox(height: 2,),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("Designation",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text("${classlist[index][5]}",style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("ID",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(regnolist[index][5],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Blood Group",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color:PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(bloodlist[index][5],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Phone No",style:  p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style:  p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(phonelist[index][5],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),

                                  ]
                              ): p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[

                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ), p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),

]
                            ),
                              namelist[index].length>6?
                              p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[

                                    p.Container(
                                      height: 252.35,
                                      width: 161.5,
                                      color:PdfColors.white,

                                      child: p.Stack(
                                        children: [
                                          p.Column(
                                            mainAxisAlignment:  p.MainAxisAlignment.end,
                                            children: [
                                               p.Container(
                                                  width:161.5,
                                                height: 180.35, 
                                                child:
                                                p.Image(bg1,fit: p.BoxFit.fill),
                                              )
                                             


                                            ],
                                          ),
                                          p.Column(
                                            crossAxisAlignment: p.CrossAxisAlignment.center,

                                            children: [
                                              p.SizedBox(height: 16,),
                                              p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Container(
                                                    width:30,
                                                    height:30,
                                                    child:   p.ClipRRect(
                                                      verticalRadius: 18,
                                                      horizontalRadius: 18,
                                                      child: p.Image(schoollogoii),),
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              p.Text(schoolname,style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                              p.Text(schooladdress,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                              p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                              p.Text(schoolweb,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                              p.SizedBox(height: 8,),
                                              p.Stack(
                                                alignment: p.Alignment.center,
                                                children: [
                                                  p.Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration:  p.BoxDecoration(
                                                      color: PdfColor.fromHex("25507D"),
                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.Container(
                                                    width: 55,
                                                    height: 55,
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.ClipRRect(
                                                      horizontalRadius: 14,
                                                      verticalRadius: 20,
                                                      child:
                                                      p.Image(imglist[index][6],height: 55,width: 55))

                                                ],
                                              ),
                                              p.SizedBox(height: 8,),
                                              p.Text("${namelist[index][6]} ${lastnamelist[index][6]}",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColors.white, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                              /*p.Text("ID: ${regnolist[index][6]}",style: p.TextStyle(
                                                  font: fontrmedpoppoins,
                                                  color:  PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),*/
                                               p.SizedBox(height: 2,),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("Designation",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text("${classlist[index][6]}",style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("ID",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(regnolist[index][6],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Blood Group",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color:PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(bloodlist[index][6],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Phone No",style:  p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style:  p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(phonelist[index][6],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),

                                  ]
                              ): p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[

                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ), p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),

]
                            ),
                              namelist[index].length>7?
                              p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[

                                    p.Container(
                                      height: 252.35,
                                      width: 161.5,
                                      color:PdfColors.white,

                                      child: p.Stack(
                                        children: [
                                          p.Column(
                                            mainAxisAlignment:  p.MainAxisAlignment.end,
                                            children: [
                                            
                                              p.Container(
                                                  width:161.5,
                                                height: 180.35, 
                                                child:
                                                p.Image(bg1,fit: p.BoxFit.fill),
                                              )
                                              
                                             
                                             


                                            ],
                                          ),
                                          p.Column(
                                            crossAxisAlignment: p.CrossAxisAlignment.center,

                                            children: [
                                              p.SizedBox(height: 16,),
                                              p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Container(
                                                    width:30,
                                                    height:30,
                                                    child:   p.ClipRRect(
                                                      verticalRadius: 18,
                                                      horizontalRadius: 18,
                                                      child: p.Image(schoollogoii),),
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              p.Text(schoolname,style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                              p.Text(schooladdress,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                              p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                              p.Text(schoolweb,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                              p.SizedBox(height: 8,),
                                              p.Stack(
                                                alignment: p.Alignment.center,
                                                children: [
                                                  p.Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration:  p.BoxDecoration(
                                                      color: PdfColor.fromHex("25507D"),
                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.Container(
                                                    width: 55,
                                                    height: 55,
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.ClipRRect(
                                                      horizontalRadius: 14,
                                                      verticalRadius: 20,
                                                      child:
                                                      p.Image(imglist[index][7],height: 55,width: 55))

                                                ],
                                              ),
                                              p.SizedBox(height: 8,),
                                              p.Text("${namelist[index][7]} ${lastnamelist[index][7]}",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColors.white, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                              /*p.Text("ID: ${regnolist[index][7]}",style: p.TextStyle(
                                                  font: fontrmedpoppoins,
                                                  color:  PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),*/
                                              p.SizedBox(height: 2,),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("Designation",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text("${classlist[index][7]}",style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("ID",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(regnolist[index][7],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Blood Group",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color:PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(bloodlist[index][7],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Phone No",style:  p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style:  p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(phonelist[index][7],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),

                                  ]
                              ): p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[

                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ), p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),

]
                            ),
                              namelist[index].length>8?
                              p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[

                                    p.Container(
                                      height: 252.35,
                                      width: 161.5,
                                      color:PdfColors.white,

                                      child: p.Stack(
                                        children: [
                                          p.Column(
                                            mainAxisAlignment:  p.MainAxisAlignment.end,
                                            children: [
                                               p.Container(
                                                  width:161.5,
                                                height: 180.35, 
                                                child:
                                                p.Image(bg1,fit: p.BoxFit.fill),
                                              )
                                             


                                            ],
                                          ),
                                          p.Column(
                                            crossAxisAlignment: p.CrossAxisAlignment.center,

                                            children: [
                                              p.SizedBox(height: 16,),
                                              p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Container(
                                                    width:30,
                                                    height:30,
                                                    child:   p.ClipRRect(
                                                      verticalRadius: 18,
                                                      horizontalRadius: 18,
                                                      child: p.Image(schoollogoii),),
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              p.Text(schoolname,style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                              p.Text(schooladdress,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                              p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                              p.Text(schoolweb,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                              p.SizedBox(height: 8,),
                                              p.Stack(
                                                alignment: p.Alignment.center,
                                                children: [
                                                  p.Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration:  p.BoxDecoration(
                                                      color: PdfColor.fromHex("25507D"),
                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.Container(
                                                    width: 55,
                                                    height: 55,
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.ClipRRect(
                                                      horizontalRadius: 14,
                                                      verticalRadius: 20,
                                                      child:
                                                      p.Image(imglist[index][8],height: 55,width: 55))

                                                ],
                                              ),
                                              p.SizedBox(height: 8,),
                                              p.Text("${namelist[index][8]} ${lastnamelist[index][8]}",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColors.white, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                              /*p.Text("ID: ${regnolist[index][8]}",style: p.TextStyle(
                                                  font: fontrmedpoppoins,
                                                  color:  PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),*/
                                               p.SizedBox(height: 2,),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("Designation",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text("${classlist[index][8]}",style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("ID",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(regnolist[index][8],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Blood Group",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color:PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(bloodlist[index][8],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Phone No",style:  p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style:  p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(phonelist[index][8],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),

                                  ]
                              ): p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[

                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ), p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),

]
                            ),
                              namelist[index].length>9?
                              p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[

                                    p.Container(
                                      height: 252.35,
                                      width: 161.5,
                                      color:PdfColors.white,

                                      child: p.Stack(
                                        children: [
                                          p.Column(
                                            mainAxisAlignment:  p.MainAxisAlignment.end,
                                            children: [
                                               p.Container(
                                                  width:161.5,
                                                height: 180.35, 
                                                child:
                                                p.Image(bg1,fit: p.BoxFit.fill),
                                              )
                                             


                                            ],
                                          ),
                                          p.Column(
                                            crossAxisAlignment: p.CrossAxisAlignment.center,
                                            children: [
                                              p.SizedBox(height: 16,),
                                              p.Row(
                                                mainAxisAlignment: p.MainAxisAlignment.center,
                                                children: [
                                                  p.Container(
                                                    width:30,
                                                    height:30,
                                                    child:   p.ClipRRect(
                                                      verticalRadius: 18,
                                                      horizontalRadius: 18,
                                                      child: p.Image(schoollogoii),),
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              p.Text(schoolname,style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColors.black, fontSize: 8,fontWeight: p.FontWeight.bold),),
                                              p.Text(schooladdress,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                              p.Text("Phone: +91 ${schoolphone}",style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),

                                              p.Text(schoolweb,style: p.TextStyle(
                                                  font: fontregpoppoins,
                                                  color: PdfColors.black, fontSize: 4,fontWeight: p.FontWeight.normal),),
                                              p.SizedBox(height: 8,),
                                              p.Stack(
                                                alignment: p.Alignment.center,
                                                children: [
                                                  p.Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration:  p.BoxDecoration(
                                                      color: PdfColor.fromHex("25507D"),
                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.Container(
                                                    width: 55,
                                                    height: 55,
                                                    decoration: p.BoxDecoration(
                                                      color:PdfColors.white,
                                                      shape: p.BoxShape.circle,
                                                    ),


                                                  ),
                                                  p.ClipRRect(
                                                      horizontalRadius: 14,
                                                      verticalRadius: 20,
                                                      child:
                                                      p.Image(imglist[index][9],height: 55,width: 55))

                                                ],
                                              ),
                                              p.SizedBox(height: 8,),
                                              p.Text("${namelist[index][9]} ${lastnamelist[index][9]}",style: p.TextStyle(
                                                  font: fontsemipoppoins,
                                                  color: PdfColors.white, fontSize: 10,fontWeight: p.FontWeight.bold),),
                                              /*p.Text("ID: ${regnolist[index][9]}",style: p.TextStyle(
                                                  font: fontrmedpoppoins,
                                                  color:  PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),*/
                                               p.SizedBox(height: 2,),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("Designation",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text("${classlist[index][9]}",style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child: p.Text("ID",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(regnolist[index][9],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Blood Group",style: p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color:PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style: p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(bloodlist[index][9],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),
                                              p.Row(
                                                children: [
                                                  p.SizedBox(width: 10,),
                                                  p.Container(
                                                    width:80,
                                                    child:  p.Text("Phone No",style:  p.TextStyle(
                                                        font: fontsemipoppoins,
                                                        color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  ),
                                                  p.Text(": ",style:  p.TextStyle(
                                                      font: fontsemipoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                  p.Text(phonelist[index][9],style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.white, fontSize: 8,fontWeight: p.FontWeight.normal),),
                                                ],
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),

                                  ]
                              ): p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[

                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ), p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),

]
                            ),




                            ]
                        ),),
                      p.Container(
                        height: 3.1,

                      ),
                      p.Padding(
                        padding: p.EdgeInsets.only(left:20),
                        child:
                        p.Container(
                          width:820,
                          child: p.Divider( thickness: 2,color:PdfColors.black),

                        ),
                      ),

                      p.Container(
                        height: 3.1,

                      ),
                      p.Padding(
                        padding: p.EdgeInsets.only(left:20),
                        child:
                        p.Row(
                            mainAxisAlignment: p.MainAxisAlignment.start,
                            children: [
                              namelist[index].length>5?
                              p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Transform.scale(scale: -1,
                                      child:
                                      p.Container(
                                        height: 252.35,
                                        width: 161.5,
                                        color:PdfColors.white,

                                        child: p.Stack(
                                          children: [
                                            p.Column(
                                              mainAxisAlignment: p.MainAxisAlignment.end,
                                              children: [
                                                p.Image(bg3,),
                                               

                                              ],
                                            ),
                                            p.Column(
                                              crossAxisAlignment: p.CrossAxisAlignment.center,

                                              children: [
                                                p.SizedBox(height: 16,),
                                                p.Row(
                                                  mainAxisAlignment: p.MainAxisAlignment.center,
                                                  children: [
                                                    p.Container(
                                                      width:40,
                                                      height:40, decoration: p.BoxDecoration(
                                                        shape: p.BoxShape.circle,
                                                        color:PdfColors.white
                                                    ),
                                                      child:   p.ClipRRect(
                                                        verticalRadius: 18,
                                                        horizontalRadius: 18,
                                                        child: p.Image(schoollogoii),),),
                                                  ],
                                                ),

                                                p.SizedBox(height: 10,),

                                                p.Text("Emergency Contact No",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Text("+91 ${emgphonelist[index][5]}",style: p.TextStyle(
                                                    font: fontregpoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                                p.SizedBox(height:5),
                                                p.Text("Address",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Container(
                                                  width:150,
                                                  child: p.Text(getCapitalizedName(addresslist[index][5]),style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                                ),




                                                p.Padding(
                                                  padding: p.EdgeInsets.only(left: 0.0),
                                                  child: p.Row(
                                                    mainAxisAlignment: p.MainAxisAlignment.center,
                                                    children: [
                                                      p.Column(
                                                        children: [
                                                          p.SizedBox(height:5),
                                                          p.Container(
                                                              width: 50,
                                                              height: 50,
                                                              child: p.Image(vidhaanlogo)),

                                                          p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                              font: fontsemimon,
                                                              color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )

                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ]) : p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[
                                  p.Container(
                                    height: 16,
                                    width: 16,
                                    child: p.Image(plusicon),
                                  ),
                                  p.Container(
                                    height: 3.0,

                                  ),
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ),]
                            ),
                              namelist[index].length>6?
                              p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Transform.scale(scale: -1,
                                      child:
                                      p.Container(
                                        height: 252.35,
                                        width: 161.5,
                                        color:PdfColors.white,

                                        child: p.Stack(
                                          children: [
                                            p.Column(
                                              mainAxisAlignment: p.MainAxisAlignment.end,
                                              children: [
                                                p.Image(bg3,),
                                               

                                              ],
                                            ),
                                            p.Column(
                                              crossAxisAlignment: p.CrossAxisAlignment.center,

                                              children: [
                                                p.SizedBox(height: 16,),
                                                p.Row(
                                                 mainAxisAlignment: p.MainAxisAlignment.center,
                                                  children: [
                                                    p.Container(
                                                      width:40,
                                                      height:40, decoration: p.BoxDecoration(
                                                        shape: p.BoxShape.circle,
                                                        color:PdfColors.white
                                                    ),
                                                      child:   p.ClipRRect(
                                                        verticalRadius: 18,
                                                        horizontalRadius: 18,
                                                        child: p.Image(schoollogoii),),),
                                                  ],
                                                ),
                                                p.SizedBox(height: 10,),


                                                p.Text("Emergency Contact No",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Text("+91 ${emgphonelist[index][6]}",style: p.TextStyle(
                                                    font: fontregpoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                                p.SizedBox(height:5),
                                                p.Text("Address",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Container(
                                                  width:150,
                                                  child: p.Text(getCapitalizedName(addresslist[index][6]),style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                                ),




                                                p.Padding(
                                                  padding: p.EdgeInsets.only(left: 0.0),
                                                  child: p.Row(
                                                    mainAxisAlignment: p.MainAxisAlignment.center,
                                                    children: [
                                                      p.Column(
                                                        children: [
                                                          p.SizedBox(height:5),
                                                          p.Container(
                                                              width: 50,
                                                              height: 50,
                                                              child: p.Image(vidhaanlogo)),

                                                          p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                              font: fontsemimon,
                                                              color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )

                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ]) : p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[
                                  p.Container(
                                    height: 16,
                                    width: 16,
                                    child: p.Image(plusicon),
                                  ),
                                  p.Container(
                                    height: 3.0,

                                  ),
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ),]
                            ),
                              namelist[index].length>7?
                              p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Transform.scale(scale: -1,
                                      child:
                                      p.Container(
                                        height: 252.35,
                                        width: 161.5,
                                        color:PdfColors.white,

                                        child: p.Stack(
                                          children: [
                                            p.Column(
                                              mainAxisAlignment: p.MainAxisAlignment.end,
                                              children: [
                                                p.Image(bg3,),
                                               

                                              ],
                                            ),
                                            p.Column(
                                              crossAxisAlignment: p.CrossAxisAlignment.center,

                                              children: [
                                                p.SizedBox(height: 16,),
                                                p.Row(
                                                 mainAxisAlignment: p.MainAxisAlignment.center,
                                                  children: [
                                                    p.Container(
                                                      width:40,
                                                      height:40, decoration: p.BoxDecoration(
                                                        shape: p.BoxShape.circle,
                                                        color:PdfColors.white
                                                    ),
                                                      child:   p.ClipRRect(
                                                        verticalRadius: 18,
                                                        horizontalRadius: 18,
                                                        child: p.Image(schoollogoii),),),
                                                  ],
                                                ),
                                                p.SizedBox(height: 10,),


                                                p.Text("Emergency Contact No",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Text("+91 ${emgphonelist[index][7]}",style: p.TextStyle(
                                                    font: fontregpoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                                p.SizedBox(height:5),
                                                p.Text("Address",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Container(
                                                  width:150,
                                                  child: p.Text(getCapitalizedName(addresslist[index][7]),style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                                ),




                                                p.Padding(
                                                  padding: p.EdgeInsets.only(left: 0.0),
                                                  child: p.Row(
                                                    mainAxisAlignment: p.MainAxisAlignment.center,
                                                    children: [
                                                      p.Column(
                                                        children: [
                                                          p.SizedBox(height:5),
                                                          p.Container(
                                                              width: 50,
                                                              height: 50,
                                                              child: p.Image(vidhaanlogo)),

                                                          p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                              font: fontsemimon,
                                                              color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )

                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ]) : p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[
                                  p.Container(
                                    height: 16,
                                    width: 16,
                                    child: p.Image(plusicon),
                                  ),
                                  p.Container(
                                    height: 3.0,

                                  ),
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ),]
                            ),
                              namelist[index].length>8? p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Transform.scale(scale: -1,
                                      child:
                                      p.Container(
                                        height: 252.35,
                                        width: 161.5,
                                        color:PdfColors.white,

                                        child: p.Stack(
                                          children: [
                                            p.Column(
                                              mainAxisAlignment: p.MainAxisAlignment.end,
                                              children: [
                                                p.Image(bg3,),
                                               

                                              ],
                                            ),
                                            p.Column(
                                              crossAxisAlignment: p.CrossAxisAlignment.center,

                                              children: [
                                                p.SizedBox(height: 16,),
                                                p.Row(
                                                 mainAxisAlignment: p.MainAxisAlignment.center,
                                                  children: [
                                                    p.Container(
                                                      width:40,
                                                      height:40, decoration: p.BoxDecoration(
                                                        shape: p.BoxShape.circle,
                                                        color:PdfColors.white
                                                    ),
                                                      child:   p.ClipRRect(
                                                        verticalRadius: 18,
                                                        horizontalRadius: 18,
                                                        child: p.Image(schoollogoii),),),
                                                  ],
                                                ),
                                                p.SizedBox(height: 10,),


                                                p.Text("Emergency Contact No",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Text("+91 ${emgphonelist[index][8]}",style: p.TextStyle(
                                                    font: fontregpoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                                p.SizedBox(height:5),
                                                p.Text("Address",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Container(
                                                  width:150,
                                                  child: p.Text(getCapitalizedName(addresslist[index][8]),style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                                ),




                                                p.Padding(
                                                  padding: p.EdgeInsets.only(left: 0.0),
                                                  child: p.Row(
                                                    mainAxisAlignment: p.MainAxisAlignment.center,
                                                    children: [
                                                      p.Column(
                                                        children: [
                                                          p.SizedBox(height:5),
                                                          p.Container(
                                                              width: 50,
                                                              height: 50,
                                                              child: p.Image(vidhaanlogo)),

                                                          p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                              font: fontsemimon,
                                                              color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )

                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ]) : p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[
                                  p.Container(
                                    height: 16,
                                    width: 16,
                                    child: p.Image(plusicon),
                                  ),
                                  p.Container(
                                    height: 3.0,

                                  ),
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ),]
                            ),
                              namelist[index].length>9? p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Transform.scale(scale: -1,
                                      child:
                                      p.Container(
                                        height: 252.35,
                                        width: 161.5,
                                        color:PdfColors.white,

                                        child: p.Stack(
                                          children: [
                                            p.Column(
                                              mainAxisAlignment: p.MainAxisAlignment.end,
                                              children: [
                                                p.Image(bg3,),
                                               

                                              ],
                                            ),
                                            p.Column(
                                              crossAxisAlignment: p.CrossAxisAlignment.center,

                                              children: [
                                                p.SizedBox(height: 16,),
                                                p.Row(
                                                 mainAxisAlignment: p.MainAxisAlignment.center,
                                                  children: [
                                                    p.Container(
                                                      width:40,
                                                      height:40, decoration: p.BoxDecoration(
                                                        shape: p.BoxShape.circle,
                                                        color:PdfColors.white
                                                    ),
                                                      child:   p.ClipRRect(
                                                        verticalRadius: 18,
                                                        horizontalRadius: 18,
                                                        child: p.Image(schoollogoii),),),
                                                  ],
                                                ),
                                                p.SizedBox(height: 10,),


                                                p.Text("Emergency Contact No",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Text("+91 ${emgphonelist[index][9]}",style: p.TextStyle(
                                                    font: fontregpoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                                p.SizedBox(height:5),
                                                p.Text("Address",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Container(
                                                  width:150,
                                                  child: p.Text(getCapitalizedName(addresslist[index][9]),style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                                ),




                                                p.Padding(
                                                  padding: p.EdgeInsets.only(left: 0.0),
                                                  child: p.Row(
                                                    mainAxisAlignment: p.MainAxisAlignment.center,
                                                    children: [
                                                      p.Column(
                                                        children: [
                                                          p.SizedBox(height:5),
                                                          p.Container(
                                                              width: 50,
                                                              height: 50,
                                                              child: p.Image(vidhaanlogo)),

                                                          p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                              font: fontsemimon,
                                                              color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )

                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ]) : p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[
                                  p.Container(
                                    height: 16,
                                    width: 16,
                                    child: p.Image(plusicon),
                                  ),
                                  p.Container(
                                    height: 3.0,

                                  ),
                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ),]
                            ),







                            ]
                        ),
                      ),
                      p.Container(
                        height: 30.1,
                      ),
                      p.Padding(
                        padding: p.EdgeInsets.only(left:20),
                        child:
                        p.Row(
                            mainAxisAlignment: p.MainAxisAlignment.start,
                            children: [
                              namelist[index].length>0?
                              p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[
                                    p.Transform.scale(scale: -1,
                                      child:
                                      p.Container(
                                        height: 252.35,
                                        width: 161.5,
                                        color:PdfColors.white,

                                        child: p.Stack(
                                          children: [
                                            p.Column(
                                              mainAxisAlignment: p.MainAxisAlignment.end,
                                              children: [
                                                p.Image(bg3,),
                                               

                                              ],
                                            ),
                                            p.Column(
                                              crossAxisAlignment: p.CrossAxisAlignment.center,

                                              children: [
                                                p.SizedBox(height: 16,),
                                                p.Row(
                                                 mainAxisAlignment: p.MainAxisAlignment.center,
                                                  children: [
                                                    p.Container(
                                                      width:40,
                                                      height:40, decoration: p.BoxDecoration(
                                                        shape: p.BoxShape.circle,
                                                        color:PdfColors.white
                                                    ),
                                                      child:   p.ClipRRect(
                                                        verticalRadius: 18,
                                                        horizontalRadius: 18,
                                                        child: p.Image(schoollogoii),),),
                                                  ],
                                                ),
                                                p.SizedBox(height: 10,),


                                                p.Text("Emergency Contact No",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Text("+91 ${emgphonelist[index][0]}",style: p.TextStyle(
                                                    font: fontregpoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                                p.SizedBox(height:5),
                                                p.Text("Address",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Container(
                                                  width:150,
                                                  child: p.Text(getCapitalizedName(addresslist[index][0]),style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                                ),




                                                p.Padding(
                                                  padding: p.EdgeInsets.only(left: 0.0),
                                                  child: p.Row(
                                                    mainAxisAlignment: p.MainAxisAlignment.center,
                                                    children: [
                                                      p.Column(
                                                        children: [
                                                          p.SizedBox(height:5),
                                                          p.Container(
                                                              width: 50,
                                                              height: 50,
                                                              child: p.Image(vidhaanlogo)),

                                                          p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                              font: fontsemimon,
                                                              color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )

                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),
                                  ]): p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[

                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ), p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),

]
                            ),
                              namelist[index].length>1? p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[
                                    p.Transform.scale(scale: -1,
                                      child:
                                      p.Container(
                                        height: 252.35,
                                        width: 161.5,
                                        color:PdfColors.white,

                                        child: p.Stack(
                                          children: [
                                            p.Column(
                                              mainAxisAlignment: p.MainAxisAlignment.end,
                                              children: [
                                                p.Image(bg3,),
                                               

                                              ],
                                            ),
                                            p.Column(
                                              crossAxisAlignment: p.CrossAxisAlignment.center,

                                              children: [
                                                p.SizedBox(height: 16,),
                                                p.Container(
                                                  width:40,
                                                  height:40, decoration: p.BoxDecoration(
                                                    shape: p.BoxShape.circle,
                                                    color:PdfColors.white
                                                ),
                                                  child:   p.ClipRRect(
                                                    verticalRadius: 18,
                                                    horizontalRadius: 18,
                                                    child: p.Image(schoollogoii),),),
                                                p.SizedBox(height: 10,),


                                                p.Text("Emergency Contact No",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Text("+91 ${emgphonelist[index][1]}",style: p.TextStyle(
                                                    font: fontregpoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                                p.SizedBox(height:5),
                                                p.Text("Address",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Container(
                                                  width:150,
                                                  child: p.Text(getCapitalizedName(addresslist[index][1]),style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                                ),




                                                p.Padding(
                                                  padding: p.EdgeInsets.only(left: 0.0),
                                                  child: p.Row(
                                                    mainAxisAlignment: p.MainAxisAlignment.center,
                                                    children: [
                                                      p.Column(
                                                        children: [
                                                          p.SizedBox(height:5),
                                                          p.Container(
                                                              width: 50,
                                                              height: 50,
                                                              child: p.Image(vidhaanlogo)),

                                                          p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                              font: fontsemimon,
                                                              color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )

                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),
                                  ]) : p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[

                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ), p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),

]
                            ),
                              namelist[index].length>2?  p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[
                                    p.Transform.scale(scale: -1,
                                      child:
                                      p.Container(
                                        height: 252.35,
                                        width: 161.5,
                                        color:PdfColors.white,

                                        child: p.Stack(
                                          children: [
                                            p.Column(
                                              mainAxisAlignment: p.MainAxisAlignment.end,
                                              children: [
                                                p.Image(bg3,),
                                               

                                              ],
                                            ),
                                            p.Column(
                                              crossAxisAlignment: p.CrossAxisAlignment.center,

                                              children: [
                                                p.SizedBox(height: 16,),
                                                p.Row(
                                                 mainAxisAlignment: p.MainAxisAlignment.center,
                                                  children: [
                                                    p.Container(
                                                      width:40,
                                                      height:40, decoration: p.BoxDecoration(
                                                        shape: p.BoxShape.circle,
                                                        color:PdfColors.white
                                                    ),
                                                      child:   p.ClipRRect(
                                                        verticalRadius: 18,
                                                        horizontalRadius: 18,
                                                        child: p.Image(schoollogoii),),),
                                                  ],
                                                ),
                                                p.SizedBox(height: 10,),


                                                p.Text("Emergency Contact No",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Text("+91 ${emgphonelist[index][2]}",style: p.TextStyle(
                                                    font: fontregpoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                                p.SizedBox(height:5),
                                                p.Text("Address",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Container(
                                                  width:150,
                                                  child: p.Text(getCapitalizedName(addresslist[index][2]),style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                                ),




                                                p.Padding(
                                                  padding: p.EdgeInsets.only(left: 0.0),
                                                  child: p.Row(
                                                    mainAxisAlignment: p.MainAxisAlignment.center,
                                                    children: [
                                                      p.Column(
                                                        children: [
                                                          p.SizedBox(height:5),
                                                          p.Container(
                                                              width: 50,
                                                              height: 50,
                                                              child: p.Image(vidhaanlogo)),

                                                          p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                              font: fontsemimon,
                                                              color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )

                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),
                                  ]) : p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[

                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ), p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),

]
                            ),
                              namelist[index].length>3? p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[
                                    p.Transform.scale(scale: -1,
                                      child:
                                      p.Container(
                                        height: 252.35,
                                        width: 161.5,
                                        color:PdfColors.white,

                                        child: p.Stack(
                                          children: [
                                            p.Column(
                                              mainAxisAlignment: p.MainAxisAlignment.end,
                                              children: [
                                                p.Image(bg3,),
                                               

                                              ],
                                            ),
                                            p.Column(
                                              crossAxisAlignment: p.CrossAxisAlignment.center,

                                              children: [
                                                p.SizedBox(height: 16,),
                                                p.Row(
                                                 mainAxisAlignment: p.MainAxisAlignment.center,
                                                  children: [
                                                    p.Container(
                                                      width:40,
                                                      height:40, decoration: p.BoxDecoration(
                                                        shape: p.BoxShape.circle,
                                                        color:PdfColors.white
                                                    ),
                                                      child:   p.ClipRRect(
                                                        verticalRadius: 18,
                                                        horizontalRadius: 18,
                                                        child: p.Image(schoollogoii),),),
                                                  ],
                                                ),
                                                p.SizedBox(height: 10,),


                                                p.Text("Emergency Contact No",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Text("+91 ${emgphonelist[index][3]}",style: p.TextStyle(
                                                    font: fontregpoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                                p.SizedBox(height:5),
                                                p.Text("Address",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Container(
                                                  width:150,
                                                  child: p.Text(getCapitalizedName(addresslist[index][3]),style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                                ),




                                                p.Padding(
                                                  padding: p.EdgeInsets.only(left: 0.0),
                                                  child: p.Row(
                                                    mainAxisAlignment: p.MainAxisAlignment.center,
                                                    children: [
                                                      p.Column(
                                                        children: [
                                                          p.SizedBox(height:5),
                                                          p.Container(
                                                              width: 50,
                                                              height: 50,
                                                              child: p.Image(vidhaanlogo)),

                                                          p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                              font: fontsemimon,
                                                              color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )

                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),
                                  ]) : p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[

                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ), p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),

]
                            ),
                              namelist[index].length>4? p.Column(
                                  crossAxisAlignment: p.CrossAxisAlignment.center,
                                  children:[
                                    p.Transform.scale(scale: -1,
                                      child:
                                      p.Container(
                                        height: 252.35,
                                        width: 161.5,
                                        color:PdfColors.white,

                                        child: p.Stack(
                                          children: [
                                            p.Column(
                                              mainAxisAlignment: p.MainAxisAlignment.end,
                                              children: [
                                                p.Image(bg3,),
                                               

                                              ],
                                            ),
                                            p.Column(
                                              crossAxisAlignment: p.CrossAxisAlignment.center,

                                              children: [
                                                p.SizedBox(height: 16,),
                                                p.Row(
                                                 mainAxisAlignment: p.MainAxisAlignment.center,
                                                  children: [
                                                    p.Container(
                                                      width:40,
                                                      height:40, decoration: p.BoxDecoration(
                                                        shape: p.BoxShape.circle,
                                                        color:PdfColors.white
                                                    ),
                                                      child:   p.ClipRRect(
                                                        verticalRadius: 18,
                                                        horizontalRadius: 18,
                                                        child: p.Image(schoollogoii),),),
                                                  ],
                                                ),
                                                p.SizedBox(height: 10,),


                                                p.Text("Emergency Contact No",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Text("+91 ${emgphonelist[index][4]}",style: p.TextStyle(
                                                    font: fontregpoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),
                                                p.SizedBox(height:5),
                                                p.Text("Address",style: p.TextStyle(
                                                    font: fontsemipoppoins,
                                                    color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),),

                                                p.Container(
                                                    width:90,
                                                    height:2,
                                                    child: p.Divider()
                                                ),
                                                p.SizedBox(height: 2,),

                                                p.Container(
                                                  width:150,
                                                  child: p.Text(getCapitalizedName(addresslist[index][4]),style: p.TextStyle(
                                                      font: fontregpoppoins,
                                                      color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal),textAlign: p.TextAlign.center),
                                                ),




                                                p.Padding(
                                                  padding: p.EdgeInsets.only(left: 0.0),
                                                  child: p.Row(
                                                    mainAxisAlignment: p.MainAxisAlignment.center,
                                                    children: [
                                                      p.Column(
                                                        children: [
                                                          p.SizedBox(height:5),
                                                          p.Container(
                                                              width: 50,
                                                              height: 50,
                                                              child: p.Image(vidhaanlogo)),

                                                          p.Text("e  d  u  c  a  r  e",style: p.TextStyle(
                                                              font: fontsemimon,
                                                              color: PdfColors.black, fontSize: 7,fontWeight: p.FontWeight.normal)),

                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )

                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),
                                  ]) : p.Column(
                                crossAxisAlignment: p.CrossAxisAlignment.center,
                                children:[

                                  p.Container(
                                    height: 252.35,
                                    width: 161.5,
                                    color:PdfColors.white,
                                  ), p.Container(
                                      height: 3.0,

                                    ),
                                    p.Container(
                                      height: 16,
                                      width: 16,
                                      child: p.Image(plusicon),
                                    ),

]
                            ),



                            ]
                        ),
                      ),



                    ]));
            }, itemCount: namelist.length)



        ));

    final pdf = p.Document();
    pdf.addPage(

      p.MultiPage(
        pageFormat: PdfPageFormat.a3,
        orientation: p.PageOrientation.portrait,
        margin: p.EdgeInsets.all(0),
        build: (context) => widgets, //here goes the widgets list
      ),
    );
    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

    setState(() {

    });
  }
  String getCapitalizedName(String name) {
    final names = name.split(' ');
    String finalName = '';
    for (var n in names) {
      n.trim();
      if (n.isNotEmpty) {
        finalName += '${n[0].toUpperCase()}${n.substring(1)} ';
      }
    }
    return finalName.trim();
  }

  List namelist = [];
  List lastnamelist = [];
  List imglist = [];
  List regnolist = [];
  List classlist = [];
  List doblist = [];
  List bloodlist = [];
  List phonelist = [];
  List emgphonelist = [];
  List addresslist = [];
  addinglist() async {
    var doucment = await FirebaseFirestore.instance.collection("Staffs").orderBy("timestamp").get();
    print("Reg NO changed successfully");
    int temp= doucment.docs.length~/10;
    int remainder = doucment.docs.length.remainder(10);
    int pagecount=0;
    int g=0;
    print(temp);
    print(remainder);
    if(remainder!=0){
      setState(() {
        pagecount=temp+1;
      });
    }
    print(pagecount);
    for (int i=0;i<pagecount;i++){
      setState(() {


        namelist.add([]);
        lastnamelist.add([]);
        imglist.add([]);
        regnolist.add([]);
        classlist.add([]);
        doblist.add([]);
        bloodlist.add([]);
        phonelist.add([]);
        emgphonelist.add([]);
        addresslist.add([]);
      });
    }
    for (int j=0;j<doucment.docs.length;j++) {

      setState(()  {
        namelist[g].add(doucment.docs[j]["stname"]);
        lastnamelist[g].add(doucment.docs[j]["stlastname"]);
        regnolist[g].add(doucment.docs[j]["regno"]);
        classlist[g].add(doucment.docs[j]["designation"]);
        doblist[g].add(doucment.docs[j]["dob"]);
        bloodlist[g].add(doucment.docs[j]["bloodgroup"]);
        phonelist[g].add(doucment.docs[j]["mobile"]);
        emgphonelist[g].add(doucment.docs[j]["Spousephone"]);
        addresslist[g].add(doucment.docs[j]["address"]);
      });
      imglist[g].add(await flutterImageProvider(NetworkImage(doucment.docs[j]["imgurl"]==""?"https://firebasestorage.googleapis.com/v0/b/vidhaan-4aee7.appspot.com/o/360_F_270188580_YDUEwBmDIxBMvCQxkcunmEkm93VqOgqm.jpg?alt=media&token=fe18ba43-4a31-4b53-9523-42bb4241d9a1":doucment.docs[j]["imgurl"])));

      if((j+1)%10==0){
        printtext(g);
        setState(() {
          g=g+1;
        });
      }
    }
    print("Added sucessfully");



  }
  printtext(g){
    print(namelist[g].length);
    print(imglist[g].length);
    print(regnolist[g].length);
    print(classlist[g].length);
    print(doblist[g].length);
    print(bloodlist[g].length);
    print(phonelist[g].length);
    print("Next Set------------------------${g+1}");
  }



  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
    return  view==false?   Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(child: Padding(
                padding: const EdgeInsets.only(left: 38.0,top: 30),
                child: Text("Staffs List",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),),
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
                        _typeAheadControllerstaffid.clear();
                      });
                    },
                    child: Container(child: Center(child: Text("Clear Search",style: GoogleFonts.poppins(color:Colors.white),)),
                      width: width/10.507,
                      height: height/16.425,
                      // color:Color(0xff00A0E3),
                      decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(5)),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: InkWell(
                      onTap: (){

                        setState(() {
                          view=true;
                        });
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(5),
                        elevation: 7,
                        child: Container(child: Center(child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.image_aspect_ratio,color: Colors.white,),
                            ),
                            Text("View Templates",style: GoogleFonts.poppins(color:Colors.white),),
                          ],
                        )),
                          width: width/8.507,
                          height: height/16.425,
                          // color:Color(0xff00A0E3),
                          decoration: BoxDecoration(color: const Color(0xff53B175),borderRadius: BorderRadius.circular(5)),

                        ),
                      ),
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
                                  child: AnimatedContainer(
                                    duration: Duration(seconds: 1),
                                    width: width/1.366,
                                    height: expand[index]==false?50:500,
                                    child: Column(
                                      children: [
                                        Row(
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
                                                if(expand[index]==true) {
                                                  setState(() {
                                                    expand[index] = false;
                                                  });
                                                }else{
                                                  setState(() {
                                                    expand[index] = true;
                                                  });
                                                }
                                              },
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(left: 45.0),
                                                child: expand[index]==false? Container(
                                                  width: width/22.76,
                                                  height: height/21.9,
                                                  //color: Color(0xffD60A0B),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                    color: Color(0xff53B175),
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                        "View",
                                                        style: GoogleFonts.poppins(
                                                            color: Colors.white),
                                                      )),
                                                ) :
                                                Container(
                                                  width: width/22.76,
                                                  height: height/21.9,
                                                  //color: Color(0xffD60A0B),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                    color: Colors.red,
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                        "Close",
                                                        style: GoogleFonts.poppins(
                                                            color: Colors.white),
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        expand[index]!=false? idcarddesign=="1"?

                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Material(

                                                    child: Container(
                                                      width: 260,
                                                      height: 450,

                                                      child: Stack(
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Image.asset("assets/staffid1.png",color: pickerColor,),


                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,

                                                            children: [
                                                              SizedBox(height: 20,),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Container(
                                                                      width:50,
                                                                      height:50, decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(25),

                                                                  ),
                                                                      child: Image.network(schoollogo)),
                                                                ],
                                                              ),
                                                              SizedBox(height: 2,),
                                                              Text(schoolname,style: GoogleFonts.poppins(
                                                                  color: pickerColor, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                              Text(schooladdress,style: GoogleFonts.poppins(
                                                                  color: pickerColor, fontSize: 8,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                                                              Text("Phone: +91 ${schoolphone}",style: GoogleFonts.poppins(
                                                                  color: pickerColor, fontSize: 8,fontWeight: FontWeight.w400),),

                                                              Text(schoolweb,style: GoogleFonts.poppins(
                                                                  color: pickerColor, fontSize: 8,fontWeight: FontWeight.w400),),
                                                              SizedBox(height: 0,),
                                                              Stack(
                                                                alignment: Alignment.center,
                                                                children: [
                                                                  Container(
                                                                    width: 120,
                                                                    height: 120,
                                                                    decoration: BoxDecoration(
                                                                        color: pickerColor,
                                                                        borderRadius: BorderRadius.circular(60)
                                                                    ),


                                                                  ),
                                                                  Container(
                                                                    width: 112,
                                                                    height: 112,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(50)
                                                                    ),
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(60),
                                                                        child: Image.network(value!['imgurl']==""?"https://firebasestorage.googleapis.com/v0/b/vidhaan-4aee7.appspot.com/o/teacher.jpg?alt=media&token=1782c5a6-34c3-42ab-819f-07d52ea06014"
                                        :value['imgurl'],fit:BoxFit.cover,),),
                                                                  ),

                                                                ],
                                                              ),
                                                              SizedBox(height: 15,),
                                                              Text(value["stname"],style: GoogleFonts.poppins(
                                                                  color: Colors.white, fontSize: 15,fontWeight: FontWeight.w700),),
                                                              Text("ID: ${value["regno"]}",style: GoogleFonts.poppins(
                                                                  color:  Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                              SizedBox(height: 10,),
                                                              Row(

                                                                children: [
                                                                  SizedBox(width:20),
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          SizedBox(width: 20,),
                                                                          Container(
                                                                            width: 90,

                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text("Designation",style: GoogleFonts.poppins(
                                                                                    color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                                Text(" : ",style: GoogleFonts.poppins(
                                                                                    color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Text(value["designation"],style: GoogleFonts.poppins(
                                                                              color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          SizedBox(width: 20,),
                                                                          Container(
                                                                            width:90,
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text("DOB",style: GoogleFonts.poppins(

                                                                                    color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                                Text(" : ",style: GoogleFonts.poppins(
                                                                                    color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Text(value["dob"],style: GoogleFonts.poppins(
                                                                              color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          SizedBox(width: 20,),
                                                                          Container(
                                                                            width:90,
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text("Blood Group",style: GoogleFonts.poppins(
                                                                                    color:Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                                Text(" : ",style: GoogleFonts.poppins(
                                                                                    color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Text(value["bloodgroup"],style: GoogleFonts.poppins(
                                                                              color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          SizedBox(width: 20,),
                                                                          Container(
                                                                            width:90,
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text("Phone",style: GoogleFonts.poppins(
                                                                                    color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                                Text(" : ",style: GoogleFonts.poppins(
                                                                                    color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Text(value["mobile"],style: GoogleFonts.poppins(
                                                                              color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),


                                                            ],
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 50,),
                                                  Container(
                                                    width: 260,
                                                    height: 450,
                                                    child: Stack(
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [

                                                            Image.asset("assets/staffid2.png",color: pickerColor,),

                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,

                                                          children: [
                                                            SizedBox(height: 20,),
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 25.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                      Container(
                                                                          width:60,
                                                                          height:60, decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(30),

                                                                      ),
                                                                          child: Image.network(schoollogo)),
                                                                      Text(schoolname,style: GoogleFonts.poppins(
                                                                          color: pickerColor, fontSize: 8,fontWeight: FontWeight.w400),textAlign: TextAlign.center),

                                                                      Text(schoolweb,style: GoogleFonts.poppins(
                                                                          color: pickerColor, fontSize: 8,fontWeight: FontWeight.w400),),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(height: 15,),

                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 20.0),
                                                              child: Text("Emergency Contact",style: GoogleFonts.poppins(
                                                                  color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                                            ),
                                                            Text("",style: GoogleFonts.poppins(
                                                                color: Color(0xff0271C5), fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                            SizedBox(height: 10,),
                                                            Row(
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Container(
                                                                  width: 110,
                                                                  child: Text("Emergency Contact No : ",style: GoogleFonts.poppins(
                                                                      color: pickerColor, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                ),
                                                                Text(value["Spousephone"],style: GoogleFonts.poppins(
                                                                    color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                              ],
                                                            ),
                                                            Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(width: 20,),
                                                                Container(
                                                                  width: 90,
                                                                  child: Text("Address : ",style: GoogleFonts.poppins(

                                                                      color: pickerColor, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                ),
                                                                Container(
                                                                  width: 150,
                                                                  child: Text(value["address"],style: GoogleFonts.poppins(
                                                                      color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                                ),
                                                              ],
                                                            ),

                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 0.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      SizedBox(height:5),
                                                                      Container(
                                                                          width: 75,
                                                                          height: 75,
                                                                          child: Image.asset("assets/VIDHAANLOGO.png",fit: BoxFit.contain,)),

                                                                      Text("e    d    u    c    a    r    e",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: 7),),
                                                                      SizedBox(height:7),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            )

                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 50,),
                                                ],
                                              ),
                                            ) : Container() : Container()
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
      ),

        floatingActionButton: mainconcent==true || check.contains(true)? InkWell(
          onTap: (){
            getvalue();
          },
          child: Padding(
            padding: const EdgeInsets.only(left:10.0),
            child: Material(
              borderRadius: BorderRadius.circular(5),
              elevation: 7,
              child: Container(child: Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.print,color: Colors.white,),
                  ),
                  Text("Print",style: GoogleFonts.poppins(color:Colors.white),textAlign: TextAlign.center,),
                ],
              )),
                width: width/13.507,
                height: height/16.425,
                // color:Color(0xff00A0E3),
                decoration: BoxDecoration(color: const Color(0xff53B175),borderRadius: BorderRadius.circular(5)),

              ),
            ),
          ),
        ) : Container()
    ) :
    SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:20.0),
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      view=false;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
                Text("Select Templates",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: width/68.3),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation:7,
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Material(

                          child: Container(
                            width: 260,
                            height: 450,

                            child: Stack(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image.asset("assets/staffid1.png",color: pickerColor,),


                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [
                                    SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            width:50,
                                            height:50, decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),

                                        ),
                                            child: Image.network(schoollogo)),
                                      ],
                                    ),
                                    SizedBox(height: 2,),
                                    Text(schoolname,style: GoogleFonts.poppins(
                                        color: pickerColor, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                    Text(schooladdress,style: GoogleFonts.poppins(
                                        color: pickerColor, fontSize: 8,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                                    Text("Phone: +91 ${schoolphone}",style: GoogleFonts.poppins(
                                        color: pickerColor, fontSize: 8,fontWeight: FontWeight.w400),),

                                    Text(schoolweb,style: GoogleFonts.poppins(
                                        color: pickerColor, fontSize: 8,fontWeight: FontWeight.w400),),
                                    SizedBox(height: 0,),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                              color: pickerColor,
                                              borderRadius: BorderRadius.circular(60)
                                          ),


                                        ),
                                        Container(
                                          width: 112,
                                          height: 112,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50)
                                          ),
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(60),
                                              child: Image.asset("assets/teacher.jpg",fit: BoxFit.cover,)),
                                        ),

                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Text("Sam Jebaseelan",style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 15,fontWeight: FontWeight.w700),),
                                    Text("ID: VBSB004",style: GoogleFonts.poppins(
                                        color:  Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                    SizedBox(height: 10,),
                                    Row(

                                      children: [
                                        SizedBox(width:50),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(width: 20,),
                                                Text("Designation       : ",style: GoogleFonts.poppins(
                                                    color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                Text("Senior",style: GoogleFonts.poppins(
                                                    color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(width: 20,),
                                                Text("DOB          : ",style: GoogleFonts.poppins(

                                                    color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                Text("05/05/2002",style: GoogleFonts.poppins(
                                                    color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(width: 20,),
                                                Text("Blood Group : ",style: GoogleFonts.poppins(
                                                    color:Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                Text("B+ve",style: GoogleFonts.poppins(
                                                    color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(width: 20,),
                                                Text("Phone      : ",style: GoogleFonts.poppins(
                                                    color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                                Text("789456213",style: GoogleFonts.poppins(
                                                    color: Colors.white, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),


                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 50,),
                        Container(
                          width: 260,
                          height: 450,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  Image.asset("assets/staffid2.png",color: pickerColor,),

                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                width:60,
                                                height:60, decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),

                                            ),
                                                child: Image.network(schoollogo)),
                                            Text(schoolname,style: GoogleFonts.poppins(
                                                color: pickerColor, fontSize: 8,fontWeight: FontWeight.w400),textAlign: TextAlign.center),

                                            Text(schoolweb,style: GoogleFonts.poppins(
                                                color: pickerColor, fontSize: 8,fontWeight: FontWeight.w400),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15,),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text("Emergency Contact",style: GoogleFonts.poppins(
                                        color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),),
                                  ),
                                  Text("",style: GoogleFonts.poppins(
                                      color: Color(0xff0271C5), fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      SizedBox(width: 20,),
                                      Container(
                                        width: 110,
                                        child: Text("Emergency Contact No : ",style: GoogleFonts.poppins(
                                            color: pickerColor, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                      ),
                                      Text("9944861235",style: GoogleFonts.poppins(
                                          color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 20,),
                                      Container(
                                        width: 110,
                                        child: Text("Address : ",style: GoogleFonts.poppins(

                                            color: pickerColor, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                      ),
                                      Text("No120/2 Kolathur \nChennai",style: GoogleFonts.poppins(
                                          color: Colors.black, fontSize: width/113.833333333,fontWeight: FontWeight.w600),),
                                    ],
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(height:5),
                                            Container(
                                                width: 75,
                                                height: 75,
                                                child: Image.asset("assets/VIDHAANLOGO.png",fit: BoxFit.contain,)),

                                            Text("e    d    u    c    a    r    e",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: 7),),
                                            SizedBox(height:7),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )

                                ],
                              ),

                            ],
                          ),
                        ),
                        SizedBox(width: 50,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Text("Card Design 1",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: width/68.3),),
                            Text("Change Color:",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 15),),

                            Container(
                              width: 465,
                              child: ColorPicker(
                                colorPickerWidth: 120,
                                pickerColor: pickerColor,
                                onColorChanged: changeColor,
                                hexInputBar: true,
                                enableAlpha: false,
                                displayThumbColor: false,

                                onHistoryChanged: (value)  {
                                  print(value);
                                },

                                onHsvColorChanged: (value)  {
                                  print(value);
                                },

                              ),
                            ),
                            SizedBox(height: 10,),
                            InkWell(
                              onTap: (){
                                selectdesign("1");
                                Successdialog();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Center(
                                      child: Text(
                                        "Select Design",
                                        style: GoogleFonts.poppins(color: Color(0xffFFFFFF)),
                                      )),
                                  width: width/6.83,
                                  //color: Color(0xff00A0E3),
                                  height: height/16.425,
                                  decoration: BoxDecoration(
                                      color: Color(0xff53B175),
                                      borderRadius: BorderRadius.circular(6)),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
  Successdialog(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Design Changed Successfully',
      desc: '',


      btnOkText: "Ok",
      btnOkOnPress: () {

      },
    )..show();
  }
  selectdesign(value) async {
    var document = await FirebaseFirestore.instance.collection("Admin").get();
    FirebaseFirestore.instance.collection("Admin").doc(document.docs[0].id).update({

      "staffidcard":value
    });
    getadmin();
  }
}
