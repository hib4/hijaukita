part of 'activity_bloc.dart';

@immutable
abstract class ActivityEvent {}

class GetActivityEvent extends ActivityEvent {
  GetActivityEvent({required this.id});

  final int id;
}
