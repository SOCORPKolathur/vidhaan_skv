import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import '../fees/fees.dart';
import '../progressreports.dart';


Future<Uint8List> generateProgressReportPdf(PdfPageFormat pageFormat,List<ExamWithSubjectModel> exams,Map<String,dynamic> student,String schoolName,String schAddress,String schlLogo) async {

  final attendance = FeesModelforPdfPrint(
      accentColor: PdfColors.pink,
      baseColor: PdfColors.purple900,
      customerAddress: '',
      customerName: '',
      invoiceNumber: '',
      paymentInfo: '',
      tax: 1,
      title: "Attendance",
      exams: exams,
      products: [],
    schlAddress: schAddress,
    schlLogo: schlLogo,
    schlName: schoolName,
    student: student
  );

  return await attendance.buildPdf(pageFormat);
}

class FeesModelforPdfPrint{

  FeesModelforPdfPrint({required this.schlAddress, required this.schlLogo, required this.schlName, required this.student,required this.products,required this.customerName, required this.customerAddress,required  this.invoiceNumber,required  this.tax,required  this.paymentInfo,required  this.baseColor,required  this.accentColor, required this.title, required this.exams});
  String? title;
  List<ExamWithSubjectModel> exams;

  final String customerName;
  final List products;
  final String customerAddress;
  final String invoiceNumber;
  final double tax;
  final String paymentInfo;
  final String schlName;
  final String schlLogo;
  final String schlAddress;
  final PdfColor baseColor;
  final PdfColor accentColor;
  final Map<String,dynamic> student;

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  PdfColor get _baseTextColor => baseColor.isLight ? _lightColor : _darkColor;

  PdfColor get _accentTextColor => baseColor.isLight ? _lightColor : _darkColor;


  String? _logo;

  String? _bgShape;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {

    final studentImage = await networkImage(student['imgurl']);
    final schoolLogoUrl = await networkImage(schlLogo);
    _logo = await rootBundle.loadString('assets/schoollogo1.svg');
    _bgShape = await rootBundle.loadString('assets/invoice.svg');

    final doc = pw.Document();


    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          await PdfGoogleFonts.robotoRegular(),
          await PdfGoogleFonts.robotoBold(),
          await PdfGoogleFonts.robotoItalic(),
        ),
        build: (context) => [
          pw.Container(
            height: 80,
            width: 600,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Container(
                  height: 40,
                  width: 40,
                  child:pw.Image(
                    schoolLogoUrl,
                    height: 40,
                    width:40,
                  ),
                ),
                pw.SizedBox(width: 10),
                pw. Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw. Text(
                      schlName,
                      style:pw.TextStyle(
                          color: PdfColors.black
                      ),
                    ),
                    pw. Text(
                      schlAddress,
                      style:pw. TextStyle(
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                ),
                //pw.SizedBox(width: 100),
              ],
            ),
          ),
          pw.SizedBox(
            height: 20
          ),
          pw.Container(
            height: 100,
            width: 600,
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  height: 90,
                  width: 80,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all()
                  ),
                  //// picture
                  child: pw.Image(studentImage),
                ),
                pw.SizedBox(
                  width: 20,
                ),
                pw.Container(
                  height: 150,
                  width: 200,
                  child: pw.Column(
                    children: [
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 70,
                            height: 20,
                            child: pw.Text(
                                "Roll No",
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                )
                            )
                          ),
                          pw.Text(
                              " : "
                          ),
                          pw.Container(
                              child: pw.Center(
                                  child: pw.Text(
                                      student["regno"],
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.normal,
                                      )
                                  )
                              )
                          ),
                        ]
                      ),
                      pw.Row(
                          children: [
                            pw.Container(
                                width: 70,
                                height: 20,
                                child: pw.Text(
                                    "Name",
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )
                                )
                            ),
                            pw.Text(
                                " : "
                            ),
                            pw.Container(
                                child: pw.Center(
                                    child: pw.Text(
                                        student["stname"],
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.normal,
                                        )
                                    )
                                )
                            ),
                          ]
                      ),
                      pw.Row(
                          children: [
                            pw.Container(
                                width: 70,
                                height: 20,
                                child: pw.Text(
                                    "DOB",
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )
                                )
                            ),
                            pw.Text(
                                " : "
                            ),
                            pw.Container(
                                child: pw.Center(
                                    child: pw.Text(
                                        student["dob"],
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.normal,
                                        )
                                    )
                                )
                            ),
                          ]
                      ),
                      pw.Row(
                          children: [
                            pw.Container(
                                width: 70,
                                height: 20,
                                child: pw.Text(
                                    "Mobile",
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )
                                )
                            ),
                            pw.Text(
                                " : "
                            ),
                            pw.Container(
                                child: pw.Center(
                                    child: pw.Text(
                                        student["mobile"],
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.normal,
                                        )
                                    )
                                )
                            ),
                          ]
                      ),
                      pw.Row(
                          children: [
                            pw.Container(
                                width: 70,
                                height: 20,
                                child: pw.Text(
                                    "Aadhaar No",
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )
                                )
                            ),
                            pw.Text(
                                " : "
                            ),
                            pw.Container(
                                child: pw.Center(
                                    child: pw.Text(
                                        student["aadhaarno"],
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.normal,
                                        )
                                    )
                                )
                            ),
                          ]
                      )
                    ]
                  )
                ),
                pw.SizedBox(
                  width: 10,
                ),
                pw.Container(
                    width: 200,
                    child: pw.Column(
                        children: [
                          pw.Row(
                              children: [
                                pw.Container(
                                    width: 70,
                                    height: 20,
                                    child: pw.Text(
                                        "Scholar No",
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                        )
                                    )
                                ),
                                pw.Text(
                                    " : "
                                ),
                                pw.Container(
                                    child: pw.Center(
                                        child: pw.Text(
                                            "",
                                            style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.normal,
                                            )
                                        )
                                    )
                                ),
                              ]
                          ),
                          pw.Row(
                              children: [
                                pw.Container(
                                    width: 70,
                                    height: 20,
                                    child: pw.Text(
                                        "Father",
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                        )
                                    )
                                ),
                                pw.Text(
                                    " : "
                                ),
                                pw.Container(
                                    child: pw.Center(
                                        child: pw.Text(
                                            student["fathername"],
                                            style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.normal,
                                            )
                                        )
                                    )
                                ),
                              ]
                          ),
                          pw.Row(
                              children: [
                                pw.Container(
                                    width: 70,
                                    height: 20,
                                    child: pw.Text(
                                        "Mother",
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                        )
                                    )
                                ),
                                pw.Text(
                                    " : "
                                ),
                                pw.Container(
                                    child: pw.Center(
                                        child: pw.Text(
                                            student["mothername"],
                                            style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.normal,
                                            )
                                        )
                                    )
                                ),
                              ]
                          ),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                              children: [
                                pw.Container(
                                    width: 70,
                                    height: 30,
                                    child: pw.Text(
                                        "Address",
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                        )
                                    )
                                ),
                                pw.SizedBox(
                                  height: 30,
                                  child: pw.Text(
                                      " : "
                                  ),
                                ),
                                pw.Container(
                                  width: 100,
                                    height: 30,
                                    child: pw.Center(
                                        child: pw.Text(
                                            student["address"],
                                            style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.normal,
                                            )
                                        )
                                    )
                                ),
                              ]
                          ),
                        ]
                    )
                ),
              ]
            )
          ),
          pw.Container(
            width: 600,
            height: 600,
            child: pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 00, vertical: 0),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(height: 10),
                  pw.SizedBox(height: 30),
                  pw.Text(
                    "Exam Reports",
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 30),
                  pw.Row(
                    children: [
                      for(int i = 0; i < exams.length+1; i++)
                        pw.Column(
                          children: [
                            for(int j = 0; j < exams.first.subjects.length+1; j++)
                              j == 0
                                  ? pw.Container(
                                height: j==0 ? 60 : 50,
                                width: (i==0 && j==0) ? 100 : i==0 ? 100 : 180,
                                decoration: pw.BoxDecoration(
                                  border: pw.Border.all(),
                                ),
                                child: pw.Column(
                                  children: [
                                    pw.Container(
                                      height: (i == 0 && j == 0) ? 58 : 30,
                                      width: 180,
                                      child: pw.Center(
                                        child: pw.Text(
                                          (i == 0 && j == 0)
                                              ? "Subject/Exams"
                                              : j == 0
                                              ? exams[i-1].examName
                                              : "",
                                          textAlign: pw.TextAlign.center,
                                          style: pw.TextStyle(
                                            color: PdfColors.black,
                                            //color: (i == 0 || j == 0) ? Colors.white : Colors.black,
                                            fontWeight: (i == 0 || j == 0) ? pw.FontWeight.bold : pw.FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                    i != 0 ? pw.Row(
                                        children: [
                                          pw.Container(
                                            height: 28,
                                            width: 60,
                                            decoration: const pw.BoxDecoration(
                                                border: pw.Border(
                                                  right: pw.BorderSide(),
                                                  top: pw.BorderSide(),
                                                )
                                            ),
                                            child: pw.Center(
                                              child: pw.Text(
                                                "Max",
                                                textAlign: pw.TextAlign.center,
                                                style: pw.TextStyle(
                                                  color: PdfColors.black,
                                                  //color: (i == 0 || j == 0) ? PdfColors.white : PdfColors.black,
                                                  fontWeight: (i == 0 || j == 0) ? pw.FontWeight.bold : pw.FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          pw.Container(
                                            height: 28,
                                            width: 59,
                                            decoration: pw.BoxDecoration(
                                                border: pw.Border(
                                                  right: pw.BorderSide(),
                                                  top: pw.BorderSide(),
                                                )
                                            ),
                                            child: pw.Center(
                                              child: pw.Text(
                                                "Mark",
                                                textAlign: pw.TextAlign.center,
                                                style: pw.TextStyle(
                                                  color: PdfColors.black,
                                                  //color: (i == 0 || j == 0) ? PdfColors.white : PdfColors.black,
                                                  fontWeight: (i == 0 || j == 0) ? pw.FontWeight.bold : pw.FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          pw.Container(
                                            height: 28,
                                            width: 59,
                                            decoration: pw.BoxDecoration(
                                                border: pw.Border(
                                                  top: pw.BorderSide(),
                                                )
                                            ),
                                            child: pw.Center(
                                              child: pw.Text(
                                                "Grade",
                                                textAlign: pw.TextAlign.center,
                                                style: pw.TextStyle(
                                                  color: PdfColors.black,
                                                  //color: (i == 0 || j == 0) ? PdfColors.white : PdfColors.black,
                                                  fontWeight: (i == 0 || j == 0) ? pw.FontWeight.bold : pw.FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ) : pw.Column(),
                                  ],
                                ),
                              )
                                  : i == 0
                                  ? pw.Container(
                                height: j==0 ? 60 : 50,
                                width: i ==0 ? 100 : 180,
                                decoration: pw.BoxDecoration(
                                  border: pw.Border.all(),
                                ),
                                child: pw.Center(
                                  child: pw.Text(
                                    (i == 0 && j == 0)
                                        ? ""
                                        : j == 0
                                        ? exams[i-1].examName
                                        : i == 0
                                        ? exams[0].subjects[j-1].name
                                        : exams[i-1].subjects[j-1].mark,
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(
                                      color: PdfColors.black,
                                      //color: (i == 0 || j == 0) ? PdfColors.white : PdfColors.black,
                                      fontWeight: (i == 0 || j == 0) ? pw.FontWeight.bold : pw.FontWeight.normal,
                                    ),
                                  ),
                                ),
                              )
                                  : pw.Row(
                                children: [
                                  pw.Container(
                                    height: j==0 ? 60 : 50,
                                    width: 60,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(),
                                    ),
                                    child: pw.Center(
                                      child: pw.Text(
                                        (i == 0 && j == 0)
                                            ? ""
                                            : j == 0
                                            ? exams[i-1].examName
                                            : i == 0
                                            ? exams[0].subjects[j-1].name
                                            : exams[i-1].subjects[j-1].totalMark,
                                        textAlign: pw.TextAlign.center,
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          //color: (i == 0 || j == 0) ? PdfColors.white : PdfColors.black,
                                          fontWeight: (i == 0 || j == 0) ? pw.FontWeight.bold : pw.FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    height: j==0 ? 60 : 50,
                                    width: 60,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(),
                                    ),
                                    child: pw.Center(
                                      child: pw.Text(
                                        (i == 0 && j == 0)
                                            ? ""
                                            : j == 0
                                            ? exams[i-1].examName
                                            : i == 0
                                            ? exams[0].subjects[j-1].name
                                            : exams[i-1].subjects[j-1].mark,
                                        textAlign: pw.TextAlign.center,
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          //color: (i == 0 || j == 0) ? Colors.white : Colors.black,
                                          fontWeight: (i == 0 || j == 0) ? pw.FontWeight.bold : pw.FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    height: j==0 ? 60 : 50,
                                    width: 60,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(),
                                    ),
                                    child: pw.Center(
                                      child: pw.Text(
                                        (i == 0 && j == 0)
                                            ? ""
                                            : j == 0
                                            ? exams[i-1].examName
                                            : i == 0
                                            ? exams[0].subjects[j-1].name
                                            : getGrade(exams[i-1].subjects[j-1].mark,exams[i-1].subjects[j-1].totalMark),
                                        textAlign: pw.TextAlign.center,
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          //color: (i == 0 || j == 0) ? Colors.white : Colors.black,
                                          fontWeight: (i == 0 || j == 0) ? pw.FontWeight.bold : pw.FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ],
                        )
                    ],
                  ),
                  pw.SizedBox(height: 30),
                ],
              ),
            ),
          )

        ],
      ),
    );
    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
    return doc.save();
  }

  pw.PageTheme _buildTheme(
      PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        child: pw.SvgImage(svg: _bgShape!),
      ),
    );
  }


  String getGrade(String mark, String totalMark){
    String grade = '';
    double gradeVal = (mark != '' && totalMark != '') ? (int.parse(mark)/int.parse(totalMark)) * 100 : 0.0;
    if(gradeVal == 0.0){
      grade = '';
    }else if(gradeVal >= 91){
      grade = 'A1';
    }else if(gradeVal >= 81){
      grade = 'A2';
    }else if(gradeVal >= 71){
      grade = 'B1';
    }else if(gradeVal >= 61){
      grade = 'B2';
    }else if(gradeVal >= 51){
      grade = 'C1';
    }else if(gradeVal >= 41){
      grade = 'C2';
    }else if(gradeVal >= 33){
      grade = 'D';
    }else if(gradeVal >= 21){
      grade = 'E1';
    }else if(gradeVal <= 20){
      grade = 'E2';
    }
    else if(gradeVal == 0.0){
      grade = '';
    }
    return grade;
  }


}

