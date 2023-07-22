import 'dart:convert';

MoreActivity moreActivityFromJson(String str) => MoreActivity.fromJson(json.decode(str));

String moreActivityToJson(MoreActivity data) => json.encode(data.toJson());

class MoreActivity {
  final String status;
  final List<Activity> activities;

  MoreActivity({
    required this.status,
    required this.activities,
  });

  factory MoreActivity.fromJson(Map<String, dynamic> json) => MoreActivity(
    status: json["status"],
    activities: List<Activity>.from(json["activities"].map((x) => Activity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
  };
}

class Activity {
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

  Activity({
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

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
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
  final int id;
  final String categoryId;
  final String name;

  SubCategory({
    required this.id,
    required this.categoryId,
    required this.name,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
  };
}
