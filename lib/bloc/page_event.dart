part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToSplashPage extends PageEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GoToProductPage extends PageEvent {
  @override
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
