part of 'list_item.dart';

class ListTransactionDetailItem extends StatelessWidget {
  final transaction_detail;
  final change_transaction_detail;
  ListTransactionDetailItem(
    this.transaction_detail,
    this.change_transaction_detail,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: transaction_detail.length,
      itemBuilder: (BuildContext context, int index) => Slidable(
          endActionPane: ActionPane(
              extentRatio: 0.4,
              motion: const ScrollMotion(),
              children: [
                CustomSlidableAction(
                    autoClose: true,
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    backgroundColor: mainColor,
                    onPressed: (context) {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled:
                            true, // Allow bottom sheet to be scroll controlled
                        builder: (BuildContext context) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: SingleChildScrollView(
                                child: ModalTransactionDetail(
                                    change_transaction_detail,
                                    transaction_detail[index],
                                    index)),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 25,
                      height: 25,
                      child: Image.asset('assets/icon/edit.png'),
                    )),
                CustomSlidableAction(
                    autoClose: true,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    backgroundColor: const Color.fromARGB(255, 197, 65, 55),
                    onPressed: (context) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                              contentPadding: EdgeInsets.all(0),
                              content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 30),
                                      decoration: BoxDecoration(
                                          color: bgcolor,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            padding: EdgeInsets.all(13),
                                            decoration: BoxDecoration(
                                                color: mainColor,
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Image.asset(
                                                'assets/icon/warning.png'),
                                          ),
                                          SizedBox(
                                            height: 17,
                                          ),
                                          Text('Apakah anda yakin ?',
                                              textAlign: TextAlign.center,
                                              style: monseratTextFont.copyWith(
                                                  fontSize: 16,
                                                  color: text2,
                                                  fontWeight: FontWeight.w600)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Data akan terhapus secara permanen!',
                                            textAlign: TextAlign.center,
                                            style: monseratTextFont.copyWith(
                                              fontSize: 14,
                                              color: text3,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 28,
                                          ),
                                          Align(
                                              alignment: Alignment.bottomCenter,
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(mainColor),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                      padding:
                                                          MaterialStateProperty
                                                              .all<EdgeInsets>(
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical: 10),
                                                      )),
                                                  child: Text('Hapus Data',
                                                      style: monseratTextFont
                                                          .copyWith(
                                                              color:
                                                                  textprimary,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                  onPressed: () async {
                                                    await change_transaction_detail(
                                                        null, 'hapus', index);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ))
                                        ],
                                      ),
                                    )
                                  ])));
                    },
                    child: Container(
                      width: 25,
                      height: 25,
                      child: Image.asset('assets/icon/delete.png'),
                    )),
              ]),
          child: Container(
            decoration: BoxDecoration(
                color: bgcolor2,
                border: Border(left: BorderSide(color: mainColor, width: 4))),
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, left: 12, right: 12),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  LayoutBuilder(
                      builder: (context, constraints) => Container(
                            constraints:
                                BoxConstraints(maxWidth: constraints.maxWidth),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  transaction_detail[index].product_name,
                                  style: monseratTextFont.copyWith(
                                      color: textprimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  transaction_detail[index].amount.toString() +
                                      ' x ' +
                                      Helper.convertToIdr(
                                          transaction_detail[index].price, 2),
                                  style: monseratTextFont.copyWith(
                                      color: textprimary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          )),
                  LayoutBuilder(
                      builder: (context, constraints) => Container(
                            constraints:
                                BoxConstraints(maxWidth: constraints.maxWidth),
                            child: Text(
                              Helper.convertToIdr(
                                  (transaction_detail[index].amount *
                                      transaction_detail[index].price),
                                  2),
                              style: monseratTextFont.copyWith(
                                  color: mainColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ))
                ]),
          )),
      separatorBuilder: (BuildContext context, int index) => SizedBox(
        height: 10,
      ),
    );
  }
}
