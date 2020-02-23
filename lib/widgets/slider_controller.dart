import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphism/color_converter.dart';

class SliderController extends StatelessWidget {
  final bool darkMode;
  final int sideLength;
  final String title;
  final Function(double) onChanged;
  final double min;
  final double max;
  final int divisions;
  final String label;
  final double value;

  SliderController({
    this.darkMode,
    this.title,
    this.sideLength,
    this.onChanged,
    this.min,
    this.max,
    this.divisions,
    this.label,
    this.value,
  });

  get _getTextStyle => TextStyle(
      fontSize: 20,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w300,
      color: darkMode ? Colors.white : HexColor.darkColour);

  get _sliderTheme => SliderThemeData(
      trackHeight: 8,
      activeTrackColor: darkMode ? Colors.white : HexColor.darkColour,
      inactiveTrackColor: darkMode ? Colors.white : HexColor.darkColour,
      thumbColor: darkMode ? Colors.white : HexColor.darkColour,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8));

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: _getTextStyle,
          ),
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
                onChanged: onChanged),
          ),
        ),
      ],
    );
  }
}
