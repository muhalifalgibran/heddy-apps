import 'package:fit_app/models/user_activity.dart';
import 'package:fit_app/providers/user_activity.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class UserActivityRepository {
  final userProvider = UserActivityProvider();
  String token;

  Future<UserActivity> fetchUserActivity() => userProvider.fetchUserActivity();
  Future<UserActivity> fetchUserActivity2() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
    print("hias: " + token);
    final response = await userProvider.fetchUserActivity2(token);
    return UserActivity.fromJson(response);
  }
}
