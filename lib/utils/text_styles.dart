import 'package:flutter/material.dart';
import 'package:flutter_neumorphism/color_converter.dart';

class AppTextStyles {
  static TextStyle bodyText(bool darkMode) => TextStyle(
    fontSize: 20,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    color: darkMode ? Colors.white : HexColor.darkColour,
  );

  static TextStyle codeText(bool darkMode) => TextStyle(
    fontFamily: "monospace",
    fontSize: 12,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    color: darkMode ? Colors.white : HexColor.darkColour,
  );

  static TextStyle get inputText => TextStyle(
    fontSize: 20,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    color: HexColor.darkColour,
  );
}
