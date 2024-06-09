part of "pages.dart";

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "Home",
              style: mainTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 17, bottom: 32),
            child: Text(
              "Hi Admin",
              style: mainTextFont.copyWith(
                  fontSize: 18, fontWeight: FontWeight.w800),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: mainColor, width: 1.5),
              borderRadius: BorderRadius.circular(20),
            ),
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Selamat Datang",
                      style: mainTextFont.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      "Ayo buat laporanmu Mudah \ndan Menarik",
                      style: blackTextFont.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Container(
                  height: 89,
                  width: 98,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/home_page.png"))),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 32, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Penginputan Terakhir",
                  style: mainTextFont.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Lihat Semua",
                  style: blackTextFont.copyWith(
                      fontSize: 11, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          const TransactionListWidget()
        ],
      ),
    );
  }
}
