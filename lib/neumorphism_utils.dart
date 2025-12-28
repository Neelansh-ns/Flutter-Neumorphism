import 'dart:math' as math;
import 'package:flutter/material.dart';

class NeumorphismUtils {
  /// Convert Color to ARGB integer components
  static (int a, int r, int g, int b) _toARGBComponents(Color color) {
    return (
      (color.a * 255.0).round().clamp(0, 255),
      (color.r * 255.0).round().clamp(0, 255),
      (color.g * 255.0).round().clamp(0, 255),
      (color.b * 255.0).round().clamp(0, 255),
    );
  }

  /// Calculate the darker shadow color for neumorphism effect
  static Color getShadowColor1(Color color, double intensity) {
    final (a, r, g, b) = _toARGBComponents(color);
    return Color.fromARGB(
      a,
      (r - intensity * r).round(),
      (g - intensity * g).round(),
      (b - intensity * b).round(),
    );
  }

  /// Calculate the lighter shadow color for neumorphism effect
  static Color getShadowColor2(Color color, double intensity) {
    final (a, r, g, b) = _toARGBComponents(color);
    return Color.fromARGB(
      a,
      math.min(255, ((r + intensity * r).round())),
      math.min(255, ((g + intensity * g).round())),
      math.min(255, ((b + intensity * b).round())),
    );
  }

  /// Calculate the darker gradient color
  static Color getGradientColor1(Color color) {
    final (a, r, g, b) = _toARGBComponents(color);
    return Color.fromARGB(
      a,
      math.min(255, ((r + 0.07 * r).round())),
      math.min(255, ((g + 0.07 * g).round())),
      math.min(255, ((b + 0.07 * b).round())),
    );
  }

  /// Calculate the lighter gradient color
  static Color getGradientColor2(Color color) {
    final (a, r, g, b) = _toARGBComponents(color);
    return Color.fromARGB(
      a,
      (r - 0.10 * r).round(),
      (g - 0.10 * g).round(),
      (b - 0.10 * b).round(),
    );
  }

  /// Get gradient colors in the correct order based on concave/convex
  static List<Color> getGradientColors(Color color, bool isConcave) {
    final gradientColor1 = getGradientColor1(color);
    final gradientColor2 = getGradientColor2(color);
    return isConcave
        ? [gradientColor1, gradientColor2]
        : [gradientColor2, gradientColor1];
  }

  /// Generate box shadow list for neumorphism effect
  static List<BoxShadow> getBoxShadow({
    required Color color,
    required double intensity,
    required int blurRadius,
    required int shadowDistance,
  }) {
    final shadowColor1 = getShadowColor1(color, intensity);
    final shadowColor2 = getShadowColor2(color, intensity);

    return [
      BoxShadow(
        blurRadius: blurRadius.toDouble(),
        color: shadowColor1,
        offset: Offset(shadowDistance.toDouble(), shadowDistance.toDouble()),
      ),
      BoxShadow(
        blurRadius: blurRadius.toDouble(),
        color: shadowColor2,
        offset: Offset(-shadowDistance.toDouble(), -shadowDistance.toDouble()),
      ),
    ];
  }

  /// Generate code box shadow (smaller shadows for code blocks)
  static List<BoxShadow> getCodeBoxShadow({
    required Color color,
    required double intensity,
  }) {
    final shadowColor1 = getShadowColor1(color, intensity);
    final shadowColor2 = getShadowColor2(color, intensity);

    return [
      BoxShadow(
        blurRadius: 18,
        color: shadowColor1,
        offset: const Offset(9, 9),
      ),
      BoxShadow(
        blurRadius: 18,
        color: shadowColor2,
        offset: const Offset(-9, -9),
      ),
    ];
  }

  /// Generate button box shadow (4-direction shadow for buttons/inputs)
  static List<BoxShadow> getButtonBoxShadow({required Color shadowColor}) {
    return [
      BoxShadow(color: shadowColor, offset: const Offset(2, 0), blurRadius: 5),
      BoxShadow(color: shadowColor, offset: const Offset(-2, 0), blurRadius: 5),
      BoxShadow(color: shadowColor, offset: const Offset(0, 2), blurRadius: 5),
      BoxShadow(color: shadowColor, offset: const Offset(0, -2), blurRadius: 5),
    ];
  }

  /// Format Color as hex string for Dart code (e.g., Color(0xffd6d6d6))
  static String _formatColorForCode(Color color) {
    final argb = color.toARGB32();
    return 'Color(0x${argb.toRadixString(16).padLeft(8, '0')})';
  }

  /// Generate box shadow code string
  static String _generateBoxShadowCode({
    required Color shadowColor1,
    required Color shadowColor2,
    required int blurRadius,
    required int shadowDistance,
  }) {
    return '''
        BoxShadow(
          blurRadius: ${blurRadius.toDouble()},
          color: ${_formatColorForCode(shadowColor1)},
          offset: Offset(${shadowDistance.toDouble()}, ${shadowDistance.toDouble()}),
        ),
        BoxShadow(
          blurRadius: ${blurRadius.toDouble()},
          color: ${_formatColorForCode(shadowColor2)},
          offset: Offset(-${shadowDistance.toDouble()}, -${shadowDistance.toDouble()}),
        ),''';
  }

  /// Generate gradient code string
  static String _generateGradientCode({
    required Color gradientColor1,
    required Color gradientColor2,
    required bool isConcave,
  }) {
    final colors = isConcave
        ? '[${_formatColorForCode(gradientColor1)}, ${_formatColorForCode(gradientColor2)}]'
        : '[${_formatColorForCode(gradientColor2)}, ${_formatColorForCode(gradientColor1)}]';

    return '''LinearGradient(
      stops: [0, 1],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: $colors,
    )''';
  }

  /// Generate Dart code string for the neumorphism container
  static String generateDartCode({
    required int sideLength,
    required Color color,
    required int blurRadius,
    required int shadowDistance,
    required double intensity,
    required bool gradient,
    required bool isConcave,
    required int radius,
  }) {
    final shadowColor1 = getShadowColor1(color, intensity);
    final shadowColor2 = getShadowColor2(color, intensity);
    final gradientColor1 = getGradientColor1(color);
    final gradientColor2 = getGradientColor2(color);

    final boxShadowCode = _generateBoxShadowCode(
      shadowColor1: shadowColor1,
      shadowColor2: shadowColor2,
      blurRadius: blurRadius,
      shadowDistance: shadowDistance,
    );

    final gradientCode = _generateGradientCode(
      gradientColor1: gradientColor1,
      gradientColor2: gradientColor2,
      isConcave: isConcave,
    );

    return '''Container(
    height: ${sideLength.toDouble()},
    width: ${sideLength.toDouble()},
    decoration: BoxDecoration(
        color: ${_formatColorForCode(color)},
        boxShadow: [$boxShadowCode
      ],
        ${gradient ? 'gradient: $gradientCode,' : ''}
        borderRadius: BorderRadius.all(Radius.circular(${radius.toDouble()})),
    ),
)''';
  }
}
