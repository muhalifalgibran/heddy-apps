import 'package:fit_app/view/auth/registration/dialogs/registration.dart';
import 'package:fit_app/view/auth/signIn.dart';
import 'package:fit_app/view/auth/splashScreen.dart';
import 'package:fit_app/view/home/homeScreen.dart';
import 'package:fit_app/view/profile/new_home_screen.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        // Set routes for using the Navigator.
        '/home': (BuildContext context) => new HomeScreen(),
        '/login': (BuildContext context) => new SignIn(),
        '/registration': (BuildContext context) => new RegistrationScreen(),
      },
    );
  }
}
