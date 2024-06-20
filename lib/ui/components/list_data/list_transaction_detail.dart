part of "list_data.dart";

class ListTransactionDetail extends StatefulWidget {
  const ListTransactionDetail(this.transaction_detail);

  @override
  State<ListTransactionDetail> createState() => _ListTransactionDetailState();
}

class _ListTransactionDetailState extends State<ListTransactionDetail> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: transaction_detail.length,
      itemBuilder: (BuildContext context, int index) => Slidable(
          endActionPane: ActionPane(motion: const ScrollMotion(), children: [
            CustomSlidableAction(
                autoClose: true,
                backgroundColor: Colors.green,
                onPressed: (context) {},
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
                  widget.transaction_detail.removeAt(index);
                  setState(() {
                    widget.transaction_detail = widget.transaction_detail;
                  });
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
            padding:
                const EdgeInsets.only(top: 25, bottom: 25, left: 22, right: 22),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    show_product(transaction_detail[index].product_id).name,
                    // transaction_detail[index].id,
                    style: mainTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    show_product(transaction_detail[index].product_id)
                        .qty
                        .toString(),
                    // transaction_detail[index].address,
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
    );
  }
}
