part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();
}

class OnInitialPage extends PageState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OnSplashPage extends PageState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OnFormStockPage extends PageState {
  final ProductModel? productModel;
  @override
  OnFormStockPage(this.productModel);
  // TODO: implement props
  List<Object> get props => [productModel ?? ""];
}

class OnFormCompanyPage extends PageState {
  final CompanyModel? companyModel;
  @override
  OnFormCompanyPage(this.companyModel);
  // TODO: implement props
  List<Object> get props => [companyModel ?? ""];
}

class OnFormTransactionPage extends PageState {
  final TransactionModel? transactionModel;
  @override
  OnFormTransactionPage(this.transactionModel);
  // TODO: implement props
  List<Object> get props => [transactionModel ?? ""];
}

class OnFormTransactionDetailPage extends PageState {
  final TransactionDetailModel? transactiondetailModel;
  @override
  OnFormTransactionDetailPage(this.transactiondetailModel);
  // TODO: implement props
  List<Object> get props => [transactiondetailModel ?? ""];
}

class OnTransactionDetailPage extends PageState {
  final TransactionModel? transactionModel;
  @override
  OnTransactionDetailPage(this.transactionModel);
  // TODO: implement props
  List<Object> get props => [transactionModel ?? ""];
}

class OnMainPage extends PageState {
  final int bottomNavBarIndex;
  final bool isExpired;
  OnMainPage({this.bottomNavBarIndex = 0, this.isExpired = false});
  @override
  // TODO: implement props
  List<Object> get props => [bottomNavBarIndex, isExpired];
}

class OnFormFilterPage extends PageState {
  OnFormFilterPage();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OnFilterPage extends PageState {
  final search_form;
  OnFilterPage(this.search_form);
  @override
  // TODO: implement props
  List<Object> get props => [];
}
