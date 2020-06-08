// To parse this JSON data, do
//
//     final foodHistory = foodHistoryFromJson(jsonString);

import 'dart:convert';

FoodHistory foodHistoryFromJson(String str) =>
    FoodHistory.fromJson(json.decode(str));

String foodHistoryToJson(FoodHistory data) => json.encode(data.toJson());

class FoodHistory {
  FoodHistory({
    this.success,
    this.data,
  });

  bool success;
  Data data;

  factory FoodHistory.fromJson(Map<String, dynamic> json) => FoodHistory(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.pagi,
    this.siang,
    this.malam,
  });

  List<Malam> pagi;
  List<Malam> siang;
  List<Malam> malam;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pagi: List<Malam>.from(json["pagi"].map((x) => Malam.fromJson(x))),
        siang: List<Malam>.from(json["siang"].map((x) => Malam.fromJson(x))),
        malam: List<Malam>.from(json["malam"].map((x) => Malam.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pagi": List<dynamic>.from(pagi.map((x) => x.toJson())),
        "siang": List<dynamic>.from(siang.map((x) => x.toJson())),
        "malam": List<dynamic>.from(malam.map((x) => x.toJson())),
      };
}

class Malam {
  Malam({
    this.id,
    this.type,
    this.timestamp,
    this.name,
    this.img,
  });

  int id;
  int type;
  DateTime timestamp;
  String name;
  String img;

  factory Malam.fromJson(Map<String, dynamic> json) => Malam(
        id: json["id"],
        type: json["type"],
        timestamp: DateTime.parse(json["timestamp"]),
        name: json["name"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "timestamp": timestamp.toIso8601String(),
        "name": name,
        "img": img,
      };
}
