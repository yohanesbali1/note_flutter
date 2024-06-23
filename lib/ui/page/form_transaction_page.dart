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
  List<CompanyModel> company_data = [];
  List<ProductModel> product_data = [];

  int? company_id;
  List<TransactionDetailModel> transaction_detail = [];
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    getData();
  }

  @override
  void change_transaction_detail(payload, status, index) {
    switch (status) {
      case 'tambah':
        setState(() {
          transaction_detail.add(payload);
        });
        break;
      case 'ubah':
        setState(() {
          transaction_detail.replaceRange(index, index + 1, [payload]);
        });
        break;
      case 'hapus':
        setState(() {
          transaction_detail.removeAt(index);
        });
        break;
    }
  }

  Future<void> getData() async {
    var data_company = await companyDB.getAll();
    var data_product = await productDB.getAll();
    List<TransactionDetailModel> transaction_detail_data = [];
    if (widget.transaction_model != null)
      transaction_detail_data =
          await transactionDB.getdetail(widget.transaction_model!.id);
    setState(() {
      company_data = data_company;
      product_data = data_product;
      dateController.text = widget.transaction_model?.date ?? "";
      company_id = widget.transaction_model?.company_id;
      transaction_detail = transaction_detail_data;
    });
  }

  ProductModel show_product(id) =>
      product_data.firstWhere((item) => item.id == id);

  Future<void> submit(int? id) async {
    if (company_id == null ||
        transaction_detail.length == 0 ||
        dateController.text.isEmpty) {
      return;
    }
    if (widget.transaction_model == null) {
      await transactionDB.create(
          company_id: company_id!,
          date: dateController.text,
          transaction_detail: transaction_detail);
    } else {
      await transactionDB.update(
          id: id!,
          company_id: company_id!,
          date: dateController.text,
          transaction_detail: transaction_detail);
    }
    if (!mounted) return;
    context.read<PageBloc>().add(GoToMainPage(bottomNavBarIndex: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
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
                                            product_data,
                                            null,
                                            null)),
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
                              company_id = newValue;
                            });
                          },
                          value: company_id,
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
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2101));
                            setState(() {
                              dateController.text = DateFormat('yyyy-MM-dd')
                                  .format(pickedDate!)
                                  .toString();
                            });
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
                      child: ListTransactionDetail(
                          transaction_detail,
                          change_transaction_detail,
                          product_data,
                          show_product))
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
                      submit(widget.transaction_model?.id ?? null);
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
