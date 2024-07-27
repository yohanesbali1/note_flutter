part of 'list_item.dart';

class ListCompanyItem extends StatelessWidget {
  final data;
  final getData;
  final companyDB;
  ListCompanyItem(this.data, this.getData, this.companyDB);

  Future<void> deleteData(context, id) async {
    var res = await Helper().alert(context, 'delete', null);
    if (res) {
      await companyDB.delete(id: id);
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
                                      child:
                                          ModalCompany(data[index], getData)),
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
                child: LayoutBuilder(
                    builder: (context, constraints) => Container(
                          decoration: BoxDecoration(
                              color: bgcolor2,
                              border: Border(
                                  left:
                                      BorderSide(color: mainColor, width: 4))),
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 12, right: 12),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      constraints: BoxConstraints(
                                          maxWidth: constraints.maxWidth),
                                      child: Text(
                                        data[index].name,
                                        style: monseratTextFont.copyWith(
                                            color: textprimary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      data[index].phone,
                                      style: monseratTextFont.copyWith(
                                          color: textprimary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: constraints.maxWidth >= 500
                                            ? 500
                                            : constraints.maxWidth,
                                      ),
                                      child: Text(
                                        data[index].address,
                                        style: monseratTextFont.copyWith(
                                            color: textprimary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ))),
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 10,
            ),
          ))
    ]));
  }
}
