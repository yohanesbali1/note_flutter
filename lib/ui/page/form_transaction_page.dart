part of 'pages.dart';

class FormTransaction extends StatefulWidget {
  final TransactionModel? transaction_model;
  const FormTransaction(this.transaction_model);

  @override
  State<FormTransaction> createState() => _FormTransactionState();
}

class _FormTransactionState extends State<FormTransaction> {
  final companyDB = CompanyDB();
  var id = 0;
  int? _selectedValue;
  List<CompanyModel> companies = [];

  List<void> transaction_detail = [];

  TextEditingController no_transaction = TextEditingController();
  TextEditingController company_idController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    get_company();
    dateController.text =
        DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
  }

  @override
  void change_transaction_detail(payload) {
    setState(() {
      transaction_detail.add(payload);
    });
  }

  Future<void> get_company() async {
    var data = await companyDB.getAll();
    setState(() {
      companies = data;
    });
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
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: 600,
                                    width: double.infinity,
                                    child: ModalTransactionDetail(
                                        change_transaction_detail),
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
                          items: companies.map<DropdownMenuItem<int>>((value) {
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
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: transaction_detail.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Slidable(
                                endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      CustomSlidableAction(
                                          autoClose: true,
                                          backgroundColor: Colors.green,
                                          onPressed: (context) {},
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.edit),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Edit",
                                                style: mainTextFont.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                // style: mainTextFont.copyWith(fontSize: 12),
                                              )
                                            ],
                                          )),
                                      CustomSlidableAction(
                                          autoClose: true,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          backgroundColor: Colors.red,
                                          onPressed: (context) {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                        context) =>
                                                    AlertDialog(
                                                      title: Text(
                                                        'Apakah anda yakin?',
                                                        style: blackTextFont
                                                            .copyWith(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                      content: Text(
                                                        'Data akan terhapus secara permanen!',
                                                        style: blackTextFont
                                                            .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context,
                                                                  'Cancel'),
                                                          child: Text(
                                                            'Batal',
                                                            style: blackTextFont
                                                                .copyWith(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed:
                                                              () async {},
                                                          child: Text(
                                                            'OK',
                                                            style: blackTextFont
                                                                .copyWith(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ));
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.delete_forever),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Delete",
                                                style: mainTextFont.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                // style: mainTextFont.copyWith(fontSize: 12),
                                              )
                                            ],
                                          )),
                                    ]),
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(
                                      top: 25, bottom: 25, left: 22, right: 22),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          transaction_detail[index].name,
                                          style: mainTextFont.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          transaction_detail[index].address,
                                          style: whiteTextFont.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: mainColor),
                                        )
                                      ]),
                                )),
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          height: 10,
                        ),
                      ))
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
