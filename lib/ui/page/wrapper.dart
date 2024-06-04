part of "pages.dart";

// ignore: use_key_in_widget_constructors
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) =>
            (pageState is OnMainPage) ? const MainPage() : const SplashPage());
  }
}
