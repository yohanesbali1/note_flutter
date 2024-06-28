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
                        onTap: () => context
                            .read<PageBloc>()
                            .add(GoToFormTransactionPage(null)),
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
