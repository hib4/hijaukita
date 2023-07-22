import 'dart:convert';

Activity activityFromJson(String str) => Activity.fromJson(json.decode(str));

String activityToJson(Activity data) => json.encode(data.toJson());

class Activity {
  final String message;
  final Data data;

  const Activity({
    required this.message,
    required this.data,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final int id;
  final String subCategoryId;
  final String name;
  final String description;
  final String? label;
  final String reward;
  final String activityType;
  final String imageUrl;
  final bool isDone;
  final bool isWishlist;
  final SubCategory subCategory;
  final List<Provision> provision;

  const Data({
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
    required this.provision,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        subCategoryId: json["sub_category_id"],
        name: json["name"],
        description: json["description"],
        label: json["label"] ?? '',
        reward: json["reward"],
        activityType: json["activity_type"],
        imageUrl: json["image_url"],
        isDone: json["is_done"],
        isWishlist: json["is_wishlist"],
        subCategory: SubCategory.fromJson(json["sub_category"]),
        provision: List<Provision>.from(
            json["provision"].map((x) => Provision.fromJson(x))),
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
        "provision": List<dynamic>.from(provision.map((x) => x.toJson())),
      };
}

class Provision {
  final String provision;

  const Provision({
    required this.provision,
  });

  factory Provision.fromJson(Map<String, dynamic> json) => Provision(
        provision: json["provision"],
      );

  Map<String, dynamic> toJson() => {
        "provision": provision,
      };
}

class SubCategory {
  final String categoryId;
  final String name;
  final List<SusdevGoal> susdevGoals;

  const SubCategory({
    required this.categoryId,
    required this.name,
    required this.susdevGoals,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        categoryId: json["category_id"],
        name: json["name"],
        susdevGoals: List<SusdevGoal>.from(
            json["susdev_goals"].map((x) => SusdevGoal.fromJson(x))),
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

  const SusdevGoal({
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
