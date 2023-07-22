import 'dart:convert';

MoreCategory moreCategoryFromJson(String str) => MoreCategory.fromJson(json.decode(str));

String moreCategoryToJson(MoreCategory data) => json.encode(data.toJson());

class MoreCategory {
  final String status;
  final List<Datum> data;

  MoreCategory({
    required this.status,
    required this.data,
  });

  factory MoreCategory.fromJson(Map<String, dynamic> json) => MoreCategory(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final int id;
  final String categoryId;
  final String name;
  final String imageUrl;

  Datum({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.imageUrl,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
