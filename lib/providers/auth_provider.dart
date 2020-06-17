import 'dart:convert';
import 'dart:io';

import 'package:fit_app/network/CustomException.dart';
import 'package:http/http.dart' as http;
import 'package:fit_app/core/tools/constants.dart' as Constants;

class AuthProvider {
  final url = Constants.API_URL;

  Future<dynamic> postFistUserData(
      String uid, String name, String email, String photoUrl) async {
    var responseJson;
    print(uid + name + email + photoUrl);
    try {
      final response = await http.post(url + "authentication/create",
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'uid': uid,
            'name': name,
            'email': email,
            'photo_url': photoUrl
          }));
      print("res: " + response.body.toString());
      print(response.statusCode);
      responseJson = CustomException().response(response);
    } on SocketException {
      print("s4");
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> updateUserProfile(int gender, int height, int weight,
      String sleepTime, int activityLevel, String token) async {
    var responseJson;
    try {
      final response = await http.put(url + "users/update",
          headers: {"Content-Type": "application/json", "api_token": token},
          body: jsonEncode({
            'gender': gender.toString(),
            'height': height.toString(),
            'weight': weight.toString(),
            'sleep_time': sleepTime,
            'activity_level': activityLevel.toString(),
          }));
      print("res: " + response.body.toString());
      print(response.statusCode);
      responseJson = CustomException().response(response);
    } on SocketException {
      print("s4");
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> createUserManual(
      String name, String email, String password) async {
    var responseJson;
    try {
      final response = await http.post(url + "users/register",
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'name': name,
            'email': email,
            'password': password,
          }));
      print("res: " + response.body.toString());
      print(response.statusCode);
      responseJson = CustomException().response(response);
    } on SocketException {
      print("s4");
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> loginUserManual(String email, String password) async {
    var responseJson;
    try {
      final response = await http.post(url + "users/login",
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'email': email,
            'password': password,
          }));
      print("resq: " + response.body.toString());
      print(response.statusCode);
      responseJson = CustomException().response(response);
    } on SocketException {
      print("s4");
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}
