import 'package:flutter/material.dart';
import 'package:flutter_neumorphism/neumorphism_utils.dart';

class NeumorphicContainer extends StatelessWidget {
  final Color color;
  final double? width;
  final double? height;
  final double intensity;
  final int blurRadius;
  final int shadowDistance;
  final bool gradient;
  final bool isConcave;
  final double radius;
  final Widget? child;

  const NeumorphicContainer({
    super.key,
    required this.color,
    this.width,
    this.height,
    required this.intensity,
    required this.blurRadius,
    required this.shadowDistance,
    required this.gradient,
    required this.isConcave,
    required this.radius,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        boxShadow: NeumorphismUtils.getBoxShadow(
          color: color,
          intensity: intensity,
          blurRadius: blurRadius,
          shadowDistance: shadowDistance,
        ),
        gradient: gradient
            ? LinearGradient(
                stops: const [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: NeumorphismUtils.getGradientColors(color, isConcave),
              )
            : null,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: child,
    );
  }
}
