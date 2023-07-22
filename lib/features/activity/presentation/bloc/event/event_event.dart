part of 'event_bloc.dart';

@immutable
abstract class EventEvent {}

class GetEventEvent extends EventEvent {
  GetEventEvent({required this.id});

  final int id;
}
