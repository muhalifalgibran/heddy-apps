// To parse this JSON data, do
//
//     final waterConsumeToday = waterConsumeTodayFromJson(jsonString);

import 'dart:convert';

WaterConsumeToday waterConsumeTodayFromJson(String str) =>
    WaterConsumeToday.fromJson(json.decode(str));

String waterConsumeTodayToJson(WaterConsumeToday data) =>
    json.encode(data.toJson());

class WaterConsumeToday {
  WaterConsumeToday({
    this.success,
    this.data,
  });

  bool success;
  Data data;

  factory WaterConsumeToday.fromJson(Map<String, dynamic> json) =>
      WaterConsumeToday(
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
    this.sum,
    this.max,
    this.history,
  });

  int sum;
  int max;
  List<History> history;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sum: json["sum"],
        max: json["max"],
        history:
            List<History>.from(json["history"].map((x) => History.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sum": sum,
        "max": max,
        "history": List<dynamic>.from(history.map((x) => x.toJson())),
      };
}

class History {
  History({
    this.id,
    this.userActivityId,
    this.qty,
    this.size,
    this.timestamp,
  });

  int id;
  int userActivityId;
  int qty;
  int size;
  DateTime timestamp;

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        userActivityId: json["user_activity_id"],
        qty: json["qty"],
        size: json["size"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_activity_id": userActivityId,
        "qty": qty,
        "size": size,
        "timestamp": timestamp.toIso8601String(),
      };
}
