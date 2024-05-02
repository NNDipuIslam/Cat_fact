part of 'cat_fact_bloc.dart';

sealed class CatFactState {}

final class CatFactInitial extends CatFactState {}

class CatFactFetchLoadingState extends CatFactState {}

class CatFactFetchSuccessState extends CatFactState {
  final List<CatFactModelUi> posts;
  CatFactFetchSuccessState({
    required this.posts,
  });
}

class CatFactFetchErrorState extends CatFactState {
  final String error;

  CatFactFetchErrorState({required this.error});
}
