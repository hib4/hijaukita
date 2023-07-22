import 'dart:convert';

Discover discoverFromJson(String str) => Discover.fromJson(json.decode(str));

String discoverToJson(Discover data) => json.encode(data.toJson());

class Discover {
  final String status;
  final Data data;

  Discover({
    required this.status,
    required this.data,
  });

  factory Discover.fromJson(Map<String, dynamic> json) => Discover(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  final List<Activity> activities;
  final List<Event> events;
  final List<SubCategory> subCategories;

  Data({
    required this.activities,
    required this.events,
    required this.subCategories,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    activities: List<Activity>.from(json["activities"].map((x) => Activity.fromJson(x))),
    events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
    subCategories: List<SubCategory>.from(json["sub_categories"].map((x) => SubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
    "events": List<dynamic>.from(events.map((x) => x.toJson())),
    "sub_categories": List<dynamic>.from(subCategories.map((x) => x.toJson())),
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
  final String imageUrl;

  SubCategory({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.imageUrl,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "image_url": imageUrl,
  };
}

class Event {
  final int id;
  final String subCategoryId;
  final String name;
  final String description;
  final String regency;
  final String registrationLink;
  final String reward;
  final DateTime dateStart;
  final DateTime dateEnd;
  final String imageUrl;
  final SubCategory subCategory;

  Event({
    required this.id,
    required this.subCategoryId,
    required this.name,
    required this.description,
    required this.regency,
    required this.registrationLink,
    required this.reward,
    required this.dateStart,
    required this.dateEnd,
    required this.imageUrl,
    required this.subCategory,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json["id"],
    subCategoryId: json["sub_category_id"],
    name: json["name"],
    description: json["description"],
    regency: json["regency"],
    registrationLink: json["registration_link"],
    reward: json["reward"],
    dateStart: DateTime.parse(json["date_start"]),
    dateEnd: DateTime.parse(json["date_end"]),
    imageUrl: json["image_url"],
    subCategory: SubCategory.fromJson(json["sub_category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sub_category_id": subCategoryId,
    "name": name,
    "description": description,
    "regency": regency,
    "registration_link": registrationLink,
    "reward": reward,
    "date_start": "${dateStart.year.toString().padLeft(4, '0')}-${dateStart.month.toString().padLeft(2, '0')}-${dateStart.day.toString().padLeft(2, '0')}",
    "date_end": "${dateEnd.year.toString().padLeft(4, '0')}-${dateEnd.month.toString().padLeft(2, '0')}-${dateEnd.day.toString().padLeft(2, '0')}",
    "image_url": imageUrl,
    "sub_category": subCategory.toJson(),
  };
}
