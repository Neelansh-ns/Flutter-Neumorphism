import 'dart:ui';

import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static bool isLight(Color color) {
    var r = color.red;
    var g = color.green;
    var b = color.blue;

    var yiq = ((r * 299) + (g * 587) + (b * 114)) / 1000;
    if (yiq >= 128)
      return false;
    else
      return true;
  }

  static final darkColour = HexColor("001F3F");
  static final lightColor = Colors.white;
}
