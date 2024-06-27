part of 'pages.dart';

class TransacationPage extends StatefulWidget {
  const TransacationPage({super.key});

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
  void getData() {
    setState(() {
      futureTranscation = transactionDB.getAll();
    });
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
                        onTap: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled:
                              true, // Allow bottom sheet to be scroll controlled
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: SingleChildScrollView(
                                  child: ModalCompany(null, getData)),
                            );
                          },
                        ),
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
