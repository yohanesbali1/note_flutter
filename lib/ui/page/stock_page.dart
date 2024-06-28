part of "pages.dart";

class StockPage extends StatefulWidget {
  final change_site;
  StockPage(this.change_site);

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  TextEditingController searchController = TextEditingController();
  Future<List<ProductModel>>? futureProduct;
  final productDB = ProductDB();
  @override
  void initState() {
    futureProductModel();
  }

  @override
  void futureProductModel() {
    setState(() {
      futureProduct = productDB.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          children: <Widget>[
            Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        child: Container(
                          width: 26,
                          height: 26,
                          child: Image.asset("assets/icon/arrow-back.png"),
                        ),
                        onTap: () => {widget.change_site(0)},
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Stok Produk",
                        style: monseratTextFont.copyWith(
                            color: textprimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled:
                              true, // Allow bottom sheet to be scroll controlled
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: SingleChildScrollView(
                                  child: ModalStock(null, futureProductModel)),
                            );
                          },
                        ),
                        child: Container(
                          width: 26,
                          height: 26,
                          child: Image.asset("assets/icon/add.png"),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: FutureBuilder(
                  future: futureProduct,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      final data = snapshot.data ?? [];
                      return data.isEmpty
                          ? DataNotFound()
                          : ListStockItem(data, futureProductModel, productDB);
                    }
                  }),
            )
          ],
        ));
  }
}
