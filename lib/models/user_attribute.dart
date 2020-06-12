// To parse this JSON data, do
//
//     final userAttribut = userAttributFromJson(jsonString);

import 'dart:convert';

UserAttribut userAttributFromJson(String str) =>
    UserAttribut.fromJson(json.decode(str));

String userAttributToJson(UserAttribut data) => json.encode(data.toJson());

class UserAttribut {
  UserAttribut({
    this.success,
    this.data,
  });

  bool success;
  Data data;

  factory UserAttribut.fromJson(Map<String, dynamic> json) => UserAttribut(
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
    this.gender,
    this.dateOfBirth,
    this.height,
    this.weight,
    this.sleepTime,
    this.activityLevel,
    this.utility,
  });

  String name;
  int gender;
  DateTime dateOfBirth;
  int height;
  int weight;
  String sleepTime;
  int activityLevel;
  Utility utility;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        gender: json["gender"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        height: json["height"],
        weight: json["weight"],
        sleepTime: json["sleep_time"],
        activityLevel: json["activity_level"],
        utility: Utility.fromJson(json["utility"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "gender": gender,
        "date_of_birth": dateOfBirth.toIso8601String(),
        "height": height,
        "weight": weight,
        "sleep_time": sleepTime,
        "activity_level": activityLevel,
        "utility": utility.toJson(),
      };
}

class Utility {
  Utility({
    this.token,
    this.email,
    this.faceUrl,
  });

  String token;
  String email;
  String faceUrl;

  factory Utility.fromJson(Map<String, dynamic> json) => Utility(
        token: json["token"],
        email: json["email"],
        faceUrl: json["face_url"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "email": email,
        "face_url": faceUrl,
      };
}
