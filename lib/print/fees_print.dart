import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import '../fees/fees.dart';
import '../models/attendance_pdf_model.dart';


Future<Uint8List> generateFeesPdf(PdfPageFormat pageFormat,StudentFeesPdfModel feesDetails) async {

  final attendance = FeesModelforPdfPrint(
      accentColor: PdfColor.fromHex('0xff00A0E3'),
      baseColor: PdfColor.fromHex('0xff00A0E3'),
      customerAddress: '',
      customerName: '',
      invoiceNumber: '',
      paymentInfo: '',
      tax: 1,
      title: "Attendance",
      feesDetails: feesDetails,
    products: []
  );

  return await attendance.buildPdf(pageFormat);
}

class FeesModelforPdfPrint{

  FeesModelforPdfPrint({required this.products,required this.customerName, required this.customerAddress,required  this.invoiceNumber,required  this.tax,required  this.paymentInfo,required  this.baseColor,required  this.accentColor, required this.title, required this.feesDetails});
  String? title;
  StudentFeesPdfModel feesDetails;

  final String customerName;
  final List products;
  final String customerAddress;
  final String invoiceNumber;
  final double tax;
  final String paymentInfo;
  final PdfColor baseColor;
  final PdfColor accentColor;

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  PdfColor get _baseTextColor => baseColor.isLight ? _lightColor : _darkColor;

  PdfColor get _accentTextColor => baseColor.isLight ? _lightColor : _darkColor;


  String? _logo;

  String? _bgShape;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {

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
        //header: _buildHeader,
        //footer: _buildFooter,
        build: (context) => [
          _contentHeader(context,feesDetails),
          _contentTable(context),
          pw.SizedBox(height: 20),
          _contentFooter(context,feesDetails),
          pw.SizedBox(height: 20),

        ],
      ),
    );
    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
    return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [

            pw.Container(
              alignment: pw.Alignment.topRight,
              padding: const pw.EdgeInsets.only(bottom: 8, left: 30),
              height: 100,
              child:
              _logo != null ? pw.SvgImage(svg: _logo!) : pw.PdfLogo(),
            ),
            // pw.Container(
            //   color: baseColor,
            //   padding: pw.EdgeInsets.only(top: 3),
            // ),

            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    height: 30,
                    padding: const pw.EdgeInsets.only(left: 0),
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      '',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  pw.Text("Kolathur,Padi Chennai - 600062", style: pw.TextStyle(
                    color: _darkColor,

                    fontSize: 13,
                  ),),
                  pw.Text("Call: +91 770880963",style: pw.TextStyle(
                    color: _darkColor,
                    fontSize: 13,
                  ),),
                ],
              ),
            ),

          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 20)
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [

        pw.Text(
          'Page ${context.pageNumber}/${context.pagesCount}',
          style: const pw.TextStyle(
            fontSize: 12,
            color: PdfColors.white,
          ),
        ),
      ],
    );
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

  pw.Widget _contentHeader(pw.Context context,StudentFeesPdfModel feesDetails) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [

        pw.Expanded(
          child: pw.Row(
            children: [
              pw.Container(
                margin: const pw.EdgeInsets.only(left: 10, right: 10),
                height: 70,
                child: pw.Text(
                  'Invoice to:',
                  style: pw.TextStyle(
                    color: _darkColor,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  height: 70,
                  child: pw.RichText(
                      text: pw.TextSpan(
                          text: '${feesDetails.studentName}\n',
                          style: pw.TextStyle(
                            color: _darkColor,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 12,
                          ),
                          children: [
                            const pw.TextSpan(
                              text: '\n',
                              style: pw.TextStyle(
                                fontSize: 5,
                              ),
                            ),
                            pw.TextSpan(
                              text: feesDetails.studentAddress,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.normal,
                                fontSize: 10,
                              ),
                            ),
                          ])),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _contentFooter(pw.Context context,StudentFeesPdfModel feesDetails) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [

              pw.Container(
                margin: const pw.EdgeInsets.only(top: 20, bottom: 8),
                child: pw.Text(
                  'Payment Info:',
                  style: pw.TextStyle(
                    color: baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),

              pw.Text(
                paymentInfo,
                style: const pw.TextStyle(
                  fontSize: 8,
                  lineSpacing: 5,
                  color: _darkColor,
                ),
              ),
              pw.SizedBox(height: 30),
              pw.Text(
                'Thank you',
                style: pw.TextStyle(
                  color: _darkColor,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          flex: 1,
          child: pw.DefaultTextStyle(
            style: const pw.TextStyle(
              fontSize: 10,
              color: _darkColor,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [


                pw.DefaultTextStyle(
                  style: pw.TextStyle(
                    color: baseColor,
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total:'),
                      pw.Text(_formatCurrency(double.parse(feesDetails.amount.toString()))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }



  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      'Si.NO',
      'Item Description',
      'Price',
      'Quantity',
      'Total'
    ];



    return pw.TableHelper.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: accentColor,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
            (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        products.length,
            (row) => List<String>.generate(
          tableHeaders.length,
              (col) => products[row].getIndex(col),
        ),
      ),
    );
  }


  String _formatCurrency(double amount) {
    return 'Rs ${amount.toStringAsFixed(2)}';
  }
}

