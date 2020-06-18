// To parse this JSON data, do
//
//     final sleepCheck = sleepCheckFromJson(jsonString);

import 'dart:convert';

SleepCheck sleepCheckFromJson(String str) =>
    SleepCheck.fromJson(json.decode(str));

String sleepCheckToJson(SleepCheck data) => json.encode(data.toJson());

class SleepCheck {
  SleepCheck({
    this.success,
    this.data,
  });

  bool success;
  Data data;

  factory SleepCheck.fromJson(Map<String, dynamic> json) => SleepCheck(
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
    this.code,
    this.startSleep,
    this.endSleep,
  });

  int code;
  String startSleep;
  String endSleep;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        code: json["code"],
        startSleep: json["start_sleep"],
        endSleep: json["end_sleep"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "start_sleep": startSleep,
        "end_sleep": endSleep,
      };
}
