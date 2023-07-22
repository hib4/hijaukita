part of 'more_activity_bloc.dart';

@immutable
abstract class MoreActivityState {}

class MoreActivityInitial extends MoreActivityState {}

class MoreActivityLoading extends MoreActivityState {}

class MoreActivitySuccess extends MoreActivityState {
  MoreActivitySuccess({required this.moreActivity});

  final MoreActivity moreActivity;
}

class MoreActivityFailure extends MoreActivityState {
  MoreActivityFailure({required this.message});

  final String message;
}
