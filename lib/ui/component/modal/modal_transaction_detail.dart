part of 'modal.dart';

class ModalTransactionDetail extends StatefulWidget {
  final change_transaction_detail;
  final TransactionDetailModel? transaction_detail_data;
  final int? id;
  ModalTransactionDetail(
      this.change_transaction_detail, this.transaction_detail_data, this.id);

  @override
  State<ModalTransactionDetail> createState() => _ModalTransactionDetailState();
}

class _ModalTransactionDetailState extends State<ModalTransactionDetail> {
  final productDB = ProductDB();
  List<ProductModel> product_data = [];
  int? product_value;
  TextEditingController qtyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController finalController = TextEditingController();
  @override
  void initState() {
    getData();
    if (widget.transaction_detail_data != null) {
      product_value = widget.transaction_detail_data?.product_id ?? 0;
      qtyController.text =
          widget.transaction_detail_data?.amount.toString() ?? "";
      priceController.text =
          widget.transaction_detail_data?.price.round().toString() ?? "";

      cont_price(qtyController.text, priceController.text);
    }
  }

  void cont_price(qty, price) async {
    qty = qty == "" ? "0" : qty;
    price = price == "" ? "0" : price;
    setState(() {
      finalController.text = (int.parse(qty) * int.parse(price)).toString();
    });
  }

  Future<void> getData() async {
    var data = await productDB.getAll();
    setState(() {
      product_data = data;
    });
  }

  ProductModel show_product(id) =>
      product_data.firstWhere((item) => item.id == id);

  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: bgcolor2,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 20.0, bottom: 14.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Form Transaksi Detail',
                textAlign: TextAlign.center,
                style: monseratTextFont.copyWith(
                    color: mainColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 20, bottom: 40),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Produk',
                                  style: monseratTextFont.copyWith(
                                      color: text2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                DropdownButtonFormField(
                                  onChanged: (newValue) {
                                    setState(() {
                                      product_value = newValue;
                                    });
                                  },
                                  alignment: Alignment.bottomCenter,
                                  decoration: InputDecoration(
                                      hintText: 'Pilih produk',
                                      hintStyle: monseratTextFont.copyWith(
                                          color: text3,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 6),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(width: 1, color: text3),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: accColor))),
                                  value: product_value,
                                  dropdownColor: bgcolor2,
                                  items: product_data
                                      .map<DropdownMenuItem<int>>((value) {
                                    return DropdownMenuItem<int>(
                                      value: value.id,
                                      child: Text(
                                        value.name,
                                        style: monseratTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    );
                                  }).toList(),
                                  style: monseratTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Jumlah',
                                  style: monseratTextFont.copyWith(
                                      color: text2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextFormField(
                                  controller: qtyController,
                                  onChanged: (value) =>
                                      cont_price(value, priceController.text),
                                  keyboardType: TextInputType.number,
                                  cursorColor: mainColor,
                                  style: monseratTextFont.copyWith(
                                      color: text2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                      hintText: 'contoh : 1',
                                      hintStyle: monseratTextFont.copyWith(
                                          color: text3,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 6),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(width: 1, color: text3),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: accColor))),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Harga',
                                  style: monseratTextFont.copyWith(
                                      color: text2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextFormField(
                                  controller: priceController,
                                  onChanged: (value) =>
                                      cont_price(qtyController.text, value),
                                  keyboardType: TextInputType.number,
                                  cursorColor: mainColor,
                                  style: monseratTextFont.copyWith(
                                      color: text2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                      hintText: 'contoh : 10000',
                                      hintStyle: monseratTextFont.copyWith(
                                          color: text3,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 6),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(width: 1, color: text3),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: accColor))),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Total Harga',
                                  style: monseratTextFont.copyWith(
                                      color: text2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextFormField(
                                  controller: finalController,
                                  readOnly: true,
                                  cursorColor: mainColor,
                                  style: monseratTextFont.copyWith(
                                      color: text2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                      hintText: 'contoh : 10000',
                                      hintStyle: monseratTextFont.copyWith(
                                          color: text3,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 6),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(width: 1, color: text3),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: accColor))),
                                )
                              ],
                            )
                          ])),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(mainColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(vertical: 14),
                              )),
                          child: Text('Simpan',
                              style: monseratTextFont.copyWith(
                                  color: textprimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          onPressed: () async {
                            if (product_value == null ||
                                qtyController.text == '' ||
                                priceController.text == '') {
                              return;
                            }
                            if (widget.id == null) {
                              widget.change_transaction_detail(
                                  TransactionDetailModel(
                                      product_id: product_value ?? 0,
                                      product_name:
                                          show_product(product_value).name,
                                      amount: int.parse(qtyController.text),
                                      price:
                                          double.parse(priceController.text)),
                                  'tambah',
                                  null);
                            } else {
                              widget.change_transaction_detail(
                                  TransactionDetailModel(
                                      product_id: product_value ?? 0,
                                      amount: int.parse(qtyController.text),
                                      product_name:
                                          show_product(product_value).name,
                                      price:
                                          double.parse(priceController.text)),
                                  'ubah',
                                  widget.id);
                            }
                            Navigator.pop(context);
                          },
                        ),
                      )),
                  SizedBox(height: 10),
                ],
              ),
            ]));
  }
}
