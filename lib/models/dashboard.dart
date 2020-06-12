// To parse this JSON data, do
//
//     final dashboard = dashboardFromJson(jsonString);

import 'dart:convert';

Dashboard dashboardFromJson(String str) => Dashboard.fromJson(json.decode(str));

String dashboardToJson(Dashboard data) => json.encode(data.toJson());

class Dashboard {
  Dashboard({
    this.success,
    this.data,
  });

  bool success;
  Data data;

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
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
    this.mineral,
    this.sleepDuration,
    this.food,
    this.activity,
    this.score,
  });

  Mineral mineral;
  SleepDuration sleepDuration;
  Food food;
  List<dynamic> activity;
  int score;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        mineral: Mineral.fromJson(json["mineral"]),
        sleepDuration: SleepDuration.fromJson(json["sleep_duration"]),
        food: Food.fromJson(json["food"]),
        activity: List<dynamic>.from(json["activity"].map((x) => x)),
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "mineral": mineral.toJson(),
        "sleep_duration": sleepDuration.toJson(),
        "food": food.toJson(),
        "activity": List<dynamic>.from(activity.map((x) => x)),
        "score": score,
      };
}

class Food {
  Food({
    this.pagi,
    this.siang,
    this.malam,
  });

  int pagi;
  int siang;
  int malam;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        pagi: json["pagi"],
        siang: json["siang"],
        malam: json["malam"],
      );

  Map<String, dynamic> toJson() => {
        "pagi": pagi,
        "siang": siang,
        "malam": malam,
      };
}

class Mineral {
  Mineral({
    this.sum,
    this.max,
  });

  int sum;
  int max;

  factory Mineral.fromJson(Map<String, dynamic> json) => Mineral(
        sum: json["sum"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "sum": sum,
        "max": max,
      };
}

class SleepDuration {
  SleepDuration({
    this.hours,
    this.minutes,
  });

  int hours;
  int minutes;

  factory SleepDuration.fromJson(Map<String, dynamic> json) => SleepDuration(
        hours: json["hours"],
        minutes: json["minutes"],
      );

  Map<String, dynamic> toJson() => {
        "hours": hours,
        "minutes": minutes,
      };
}
