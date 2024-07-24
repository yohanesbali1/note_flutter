part of 'shared.dart';

class Helper {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  Future<bool> alert(BuildContext context, status, message) async {
    switch (status) {
      case 'delete':
        var res = await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                contentPadding: EdgeInsets.all(0),
                content:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    decoration: BoxDecoration(
                        color: bgcolor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 60,
                            height: 60,
                            // padding: EdgeInsets.all(10),

                            decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(100)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/icon/warning.png'),
                              ],
                            )),
                        SizedBox(
                          height: 17,
                        ),
                        Text('Apakah anda yakin ?',
                            textAlign: TextAlign.center,
                            style: monseratTextFont.copyWith(
                                fontSize: 16,
                                color: text2,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Data akan terhapus secara permanen!',
                          textAlign: TextAlign.center,
                          style: monseratTextFont.copyWith(
                            fontSize: 14,
                            color: text3,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 28,
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
                                      const EdgeInsets.symmetric(vertical: 10),
                                    )),
                                child: Text('Hapus Data',
                                    style: monseratTextFont.copyWith(
                                        color: textprimary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                                onPressed: () =>
                                    {Navigator.of(context).pop(true)},
                              ),
                            ))
                      ],
                    ),
                  )
                ])));
        return res is bool ? res : false;

      default:
        return false;
    }
  }
}
