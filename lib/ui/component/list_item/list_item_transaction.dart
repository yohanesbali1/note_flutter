part of 'list_item.dart';

class ListTransactionItem extends StatelessWidget {
  final data;
  final getData;
  final transactionDB;
  ListTransactionItem(this.data, this.getData, this.transactionDB);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 420,
        child: ListView.separated(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) => Slidable(
              endActionPane: ActionPane(
                  extentRatio: 0.4,
                  motion: const ScrollMotion(),
                  children: [
                    CustomSlidableAction(
                        autoClose: true,
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        backgroundColor: mainColor,
                        onPressed: (context) {
                          context
                              .read<PageBloc>()
                              .add(GoToFormTransactionPage(data[index]));
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
                                                  style:
                                                      monseratTextFont.copyWith(
                                                          fontSize: 16,
                                                          color: text2,
                                                          fontWeight:
                                                              FontWeight.w600)),
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
                                                        await transactionDB
                                                            .delete(
                                                                id: data[index]
                                                                    .id);
                                                        getData();
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
                    border:
                        Border(left: BorderSide(color: mainColor, width: 4))),
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 12, right: 12),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data[index].company_name,
                            style: monseratTextFont.copyWith(
                                color: textprimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            data[index].date,
                            style: monseratTextFont.copyWith(
                                color: textprimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      LayoutBuilder(
                          builder: (context, constraints) => Container(
                                constraints: BoxConstraints(
                                    maxWidth: constraints.maxWidth),
                                child: Text(
                                  Helper.convertToIdr(
                                      (data[index].totalprice), 2),
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
        ));
  }
}
