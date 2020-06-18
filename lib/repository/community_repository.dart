import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/models/user_attribute.dart';
import 'package:fit_app/providers/community_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommunityRepository {
  final userProvider = CommunityProvider();
  String token;

  Future<UserAttribut> getProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');

    final response = await userProvider.getProfile(token);
    return UserAttribut.fromJson(response);
  }

  Future<GeneralResponse> setProfile(int attr, String profil) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
    final response = await userProvider.setProfil(attr, profil, token);
    print(response);
    return GeneralResponse.fromJson(response);
  }
}
