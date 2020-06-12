// To parse this JSON data, do
//
//     final signInResponse = signInResponseFromJson(jsonString);

import 'dart:convert';

SignInResponse signInResponseFromJson(String str) =>
    SignInResponse.fromJson(json.decode(str));

String signInResponseToJson(SignInResponse data) => json.encode(data.toJson());

class SignInResponse {
  SignInResponse({
    this.success,
    this.message,
  });

  bool success;
  Message message;

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
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
