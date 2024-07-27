part of 'list_item.dart';

class ListStockItem extends StatelessWidget {
  final data;
  final futureProductModel;
  final productDB;
  ListStockItem(this.data, this.futureProductModel, this.productDB);
  Future<void> deleteData(context, id) async {
    var res = await Helper().alert(context, 'delete', null);
    if (res) {
      await productDB.delete(id: id);
      futureProductModel();
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
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) => Slidable(
                endActionPane: ActionPane(
                    extentRatio: 0.45,
                    motion: const ScrollMotion(),
                    children: [
                      CustomSlidableAction(
                          autoClose: true,
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          backgroundColor: mainColor,
                          onPressed: (context) {
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
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              Helper.convertToIdr(data[index].price, 2),
                              style: monseratTextFont.copyWith(
                                  color: textprimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
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
