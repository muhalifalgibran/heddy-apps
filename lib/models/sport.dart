// To parse this JSON data, do
//
//     final sport = sportFromJson(jsonString);

import 'dart:convert';

Sport sportFromJson(String str) => Sport.fromJson(json.decode(str));

String sportToJson(Sport data) => json.encode(data.toJson());

class Sport {
  Sport({
    this.success,
    this.data,
  });

  bool success;
  List<Datum> data;

  factory Sport.fromJson(Map<String, dynamic> json) => Sport(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.startActivity,
    this.endActivity,
    this.name,
    this.url,
    this.time,
  });

  int id;
  String startActivity;
  String endActivity;
  String name;
  String url;
  Time time;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        startActivity: json["start_activity"],
        endActivity: json["end_activity"],
        name: json["name"],
        url: json["url"],
        time: Time.fromJson(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_activity": startActivity,
        "end_activity": endActivity,
        "name": name,
        "url": url,
        "time": time.toJson(),
      };
}

class Time {
  Time({
    this.hours,
    this.minutes,
  });

  int hours;
  int minutes;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        hours: json["hours"],
        minutes: json["minutes"],
      );

  Map<String, dynamic> toJson() => {
        "hours": hours,
        "minutes": minutes,
      };
}
