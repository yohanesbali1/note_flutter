part of '../pages.dart';

class FormFilterTransaction extends StatefulWidget {
  const FormFilterTransaction({super.key});

  @override
  State<FormFilterTransaction> createState() => _FormFilterTransactionState();
}

class _FormFilterTransactionState extends State<FormFilterTransaction> {
  final companyDB = CompanyDB();
  List<CompanyModel> company_data = [];
  int? company_id;
  String start_date = "";
  String end_date = "";
  TextEditingController dateController = TextEditingController();

  bool dateValidate = false;
  bool companyValidate = false;

  void initState() {
    super.initState();
    getData();
  }

  @override
  Future<void> getData() async {
    var data = await companyDB.getAll();
    setState(() {
      company_data = data;
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
                                      onTap: () => context
                                          .read<PageBloc>()
                                          .add(GoToMainPage(
                                            bottomNavBarIndex: 3,
                                          )),
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
                                      "Form Transaksi",
                                      style: monseratTextFont.copyWith(
                                          color: textprimary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
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
                                                    readOnly: true,
                                                    onChanged: (value) =>
                                                        setState(() {
                                                      dateValidate =
                                                          dateController.text ==
                                                              "";
                                                    }),
                                                    onTap: () async {
                                                      var pickedDate =
                                                          await showDateRangePicker(
                                                              context: context,
                                                              firstDate:
                                                                  DateTime(
                                                                      2020),
                                                              lastDate:
                                                                  DateTime(
                                                                      2101));
                                                      if (pickedDate == null)
                                                        return;
                                                      DateFormat dateFormat =
                                                          DateFormat(
                                                              'yyyy-MM-dd');
                                                      String
                                                          formattedStartDate =
                                                          dateFormat.format(
                                                              pickedDate.start);
                                                      String formattedEndDate =
                                                          dateFormat.format(
                                                              pickedDate.end);
                                                      setState(() {
                                                        start_date =
                                                            formattedStartDate;
                                                        end_date =
                                                            formattedEndDate;
                                                        dateController.text =
                                                            '${formattedStartDate} - ${formattedEndDate}';
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
                                                            'contoh : 2024-01-01 - 2024-01-01',
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
                                child: Text('Cari',
                                    style: monseratTextFont.copyWith(
                                        color: textprimary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                onPressed: () async {
                                  if (company_id == null ||
                                      dateController.text == '') {
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

                                  TransactionFilterModel search_form =
                                      TransactionFilterModel(
                                          company_id: company_id,
                                          start_date: start_date,
                                          end_date: end_date);
                                  context
                                      .read<PageBloc>()
                                      .add(GoToFilterPage(search_form));
                                },
                              ),
                            )),
                      ],
                    )))));
  }
}
