import 'dart:convert';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/settings.dart';

class PdfService {
  static Future<void> generateInvoicePdf(Map<String, dynamic> invoiceData, AppSettings settings) async {
    final pdf = pw.Document();
    
    pw.ImageProvider? logoImage;
    if (settings.companyLogoBase64 != null && settings.companyLogoBase64!.isNotEmpty) {
      try {
        final file = File(settings.companyLogoBase64!);
        if (await file.exists()) {
          logoImage = pw.MemoryImage(await file.readAsBytes());
        } else {
          logoImage = pw.MemoryImage(base64Decode(settings.companyLogoBase64!));
        }
      } catch (e) {
        // ignore
      }
    }
    try {
      logoImage ??= await imageFromAssetBundle('assets/images/prime_ledger_logo.png');
    } catch (e) {
      // ignore
    }

    final List<dynamic> rawItems = invoiceData['items'] ?? [];
    final List<Map<String, dynamic>> items = rawItems.cast<Map<String, dynamic>>();
    
    final font = await PdfGoogleFonts.robotoRegular();
    final fontBold = await PdfGoogleFonts.robotoBold();

    final subtotal = (invoiceData['subtotal'] as num?)?.toDouble() ?? 0.0;
    final taxTotal = (invoiceData['tax'] as num?)?.toDouble() ?? 0.0;
    final discountPercent = (invoiceData['discountPercent'] as num?)?.toDouble() ?? 0.0;
    final discountAmount = (invoiceData['discountAmount'] as num?)?.toDouble() ?? 0.0;
    final total = (invoiceData['total'] as num?)?.toDouble() ?? 0.0;
    final previousDues = (invoiceData['previousDues'] as num?)?.toDouble() ?? 0.0;
    final amountPaid = (invoiceData['amountPaid'] as num?)?.toDouble() ?? 0.0;
    final balanceDue = (total - amountPaid).clamp(0.0, double.infinity);

    final invoiceDiscount = (subtotal * (discountPercent / 100)) + discountAmount;

    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(
          base: font,
          bold: fontBold,
        ),
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        build: (pw.Context context) {
          return [
            // Invoice Header
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    if (logoImage != null)
                      pw.Container(
                        width: 70,
                        height: 70,
                        margin: const pw.EdgeInsets.only(bottom: 12),
                        child: pw.Image(logoImage),
                      ),
                    pw.Text(settings.companyName, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#4F46E5'))),
                    pw.SizedBox(height: 4),
                    pw.Text(settings.companyAddress, style: pw.TextStyle(color: PdfColors.grey700, fontSize: 10)),
                    pw.Text(settings.companyEmail, style: pw.TextStyle(color: PdfColors.grey700, fontSize: 10)),
                    if (settings.companyPhone != null && settings.companyPhone!.isNotEmpty)
                      pw.Text(settings.companyPhone!, style: pw.TextStyle(color: PdfColors.grey700, fontSize: 10)),
                  ]
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text('INVOICE', style: pw.TextStyle(fontSize: 32, fontWeight: pw.FontWeight.bold, color: PdfColors.grey400)),
                    pw.SizedBox(height: 12),
                    if (invoiceData['invoiceNumber'] != null)
                      pw.Text('Invoice #: ${invoiceData['invoiceNumber']}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 13, color: PdfColors.grey900)),
                    pw.SizedBox(height: 4),
                    if (invoiceData['issueDate'] != null)
                      pw.Text('Issue Date: ${_formatPdfDate(invoiceData['issueDate'])}', style: const pw.TextStyle(color: PdfColors.grey700, fontSize: 9)),
                    pw.SizedBox(height: 2),
                    if (invoiceData['dueDate'] != null)
                      pw.Text('Due Date: ${_formatPdfDate(invoiceData['dueDate'])}', style: const pw.TextStyle(color: PdfColors.grey700, fontSize: 9)),
                    if (invoiceData['status'] != null) ...[
                      pw.SizedBox(height: 8),
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: pw.BoxDecoration(
                          color: _getPdfStatusColor(invoiceData['status']),
                          borderRadius: pw.BorderRadius.circular(12),
                        ),
                        child: pw.Text(
                          invoiceData['status'].toUpperCase(),
                          style: pw.TextStyle(color: PdfColors.white, fontWeight: pw.FontWeight.bold, fontSize: 8),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 32),
            pw.Divider(color: PdfColor.fromHex('#E5E7EB'), thickness: 1),
            pw.SizedBox(height: 20),
            
            // Client details
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('BILL TO', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.grey500, fontSize: 10)),
                    pw.SizedBox(height: 6),
                    pw.Text('${invoiceData['client'] ?? ''}', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.grey900)),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 28),
            
            // Itemized Table
            pw.Table(
              border: const pw.TableBorder(
                bottom: pw.BorderSide(color: PdfColors.grey300, width: 0.5),
                horizontalInside: pw.BorderSide(color: PdfColors.grey200, width: 0.5),
              ),
              columnWidths: {
                0: const pw.FlexColumnWidth(3.5),
                1: const pw.FlexColumnWidth(0.8),
                2: const pw.FlexColumnWidth(1.2),
                3: const pw.FlexColumnWidth(1.0),
                4: const pw.FlexColumnWidth(1.5),
              },
              children: [
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: PdfColor.fromHex('#4F46E5')),
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: pw.Text('Description', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 9)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: pw.Text('Qty', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 9), textAlign: pw.TextAlign.right),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: pw.Text('Price', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 9), textAlign: pw.TextAlign.right),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: pw.Text('Tax', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 9), textAlign: pw.TextAlign.right),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: pw.Text('Total', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 9), textAlign: pw.TextAlign.right),
                    ),
                  ],
                ),
                ...items.map((item) {
                  final qty = item['quantity'] ?? 1;
                  final price = item['price'] ?? 0.0;
                  final taxP = item['tax'] ?? 0.0;
                  final discP = 0.0;
                  final taxable = (qty * price) * (1 - discP / 100);
                  final totalItem = taxable * (1 + taxP / 100);
                  return pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: pw.Text(item['description'], style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey900)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: pw.Text(qty.toString(), style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey800), textAlign: pw.TextAlign.right),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: pw.Text(settings.formatCurrency(price), style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey800), textAlign: pw.TextAlign.right),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: pw.Text(taxP > 0 ? '${taxP.toStringAsFixed(1)}%' : '-', style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey800), textAlign: pw.TextAlign.right),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: pw.Text(settings.formatCurrency(totalItem), style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: PdfColors.grey900), textAlign: pw.TextAlign.right),
                      ),
                    ],
                  );
                }),
              ],
            ),
            pw.SizedBox(height: 24),
            
            // Totals Summary
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Container(
                  width: 220,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Subtotal:', style: const pw.TextStyle(color: PdfColors.grey700, fontSize: 9)),
                          pw.Text(settings.formatCurrency(subtotal), style: const pw.TextStyle(fontSize: 9)),
                        ]
                      ),
                      pw.SizedBox(height: 6),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Tax:', style: const pw.TextStyle(color: PdfColors.grey700, fontSize: 9)),
                          pw.Text(settings.formatCurrency(taxTotal), style: const pw.TextStyle(fontSize: 9)),
                        ]
                      ),
                      if (invoiceDiscount > 0) ...[
                        pw.SizedBox(height: 6),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Discount:', style: const pw.TextStyle(color: PdfColors.grey700, fontSize: 9)),
                            pw.Text('-${settings.formatCurrency(invoiceDiscount)}', style: const pw.TextStyle(color: PdfColors.red700, fontSize: 9)),
                          ]
                        ),
                      ],
                      pw.Divider(color: PdfColor.fromHex('#E5E7EB')),
                      pw.SizedBox(height: 4),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Total:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
                          pw.Text(settings.formatCurrency(total), style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11, color: PdfColor.fromHex('#4F46E5'))),
                        ]
                      ),
                      if (amountPaid > 0.01) ...[
                        pw.SizedBox(height: 6),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Amount Paid:', style: const pw.TextStyle(color: PdfColors.grey700, fontSize: 9)),
                            pw.Text(settings.formatCurrency(amountPaid), style: const pw.TextStyle(fontSize: 9, color: PdfColors.green700)),
                          ]
                        ),
                        pw.SizedBox(height: 6),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Balance Due:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9, color: PdfColors.grey900)),
                            pw.Text(settings.formatCurrency(balanceDue), style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9, color: PdfColor.fromHex('#4F46E5'))),
                          ]
                        ),
                      ],
                      if (previousDues > 0.01) ...[
                        pw.SizedBox(height: 6),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Previous Dues:', style: const pw.TextStyle(color: PdfColors.grey700, fontSize: 9)),
                            pw.Text(settings.formatCurrency(previousDues), style: const pw.TextStyle(fontSize: 9)),
                          ]
                        ),
                        pw.Divider(color: PdfColor.fromHex('#D1D5DB'), thickness: 1),
                        pw.SizedBox(height: 4),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Total Dues:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
                            pw.Text(settings.formatCurrency(balanceDue + previousDues), style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11, color: PdfColor.fromHex('#10B981'))),
                          ]
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            pw.Spacer(),
            pw.Divider(color: PdfColor.fromHex('#F3F4F6')),
            pw.SizedBox(height: 12),
            pw.Center(
              child: pw.Text('Thank you for your business!', style: pw.TextStyle(fontStyle: pw.FontStyle.italic, color: PdfColors.grey500, fontSize: 10)),
            ),
          ];
        },
      ),
    );
    
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  static Future<void> generateEstimatePdf(Map<String, dynamic> estimateData, AppSettings settings) async {
    final map = Map<String, dynamic>.from(estimateData);
    map['invoiceNumber'] = estimateData['estimateNumber'];
    map['dueDate'] = estimateData['issueDate'];
    await generateInvoicePdf(map, settings);
  }

  static PdfColor _getPdfStatusColor(String status) {
    switch (status) {
      case 'Paid':
        return PdfColor.fromHex('#10B981');
      case 'Sent':
      case 'Pending':
      case 'Partially Paid':
        return PdfColor.fromHex('#F59E0B');
      case 'Overdue':
      case 'Cancelled':
        return PdfColor.fromHex('#EF4444');
      default:
        return PdfColor.fromHex('#6B7280');
    }
  }

  static Future<void> generateReportPdf(String title, List<String> headers, List<List<dynamic>> data, AppSettings settings) async {
    final pdf = pw.Document();
    
    final font = await PdfGoogleFonts.robotoRegular();
    final fontBold = await PdfGoogleFonts.robotoBold();

    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(base: font, bold: fontBold),
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(48),
        build: (pw.Context context) {
          return [
              pw.Text(settings.companyName, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#6366F1'))),
              pw.SizedBox(height: 8),
              pw.Text(title, style: pw.TextStyle(fontSize: 32, fontWeight: pw.FontWeight.bold, color: PdfColors.grey800)),
              pw.SizedBox(height: 8),
              pw.Text('Generated on: ${DateTime.now().toIso8601String().split('T').first}', style: pw.TextStyle(color: PdfColors.grey600)),
              pw.SizedBox(height: 32),
              pw.TableHelper.fromTextArray(
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                headerDecoration: pw.BoxDecoration(color: PdfColor.fromHex('#6366F1')),
                cellHeight: 30,
                headers: headers,
                data: data.map((row) => row.map((cell) => cell.toString()).toList()).toList(),
              ),
          ];
        },
      ),
    );
    
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  static String _formatPdfDate(String isoDate) {
    try {
      final dt = DateTime.parse(isoDate);
      final months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
      return '${dt.day} ${months[dt.month-1]} ${dt.year}';
    } catch (_) {
      return isoDate;
    }
  }
}
