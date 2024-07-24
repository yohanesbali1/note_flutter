part of '../pages.dart';

class TransacationPage extends StatefulWidget {
  final change_site;
  const TransacationPage(this.change_site);

  @override
  State<TransacationPage> createState() => _TransacationPageState();
}

class _TransacationPageState extends State<TransacationPage> {
  Future<List<TransactionModel>>? futureTranscation;
  var count_data = 0;
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
                        onTap: () => showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          isScrollControlled:
                              true, // Allow bottom sheet to be scroll controlled
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: SingleChildScrollView(child: SubMenu()),
                            );
                          },
                        ),
                        child: Container(
                          width: 26,
                          height: 26,
                          child: Image.asset("assets/icon/menu.png"),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: FutureBuilder(
                  future: futureTranscation,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      final data = snapshot.data ?? [];
                      return data.isEmpty
                          ? DataNotFound()
                          : ListTransactionItem(
                              data, getData, transactionDB, null);
                    }
                  }),
            )
          ],
        ));
  }

  Widget SubMenu() => Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgcolor2,
      ),
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 20.0, bottom: 25.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                context.read<PageBloc>().add(GoToFormTransactionPage(null));
                Navigator.pop(context);
              },
              child: Text('Tambah Data',
                  style: monseratTextFont.copyWith(
                      color: textprimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                context.read<PageBloc>().add(GoToFormFilterPage());
                Navigator.pop(context);
              },
              child: Text('Filter Data',
                  style: monseratTextFont.copyWith(
                      color: textprimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ),
          ]));
}
