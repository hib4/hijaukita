import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  final String message;
  final Data data;

  Profile({
    required this.message,
    required this.data,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final User user;
  final List<DoneActivity> doneActivities;
  final List<BadgeProfile> myBadges;
  final List<BadgeProfile> listBadges;

  Data({
    required this.user,
    required this.doneActivities,
    required this.myBadges,
    required this.listBadges,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
    doneActivities: List<DoneActivity>.from(json["done_activities"].map((x) => DoneActivity.fromJson(x))),
    myBadges: List<BadgeProfile>.from(json["my_badges"].map((x) => BadgeProfile.fromJson(x))),
    listBadges: List<BadgeProfile>.from(json["list_badges"].map((x) => BadgeProfile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "done_activities": List<dynamic>.from(doneActivities.map((x) => x.toJson())),
    "my_badges": List<dynamic>.from(myBadges.map((x) => x.toJson())),
    "list_badges": List<dynamic>.from(listBadges.map((x) => x.toJson())),
  };
}

class DoneActivity {
  final int id;
  final String subCategory;
  final String imageUrl;
  final int count;

  DoneActivity({
    required this.id,
    required this.subCategory,
    required this.imageUrl,
    required this.count,
  });

  factory DoneActivity.fromJson(Map<String, dynamic> json) => DoneActivity(
    id: json["id"],
    subCategory: json["sub_category"],
    imageUrl: json["image_url"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sub_category": subCategory,
    "image_url": imageUrl,
    "count": count,
  };
}

class BadgeProfile {
  final int id;
  final String name;
  final String price;
  final String imageUrl;

  BadgeProfile({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory BadgeProfile.fromJson(Map<String, dynamic> json) => BadgeProfile(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "image_url": imageUrl,
  };
}

class User {
  final int id;
  final String name;
  final String email;
  final String point;
  final String avatarUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.point,
    required this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
