part of 'list_item.dart';

class ListTransactionItem extends StatelessWidget {
  final data;
  final getData;
  var status = "";
  final transactionDB;
  final limit;
  ListTransactionItem(this.data, this.getData, this.transactionDB, this.limit);

  DateFormat dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
  Future<void> deleteData(context, id) async {
    var res = await Helper().alert(context, 'delete', null);
    if (res) {
      await transactionDB.delete(id: id);
      getData();
    }
  }

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
            itemCount: data.length > 0 && limit is bool ? limit : data.length,
            itemBuilder: (BuildContext context, int index) => Slidable(
                endActionPane: ActionPane(
                    extentRatio: 0.65,
                    motion: const ScrollMotion(),
                    children: [
                      CustomSlidableAction(
                          autoClose: true,
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          backgroundColor: bgcolor3,
                          onPressed: (context) {
                            context
                                .read<PageBloc>()
                                .add(GoToTransactionDetailPage(data[index]));
                          },
                          child: Container(
                            width: 25,
                            height: 25,
                            child: Image.asset('assets/icon/details.png'),
                          )),
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
                          backgroundColor:
                              const Color.fromARGB(255, 197, 65, 55),
                          onPressed: (context) {
                            deleteData(context, data[index].id);
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
                              dateFormat
                                  .format(DateTime.parse(data[index].date)),
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
          ))
    ]));
  }
}
