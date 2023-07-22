part of 'event_bloc.dart';

@immutable
abstract class EventState {}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventSuccess extends EventState {
  EventSuccess({required this.event});

  final Event event;
}

class EventFailure extends EventState {
  EventFailure({required this.message});

  final String message;
}
