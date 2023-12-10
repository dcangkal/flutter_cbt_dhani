import 'dart:convert';

class MateriResponseModel {
  final String status;
  final List<Materi> data;

  MateriResponseModel({
    required this.status,
    required this.data,
  });

  factory MateriResponseModel.fromJson(String str) =>
      MateriResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MateriResponseModel.fromMap(Map<String, dynamic> json) =>
      MateriResponseModel(
        status: json["status"],
        data: List<Materi>.from(json["data"].map((x) => Materi.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Materi {
  final int id;
  final String title;
  final String image;
  final String content;
  final String createdAt;
  final String updatedAt;

  Materi({
    required this.id,
    required this.title,
    required this.image,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Materi.fromJson(String str) => Materi.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Materi.fromMap(Map<String, dynamic> json) => Materi(
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
