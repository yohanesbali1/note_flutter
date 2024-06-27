part of '../pages.dart';

class FormTransaction extends StatefulWidget {
  final TransactionModel? transaction_model;
  const FormTransaction(this.transaction_model);

  @override
  State<FormTransaction> createState() => _FormTransactionState();
}

class _FormTransactionState extends State<FormTransaction> {
  List<TransactionDetailModel> transaction_detail = [];
  @override
  void change_transaction_detail(payload, status, index) {
    switch (status) {
      case 'tambah':
        setState(() {
          transaction_detail.add(payload);
        });
        break;
      case 'ubah':
        setState(() {
          transaction_detail.replaceRange(index, index + 1, [payload]);
        });
        break;
      case 'hapus':
        setState(() {
          transaction_detail.removeAt(index);
        });
        break;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgcolor,
        body: Container(
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: [
                Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Stack(
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
                              child: Image.asset("assets/icon/arrow-back.png"),
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
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: SingleChildScrollView(
                                      child: ModalTransactionDetail(
                                          change_transaction_detail,
                                          null,
                                          null)),
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
                    ))
              ],
            )));
  }
}
