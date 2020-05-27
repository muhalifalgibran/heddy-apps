import 'package:fit_app/core/res/app_color.dart';
import 'package:fit_app/view/auth/registration/signUp.dart';
import 'package:fit_app/view/auth/signIn.dart';
import 'package:fit_app/view/flashscreen/flashscreen.dart';
import 'package:fit_app/view/home/homeScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: AppColor.primaryColor),
      home: FlashScreen(),
    );
  }
}
