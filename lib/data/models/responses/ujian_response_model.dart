import 'dart:convert';

class UjianResponseModel {
  final String message;
  final int timer;
  final List<Ujian> data;

  UjianResponseModel({
    required this.message,
    required this.timer,
    required this.data,
  });

  factory UjianResponseModel.fromJson(String str) =>
      UjianResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UjianResponseModel.fromMap(Map<String, dynamic> json) =>
      UjianResponseModel(
        message: json["message"],
        timer: json["timer"],
        data: List<Ujian>.from(json["data"].map((x) => Ujian.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "timer": timer,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Ujian {
  final int id;
  final String pertanyaan;
  final String kategori;
  final String jawabanA;
  final String jawabanB;
  final String jawabanC;
  final String jawabanD;

  Ujian({
    required this.id,
    required this.pertanyaan,
    required this.kategori,
    required this.jawabanA,
    required this.jawabanB,
    required this.jawabanC,
    required this.jawabanD,
  });

  factory Ujian.fromJson(String str) => Ujian.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ujian.fromMap(Map<String, dynamic> json) => Ujian(
        id: json["id"],
        pertanyaan: json["pertanyaan"],
        kategori: json["kategori"],
        jawabanA: json["jawaban_a"],
        jawabanB: json["jawaban_b"],
        jawabanC: json["jawaban_c"],
        jawabanD: json["jawaban_d"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "pertanyaan": pertanyaan,
        "kategori": kategori,
        "jawaban_a": jawabanA,
        "jawaban_b": jawabanB,
        "jawaban_c": jawabanC,
        "jawaban_d": jawabanD,
      };
}
