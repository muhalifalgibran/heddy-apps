import 'package:fit_app/models/first_auth.dart';
import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/models/signin_response.dart';
import 'package:fit_app/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final signInProvider = AuthProvider();
  String token;

  Future<FirstAuth> postFirstRegist(
      String uid, String name, String email, String photoUrl) async {
    final response =
        await signInProvider.postFistUserData(uid, name, email, photoUrl);
    return FirstAuth.fromJson(response);
  }

  Future<GeneralResponse> updateUserProfile(int gender, int height, int weight,
      String sleepTime, int activityLevel, String dateOfBirth) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
    final response = await signInProvider.updateUserProfile(
        gender, height, weight, sleepTime, activityLevel, dateOfBirth, token);
    return GeneralResponse.fromJson(response);
  }

  Future<GeneralResponse> createUserManual(
      String name, String email, String password) async {
    final response =
        await signInProvider.createUserManual(name, email, password);
    return GeneralResponse.fromJson(response);
  }

  Future<SignInResponse> loginUserManual(String email, String password) async {
    final response = await signInProvider.loginUserManual(email, password);
    return SignInResponse.fromJson(response);
  }
}
