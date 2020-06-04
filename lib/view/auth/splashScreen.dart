import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_app/core/tools/injector.dart';
import 'package:fit_app/view/flashscreen/flashscreen.dart';
import 'package:fit_app/view/home/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((firebaseUser) {
      if (firebaseUser == null) {
        //signed out
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return FlashScreen();
            },
          ),
        );
      } else {
        //signed in
        print("assfczxc");
        setupLocator(firebaseUser);
        // addStringToSF(firebaseUser);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return HomeScreen();
            },
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
