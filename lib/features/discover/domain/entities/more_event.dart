import 'dart:convert';

MoreEvent moreEventFromJson(String str) => MoreEvent.fromJson(json.decode(str));

String moreEventToJson(MoreEvent data) => json.encode(data.toJson());

class MoreEvent {
  final String status;
  final List<Event> events;

  MoreEvent({
    required this.status,
    required this.events,
  });

  factory MoreEvent.fromJson(Map<String, dynamic> json) => MoreEvent(
        status: json["status"],
        events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
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
        "date_start":
            "${dateStart.year.toString().padLeft(4, '0')}-${dateStart.month.toString().padLeft(2, '0')}-${dateStart.day.toString().padLeft(2, '0')}",
        "date_end":
            "${dateEnd.year.toString().padLeft(4, '0')}-${dateEnd.month.toString().padLeft(2, '0')}-${dateEnd.day.toString().padLeft(2, '0')}",
        "image_url": imageUrl,
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
