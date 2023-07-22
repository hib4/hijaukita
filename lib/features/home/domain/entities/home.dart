import 'dart:convert';

Home homeFromJson(String str) => Home.fromJson(json.decode(str));

String homeToJson(Home data) => json.encode(data.toJson());

class Home {
  final String message;
  final Data data;

  Home({
    required this.message,
    required this.data,
  });

  factory Home.fromJson(Map<String, dynamic> json) => Home(
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
  final List<Wishlist> wishlist;

  Data({
    required this.user,
    required this.wishlist,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
    wishlist: List<Wishlist>.from(json["wishlist"].map((x) => Wishlist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "wishlist": List<dynamic>.from(wishlist.map((x) => x.toJson())),
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

class Wishlist {
  final int id;
  final String subCategoryId;
  final String name;
  final String description;
  final String label;
  final String reward;
  final String activityType;
  final String imageUrl;
  final bool isDone;
  final bool isWishlist;
  final SubCategory subCategory;

  Wishlist({
    required this.id,
    required this.subCategoryId,
    required this.name,
    required this.description,
    required this.label,
    required this.reward,
    required this.activityType,
    required this.imageUrl,
    required this.isDone,
    required this.isWishlist,
    required this.subCategory,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
    id: json["id"],
    subCategoryId: json["sub_category_id"],
    name: json["name"],
    description: json["description"],
    label: json["label"],
    reward: json["reward"],
    activityType: json["activity_type"],
    imageUrl: json["image_url"],
    isDone: json["is_done"],
    isWishlist: json["is_wishlist"],
    subCategory: SubCategory.fromJson(json["sub_category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sub_category_id": subCategoryId,
    "name": name,
    "description": description,
    "label": label,
    "reward": reward,
    "activity_type": activityType,
    "image_url": imageUrl,
    "is_done": isDone,
    "is_wishlist": isWishlist,
    "sub_category": subCategory.toJson(),
  };
}

class SubCategory {
  final String categoryId;
  final String name;
  final List<SusdevGoal> susdevGoals;

  SubCategory({
    required this.categoryId,
    required this.name,
    required this.susdevGoals,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    categoryId: json["category_id"],
    name: json["name"],
    susdevGoals: List<SusdevGoal>.from(json["susdev_goals"].map((x) => SusdevGoal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "name": name,
    "susdev_goals": List<dynamic>.from(susdevGoals.map((x) => x.toJson())),
  };
}

class SusdevGoal {
  final String name;
  final String imageUrl;

  SusdevGoal({
    required this.name,
    required this.imageUrl,
  });

  factory SusdevGoal.fromJson(Map<String, dynamic> json) => SusdevGoal(
    name: json["name"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image_url": imageUrl,
  };
}
