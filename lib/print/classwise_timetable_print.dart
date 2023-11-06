import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import '../timetable/classTimeTable.dart';
import '../timetable/timetable.dart';


Future<Uint8List> generateClassWiseTimeTablePdf(PdfPageFormat pageFormat,List<ClassWiseTimeTableModel> timetables) async {

  final attendance = TimeTablePrintModelPdf(
      title: "TimeTable",
      timetables: timetables
  );

  return await attendance.buildPdf(pageFormat,timetables);
}

class TimeTablePrintModelPdf{

  TimeTablePrintModelPdf({required this.title, required this.timetables});
  String? title;
  List<ClassWiseTimeTableModel> timetables;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat,List<ClassWiseTimeTableModel> isStudent) async {

    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.symmetric(horizontal: 20,vertical: 100),
        build: (context) => [
          _contentTable(context,timetables),
        ],
      ),
    );
    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
    return doc.save();
  }

  pw.Widget _contentTable(pw.Context context,List<ClassWiseTimeTableModel> timeTable) {
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
        // data: List.generate(timetables.length,
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
        //               row == 0
        //                   ? col == 0 ? timetables[col].staffName : col == 1 ? timetables[col].firstPeriod : col == 2 ? timetables[col].secondPeriod : col == 3 ? timetables[col].thirdPeriod : col == 4 ? timetables[col].fourthPeriod : col == 5 ? timetables[col].fifthPeriod : col == 6 ? timetables[col].sixthPeriod : col == 7 ? timetables[col].seventhPeriod : timetables[col].eighthPeriod,
        //                   style: pw.TextStyle(
        //                 color: PdfColors.black,
        //               )
        //           ),
        //         )
        //     ),
        //   ),
          data: List<List<pw.Widget>>.generate(
            timetables.length,
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
                        timetables[row].getIndex(col,row),
                        style: pw.TextStyle(
                          color: timetables[row].getIndex(col,row) == "Free" ? PdfColors.green : PdfColors.black,
                        )
                    ),
                  )
              ),
            ),
          ),
        );
  }
}