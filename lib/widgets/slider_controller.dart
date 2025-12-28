import 'package:flutter/material.dart';
import 'package:flutter_neumorphism/color_converter.dart';

class SliderController extends StatelessWidget {
  final bool darkMode;
  final String title;
  final Function(double) onChanged;
  final double min;
  final double max;
  final int divisions;
  final String label;
  final double value;

  const SliderController({
    super.key,
    required this.darkMode,
    required this.title,
    required this.onChanged,
    required this.min,
    required this.max,
    required this.divisions,
    required this.label,
    required this.value,
  });

  TextStyle get _getTextStyle => TextStyle(
    fontSize: 20,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    color: darkMode ? Colors.white : HexColor.darkColour,
  );

  SliderThemeData get _sliderTheme => SliderThemeData(
    trackHeight: 8,
    activeTrackColor: darkMode ? Colors.white : HexColor.darkColour,
    inactiveTrackColor: darkMode ? Colors.white : HexColor.darkColour,
    thumbColor: darkMode ? Colors.white : HexColor.darkColour,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(title, style: _getTextStyle),
        ),
        Expanded(
          child: SliderTheme(
            data: _sliderTheme,
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              label: label,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
