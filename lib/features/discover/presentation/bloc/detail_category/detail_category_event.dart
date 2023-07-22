part of 'detail_category_bloc.dart';

@immutable
abstract class DetailCategoryEvent {}

class GetDetailCategoryEvent extends DetailCategoryEvent {
  GetDetailCategoryEvent({required this.id});

  final int id;
}
