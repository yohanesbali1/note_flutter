part of 'widget.dart';

class DataNotFound extends StatelessWidget {
  const DataNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Image.asset("assets/data_not_found.png"),
          ),
          Column(
            children: [
              Text(
                "Whoops!",
                style: monseratTextFont.copyWith(
                    color: mainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "Data Tidak ditemukan",
                style: monseratTextFont.copyWith(
                    color: textprimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ],
          )
        ],
      ),
    );
  }
}
