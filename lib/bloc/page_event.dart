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
  List<Object> get props => [];
}

class GoToFormCompanyPage extends PageEvent {
  final CompanyModel? companyModel;
  @override
  GoToFormCompanyPage(this.companyModel);
  // TODO: implement props
  List<Object> get props => [];
}

class GoToFormTransactionPage extends PageEvent {
  final TransactionModel? transactionModel;
  @override
  GoToFormTransactionPage(this.transactionModel);
  // TODO: implement props
  List<Object> get props => [];
}

class GoToFormTransactionDetailPage extends PageEvent {
  final TransactionDetailModel? transactiondetailModel;
  @override
  GoToFormTransactionDetailPage(this.transactiondetailModel);
  // TODO: implement props
  List<Object> get props => [];
}

class GoToMainPage extends PageEvent {
  final int bottomNavBarIndex;
  final bool isExpired;
  @override
  GoToMainPage({this.bottomNavBarIndex = 0, this.isExpired = false});
  // TODO: implement props
  List<Object> get props => [bottomNavBarIndex, isExpired];
}
