import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDialog {
  static void show(
    BuildContext context, {
    required Color currentColor,
    required Function(Color) onColorChanged,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: ColorPicker(
            displayThumbColor: true,
            enableAlpha: false,
            paletteType: PaletteType.hsl,
            pickerAreaHeightPercent: 0.4,
            onColorChanged: onColorChanged,
            pickerColor: currentColor,
          ),
        ),
      ),
    );
  }
}
