part of 'more_category_bloc.dart';

@immutable
abstract class MoreCategoryState {}

class MoreCategoryInitial extends MoreCategoryState {}

class MoreCategoryLoading extends MoreCategoryState {}

class MoreCategorySuccess extends MoreCategoryState {
  MoreCategorySuccess({required this.moreCategory});

  final MoreCategory moreCategory;
}

class MoreCategoryFailure extends MoreCategoryState {
  MoreCategoryFailure({required this.message});

  final String message;
}
