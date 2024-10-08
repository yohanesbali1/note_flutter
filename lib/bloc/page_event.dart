part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToSplashPage extends PageEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GoToFormStockPage extends PageEvent {
  final ProductModel? productModel;
  @override
  GoToFormStockPage(this.productModel);
  // TODO: implement props
  List<Object> get props => [productModel ?? ""];
}

class GoToFormCompanyPage extends PageEvent {
  final CompanyModel? companyModel;
  @override
  GoToFormCompanyPage(this.companyModel);
  // TODO: implement props
  List<Object> get props => [companyModel ?? ""];
}

class GoToFormTransactionPage extends PageEvent {
  final TransactionModel? transactionModel;
  @override
  GoToFormTransactionPage(this.transactionModel);
  // TODO: implement props
  List<Object> get props => [transactionModel ?? ""];
}

class GoToFormTransactionDetailPage extends PageEvent {
  final TransactionDetailModel? transactiondetailModel;
  @override
  GoToFormTransactionDetailPage(this.transactiondetailModel);
  // TODO: implement props
  List<Object> get props => [transactiondetailModel ?? ""];
}

class GoToTransactionDetailPage extends PageEvent {
  final TransactionModel? transactionModel;
  @override
  GoToTransactionDetailPage(this.transactionModel);
  // TODO: implement props
  List<Object> get props => [transactionModel ?? ""];
}

class GoToMainPage extends PageEvent {
  final int bottomNavBarIndex;
  @override
  GoToMainPage({this.bottomNavBarIndex = 0});
  // TODO: implement props
  List<Object> get props => [bottomNavBarIndex];
}

class GoToFormFilterPage extends PageEvent {
  @override
  GoToFormFilterPage();
  // TODO: implement props
  List<Object> get props => [];
}

class GoToFilterPage extends PageEvent {
  final search_form;
  @override
  GoToFilterPage(this.search_form);
  // TODO: implement props
  List<Object> get props => [search_form];
}
