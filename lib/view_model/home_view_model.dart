import 'package:flutter/material.dart';
import 'package:flutter_neumorphism/color_converter.dart';

class HomeViewModel extends ChangeNotifier {
  int sideLength = 300;
  int shadowDistance = 30;
  bool gradient = true;
  int blurRadius = 150;
  int radius = 50;
  double intensity = 0.15;
  bool isConcave = false;

  Color _color = const Color(0xffe1c1c1);
  bool _darkMode = false;

  Color get color => _color;
  bool get darkMode => _darkMode;

  set color(Color value) {
    _color = value;
    _darkMode = HexColor.isLight(value);
    notifyListeners();
  }

  void updateValues({
    int? sideLength,
    Color? color,
    int? shadowDistance,
    bool? gradient,
    int? blurRadius,
    int? radius,
    double? intensity,
    bool? isConcave,
  }) {
    this.sideLength = sideLength ?? this.sideLength;
    if (color != null) this.color = color;
    this.shadowDistance = shadowDistance ?? this.shadowDistance;
    this.gradient = gradient ?? this.gradient;
    this.blurRadius = blurRadius ?? this.blurRadius;
    this.radius = radius ?? this.radius;
    this.intensity = intensity ?? this.intensity;
    this.isConcave = isConcave ?? this.isConcave;
    notifyListeners();
  }
}
