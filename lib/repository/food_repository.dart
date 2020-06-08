import 'package:fit_app/models/food_consumtion.dart';
import 'package:fit_app/models/food_history.dart';
import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/providers/food_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodRepository {
  String token;
  final _foodProvider = FoodProvider();

  Future<FoodConsumtionModel> searchFood(int category, String search) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
    final response = await _foodProvider.searchFood(category, search, token);
    return FoodConsumtionModel.fromJson(response);
  }

  Future<GeneralResponse> saveFood(String time, List<int> idFoods) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
    final response = await _foodProvider.saveFood(time, idFoods, token);
    return GeneralResponse.fromJson(response);
  }

  Future<FoodHistory> getTodayHistory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
    final response = await _foodProvider.getTodayHistory(token);
    return FoodHistory.fromJson(response);
  }

  Future<GeneralResponse> deleteFood(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
    final response = await _foodProvider.deleteFood(id, token);
    return GeneralResponse.fromJson(response);
  }
}
