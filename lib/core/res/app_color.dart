import 'package:flutter/material.dart';
import 'package:native_color/native_color.dart';

class AppColor {
  // solid
  static Color appBackground = Colors.white;
  static Color primaryColor = HexColor('11458C');
  static Color secondaryColor = HexColor('2D9CDB');
  static Color blueCyan = HexColor('36DEED');
  static Color blueHard = HexColor('4F6DF5');
  static Color blueHard2 = HexColor('0E2BAE');
  static Color blueGrey = HexColor('F6F9FB');
  static Color profileBgColor = HexColor('B4B4B4');
  static Color pinkHard = HexColor('F54F8C');
  static Color yellowHard = HexColor('FFAC00');
  static Color blueCyanSoft = HexColor('CFF1F0');
  static Color blueSoft = HexColor('D4DBFC');
  static Color pinkSoft = HexColor('FCD4E3');
  static Color yellowSoft = HexColor('FFEBC1');
  static Color bgSleep = HexColor('283761');
  static Color bgWakeUp = HexColor('FFFFFF');

  //font
  static Color primaryColorFont = HexColor('333333');
  static Color colorCaption = HexColor('4F4F4F');
  static Color colorParagraphGrey = HexColor('828282');
  static Color colorParagraphGrey2 = HexColor('BDBDBD');

  // gradient
  static Gradient blueGradient = LinearGradient(colors: <Color>[
    HexColor('11458C'),
    HexColor('2978D4'),
    HexColor('59A8ED'),
    HexColor('C8E5FF'),
  ], end: Alignment.bottomCenter, begin: Alignment.topCenter);
}

class AppFont {}
