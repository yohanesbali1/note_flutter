part of 'shared.dart';

class Export {
  Future<void> export_excel_detail_transaction(detail, transcation) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    final List<Style> styles = createStyles(workbook);

    sheet.getRangeByName('A1').columnWidth = 1.69;
    sheet.getRangeByName('B1').text = transcation!.company_name;
    sheet.getRangeByName('B1:E1').cellStyle = styles[0];

    sheet.getRangeByName('B2').text = transcation!.address;
    sheet.getRangeByName('B3').text = transcation!.phone;
    sheet.getRangeByName('B3:E3').cellStyle = styles[10];

    double total = 0.00;
    num qty = 0;

    sheet.getRangeByName('B6').text = 'Nama Produk';
    sheet.getRangeByName('C6').text = 'Qty';
    sheet.getRangeByName('D6').text = 'Harga';
    sheet.getRangeByName('E6').text = 'Sub Harga';
    sheet.getRangeByName('B6:E6').cellStyle = styles[1];

    for (var i = 0; i < detail.length; i++) {
      final item = detail[i];
      total = total + (item.amount * item.price);
      qty += item.amount;
      sheet.getRangeByName('B${i + 7}').setText(item.product_name);
      sheet.getRangeByName('B${i + 7}').cellStyle.wrapText = true;
      sheet.getRangeByName('C${i + 7}').setText(item.amount.toString());
      sheet
          .getRangeByName('D${i + 7}')
          .setText(Helper.convertToIdr(item.price, 2));
      sheet
          .getRangeByName('E${i + 7}')
          .setText(Helper.convertToIdr((item.amount * item.price), 2));
      sheet.getRangeByName('B${i + 7}:E${i + 7}').cellStyle = styles[2];
    }

    sheet.getRangeByName('B${detail.length + 7}').text = 'Qty';
    sheet.getRangeByName('B${detail.length + 7}:D${detail.length + 7}').merge();
    sheet.getRangeByName('E${detail.length + 7}').text = qty.toString();
    sheet
        .getRangeByName('B${detail.length + 7}:E${detail.length + 7}')
        .cellStyle = styles[4];

    sheet.getRangeByName('B${detail.length + 8}').text = 'Total';
    sheet.getRangeByName('B${detail.length + 8}:D${detail.length + 8}').merge();
    sheet.getRangeByName('E${detail.length + 8}').text =
        Helper.convertToIdr(total, 2);
    sheet
        .getRangeByName('B${detail.length + 8}:E${detail.length + 8}')
        .cellStyle = styles[4];
    sheet.autoFitColumn(2);
    sheet.autoFitColumn(3);
    sheet.autoFitColumn(4);
    sheet.autoFitColumn(5);

// Save and dispose workbook.
    final List<int> bytes = workbook.saveAsStream();
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
    }
    Directory _directory = Directory("");
    if (Platform.isAndroid) {
      // Redirects it to download folder in android
      _directory = Directory("/storage/emulated/0/Download");
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }
    String filePath = '${_directory.path}/transaction_detail.xlsx';
    final File file = File(filePath);
    await file.writeAsBytes(bytes, flush: true);
    final exPath = _directory.path;
    await Directory(exPath).create(recursive: true);
    workbook.dispose();
  }

  Future<void> export_excel_transaction(transcation) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    final List<Style> styles = createStyles(workbook);

    sheet.getRangeByName('A1').columnWidth = 1.69;
    sheet.getRangeByName('B1').text = transcation![0].company_name;
    sheet.getRangeByName('B1:E1').cellStyle = styles[0];

    sheet.getRangeByName('B2').text = transcation![0].address;
    sheet.getRangeByName('B3').text = transcation![0].phone;
    sheet.getRangeByName('B3:E3').cellStyle = styles[10];

    double total = 0.00;

    sheet.getRangeByName('B6').text = 'Tanggal';
    sheet.getRangeByName('C6').text = 'Sub Harga';
    sheet.getRangeByName('B6:C6').cellStyle = styles[1];

    for (var i = 0; i < transcation.length; i++) {
      final item = transcation[i];
      total = total + double.parse(item.totalprice.toString());
      sheet.getRangeByName('B${i + 7}').setText(item.date);
      sheet.getRangeByName('B${i + 7}').cellStyle.wrapText = true;
      sheet
          .getRangeByName('C${i + 7}')
          .setText(Helper.convertToIdr(item.totalprice, 2));
      sheet.getRangeByName('B${i + 7}:C${i + 7}').cellStyle = styles[2];
    }

    sheet.getRangeByName('B${transcation.length + 7}').text = 'Total';
    sheet.getRangeByName('C${transcation.length + 7}').text =
        Helper.convertToIdr(total, 2);
    sheet
        .getRangeByName('B${transcation.length + 7}:C${transcation.length + 7}')
        .cellStyle = styles[4];
    sheet.autoFitColumn(2);
    sheet.autoFitColumn(3);
    sheet.autoFitColumn(4);
    sheet.autoFitColumn(5);

// Save and dispose workbook.
    final List<int> bytes = workbook.saveAsStream();
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
    }
    Directory _directory = Directory("");
    if (Platform.isAndroid) {
      // Redirects it to download folder in android
      _directory = Directory("/storage/emulated/0/Download");
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }
    String filePath = '${_directory.path}/transaction.xlsx';
    final File file = File(filePath);
    await file.writeAsBytes(bytes, flush: true);
    final exPath = _directory.path;
    await Directory(exPath).create(recursive: true);
    workbook.dispose();
  }

  List<Style> createStyles(Workbook workbook) {
    final Style style = workbook.styles.add('Style');
    style.fontColor = '#308DA2';
    style.fontSize = 18;
    style.bold = true;
    style.vAlign = VAlignType.center;

    final Style style1 = workbook.styles.add('Style1');
    style1.bold = true;
    style1.fontSize = 12;
    style1.fontColor = '#595959';
    style1.vAlign = VAlignType.center;
    style1.borders.all.lineStyle = LineStyle.thin;
    style1.borders.all.color = '#A6A6A6';

    final Style style2 = workbook.styles.add('Style2');
    style2.fontColor = '#595959';
    style2.vAlign = VAlignType.center;
    style2.borders.all.lineStyle = LineStyle.thin;
    style2.borders.all.color = '#A6A6A6';

    final Style style3 = workbook.styles.add('style3');
    style3.backColor = '#F2F2F2';
    style3.fontColor = '#313F55';
    style3.vAlign = VAlignType.center;
    style3.borders.bottom.lineStyle = LineStyle.thin;
    style3.borders.bottom.color = '#308DA2';
    style3.borders.right.lineStyle = LineStyle.thin;
    style3.borders.right.color = '#A6A6A6';

    final Style style4 = workbook.styles.add('Style4');
    style4.backColor = '#CFEBF1';
    style4.bold = true;
    style4.vAlign = VAlignType.center;
    style4.borders.all.lineStyle = LineStyle.thin;
    style4.borders.all.color = '#A6A6A6';

    final Style style5 = workbook.styles.add('Style5');
    style5.fontSize = 12;
    style5.vAlign = VAlignType.center;
    style5.hAlign = HAlignType.right;
    style5.indent = 1;
    style5.borders.bottom.lineStyle = LineStyle.thick;
    style5.borders.bottom.color = '#308DA2';
    style5.borders.right.lineStyle = LineStyle.thin;
    style5.borders.right.color = '#A6A6A6';
    style5.borders.left.lineStyle = LineStyle.thin;
    style5.borders.left.color = '#A6A6A6';

    final Style style6 = workbook.styles.add('Style6');
    style6.fontColor = '#595959';
    style6.wrapText = true;
    style6.vAlign = VAlignType.center;
    style6.borders.right.lineStyle = LineStyle.thin;
    style6.borders.right.color = '#A6A6A6';
    style6.numberFormat = '_(\$* #,##0_);_(\$* (#,##0);_(\$* "-"_);_(@_)';

    final Style style7 = workbook.styles.add('Style7');
    style7.fontColor = '#595959';
    style7.wrapText = true;
    style7.vAlign = VAlignType.center;
    style7.borders.bottom.lineStyle = LineStyle.thin;
    style7.borders.bottom.color = '#A6A6A6';

    final Style style8 = workbook.styles.add('style8');
    style8.backColor = '#F2F2F2';
    style8.fontColor = '#313F55';
    style8.vAlign = VAlignType.center;
    style8.borders.bottom.lineStyle = LineStyle.thin;
    style8.borders.bottom.color = '#308DA2';
    style8.borders.right.lineStyle = LineStyle.thin;
    style8.borders.right.color = '#A6A6A6';
    style8.numberFormat = '_(\$* #,##0_);_(\$* (#,##0);_(\$* "-"_);_(@_)';

    final Style style9 = workbook.styles.add('style9');
    style9.backColor = '#CFEBF1';
    style9.bold = true;
    style9.vAlign = VAlignType.center;
    style9.borders.bottom.lineStyle = LineStyle.medium;
    style9.borders.bottom.color = '#308DA2';
    style9.borders.right.lineStyle = LineStyle.thin;
    style9.borders.right.color = '#A6A6A6';
    style9.numberFormat = '_(\$* #,##0_);_(\$* (#,##0);_(\$* "-"_);_(@_)';

    final Style style10 = workbook.styles.add('style10');
    style10.borders.bottom.lineStyle = LineStyle.double;
    style10.borders.bottom.color = '#595959';

    return [
      style,
      style1,
      style2,
      style3,
      style4,
      style5,
      style6,
      style7,
      style8,
      style9,
      style10
    ];
  }
}
