import 'package:fit_app/models/first_auth.dart';
import 'package:fit_app/providers/auth_provider.dart';

class AuthRepository {
  final signInProvider = AuthProvider();
  Future<FirstAuth> postFirstRegist(
      String uid, String name, String email, String photoUrl) async {
    print("ss2");
    final response =
        await signInProvider.postFistUserData(uid, name, email, photoUrl);
    return FirstAuth.fromJson(response);
  }
}
