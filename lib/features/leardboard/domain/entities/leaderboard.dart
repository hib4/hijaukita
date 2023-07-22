// To parse this JSON data, do
//
//     final leaderboard = leaderboardFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Leaderboard leaderboardFromJson(String str) => Leaderboard.fromJson(json.decode(str));

String leaderboardToJson(Leaderboard data) => json.encode(data.toJson());

class Leaderboard {
  final String message;
  final Data data;

  Leaderboard({
    required this.message,
    required this.data,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) => Leaderboard(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final MyPoint myPoint;
  final List<LeaderboardElement> leaderboard;

  Data({
    required this.myPoint,
    required this.leaderboard,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    myPoint: MyPoint.fromJson(json["my_point"]),
    leaderboard: List<LeaderboardElement>.from(json["leaderboard"].map((x) => LeaderboardElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "my_point": myPoint.toJson(),
    "leaderboard": List<dynamic>.from(leaderboard.map((x) => x.toJson())),
  };
}

class LeaderboardElement {
  final String userId;
  final String totalPoint;
  final MyPoint user;

  LeaderboardElement({
    required this.userId,
    required this.totalPoint,
    required this.user,
  });

  factory LeaderboardElement.fromJson(Map<String, dynamic> json) => LeaderboardElement(
    userId: json["user_id"],
    totalPoint: json["total_point"],
    user: MyPoint.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "total_point": totalPoint,
    "user": user.toJson(),
  };
}

class MyPoint {
  final int id;
  final String name;
  final String email;
  final String point;
  final String avatarUrl;

  MyPoint({
    required this.id,
    required this.name,
    required this.email,
    required this.point,
    required this.avatarUrl,
  });

  factory MyPoint.fromJson(Map<String, dynamic> json) => MyPoint(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    point: json["point"],
    avatarUrl: json["avatar_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "point": point,
    "avatar_url": avatarUrl,
  };
}
