import 'package:fit_app/models/user_activity.dart';
import 'package:fit_app/usecases/user_activity.dart';
import 'dart:async';

class UserActivityRepository {
  final userProvider = UserActivityProvider();

  Future<UserActivity> fetchUserActivity() => userProvider.fetchUserActivity();
}
