import 'package:fit_app/core/tools/constants.dart' as Constants;
import 'package:fit_app/models/user_activity.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'dart:async';

class UserActivityProvider {
  Client client = Client();
  final url = Constants.API_URL;

  Future<UserActivity> fetchUserActivity() async {
    print('masuk');
    final response = await client.get(url + 'user-activities/get',
        headers: {"api_token": "0ec3238f638daad0d78e415ef80d3f44d38fe522"});

    if (response.statusCode == 200) {
      return compute(userActivityFromJson, response.body);
    } else {
      print(response.statusCode);
      throw Exception();
    }
  }
}
