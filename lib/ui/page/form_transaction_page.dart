part of 'pages.dart';

class FormTransaction extends StatefulWidget {
  final TransactionModel? transaction_model;
  const FormTransaction(this.transaction_model);

  @override
  State<FormTransaction> createState() => _FormTransactionState();
}

class _FormTransactionState extends State<FormTransaction> {
  final companyDB = CompanyDB();
  final transactionDB = TransactionDB();
  final productDB = ProductDB();
  var id = 0;
  int? _selectedValue;
  List<CompanyModel> company_data = [];
  List<ProductModel> product_data = [];

  List<TransactionDetailFormModel> transaction_detail = [];

  TextEditingController no_transaction = TextEditingController();
  TextEditingController company_idController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    getData();
    print(transaction_detail.length);
    dateController.text =
        DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
  }

  @override
  void change_transaction_detail(payload) {
    setState(() {
      transaction_detail.add(payload);
    });
  }

  Future<void> getData() async {
    var data_company = await companyDB.getAll();
    var data_product = await productDB.getAll();
    setState(() {
      company_data = data_company;
      product_data = data_product;
    });
  }

  ProductModel show_product(id) =>
      product_data.firstWhere((item) => item.id == id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
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
                            "Form Transaksi",
                            style: mainTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled:
                                    true, // Allow bottom sheet to be scroll controlled
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    child: SingleChildScrollView(
                                        child: ModalTransactionDetail(
                                            change_transaction_detail,
                                            product_data)),
                                  );
                                },
                              );
                            },
                            child: Icon(Icons.add_rounded, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Vila",
                          style: blackTextFont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        DropdownButtonFormField(
                          onChanged: (newValue) {
                            setState(() {
                              // company_id = newValue;
                              // company_idController.text = newValue.toString();
                              // _selectedValue = newValue;

                              print(newValue);
                              //   // _currentSelectedValue = newValue;
                              //   // state.didChange(newValue);
                            });
                          },
                          value: _selectedValue,
                          items:
                              company_data.map<DropdownMenuItem<int>>((value) {
                            return DropdownMenuItem<int>(
                              value: value.id,
                              child: Text(
                                value.name,
                                style: mainTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 13),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.black),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.black)),
                            hintText: "Pilih vila",
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tanggal",
                          style: blackTextFont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2101));
                          },
                          controller: dateController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 13),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.black),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.black)),
                            hintText: "Masukan tanggal transaksi",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 420,
                      child: )
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
                      // if (no_transaction.text.isEmpty ||
                      //     company_idController.text.isEmpty ||
                      //     transaction_detail.length == 0) {
                      //   return;
                      // }
                      // if (id == 0) {
                      //   await companyDB.create(
                      //       name: nameController.text,
                      //       address: addressController.text);
                      // } else {
                      //   await companyDB.update(
                      //       id: id,
                      //       name: nameController.text,
                      //       address: addressController.text);
                      // }
                      // if (!mounted) return;
                      // context
                      //     .read<PageBloc>()
                      //     .add(GoToMainPage(bottomNavBarIndex: 2));
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
