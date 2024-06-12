part of "pages.dart";

// ignore: use_key_in_widget_constructors
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<PageBloc>().add(GoToMainPage());
    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
            ? const SplashPage()
            : (pageState is OnMainPage)
                ? MainPage(bottomNavBarIndex: pageState.bottomNavBarIndex)
                : (pageState is OnFormStockPage)
                    ? FormStock(pageState.productModel)
                    : Container());
  }
}
