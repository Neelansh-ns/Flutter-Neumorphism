import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static bool isLight(Color color) {
    final r = (color.r * 255.0).round();
    final g = (color.g * 255.0).round();
    final b = (color.b * 255.0).round();

    final yiq = ((r * 299) + (g * 587) + (b * 114)) / 1000;
    return yiq < 128;
  }

  /// Convert Color to hex string (without # prefix, e.g., "d6d6d6")
  static String colorToHexString(Color color) {
    return color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2);
  }

  static final darkColour = HexColor("001F3F");
  static final lightColor = Colors.white;
}
