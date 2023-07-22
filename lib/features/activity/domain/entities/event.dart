import 'dart:convert';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  final String message;
  final Data data;

  Event({
    required this.message,
    required this.data,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
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
  final String regency;
  final String registrationLink;
  final String reward;
  final DateTime dateStart;
  final DateTime dateEnd;
  final String imageUrl;
  final SubCategory subCategory;
  final List<Provision> provision;

  Data({
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
    required this.provision,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        provision: List<Provision>.from(
            json["provision"].map((x) => Provision.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_category_id": subCategoryId,
        "name": name,
        "description": description,
        "regency": regency,
        "registration_link": registrationLink,
        "reward": reward,
        "date_start":
            "${dateStart.year.toString().padLeft(4, '0')}-${dateStart.month.toString().padLeft(2, '0')}-${dateStart.day.toString().padLeft(2, '0')}",
        "date_end":
            "${dateEnd.year.toString().padLeft(4, '0')}-${dateEnd.month.toString().padLeft(2, '0')}-${dateEnd.day.toString().padLeft(2, '0')}",
        "image_url": imageUrl,
        "sub_category": subCategory.toJson(),
        "provision": List<dynamic>.from(provision.map((x) => x.toJson())),
      };
}

class Provision {
  final int id;
  final String eventId;
  final String provision;

  Provision({
    required this.id,
    required this.eventId,
    required this.provision,
  });

  factory Provision.fromJson(Map<String, dynamic> json) => Provision(
        id: json["id"],
        eventId: json["event_id"],
        provision: json["provision"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_id": eventId,
        "provision": provision,
      };
}

class SubCategory {
  final int id;
  final String categoryId;
  final String name;
  final String imageUrl;
  final List<SusdevGoal> susdevGoals;

  SubCategory({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.imageUrl,
    required this.susdevGoals,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        imageUrl: json["image_url"],
        susdevGoals: List<SusdevGoal>.from(
            json["susdev_goals"].map((x) => SusdevGoal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "image_url": imageUrl,
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
