import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(OnInitialPage()) {
    on<GoToSplashPage>((event, emit) => emit(OnSplashPage()));
    on<GoToProductPage>((event, emit) => emit(OnProductPage()));
    on<GoToMainPage>((event, emit) => emit(OnMainPage()));
  }
}
