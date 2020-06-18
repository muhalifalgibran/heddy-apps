import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_app/core/firebase/firebase_auth.dart';
import 'package:fit_app/core/tools/injector.dart';
import 'package:fit_app/view/flashscreen/flashscreen.dart';
import 'package:fit_app/view/home/homeScreen.dart';
import 'package:fit_app/view/profile/new_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void saveData(FirebaseUser user) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('email', user.email);
    _prefs.setString('name', user.displayName);
    _prefs.setString('uid', user.uid);
    _prefs.setString('photoUrl', user.photoUrl);
  }

  String token;

  Future getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString('token');
  }

  @override
  void initState() {
    super.initState();
    checkLog();
  }

  Future checkLog() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString('token');
    if (token != null) {
      Navigator.of(context).pushReplacementNamed('/home');

      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return HomeScreen();
      //     },
      //   ),
      // );
    } else {
      isLoggedIn().then((value) {
        if (!value) {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return FlashScreen();
          //     },
          //   ),
          // );
          Navigator.of(context).pushReplacementNamed('/flash');
        } else {
          FirebaseAuth.instance.currentUser().then((firebaseUser) {
            //signed in
            print("logged in");
            saveData(firebaseUser);
            Navigator.of(context).pushReplacementNamed('/home');

            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return HomeScreen();
            //     },
            //   ),
            // );
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
