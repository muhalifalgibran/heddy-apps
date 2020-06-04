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

  Future<dynamic> fetchUserActivity2() async {
    var responseJson;
    try {
      final response = await http.get(url + 'user-activities/get',
          headers: {"api_token": "a73143c0f171c7eadd9bb2f7a86c27f2e99cfdcf"});
      print("res:" + response.statusCode.toString());
      responseJson = CustomException().response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }
}
