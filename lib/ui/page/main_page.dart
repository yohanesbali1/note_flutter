part of "pages.dart";

class MainPage extends StatefulWidget {
  final int bottomNavBarIndex;
  MainPage({this.bottomNavBarIndex = 0});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int bottomNavBarIndex;

  late PageController pageController;
  @override
  void initState() {
    super.initState();
    bottomNavBarIndex = widget.bottomNavBarIndex;
    pageController = PageController(initialPage: bottomNavBarIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgcolor,
        body: Container(
          margin: const EdgeInsets.only(top: 8),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        bottomNavBarIndex = index;
                      });
                    },
                    children: <Widget>[
                      DashboardPage(),
                      StockPage(),
                      CompanyPage(),
                      TransacationPage(),
                    ],
                  ),
                ),
                createCustomBottomNavBar(),
              ]),
        ));
  }

  Widget createCustomBottomNavBar() => Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          // Center(
          //   heightFactor: 0.1,
          //   child: FloatingActionButton(
          //     shape: const CircleBorder(),
          //     elevation: 0.1,
          //     onPressed: () {
          //       switch (bottomNavBarIndex) {
          //         case 1:
          //           return context
          //               .read<PageBloc>()
          //               .add(GoToFormStockPage(null));
          //         case 2:
          //           return context
          //               .read<PageBloc>()
          //               .add(GoToFormCompanyPage(null));
          //         default:
          //           return context
          //               .read<PageBloc>()
          //               .add(GoToFormTransactionPage(null));
          //       }
          //     },
          //     backgroundColor: mainColor,
          //     child: Icon(
          //       MdiIcons.fromString('plus'),
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          ClipPath(
            // clipper: BottomNavBarClipper(),
            child: Container(
                height: 68,
                decoration: const BoxDecoration(color: Color(0xFF2C2E30)),
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              bottomNavBarIndex = 0;
                              pageController.jumpToPage(bottomNavBarIndex);
                            });
                          },
                          icon: Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: 24,
                                  margin: EdgeInsetsDirectional.only(bottom: 4),
                                  height: 24,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(bottomNavBarIndex == 0
                                        ? "assets/icon/home-active.png"
                                        : "assets/icon/home.png"),
                                  )),
                              Text('Home',
                                  style: monseratTextFont.copyWith(
                                      color: bottomNavBarIndex == 0
                                          ? mainColor
                                          : text2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500))
                            ],
                          ))),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              bottomNavBarIndex = 1;
                              pageController.jumpToPage(bottomNavBarIndex);
                            });
                          },
                          icon: Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: 24,
                                  margin: EdgeInsetsDirectional.only(bottom: 4),
                                  height: 24,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(bottomNavBarIndex == 1
                                        ? "assets/icon/archive-active.png"
                                        : "assets/icon/archive.png"),
                                  )),
                              Text('Stok',
                                  style: monseratTextFont.copyWith(
                                      color: bottomNavBarIndex == 1
                                          ? mainColor
                                          : text2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500))
                            ],
                          ))),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              bottomNavBarIndex = 2;
                              pageController.jumpToPage(bottomNavBarIndex);
                            });
                          },
                          icon: Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: 24,
                                  margin: EdgeInsetsDirectional.only(bottom: 4),
                                  height: 24,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(bottomNavBarIndex == 2
                                        ? "assets/icon/company-active.png"
                                        : "assets/icon/vila.png"),
                                  )),
                              Text('Vila',
                                  style: monseratTextFont.copyWith(
                                      color: bottomNavBarIndex == 2
                                          ? mainColor
                                          : text2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500))
                            ],
                          ))),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              bottomNavBarIndex = 3;
                              pageController.jumpToPage(bottomNavBarIndex);
                            });
                          },
                          icon: Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: 24,
                                  margin: EdgeInsetsDirectional.only(bottom: 4),
                                  height: 24,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(bottomNavBarIndex == 3
                                        ? "assets/icon/note-active.png"
                                        : "assets/icon/note.png"),
                                  )),
                              Text('Transaksi',
                                  style: monseratTextFont.copyWith(
                                      color: bottomNavBarIndex == 3
                                          ? mainColor
                                          : text2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500))
                            ],
                          ))),
                    ],
                  ),
                )),
          ),
        ],
      ));
}

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width / 2 - 28, 0);
    path.quadraticBezierTo(size.width / 2 - 28, 33, size.width / 2, 33);
    path.quadraticBezierTo(size.width / 2 + 28, 33, size.width / 2 + 28, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
