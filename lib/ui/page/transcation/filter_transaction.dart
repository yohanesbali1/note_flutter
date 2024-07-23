part of '../pages.dart';

class FilterTransaction extends StatefulWidget {
  final search_form;
  const FilterTransaction(this.search_form);

  @override
  State<FilterTransaction> createState() => _FilterTransactionState();
}

class _FilterTransactionState extends State<FilterTransaction> {
  List<TransactionModel> futureTranscation = [];
  double total = 0.00;

  final transactionDB = TransactionDB();
  void initState() {
    super.initState();
    getData();
  }

  @override
  Future<void> getData() async {
    List<TransactionModel> transaction = await transactionDB.getFilter(
        widget.search_form!.company_id,
        widget.search_form!.start_date,
        widget.search_form!.end_date);
    transaction.forEach((element) {
      total = total + double.parse(element.totalprice.toString());
    });
    setState(() {
      futureTranscation = transaction;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgcolor,
        body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
                child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    padding: const EdgeInsets.only(
                        left: defaultMargin,
                        right: defaultMargin,
                        top: 42.0,
                        bottom: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(children: [
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    onTap: () => {
                                      context
                                          .read<PageBloc>()
                                          .add(GoToFormFilterPage()),
                                    },
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      child: Image.asset(
                                          "assets/icon/arrow-back.png"),
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
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom,
                                          ),
                                          child: SingleChildScrollView(
                                              child: SubMenu()),
                                        );
                                      },
                                    ),
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      child:
                                          Image.asset("assets/icon/menu.png"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 4, bottom: 10),
                                child: futureTranscation.isEmpty
                                    ? DataNotFound()
                                    : ListFilterTransactionItem(
                                        futureTranscation,
                                        getData,
                                        transactionDB)),
                            SizedBox(
                              height: 10,
                            ),
                          ]),
                        ),
                        futureTranscation.isEmpty
                            ? Container()
                            : Container(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                decoration: BoxDecoration(
                                    border: Border(
                                  top: BorderSide(
                                      color: textprimary, width: 1.0),
                                )),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total",
                                        style: monseratTextFont.copyWith(
                                            color: textprimary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    Text(Helper.convertToIdr(total, 2),
                                        style: monseratTextFont.copyWith(
                                            color: mainColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ))
                      ],
                    )))));
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
                Export().export_excel_transaction(futureTranscation);
                Navigator.pop(context);
              },
              child: Text('Export Data',
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
                Helper.share_data_transaction(futureTranscation);
                Navigator.pop(context);
              },
              child: Text('Share Data',
                  style: monseratTextFont.copyWith(
                      color: textprimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ),
          ]));
}
