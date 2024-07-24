part of "pages.dart";

class DashboardPage extends StatefulWidget {
  final change_site;
  const DashboardPage(this.change_site);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<TransactionModel> futureTranscation = [];
  List<ProductModel> futureProduct = [];
  final transactionDB = TransactionDB();
  final productDB = ProductDB();
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var data_transaction = await transactionDB.getThisMonth();
    var data_product = await productDB.getAll();
    setState(() {
      futureTranscation = data_transaction;
      futureProduct = data_product;
    });
  }

  String formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
      child: ListView(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "Dashboard",
              style: monseratTextFont.copyWith(
                  color: textprimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 35, bottom: 26),
            height: 144,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 125,
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  decoration: BoxDecoration(
                      color: bgcolor2,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(100)),
                          child: Container(
                            width: 26,
                            height: 26,
                            child:
                                Image.asset("assets/icon/archive-yello-bg.png"),
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Produk',
                            style: monseratTextFont.copyWith(
                                color: text3,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            formatNumber(futureProduct.length),
                            style: monseratTextFont.copyWith(
                                color: textprimary,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  width: 200,
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  decoration: BoxDecoration(
                      color: bgcolor2,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(100)),
                          child: Container(
                            width: 26,
                            height: 26,
                            child: Image.asset("assets/icon/note-yello-bg.png"),
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transaksi Bulan Ini',
                            style: monseratTextFont.copyWith(
                                color: text3,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            formatNumber(futureTranscation.length),
                            style: monseratTextFont.copyWith(
                                color: textprimary,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Transaksi Bulan Ini",
                  style: monseratTextFont.copyWith(
                    color: textprimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
                GestureDetector(
                    onTap: () => {widget.change_site(3)},
                    child: Text(
                      "Lihat Semua",
                      style: monseratTextFont.copyWith(
                          color: mainColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    ))
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 20, bottom: 30),
              child: futureTranscation.isEmpty
                  ? DataNotFound()
                  : ListTransactionItem(
                      futureTranscation, getData, transactionDB, 5))
        ],
      ),
    );
  }
}
