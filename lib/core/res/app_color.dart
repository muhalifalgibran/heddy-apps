import 'package:flutter/material.dart';
import 'package:native_color/native_color.dart';

class AppColor {
  // solid
  static Color appBackground = HexColor('F3F3F3');
  static Color primaryColor = HexColor('283761');
  static Color secondaryColor = HexColor('F3F3F3');
  static Color primaryDarkColor = HexColor('BD5454');
  static Color accentColor = HexColor('FF8C9F');
  static Color profileBgColor = HexColor('B4B4B4');

  // gradient
  static Gradient blueGradient = LinearGradient(colors: <Color>[
    HexColor('11458C'),
    HexColor('2978D4'),
    HexColor('59A8ED'),
    HexColor('C8E5FF'),
  ], end: Alignment.bottomCenter, begin: Alignment.topCenter);
}
