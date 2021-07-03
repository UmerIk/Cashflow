import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CColors{

  // static const primary =  Color(0xFFfe653c);
  static const primary =  Color(0xFF2196F3);
  static const greentext =  Color(0xFF4BA759);
  static const primary2 =  Color(0xFF221f1f);



  static const darkestgray =  Color(0xFF808080);
  static const darkgray =  Color(0xFFA9A9A9);
  static const lightgray =  Color(0xFFD3D3D3);
  static const textblack = Color(0xFF242020);
  static const lightestgray =  Color(0xFFE0E0E0);
  static const textgray = Color(0xff4c4c4c);
  static const graybg = Color(0xffe2e2e2);

  static Map<int, Color> getSwatch(Color color) {
    final hslColor = HSLColor.fromColor(color);
    final lightness = hslColor.lightness;

    final lowDivisor = 6;

    final highDivisor = 5;

    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;

    return {
      50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
      100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
      200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
      300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
      400: (hslColor.withLightness(lightness + lowStep)).toColor(),
      500: (hslColor.withLightness(lightness)).toColor(),
      600: (hslColor.withLightness(lightness - highStep)).toColor(),
      700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
      800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
      900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
    };
  }
}