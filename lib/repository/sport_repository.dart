import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/models/sport.dart';
import 'package:fit_app/providers/sport_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SportRepository {
  final _provider = SportProvider();
  String token;

  Future<GeneralResponse> createStart(
      int category, String startSport, String endSport) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
    final response =
        await _provider.createOlahraga(category, startSport, endSport, token);

    return GeneralResponse.fromJson(response);
  }

  Future<Sport> getSportToday() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
    final response = await _provider.getSport(token);
    return Sport.fromJson(response);
  }
}
