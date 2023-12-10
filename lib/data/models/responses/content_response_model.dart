import 'dart:convert';

class ContentResponseModel {
  final String status;
  final List<Content> data;

  ContentResponseModel({
    required this.status,
    required this.data,
  });

  factory ContentResponseModel.fromJson(String str) =>
      ContentResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContentResponseModel.fromMap(Map<String, dynamic> json) =>
      ContentResponseModel(
        status: json["status"],
        data: List<Content>.from(json["data"].map((x) => Content.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Content {
  final int id;
  final String title;
  final String image;
  final String content;
  final String createdAt;
  final String updatedAt;

  Content({
    required this.id,
    required this.title,
    required this.image,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Content.fromJson(String str) => Content.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Content.fromMap(Map<String, dynamic> json) => Content(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        content: json["content"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "image": image,
        "content": content,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
