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
    on<GoToFormCompanyPage>(
        (event, emit) => emit(OnFormCompanyPage(event.companyModel)));
    on<GoToFormTransactionPage>(
        (event, emit) => emit(OnFormTransactionPage(event.transactionModel)));
    on<GoToFormTransactionDetailPage>((event, emit) =>
        emit(OnFormTransactionDetailPage(event.transactiondetailModel)));
    on<GoToTransactionDetailPage>(
        (event, emit) => emit(OnTransactionDetailPage(event.transactionModel)));
    on<GoToMainPage>((event, emit) =>
        emit(OnMainPage(bottomNavBarIndex: event.bottomNavBarIndex)));
    on<GoToFormFilterPage>((event, emit) => emit(OnFormFilterPage()));
    on<GoToFilterPage>((event, emit) => emit(OnFilterPage(event.search_form)));
  }
}
