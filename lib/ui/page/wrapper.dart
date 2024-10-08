part of "pages.dart";

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<PageBloc>().add(GoToSplashPage());
    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
            ? const SplashPage()
            : (pageState is OnMainPage)
                ? MainPage(bottomNavBarIndex: pageState.bottomNavBarIndex)
                : (pageState is OnFormTransactionPage)
                    ? FormTransaction(pageState.transactionModel)
                    : (pageState is OnTransactionDetailPage)
                        ? TransactionDetail(pageState.transactionModel)
                        : (pageState is OnFormFilterPage)
                            ? FormFilterTransaction()
                            : (pageState is OnFilterPage)
                                ? FilterTransaction(pageState.search_form)
                                : Container());
  }
}
