// To parse this JSON data, do
//
//     final userActivity = userActivityFromJson(jsonString);

import 'dart:convert';

UserActivity userActivityFromJson(String str) =>
    UserActivity.fromJson(json.decode(str));

String userActivityToJson(UserActivity data) => json.encode(data.toJson());

class UserActivity {
  bool success;
  Data data;

  UserActivity({
    this.success,
    this.data,
  });

  factory UserActivity.fromJson(Map<String, dynamic> json) => UserActivity(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  int mineralWaterConsumption;
  int calories;
  int sleepDuration;
  int calorieFoods;
  int steps;

  Data({
    this.mineralWaterConsumption,
    this.calories,
    this.sleepDuration,
    this.calorieFoods,
    this.steps,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        mineralWaterConsumption: json["mineral_water_consumption"],
        calories: json["calories"],
        sleepDuration: json["sleep_duration"],
        calorieFoods: json["calorie_foods"],
        steps: json["steps"],
      );

  Map<String, dynamic> toJson() => {
        "mineral_water_consumption": mineralWaterConsumption,
        "calories": calories,
        "sleep_duration": sleepDuration,
        "calorie_foods": calorieFoods,
        "steps": steps,
      };
}
