part of '../pages.dart';

class TransactionDetail extends StatefulWidget {
  final TransactionModel? transaction_model;
  TransactionDetail(this.transaction_model);

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  final transactionDB = TransactionDB();
  List<TransactionDetailModel> transaction_detail = [];
  double total = 0.00;
  DateFormat dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    List<TransactionDetailModel> transaction_detail_data =
        await transactionDB.getdetail(widget.transaction_model!.id);
    transaction_detail_data.forEach((element) {
      total = total + (element.price * element.amount);
    });
    setState(() {
      transaction_detail = transaction_detail_data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgcolor,
        body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
                    child: Container(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  padding: const EdgeInsets.only(
                      left: defaultMargin,
                      right: defaultMargin,
                      top: 42.0,
                      bottom: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () =>
                                      context.read<PageBloc>().add(GoToMainPage(
                                            bottomNavBarIndex: 3,
                                          )),
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
                                  "Detail Transaksi",
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
                                  onTap: () => {
                                    showModalBottomSheet(
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
                                              child: SubMenu(transaction_detail,
                                                  widget.transaction_model)),
                                        );
                                      },
                                    ),
                                  },
                                  child: Container(
                                    width: 26,
                                    height: 26,
                                    child: Image.asset("assets/icon/menu.png"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            width: double.infinity,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Nama Vila',
                                          style: monseratTextFont.copyWith(
                                              color: textprimary,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400)),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                          widget.transaction_model!
                                                  .company_name ??
                                              '',
                                          textAlign: TextAlign.left,
                                          style: monseratTextFont.copyWith(
                                              color: textprimary,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600))
                                    ],
                                  )
                                ]),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            width: double.infinity,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Tanggal Transaksi',
                                          style: monseratTextFont.copyWith(
                                              color: textprimary,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400)),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                          dateFormat.format(DateTime.parse(
                                              widget.transaction_model!.date ??
                                                  '')),
                                          textAlign: TextAlign.left,
                                          style: monseratTextFont.copyWith(
                                              color: textprimary,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600))
                                    ],
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "List Transaksi",
                            style: monseratTextFont.copyWith(
                                color: textprimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 4, bottom: 10),
                              child: transaction_detail.isEmpty
                                  ? DataNotFound()
                                  : ListTransactionDetailItem(
                                      transaction_detail, null, false)),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          decoration: BoxDecoration(
                              border: Border(
                            top: BorderSide(color: textprimary, width: 1.0),
                          )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ),
                ))));
  }

  Widget SubMenu(transaction_detail, transaction) => Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgcolor2,
      ),
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                await Export().export_excel_detail_transaction(
                    transaction_detail, widget.transaction_model);
                Helper().alert(context, 'success', null);
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
                ShareMedia.share_data_transaction_detail(
                    transaction_detail, widget.transaction_model);
              },
              child: Text('Kirim Data',
                  style: monseratTextFont.copyWith(
                      color: textprimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ),
          ]));
}
