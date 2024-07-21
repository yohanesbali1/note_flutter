part of 'modal.dart';

class ModalCompany extends StatefulWidget {
  final CompanyModel? company;
  final getData;
  ModalCompany(this.company, this.getData);

  @override
  State<ModalCompany> createState() => _ModalCompanyState();
}

class _ModalCompanyState extends State<ModalCompany> {
  final companyDB = CompanyDB();
  int? id;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool nameValidate = false;
  bool phoneValidate = false;
  bool addressValidate = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      nameController.text = widget.company?.name ?? "";
      addressController.text = widget.company?.address ?? "";
      phoneController.text = widget.company?.phone ?? "";
      id = widget.company?.id ?? null;
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
                'Form Vila',
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
                                  'Nama Vila',
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
                                      hintText: 'contoh : Vila Flamboyan',
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
                                  'Hp. Vila',
                                  style: monseratTextFont.copyWith(
                                      color: text2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextFormField(
                                  controller: phoneController,
                                  cursorColor: mainColor,
                                  keyboardType: TextInputType.phone,
                                  onChanged: (value) => setState(() {
                                    phoneValidate = phoneController.text == "";
                                  }),
                                  style: monseratTextFont.copyWith(
                                      color: text2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                      hintText: 'contoh : 08812345678',
                                      errorText: phoneValidate
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
                                  'Alamat',
                                  style: monseratTextFont.copyWith(
                                      color: text2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextFormField(
                                  controller: addressController,
                                  cursorColor: mainColor,
                                  maxLines: 5,
                                  onChanged: (value) => setState(() {
                                    addressValidate =
                                        addressController.text == "";
                                  }),
                                  style: monseratTextFont.copyWith(
                                      color: text2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                      errorText: addressValidate
                                          ? 'Data tidak boleh kosong'
                                          : null,
                                      hintText:
                                          'contoh : Jl. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
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
                            if (nameController.text == '' ||
                                addressController.text == '' ||
                                phoneController.text == '') {
                              nameController.text == ''
                                  ? setState(() {
                                      nameValidate = true;
                                    })
                                  : null;
                              addressController.text == ''
                                  ? setState(() {
                                      addressValidate = true;
                                    })
                                  : null;
                              return;
                            }
                            if (id == null) {
                              await companyDB.create(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  address: addressController.text);
                            } else {
                              await companyDB.update(
                                  name: nameController.text,
                                  id: id!,
                                  phone: phoneController.text,
                                  address: addressController.text);
                            }
                            widget.getData();
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
