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
    this.name,
    this.mineral,
    this.sleepDuration,
    this.food,
    this.activity,
    this.score,
  });

  String name;
  Mineral mineral;
  SleepDuration sleepDuration;
  Food food;
  Activity activity;
  int score;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        mineral: Mineral.fromJson(json["mineral"]),
        sleepDuration: SleepDuration.fromJson(json["sleep_duration"]),
        food: Food.fromJson(json["food"]),
        activity: Activity.fromJson(json["activity"]),
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mineral": mineral.toJson(),
        "sleep_duration": sleepDuration.toJson(),
        "food": food.toJson(),
        "activity": activity.toJson(),
        "score": score,
      };
}

class Activity {
  Activity({
    this.id,
    this.startActivity,
    this.endActivity,
    this.name,
    this.url,
  });

  int id;
  String startActivity;
  String endActivity;
  String name;
  String url;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"],
        startActivity: json["start_activity"],
        endActivity: json["end_activity"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_activity": startActivity,
        "end_activity": endActivity,
        "name": name,
        "url": url,
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
