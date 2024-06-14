part of 'pages.dart';

class FormCompany extends StatefulWidget {
  final CompanyModel? companyModel;
  const FormCompany(this.companyModel);

  @override
  State<FormCompany> createState() => _FormCompanyState();
}

class _FormCompanyState extends State<FormCompany> {
  final companyDB = CompanyDB();
  var id = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    id = widget.companyModel?.id ?? 0;
    nameController.text = widget.companyModel?.name ?? "";
    addressController.text = widget.companyModel?.address ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.read<PageBloc>().add(GoToMainPage());
                            },
                            child: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Form Stock",
                            style: mainTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 1)),
                      labelText: "Nama Produk ",
                      hintText: "Masukan nama produk",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLines: 8,
                    textAlignVertical: TextAlignVertical.top,
                    controller: addressController,
                    decoration: InputDecoration(
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 1)),
                        labelText: "Alamat ",
                        hintText: "Masukan alamat"),
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 70, bottom: 19),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(mainColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      if (nameController.text.isEmpty ||
                          addressController.text.isEmpty) {
                        return;
                      }
                      if (id == 0) {
                        await companyDB.create(
                            name: nameController.text,
                            address: addressController.text);
                      } else {
                        await companyDB.update(
                            id: id,
                            name: nameController.text,
                            address: addressController.text);
                      }
                      if (!mounted) return;
                      context
                          .read<PageBloc>()
                          .add(GoToMainPage(bottomNavBarIndex: 2));
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
