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
      backgroundColor: bgcolor,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 198,
              decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("assets/splash.png"))),
            ),
            Container(
              margin: const EdgeInsets.only(top: 42, bottom: 16),
              child: Text(
                "Selamat Datang di\nCopasApps",
                style: monseratTextFont.copyWith(
                  color: textprimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "Buat pencatatan bisnis mu semakin profesional dan cepat",
              style: monseratTextFont.copyWith(
                  color: text3, fontSize: 16, fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            Container(
              width: 250,
              margin: const EdgeInsets.only(top: 70, bottom: 19),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mainColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(vertical: 14),
                    )),
                child: Text('Get Started',
                    style: monseratTextFont.copyWith(
                        color: textprimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                onPressed: () {
                  context.read<PageBloc>().add(GoToMainPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
