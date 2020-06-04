// To parse this JSON data, do
//
//     final firstAuth = firstAuthFromJson(jsonString);

import 'dart:convert';

FirstAuth firstAuthFromJson(String str) => FirstAuth.fromJson(json.decode(str));

String firstAuthToJson(FirstAuth data) => json.encode(data.toJson());

class FirstAuth {
  FirstAuth({
    this.success,
    this.message,
  });

  bool success;
  Message message;

  factory FirstAuth.fromJson(Map<String, dynamic> json) => FirstAuth(
        success: json["success"],
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message.toJson(),
      };
}

class Message {
  Message({
    this.code,
    this.res,
    this.token,
  });

  int code;
  String res;
  String token;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        code: json["code"],
        res: json["res"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "res": res,
        "token": token,
      };
}
