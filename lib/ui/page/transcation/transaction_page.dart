part of '../pages.dart';

class TransacationPage extends StatefulWidget {
  final change_site;
  const TransacationPage(this.change_site);

  @override
  State<TransacationPage> createState() => _TransacationPageState();
}

class _TransacationPageState extends State<TransacationPage> {
  Future<List<TransactionModel>>? futureTranscation;
  final transactionDB = TransactionDB();
  void initState() {
    super.initState();
    getData();
  }

  @override
  Future<void> getData() async {
    setState(() {
      futureTranscation = transactionDB.getAll();
    });
  }

  void createExcel() async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    sheetObject.cell(CellIndex.indexByString("A1")).value =
        TextCellValue('Some Text');
    sheetObject.cell(CellIndex.indexByString("B1")).value =
        TextCellValue('Some Text');
    sheetObject.cell(CellIndex.indexByString("A2")).value =
        TextCellValue('Some Text');
    sheetObject.cell(CellIndex.indexByString("B2")).value =
        TextCellValue('Some Text');
    sheetObject.cell(CellIndex.indexByString("A3")).value =
        TextCellValue('Some Text');
    sheetObject.cell(CellIndex.indexByString("B3")).value =
        TextCellValue('Some Text');

    var directory = Directory('/storage/emulated/0/Download');
    String filePath = '${directory.path}/example.text';

    // Save the file
    var fileBytes = excel.save();
    if (fileBytes != null) {
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('AlertDialog Title'),
                content: const Text('AlertDialog description'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          children: <Widget>[
            Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => {widget.change_site(0)},
                        child: Container(
                          width: 26,
                          height: 26,
                          child: Image.asset("assets/icon/arrow-back.png"),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Transaksi",
                        style: monseratTextFont.copyWith(
                            color: textprimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => createExcel(),
                        child: Container(
                          width: 26,
                          height: 26,
                          child: Image.asset("assets/icon/add.png"),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: FutureBuilder(
                  future: futureTranscation,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      final data = snapshot.data ?? [];
                      return data.isEmpty
                          ? DataNotFound()
                          : ListTransactionItem(data, getData, transactionDB);
                    }
                  }),
            )
          ],
        ));
  }
}
