part of 'more_event_bloc.dart';

@immutable
abstract class MoreEventState {}

class MoreEventInitial extends MoreEventState {}

class MoreEventLoading extends MoreEventState {}

class MoreEventSuccess extends MoreEventState {
  MoreEventSuccess({required this.moreEvent});

  final MoreEvent moreEvent;
}

class MoreEventFailure extends MoreEventState {
  MoreEventFailure({required this.message});

  final String message;
}
