part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  HomeSuccess({required this.home});

  final Home home;
}

class HomeFailure extends HomeState {
  HomeFailure({required this.message});

  final String message;
}
