import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'constants.dart' as Constant;

GetIt locator = GetIt.instance;

class GetPreferences {
  String uid;
  String name;
  String email;
  String photoUrl;
  GetPreferences(FirebaseUser user) {
    uid = user.uid.toString();
    name = user.displayName.toString();
    email = user.email.toString();
    photoUrl = user.photoUrl.toString();
  }
}

class GetToken {
  String token;
  GetToken(String tokenString) {
    token = tokenString;
  }
}

void setupLocator(FirebaseUser user) {
  locator.registerSingleton<GetPreferences>(GetPreferences(user),
      signalsReady: true);
}

void setupLocatorToken(String token) {
  Constant.token = token;
  locator.registerSingleton<GetToken>(GetToken(token), signalsReady: true);
}
