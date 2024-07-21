part of 'modal.dart';

class ModalStock extends StatefulWidget {
  final ProductModel? product;
  final futureProductModel;
  const ModalStock(this.product, this.futureProductModel);

  @override
  State<ModalStock> createState() => _ModalStockState();
}

class _ModalStockState extends State<ModalStock> {
  final productDB = ProductDB();
  int? id;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  bool priceValidate = false;
  bool nameValidate = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      nameController.text = widget.product?.name ?? "";
      priceController.text = widget.product?.price.toString() ?? "";
      id = widget.product?.id ?? null;
    });
  }

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
                'Form Stok Produk',
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
                                  'Nama Barang',
                                  style: monseratTextFont.copyWith(
                                      color: text2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextFormField(
                                  controller: nameController,
                                  cursorColor: mainColor,
                                  onChanged: (value) => setState(() {
                                    nameValidate = nameController.text == "";
                                  }),
                                  style: monseratTextFont.copyWith(
                                      color: text2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                      hintText: 'contoh : Bantal',
                                      errorText: nameValidate
                                          ? 'Data tidak boleh kosong'
                                          : null,
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
                                  cursorColor: mainColor,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) => setState(() {
                                    priceValidate = priceController.text == "";
                                  }),
                                  style: monseratTextFont.copyWith(
                                      color: text2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                      hintText: 'contoh : 10000',
                                      errorText: priceValidate
                                          ? 'Data tidak boleh kosong'
                                          : null,
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
                            if (nameController.text == '') {
                              setState(() {
                                nameValidate = true;
                              });
                              return;
                            }
                            if (id == null) {
                              await productDB.create(
                                  name: nameController.text,
                                  price: double.parse(priceController.text));
                            } else {
                              await productDB.update(
                                  name: nameController.text,
                                  id: id!,
                                  price: double.parse(priceController.text));
                            }
                            widget.futureProductModel();
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
