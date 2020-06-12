import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/providers/sleep_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SleepRepository {
  final userProvider = SleepProvider();
  String token;

  Future<GeneralResponse> createStart(String sleepStart) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
    final response = await userProvider.createStart(sleepStart, token);
    return GeneralResponse.fromJson(response);
  }

  Future<GeneralResponse> createEnd(String sleepEnd) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
    final response = await userProvider.createEnd(sleepEnd, token);
    return GeneralResponse.fromJson(response);
  }

  Future<GeneralResponse> createManual(
      String sleepStart, String sleepEnd) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
    final response =
        await userProvider.manualSleep(sleepStart, sleepEnd, token);
    return GeneralResponse.fromJson(response);
  }
}
