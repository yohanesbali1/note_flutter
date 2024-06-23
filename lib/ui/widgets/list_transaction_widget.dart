part of 'widgets.dart';

class ListTransactionPage extends StatelessWidget {
  final List<TransactionModel> data;
  final TransactionDB transactionDB;
  final getDataTransaction;
  const ListTransactionPage(
      this.data, this.transactionDB, this.getDataTransaction);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 420,
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) => Slidable(
              endActionPane:
                  ActionPane(motion: const ScrollMotion(), children: [
                CustomSlidableAction(
                    autoClose: true,
                    backgroundColor: Colors.green,
                    onPressed: (context) {
                      context
                          .read<PageBloc>()
                          .add(GoToFormTransactionPage(data[index]));
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
                          style: mainTextFont.copyWith(
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
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text(
                                  'Apakah anda yakin?',
                                  style: blackTextFont.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                content: Text(
                                  'Data akan terhapus secara permanen!',
                                  style: blackTextFont.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: Text(
                                      'Batal',
                                      style: blackTextFont.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await transactionDB.delete(
                                          id: data[index].id);
                                      getDataTransaction();
                                      Navigator.pop(context, 'OK');
                                    },
                                    child: Text(
                                      'OK',
                                      style: blackTextFont.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ));
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
                          style: mainTextFont.copyWith(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          // style: mainTextFont.copyWith(fontSize: 12),
                        )
                      ],
                    )),
              ]),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                width: double.infinity,
                padding: const EdgeInsets.only(
                    top: 25, bottom: 25, left: 22, right: 22),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        data[index].company_name ?? "-",
                        style: mainTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        data[index].date,
                        style: whiteTextFont.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: mainColor),
                      )
                    ]),
              )),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: 10,
          ),
        ));
  }
}
