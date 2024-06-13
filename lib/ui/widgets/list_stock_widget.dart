part of 'widgets.dart';

class ListStockPage extends StatelessWidget {
  final data;
  const ListStockPage(this.data);

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
                          .add(GoToFormStockPage(data[index]));
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
                    onPressed: (context) {},
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
                padding: const EdgeInsets.only(
                    top: 25, bottom: 25, left: 22, right: 22),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data[index].name,
                            style: mainTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Container(
                        child: Text(
                          data[index].qty.toString(),
                          style: whiteTextFont.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: mainColor),
                        ),
                      )
                    ]),
              )),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: 10,
          ),
        ));
  }
}
