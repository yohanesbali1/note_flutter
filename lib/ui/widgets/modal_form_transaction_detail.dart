part of 'widgets.dart';

class ModalTransactionDetail extends StatefulWidget {
  final change_transaction_detail;
  final List<ProductModel> product_data;
  ModalTransactionDetail(this.change_transaction_detail, this.product_data);

  @override
  State<ModalTransactionDetail> createState() => _ModalTransactionDetailState();
}

class _ModalTransactionDetailState extends State<ModalTransactionDetail> {
  final productDB = ProductDB();

  int? product_value;
  TextEditingController qtyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController finalController = TextEditingController();

  Future<void> cont_price(qty, price) async {
    qty = qty == "" ? "0" : qty;
    price = price == "" ? "0" : price;
    setState(() {
      finalController.text = (int.parse(qty) * int.parse(price)).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: 18.0, right: 18.0, top: 20.0, bottom: 14.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Form Detail Transaction',
            textAlign: TextAlign.left,
            style: blackTextFont.copyWith(
                fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Produk',
                            textAlign: TextAlign.left,
                            style: blackTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          DropdownButtonFormField(
                            onChanged: (newValue) {
                              setState(() {
                                product_value = newValue;
                              });
                            },
                            decoration: InputDecoration(
                                hintText: 'Pilih produk',
                                hintStyle: blackTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                            value: product_value,
                            items: widget.product_data
                                .map<DropdownMenuItem<int>>((value) {
                              return DropdownMenuItem<int>(
                                value: value.id,
                                child: Text(
                                  value.name,
                                  style: mainTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              );
                            }).toList(),
                            style: blackTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jumlah',
                            textAlign: TextAlign.left,
                            style: blackTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          TextFormField(
                            controller: qtyController,
                            onChanged: (value) =>
                                cont_price(value, priceController.text),
                            keyboardType: TextInputType.number,
                            style: blackTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                              hintText: 'Masukan jumlah',
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Harga',
                            textAlign: TextAlign.left,
                            style: blackTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          TextFormField(
                            controller: priceController,
                            onChanged: (value) =>
                                cont_price(qtyController.text, value),
                            keyboardType: TextInputType.number,
                            style: blackTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                              hintText: 'Masukan harga',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Harga',
                            textAlign: TextAlign.left,
                            style: blackTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          TextFormField(
                            controller: finalController,
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            style: blackTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                              hintText: 'Masukan total harga',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                              style: whiteTextFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          onPressed: () async {
                            if (product_value == null ||
                                qtyController.text == '' ||
                                priceController.text == '') {}
                            widget.change_transaction_detail(
                                TransactionDetailFormModel(
                                    product_id: product_value ?? 0,
                                    amount: int.parse(qtyController.text),
                                    price: double.parse(priceController.text)));
                            Navigator.pop(context);
                          },
                        ),
                      ))
                ],
              ))
        ],
      ),
    );
  }
}
