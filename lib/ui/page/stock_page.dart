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
    return ListView(
      //

      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Text(
            "Stock",
            style: mainTextFont.copyWith(
                fontSize: 16, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 40, bottom: 16),
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: TextField(
              controller: this.searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
                labelText: "Cari",
              ),
            )),
        Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: FutureBuilder(
              future: futureProduct,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final data = snapshot.data!;
                  return data.isEmpty
                      ? const Center(child: Text('Tidak ada data  '))
                      : ListStockPage(data);
                }
              }),
        )
      ],
    );
  }
}
