import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier {
  String text = 'default';
  int ctr;

  int sideLength;
  Color color;
  int shadowDistance;
  bool gradient;
  int blurRadius;
  int radius;
  double intensity;
  bool darkMode;
  bool isConcave;

  void init() {
    print("init");
    ctr = 0;
    text = 'Neelansh';
    sideLength = 300;
    color = Color(0xffd6d6d6);
    shadowDistance = 30;
    gradient = true;
    blurRadius = 150;
    radius = 50;
    intensity = 0.15;
    darkMode = false;
    isConcave = false;
    notifyListeners();
  }

  void update() {
    text = " ${ctr++}";
    notifyListeners();
  }

  void updateValues({
    int sideLength,
    Color color,
    int shadowDistance,
    bool gradient,
    int blurRadius,
    int radius,
    double intensity,
    bool darkMode,
    bool isConcave,
  }) {
    if (sideLength != null) this.sideLength = sideLength;
    if (color != null) this.color = color;
    if (shadowDistance != null) this.shadowDistance = shadowDistance;
    if (gradient != null) this.gradient = gradient;
    if (blurRadius != null) this.blurRadius = blurRadius;
    if (radius != null) this.radius = radius;
    if (intensity != null) this.intensity = intensity;
    if (darkMode != null) this.darkMode = darkMode;
    if (isConcave != null) this.isConcave = isConcave;
    notifyListeners();
  }
}
