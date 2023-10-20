import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/attendance_pdf_model.dart';
import '../timetable/timetable.dart';


Future<Uint8List> generateTimeTablePdf(PdfPageFormat pageFormat,TimeTablePrintModel timetable) async {

  final attendance = TimeTablePrintModelPdf(
      title: "Attendance",
      timetable: timetable
  );

  return await attendance.buildPdf(pageFormat,timetable);
}

class TimeTablePrintModelPdf{

  TimeTablePrintModelPdf({required this.title, required this.timetable});
  String? title;
  TimeTablePrintModel timetable;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat,TimeTablePrintModel isStudent) async {

    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.symmetric(horizontal: 20,vertical: 100),
        build: (context) => [
            _contentTable(context,timetable),
        ],
      ),
    );
    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
    return doc.save();
  }

  pw.Widget _contentTable(pw.Context context,TimeTablePrintModel timeTable) {
    List tableHeaders = [
      'Day/Period',
      'Period -01',
      'Period -02',
      'Period -03',
      'Period -04',
      'Period -05',
      'Period -06',
      'Period -07',
      'Period -08',
    ];

    return pw.
    TableHelper.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        //color: PdfColors.teal
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
      },

      cellPadding: pw.EdgeInsets.zero,
      headerPadding: pw.EdgeInsets.zero,
      headerStyle: pw.TextStyle(
        color: PdfColors.amber,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: PdfColors.black,
            width: .5,
          ),
        ),
      ),
      headers: List<pw.Widget>.generate(
        tableHeaders.length,
            (col) => pw.Container(
          // width: 60,
            height:40,
            decoration:pw.BoxDecoration(
                border: pw.Border.all(color:PdfColors.black),
                color: PdfColors.blue
            ),
            child:  pw.Center(child:pw.Text(tableHeaders[col],style: pw.TextStyle(fontWeight: pw.FontWeight.bold,color: PdfColors.white)),)
        ),
      ),
      data: List.generate(6,
      (row) => List<pw.Widget>.generate(
        tableHeaders.length,
            (col) => pw.Container(
          // width: 60,
            height:40,
            decoration:pw.BoxDecoration(
                border: pw.Border.all(color:PdfColors.black)
            ),
            child:  pw.Center(
              child:pw.Text(
                  row == 0
                      ? col == 0 ? 'Monday' : col == 1 ? timetable.mondayFirst : col == 2 ? timetable.mondaySecond : col == 3 ? timetable.mondayThird : col == 4 ? timetable.mondayFourth : col == 5 ? timetable.mondayFifth : col == 6 ? timetable.mondaySixth : col == 7 ? timetable.mondaySeventh : timetable.mondayEighth
                      : row == 1
                      ? col == 0 ? 'Tuesday' : col == 1 ? timetable.tuesdayFirst : col == 2 ? timetable.tuesdaySecond : col == 3 ? timetable.tuesdayThird : col == 4 ? timetable.tuesdayFourth : col == 5 ? timetable.tuesdayFirst : col == 6 ? timetable.tuesdaySixth : col == 7 ? timetable.tuesdaySeventh : timetable.tuesdayEighth
                      : row == 2
                      ? col == 0 ? 'Wednesday' : col == 1 ? timetable.wednesdayFirst : col == 2 ? timetable.wednesdaySecond : col == 3 ? timetable.wednesdayThird : col == 4 ? timetable.wednesdayFourth : col == 5 ? timetable.wednesdayFifth : col == 6 ? timetable.wednesdaySixth : col == 7 ? timetable.wednesdaySeventh : timetable.wednesdayEighth
                      : row == 3
                      ? col == 0 ? 'Thursday' : col == 1 ? timetable.thursdayFirst : col == 2 ? timetable.thursdaySecond : col == 3 ? timetable.thursdayThird : col == 4 ? timetable.thursdayFourth : col == 5 ? timetable.thursdayFifth : col == 6 ? timetable.thursdaySixth : col == 7 ? timetable.thursdaySeventh : timetable.thursdayEighth
                      : row == 4
                      ? col == 0 ? 'Friday' : col == 1 ? timetable.fridayFirst : col == 2 ? timetable.fridaySecond : col == 3 ? timetable.fridayThird : col == 4 ? timetable.fridayFourth : col == 5 ? timetable.fridayFifth : col == 6 ? timetable.fridaySixth : col == 7 ? timetable.fridaySeventh : timetable.fridayEighth
                      : col == 0 ? 'Saturday' : col == 1 ? timetable.saturdayFirst : col == 2 ? timetable.saturdaySecond : col == 3 ? timetable.saturdayThird : col == 4 ? timetable.saturdayFourth : col == 5 ? timetable.saturdayFifth : col == 6 ? timetable.saturdaySixth : col == 7 ? timetable.saturdaySeventh : timetable.saturdayEighth,
                     style: pw.TextStyle(
                    color: PdfColors.black,
                  )
              ),
            )
        ),
      ),
      // data: List<List<pw.Widget>>.generate(
      //   attendances.length,
      //       (row) => List<pw.Widget>.generate(
      //     tableHeaders.length,
      //         (col) => pw.Container(
      //       // width: 60,
      //         height:40,
      //         decoration:pw.BoxDecoration(
      //             border: pw.Border.all(color:PdfColors.black)
      //         ),
      //         child:  pw.Center(
      //           child:pw.Text(
      //               attendances[row].getIndex(col,row),
      //               style: pw.TextStyle(
      //                 color: col == 3 ? attendances[row].getIndex(col,row) == "Present" ? PdfColors.green : PdfColors.red : PdfColors.black,
      //               )
      //           ),
      //         )
      //     ),
      //   ),
      // ),
    ));
  }
}