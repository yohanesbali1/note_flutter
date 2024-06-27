part of 'list_item.dart';

class ListTransaction extends StatefulWidget {
  ListTransaction({super.key});

  @override
  State<ListTransaction> createState() => _ListTransactionState();
}

class _ListTransactionState extends State<ListTransaction> {
  TextEditingController searchController = TextEditingController();
  Future<List<TransactionModel>>? futureTransaction;
  final transactionDB = TransactionDB();
  @override
  void initState() {
    getDataTransaction();
  }

  @override
  void getDataTransaction() {
    setState(() {
      futureTransaction = transactionDB.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child:
            //  FutureBuilder(
            //     future: futureTransaction,
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const Center(child: CircularProgressIndicator());
            //       } else {
            //         final data = snapshot.data ?? [];
            //         return data.isEmpty
            //             ? const Center(child: Text('Tidak ada data  '))
            //             :
            SizedBox(
                width: double.infinity,
                height: 420,
                child: ListView.separated(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) => Slidable(
                      endActionPane:
                          ActionPane(motion: const ScrollMotion(), children: [
                        CustomSlidableAction(
                            autoClose: true,
                            backgroundColor: Colors.green,
                            onPressed: (context) {
                              // context.read<PageBloc>().add(
                              //     GoToFormTransactionPage(
                              //         data[index]));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Edit",
                                  style: monseratTextFont.copyWith(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  // style: mainTextFont.copyWith(fontSize: 12),
                                )
                              ],
                            )),
                        CustomSlidableAction(
                            autoClose: true,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            backgroundColor: Colors.red,
                            onPressed: (context) {
                              // showDialog(
                              //     context: context,
                              //     builder: (BuildContext
                              //             context) =>
                              //         AlertDialog(
                              //           title: Text(
                              //             'Apakah anda yakin?',
                              //             style: blackTextFont
                              //                 .copyWith(
                              //                     fontSize: 18,
                              //                     fontWeight:
                              //                         FontWeight
                              //                             .w600),
                              //           ),
                              //           content: Text(
                              //             'Data akan terhapus secara permanen!',
                              //             style: blackTextFont
                              //                 .copyWith(
                              //                     fontSize: 14,
                              //                     fontWeight:
                              //                         FontWeight
                              //                             .w400),
                              //           ),
                              //           actions: <Widget>[
                              //             TextButton(
                              //               onPressed: () =>
                              //                   Navigator.pop(
                              //                       context,
                              //                       'Cancel'),
                              //               child: Text(
                              //                 'Batal',
                              //                 style: blackTextFont
                              //                     .copyWith(
                              //                   fontSize: 14,
                              //                   fontWeight:
                              //                       FontWeight
                              //                           .w400,
                              //                 ),
                              //               ),
                              //             ),
                              //             TextButton(
                              //               onPressed: () async {
                              //                 await transactionDB
                              //                     .delete(
                              //                         id: data[
                              //                                 index]
                              //                             .id);
                              //                 getDataTransaction();
                              //                 Navigator.pop(
                              //                     context, 'OK');
                              //               },
                              //               child: Text(
                              //                 'OK',
                              //                 style: blackTextFont
                              //                     .copyWith(
                              //                   fontSize: 14,
                              //                   fontWeight:
                              //                       FontWeight
                              //                           .w400,
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         ));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.delete_forever),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Delete",
                                  style: monseratTextFont.copyWith(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  // style: mainTextFont.copyWith(fontSize: 12),
                                )
                              ],
                            )),
                      ]),
                      child: Container(
                        decoration: BoxDecoration(
                            color: bgcolor2,
                            border: Border(
                                left: BorderSide(color: mainColor, width: 4))),
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 22, right: 22),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Vila Flamboyan",
                                style: monseratTextFont.copyWith(
                                    color: text2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "20 Januari 2024",
                                style: monseratTextFont.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: text3),
                              )
                            ]),
                      )),
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    height: 10,
                  ),
                ))
        // }
        // }),
        );
  }
}
