part of 'widgets.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget(
      {super.key,
      required this.bottomNavBarIndex,
      required this.pageController});
  final int bottomNavBarIndex;
  final PageController pageController;

  @override
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipper: BottomNavBarClipper(),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              selectedItemColor: mainColor,
              unselectedItemColor: Color(0xFFE5E5E5),
              currentIndex: bottomNavBarIndex,
              onTap: (index) {
                (() {
                  bottomNavBarIndex = index;
                  pageController.jumpToPage(index);
                });
              },
              items: [
                BottomNavigationBarItem(
                    label: Text("New Movies",
                        style: GoogleFonts.raleway(
                            fontSize: 13, fontWeight: FontWeight.w600)),
                    icon: Container(
                      margin: EdgeInsets.only(bottom: 6),
                      height: 20,
                      child: Image.asset((bottomNavBarIndex == 0)
                          ? "assets/ic_movie.png"
                          : "assets/ic_movie_grey.png"),
                    )),
                BottomNavigationBarItem(
                    title: Text("My Tickets",
                        style: GoogleFonts.raleway(
                            fontSize: 13, fontWeight: FontWeight.w600)),
                    icon: Container(
                      margin: EdgeInsets.only(bottom: 6),
                      height: 20,
                      child: Image.asset((bottomNavBarIndex == 1)
                          ? "assets/ic_tickets.png"
                          : "assets/ic_tickets_grey.png"),
                    ))
              ]),
        ),
      ),
    );
  }
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
