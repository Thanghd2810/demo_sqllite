part of pdf_service;

class PdfService {
  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  static Future<File> generatePDf(SupplierWithOrder data) async {
    final myTheme = pw.ThemeData.withFont(
        base: pw.Font.ttf(
      await rootBundle.load('assets/fonts/RobotoSlab-Medium.ttf'),
    ));
    final pdf = pw.Document(theme: myTheme);

    pdf.addPage(await _buildPdfPage(data));
    final String name =
        "order_reactplus_" + data.supplierName.replaceAll(RegExp('\\s+'), "");

    return saveDocument(name: '$name.pdf', pdf: pdf);
  }

  static Future<pw.Page> _buildPdfPage(SupplierWithOrder data) async {
    final byteData = await rootBundle.load('assets/images/ic_logo_react.png');
    final logo = byteData.buffer.asUint8List();

    return pw.MultiPage(
      build: (context) {
        return <pw.Widget>[
          _buildCustomHeader(logo: logo),
          pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
          _buildCustomHeadline(),
          _buildTableForOrders(data),
        ];
      },
      footer: (context) {
        return pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(top: 1 * PdfPageFormat.cm),
          child: pw.Text(
            'Page ${context.pageNumber} of ${context.pagesCount}',
            style: const pw.TextStyle(color: PdfColors.black),
          ),
        );
      },
    );
  }

  static pw.Widget _buildTableForOrders(SupplierWithOrder data) {
    final headers = ['Tên món ăn', 'Số lượng'];
    final List<OrderModel> ordersTemp = [];

    ordersTemp.addAll(data.orders);
    final listOrder =
        ordersTemp.map((order) => [order.name, order.quantity]).toList();

    return pw.Table.fromTextArray(
      headers: headers,
      data: listOrder,
    );
  }

  static pw.Widget _buildCustomHeader({
    required Uint8List logo,
    pw.Font? font,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(width: 2, color: PdfColors.blue),
        ),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Image(
            pw.MemoryImage(logo),
            fit: pw.BoxFit.cover,
            height: 50,
            width: 50,
          ),
          pw.SizedBox(width: 0.5 * PdfPageFormat.cm),
          pw.Paragraph(
            text: 'Đặt cơm ReactPlus',
            style: pw.TextStyle(
              font: font,
              fontSize: 40,
              color: PdfColors.blue,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildCustomHeadline() {
    return pw.Header(
      child: pw.Center(
        child: pw.Paragraph(
          textAlign: pw.TextAlign.center,
          text: 'Danh sách đặt cơm ngày ' +
              DateTime.now().formatddMMYYYY().toString(),
          style: const pw.TextStyle(
            fontSize: 24,
            color: PdfColors.white,
          ),
        ),
      ),
      padding: const pw.EdgeInsets.all(4),
      decoration: const pw.BoxDecoration(color: PdfColors.blueAccent),
    );
  }
}
