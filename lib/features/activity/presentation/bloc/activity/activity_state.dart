part of 'activity_bloc.dart';

@immutable
abstract class ActivityState {}

class ActivityInitial extends ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivitySuccess extends ActivityState {
  ActivitySuccess({required this.activity});

  final Activity activity;
}

class ActivityFailure extends ActivityState {
  ActivityFailure({required this.message});

  final String message;
}
