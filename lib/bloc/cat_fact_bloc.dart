import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cat_fact/Models/CatFactModel.dart';
import 'package:cat_fact/Repository/catFactRepo.dart';

part 'cat_fact_event.dart';
part 'cat_fact_state.dart';

class CatFactBloc extends Bloc<CatFactEvent, CatFactState> {
  CatFactBloc() : super(CatFactInitial()) {
    on<CatFactInitialFetchEvent>(_catFactInitialFetchEvent);
  }

  FutureOr<void> _catFactInitialFetchEvent(
      CatFactInitialFetchEvent event, Emitter<CatFactState> emit) async {
    emit(CatFactFetchLoadingState());
    try {
      List<CatFactModelUi> posts = await CatFactRepo.fetchPosts();
      emit(CatFactFetchSuccessState(posts: posts));
    } catch (e) {
      emit(CatFactFetchErrorState(error: e.toString()));
    }
  }
}
