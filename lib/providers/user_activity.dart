import 'dart:convert';
import 'dart:io';

import 'package:fit_app/core/tools/constants.dart' as Constants;
import 'package:fit_app/core/tools/injector.dart';
import 'package:fit_app/models/user_activity.dart';
import 'package:fit_app/network/CustomException.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class UserActivityProvider {
  Client client = Client();
  final url = Constants.API_URL;
  final token = Constants.token;
  static GetToken userRef = locator<GetToken>();

  Future<UserActivity> fetchUserActivity() async {
    try {
      final response = await client.get(url + 'user-activities/get',
          headers: {"api_token": "510862056f7004c245ff1ce4dc2285f22c943961"});
      if (response.statusCode == 200) {
        return compute(userActivityFromJson, response.body);
      } else {
        print(response.statusCode);
        throw Exception();
      }
    } catch (e) {
      print("error");
    }
    return null;
  }

  Future<dynamic> fetchUserActivity2(String token) async {
    var responseJson;
    try {
      final response = await http
          .get(url + 'user-activities/get', headers: {"api_token": token});
      print("res:" + response.statusCode.toString());
      responseJson = CustomException().response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  Future<dynamic> getDashboard(String date, String token) async {
    var responseJson;
    try {
      final response = await http.post(url + 'dashboard/get-history',
          headers: {"api_token": token, "Content-Type": "application/json"},
          body: jsonEncode({"date": date}));
      print("res:" + response.statusCode.toString());
      print(date);
      responseJson = CustomException().response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }
}
