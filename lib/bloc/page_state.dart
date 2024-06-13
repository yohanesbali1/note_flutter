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
  List<Object> get props => [];
}

class OnFormCompanyPage extends PageState {
  final CompanyModel? companyModel;
  @override
  OnFormCompanyPage(this.companyModel);
  // TODO: implement props
  List<Object> get props => [];
}

class OnMainPage extends PageState {
  final int bottomNavBarIndex;
  final bool isExpired;
  OnMainPage({this.bottomNavBarIndex = 0, this.isExpired = false});
  @override
  // TODO: implement props
  List<Object> get props => [bottomNavBarIndex, isExpired];
}
