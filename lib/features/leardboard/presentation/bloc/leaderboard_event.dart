import 'package:flutter/cupertino.dart';

@immutable
abstract class LeaderboardEvent {}

class GetLeaderboardEvent extends LeaderboardEvent {
  GetLeaderboardEvent({required this.type});

  final String type;
}