import 'package:flutter/cupertino.dart';

import '../../domain/entities/leaderboard.dart';

@immutable
abstract class LeaderboardState {}

class LeaderboardInitial extends LeaderboardState {}

class LeaderboardLoading extends LeaderboardState {}

class LeaderboardSuccess extends LeaderboardState {
  LeaderboardSuccess({required this.leaderboard});

  final Leaderboard leaderboard;
}

class LeaderboardFailure extends LeaderboardState {
  LeaderboardFailure({required this.message});

  final String message;
}

