part of "pages.dart";

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   height: 136,
            //   decoration: const BoxDecoration(
            //       image: DecorationImage(image: AssetImage("assets/logo.png"))),
            // ),
            Container(
              margin: const EdgeInsets.only(top: 70, bottom: 16),
              child: Text(
                "Selamat Datang di CopasApps",
                style: blackTextFont.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "Buat pencatatan bisnis mu semakin profesional dan cepat",
              style: grayTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            Container(
              width: 250,
              margin: const EdgeInsets.only(top: 70, bottom: 19),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                child: Text('Get Started',
                    style: whiteTextFont.copyWith(fontSize: 16)),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
