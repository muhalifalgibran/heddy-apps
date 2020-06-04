import 'package:fit_app/models/user_activity.dart';
import 'package:fit_app/providers/user_activity.dart';
import 'dart:async';

class UserActivityRepository {
  final userProvider = UserActivityProvider();

  Future<UserActivity> fetchUserActivity() => userProvider.fetchUserActivity();
  Future<UserActivity> fetchUserActivity2() async {
    final response = await userProvider.fetchUserActivity2();
    return UserActivity.fromJson(response);
  }
}
