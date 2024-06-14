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
        backgroundColor: backgroundColor,
        body: Container(
          child: Column(
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
                      const DashboardPage(),
                      StockPage(),
                      CompanyPage(),
                      NotePage(),
                    ],
                  ),
                ),
                createCustomBottomNavBar(),

                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     height: 46,
                //     width: 46,
                //     margin: EdgeInsets.only(bottom: 42),
                //     child: FloatingActionButton(
                //         elevation: 0,
                //         backgroundColor: accentColor2,
                //         child: SizedBox(
                //           height: 26,
                //           width: 26,
                //           child: Icon(
                //             MdiIcons.fromString('plus'),
                //             color: Colors.black.withOpacity(0.54),
                //           ),
                //         ),
                //         onPressed: () {
                //           context.read<PageBloc>().add(GoToMainPage());
                //         }),
                //   ),
                // )
              ]),
        ));
  }

  Widget createCustomBottomNavBar() => Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          Center(
            heightFactor: 0.1,
            child: FloatingActionButton(
              shape: const CircleBorder(),
              elevation: 0.1,
              onPressed: () {
                switch (bottomNavBarIndex) {
                  case 1:
                    return context
                        .read<PageBloc>()
                        .add(GoToFormStockPage(null));
                  case 2:
                    return context
                        .read<PageBloc>()
                        .add(GoToFormCompanyPage(null));
                }
              },
              backgroundColor: mainColor,
              child: Icon(
                MdiIcons.fromString('plus'),
                color: Colors.white,
              ),
            ),
          ),
          ClipPath(
            clipper: BottomNavBarClipper(),
            child: Container(
                height: 60,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white),
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
                              height: 40,
                              child: Column(
                                children: [
                                  Image.asset((bottomNavBarIndex == 0)
                                      ? "assets/icon/home.png"
                                      : "assets/icon/home.png"),
                                  Text('Home',
                                      style: mainTextFont.copyWith(
                                          fontSize: 12,
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
                              height: 40,
                              child: Column(
                                children: [
                                  Image.asset((bottomNavBarIndex == 1)
                                      ? "assets/icon/archive.png"
                                      : "assets/icon/archive.png"),
                                  Text('Stok',
                                      style: mainTextFont.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500))
                                ],
                              ))),
                      Container(
                        width: 30,
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              bottomNavBarIndex = 2;
                              pageController.jumpToPage(bottomNavBarIndex);
                            });
                          },
                          icon: Container(
                              height: 40,
                              child: Column(
                                children: [
                                  Image.asset((bottomNavBarIndex == 2)
                                      ? "assets/icon/company.png"
                                      : "assets/icon/company.png"),
                                  Text('Vila',
                                      style: mainTextFont.copyWith(
                                          fontSize: 12,
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
                              height: 40,
                              child: Column(
                                children: [
                                  Image.asset((bottomNavBarIndex == 3)
                                      ? "assets/icon/note.png"
                                      : "assets/icon/note.png"),
                                  Text('Note',
                                      style: mainTextFont.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500))
                                ],
                              ))),
                    ],
                  ),
                )
                // BottomNavigationBar(
                //     elevation: 0,
                //     selectedItemColor: mainColor,
                //     currentIndex: bottomNavBarIndex,
                //     unselectedFontSize: 12,
                //     // fixedColor: mainColor,
                //     onTap: (index) {
                //       setState(() {
                //         bottomNavBarIndex = index;
                //         pageController.jumpToPage(index);
                //       });
                //     },
                //     items: [
                //       BottomNavigationBarItem(
                //           label: 'Home',
                //           backgroundColor: Colors.red,

                //           icon: Container(
                //             margin: EdgeInsets.only(bottom: 6),
                //             height: 20,
                //             child: Image.asset((bottomNavBarIndex == 0)
                //                 ? "assets/icon/note.png"
                //                 : "assets/icon/note.png"),
                //           )),
                //       BottomNavigationBarItem(
                //           label: 'Stok',
                //           icon: Container(
                //             margin: EdgeInsets.only(bottom: 6),
                //             height: 20,
                //             child: Image.asset((bottomNavBarIndex == 1)
                //                 ? "assets/icon/note.png"
                //                 : "assets/icon/note.png"),
                //           )),
                //       BottomNavigationBarItem(
                //           label: 'Perusahaan',
                //           icon: Container(
                //             margin: EdgeInsets.only(bottom: 6),
                //             height: 20,
                //             child: Image.asset((bottomNavBarIndex == 2)
                //                 ? "assets/icon/note.png"
                //                 : "assets/icon/note.png"),
                //           )),
                //       BottomNavigationBarItem(
                //           label: 'Note',
                //           icon: Container(
                //             margin: EdgeInsets.only(bottom: 6),
                //             height: 20,
                //             child: Image.asset((bottomNavBarIndex == 3)
                //                 ? "assets/icon/note.png"
                //                 : "assets/icon/note.png"),
                //           ))
                //     ]),
                ),
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
