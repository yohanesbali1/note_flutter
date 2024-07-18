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
  Future<void> getData() async {
    List<TransactionDetailModel> transaction_detail_data =
        await transactionDB.getdetail(widget.transaction_model!.id);

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
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () => context.read<PageBloc>().add(
                                  GoToMainPage(
                                      bottomNavBarIndex: 3, isExpired: false)),
                              child: Container(
                                width: 26,
                                height: 26,
                                child:
                                    Image.asset("assets/icon/arrow-back.png"),
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
                              onTap: () => {},
                              child: Container(
                                width: 26,
                                height: 26,
                                child: Image.asset("assets/icon/add.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Nama Vila',
                                      style: monseratTextFont.copyWith(
                                          color: textprimary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                      widget.transaction_model!.company_name ??
                                          '',
                                      textAlign: TextAlign.left,
                                      style: monseratTextFont.copyWith(
                                          color: textprimary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600))
                                ],
                              )
                            ]),
                      )
                    ],
                  ),
                ))));
  }
}
