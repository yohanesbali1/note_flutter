part of 'list_item.dart';

class ListStockItem extends StatelessWidget {
  final data;
  final futureProductModel;
  final productDB;
  ListStockItem(this.data, this.futureProductModel, this.productDB);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 20),
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) => Slidable(
                endActionPane: ActionPane(
                    extentRatio: 0.35,
                    motion: const ScrollMotion(),
                    children: [
                      CustomSlidableAction(
                          autoClose: true,
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          backgroundColor: mainColor,
                          onPressed: (context) {
                            showModalBottomSheet(
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
                                      child: ModalStock(
                                          data[index], futureProductModel)),
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
                          backgroundColor:
                              const Color.fromARGB(255, 197, 65, 55),
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
                                                          BorderRadius.circular(
                                                              100)),
                                                  child: Image.asset(
                                                      'assets/icon/warning.png'),
                                                ),
                                                SizedBox(
                                                  height: 17,
                                                ),
                                                Text('Apakah anda yakin ?',
                                                    textAlign: TextAlign.center,
                                                    style: monseratTextFont
                                                        .copyWith(
                                                            fontSize: 16,
                                                            color: text2,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Data akan terhapus secara permanen!',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      monseratTextFont.copyWith(
                                                    fontSize: 14,
                                                    color: text3,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 28,
                                                ),
                                                Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(
                                                                        mainColor),
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
                                                                    .all<
                                                                        EdgeInsets>(
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 10),
                                                            )),
                                                        child: Text(
                                                            'Hapus Data',
                                                            style: monseratTextFont.copyWith(
                                                                color:
                                                                    textprimary,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                        onPressed: () async {
                                                          await productDB
                                                              .delete(
                                                                  id: data[
                                                                          index]
                                                                      .id);
                                                          futureProductModel();
                                                          Navigator.pop(
                                                              context);
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
                      border:
                          Border(left: BorderSide(color: mainColor, width: 4))),
                  padding: const EdgeInsets.only(
                      top: 23, bottom: 23, left: 12, right: 12),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data[index].name,
                              style: monseratTextFont.copyWith(
                                  color: textprimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ]),
                )),
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 10,
            ),
          ))
    ]));
  }
}
