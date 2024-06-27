part of "pages.dart";

class StockPage extends StatefulWidget {
  StockPage({super.key});

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
            // Container(
            //     width: double.infinity,
            //     margin: const EdgeInsets.only(top: 40, bottom: 16),
            //     padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            //     child: TextField(
            //       controller: this.searchController,
            //       decoration: InputDecoration(
            //         filled: true,
            //         fillColor: Colors.white,
            //         contentPadding:
            //             EdgeInsets.symmetric(vertical: 10, horizontal: 13),
            //         border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(12),
            //             borderSide: const BorderSide(
            //                 width: 0, style: BorderStyle.none)),
            //         labelText: "Cari",
            //       ),
            //     )),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: FutureBuilder(
                  future: futureProduct,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      final data = snapshot.data ?? [];
                      print(data);
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
