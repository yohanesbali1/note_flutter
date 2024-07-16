part of '../pages.dart';

class FormTransaction extends StatefulWidget {
  final TransactionModel? transaction_model;
  const FormTransaction(this.transaction_model);

  @override
  State<FormTransaction> createState() => _FormTransactionState();
}

class _FormTransactionState extends State<FormTransaction> {
  final transactionDB = TransactionDB();
  final companyDB = CompanyDB();
  List<TransactionDetailModel> transaction_detail = [];
  List<CompanyModel> company_data = [];
  int? company_id;
  TextEditingController dateController = TextEditingController();

  bool dateValidate = false;
  bool companyValidate = false;

  void initState() {
    super.initState();
    getData();
    if (widget.transaction_model != null) {
      company_id = widget.transaction_model?.company_id;
      dateController.text = widget.transaction_model?.date ?? "";
    }
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

  @override
  Future<void> getData() async {
    var data = await companyDB.getAll();
    List<TransactionDetailModel> transaction_detail_data = [];
    if (widget.transaction_model != null)
      transaction_detail_data =
          await transactionDB.getdetail(widget.transaction_model!.id);
    setState(() {
      company_data = data;
      transaction_detail = transaction_detail_data;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgcolor,
        body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
                child: Container(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    padding: const EdgeInsets.only(
                        left: defaultMargin,
                        right: defaultMargin,
                        top: 42.0,
                        bottom: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: () => context.read<PageBloc>().add(
                                          GoToMainPage(
                                              bottomNavBarIndex: 3,
                                              isExpired: false)),
                                      child: Container(
                                        width: 26,
                                        height: 26,
                                        child: Image.asset(
                                            "assets/icon/arrow-back.png"),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      widget.transaction_model != null
                                          ? "Ubah Transaksi"
                                          : "Tambah Transaksi",
                                      style: monseratTextFont.copyWith(
                                          color: textprimary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () => showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
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
                                                    null,
                                                    null)),
                                          );
                                        },
                                      ),
                                      child: Container(
                                        width: 26,
                                        height: 26,
                                        child:
                                            Image.asset("assets/icon/add.png"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 20),
                                            child: Column(children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Vila',
                                                    style: monseratTextFont
                                                        .copyWith(
                                                            color: text2,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                  DropdownButtonFormField(
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        company_id = newValue;
                                                        companyValidate =
                                                            newValue == "";
                                                      });
                                                    },
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    decoration: InputDecoration(
                                                        hintText: 'Pilih vila',
                                                        errorText: companyValidate
                                                            ? 'Data tidak boleh kosong'
                                                            : null,
                                                        hintStyle: monseratTextFont
                                                            .copyWith(
                                                                color: text3,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        6),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1,
                                                                  color: text3),
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                        width:
                                                                            1,
                                                                        color:
                                                                            accColor))),
                                                    value: company_id,
                                                    dropdownColor: bgcolor2,
                                                    items: company_data.map<
                                                        DropdownMenuItem<
                                                            int>>((value) {
                                                      return DropdownMenuItem<
                                                          int>(
                                                        value: value.id,
                                                        child: Text(
                                                          value.name,
                                                          style: monseratTextFont
                                                              .copyWith(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    style: monseratTextFont
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Tanggal',
                                                    style: monseratTextFont
                                                        .copyWith(
                                                            color: text2,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                  TextFormField(
                                                    controller: dateController,
                                                    onChanged: (value) =>
                                                        setState(() {
                                                      dateValidate =
                                                          dateController.text ==
                                                              "";
                                                    }),
                                                    onTap: () async {
                                                      DateTime? pickedDate =
                                                          await showDatePicker(
                                                              context: context,
                                                              firstDate:
                                                                  DateTime(
                                                                      2020),
                                                              lastDate:
                                                                  DateTime(
                                                                      2101));
                                                      if (pickedDate == null)
                                                        return;
                                                      setState(() {
                                                        dateController
                                                            .text = DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(pickedDate!)
                                                            .toString();
                                                      });
                                                    },
                                                    cursorColor: mainColor,
                                                    style: monseratTextFont
                                                        .copyWith(
                                                            color: text2,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            'contoh : 2024-01-01',
                                                        errorText: dateValidate
                                                            ? 'Data tidak boleh kosong'
                                                            : null,
                                                        hintStyle: monseratTextFont
                                                            .copyWith(
                                                                color: text3,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        6),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1,
                                                                  color: text3),
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                        width:
                                                                            1,
                                                                        color:
                                                                            accColor))),
                                                  )
                                                ],
                                              )
                                            ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 40),
                                  child: transaction_detail.isEmpty
                                      ? DataNotFound()
                                      : ListTransactionDetailItem(
                                          transaction_detail,
                                          change_transaction_detail)),
                            ],
                          ),
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.symmetric(vertical: 14),
                                    )),
                                child: Text('Simpan',
                                    style: monseratTextFont.copyWith(
                                        color: textprimary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                onPressed: () async {
                                  if (company_id == null ||
                                      dateController.text == '' ||
                                      transaction_detail.length == 0) {
                                    company_id == null
                                        ? setState(() {
                                            companyValidate = true;
                                          })
                                        : null;

                                    dateController.text == ''
                                        ? setState(() {
                                            dateValidate = true;
                                          })
                                        : null;
                                    return;
                                  }
                                  if (widget.transaction_model == null) {
                                    await transactionDB.create(
                                        company_id: company_id!,
                                        date: dateController.text,
                                        transaction_detail: transaction_detail);
                                  } else {
                                    await transactionDB.update(
                                      company_id: company_id!,
                                      date: dateController.text,
                                      transaction_detail: transaction_detail,
                                      id: widget.transaction_model!.id,
                                    );
                                  }
                                  if (!mounted) return;
                                  context
                                      .read<PageBloc>()
                                      .add(GoToMainPage(bottomNavBarIndex: 3));
                                },
                              ),
                            )),
                      ],
                    )))));
  }
}
