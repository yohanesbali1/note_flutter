part of '../pages.dart';

class FormTransaction extends StatefulWidget {
  final TransactionModel? transaction_model;
  const FormTransaction(this.transaction_model);

  @override
  State<FormTransaction> createState() => _FormTransactionState();
}

class _FormTransactionState extends State<FormTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgcolor,
        body: Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: Container(
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
                                    child: Image.asset(
                                        "assets/icon/arrow-back.png"),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Stok Produk",
                                  style: monseratTextFont.copyWith(
                                      color: textprimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // Align(
                              //   alignment: Alignment.centerRight,
                              //   child: GestureDetector(
                              //     onTap: () => showModalBottomSheet(
                              //       context: context,
                              //       isScrollControlled:
                              //           true, // Allow bottom sheet to be scroll controlled
                              //       builder: (BuildContext context) {
                              //         return Padding(
                              //           padding: EdgeInsets.only(
                              //             bottom: MediaQuery.of(context)
                              //                 .viewInsets
                              //                 .bottom,
                              //           ),
                              //           child: SingleChildScrollView(
                              //               child: ModalStock(
                              //                   null, futureProductModel)),
                              //         );
                              //       },
                              //     ),
                              //     child: Container(
                              //       width: 26,
                              //       height: 26,
                              //       child: Image.asset("assets/icon/add.png"),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ))),
                ])));
  }
}
