part of "pages.dart";

class StockPage extends StatefulWidget {
  StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
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
            child: TextField(
              controller: this.searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: accentColor4,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
                labelText: "Cari",
              ),
            )),
        const ListStockPage()
      ],
    );
  }
}
