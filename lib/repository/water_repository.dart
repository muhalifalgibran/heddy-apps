import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/models/today_water_consum.dart';
import 'package:fit_app/providers/water_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaterRepository {
  String token;
  WaterRepository(String token1) {
    // token = token1;
  }
  final waterProvider = WaterProvider();

  Future<WaterConsumeToday> fetchConsumeDatatoday() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
    final response = await waterProvider.fetchTodayWater(token);
    return WaterConsumeToday.fromJson(response);
  }

  Future<GeneralResponse> postDrinkWater(int qty, int size) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
    final response = await waterProvider.postDrinkWater(qty, size, token);
    return GeneralResponse.fromJson(response);
  }

  Future<WaterConsumeToday> deleteMineralWater(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
    final response = await waterProvider.deleteMineralWater(id, token);
    return WaterConsumeToday.fromJson(response);
  }
}
