part of 'shared.dart';

class Helper {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  void export_excel(myList) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    for (var i = 0; i < myList.length; i++) {
      final item = myList[i];
      sheet.getRangeByIndex(i + 2, 1).setText(item["title"].toString());
      sheet.getRangeByIndex(i + 2, 2).setText(item["link"].toString());
    }
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
    String filePath = '${_directory.path}/example.xlsx';
    final File file = File(filePath);
    await file.writeAsBytes(bytes, flush: true);
    final exPath = _directory.path;
    await Directory(exPath).create(recursive: true);
    workbook.dispose();
  }
}
