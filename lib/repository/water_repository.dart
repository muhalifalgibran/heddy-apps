import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/models/today_water_consum.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/providers/water_provider.dart';

class WaterRepository {
  String token;
  WaterRepository(String token1) {
    token = token1;
  }
  final waterProvider = WaterProvider();

  Future<WaterConsumeToday> fetchConsumeDatatoday() async {
    final response = await waterProvider.fetchTodayWater();
    return WaterConsumeToday.fromJson(response);
  }

  Future<GeneralResponse> postDrinkWater(int qty, int size) async {
    final response = await waterProvider.postDrinkWater(qty, size);
    return GeneralResponse.fromJson(response);
  }

  Future<WaterConsumeToday> deleteMineralWater(int id) async {
    final response = await waterProvider.deleteMineralWater(id);
    return WaterConsumeToday.fromJson(response);
  }
}
