import 'package:fit_app/models/food_consumtion.dart';
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
}
