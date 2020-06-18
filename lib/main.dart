import 'package:fit_app/models/food_history.dart';
import 'package:fit_app/view/auth/registration/dialogs/registration.dart';
import 'package:fit_app/view/auth/signIn.dart';
import 'package:fit_app/view/auth/splashScreen.dart';
import 'package:fit_app/view/flashscreen/flashscreen.dart';
import 'package:fit_app/view/home/homeScreen.dart';
import 'package:fit_app/view/profile/foodComsumtion/foodHistory/food_history_screen.dart';
import 'package:fit_app/view/profile/foodComsumtion/food_consumtion.dart';
import 'package:fit_app/view/profile/new_home_screen.dart';
import 'package:fit_app/view/profile/profileScreen.dart';
import 'package:fit_app/view/profile/sleepTime/sleepScreen.dart';
import 'package:fit_app/view/profile/sportTracker/sport_tracker.dart';
import 'package:fit_app/view/profile/waterConsumtion/water_consumtion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}
//runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heddy',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        // Set routes for using the Navigator.
        '/home': (BuildContext context) => new HomeScreen(),
        '/flash': (BuildContext context) => new FlashScreen(),
        '/login': (BuildContext context) => new SignIn(),
        '/registration': (BuildContext context) => new RegistrationScreen(),
        '/water': (BuildContext context) => new WaterConsumtion(),
        '/sleep': (BuildContext context) => new SleepScreen(),
        '/food': (BuildContext context) => new FoodConsumtion(),
        '/foodHistory': (BuildContext context) => new FoodHistoryScreen(),
        '/sport': (BuildContext context) => new SportTrackerScreen(),
        '/profile': (BuildContext context) => new ProfileScreen(),
      },
    );
  }
}
