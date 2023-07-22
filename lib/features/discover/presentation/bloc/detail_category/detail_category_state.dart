part of 'detail_category_bloc.dart';

@immutable
abstract class DetailCategoryState {}

class DetailCategoryInitial extends DetailCategoryState {}

class DetailCategoryLoading extends DetailCategoryState {}

class DetailCategorySuccess extends DetailCategoryState {
  DetailCategorySuccess({required this.detailCategory});

  final DetailCategory detailCategory;
}

class DetailCategoryFailure extends DetailCategoryState {
  DetailCategoryFailure({required this.message});

  final String message;
}
