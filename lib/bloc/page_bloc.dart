import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nota/models/models.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(OnInitialPage()) {
    on<GoToSplashPage>((event, emit) => emit(OnSplashPage()));
    on<GoToFormStockPage>(
        (event, emit) => emit(OnFormStockPage(event.productModel)));
    on<GoToMainPage>((event, emit) => emit(OnMainPage(
        bottomNavBarIndex: event.bottomNavBarIndex,
        isExpired: event.isExpired)));
  }
}
