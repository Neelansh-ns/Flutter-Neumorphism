import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphism/color_converter.dart';
import 'package:flutter_neumorphism/neumorphism_utils.dart';
import 'package:flutter_neumorphism/utils/text_styles.dart';
import 'package:flutter_neumorphism/view_model/home_view_model.dart';
import 'package:flutter_neumorphism/widgets/color_picker_dialog.dart';
import 'package:flutter_neumorphism/widgets/slider_controller.dart';

class ControlPanel extends StatelessWidget {
  final TextEditingController controller;
  final Function(Color) onColorChanged;

  const ControlPanel({
    super.key,
    required this.controller,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, model, _) => Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Pick a color",
                  style: AppTextStyles.bodyText(model.darkMode),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ColorPickerDialog.show(
                    context,
                    currentColor: model.color,
                    onColorChanged: onColorChanged,
                  );
                },
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    boxShadow: NeumorphismUtils.getButtonBoxShadow(
                      shadowColor: HexColor.darkColour,
                    ),
                    color: model.color,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "or",
                  style: AppTextStyles.bodyText(model.darkMode),
                ),
              ),
              Flexible(
                child: Container(
                  height: 32,
                  width: 100,
                  decoration: BoxDecoration(
                    boxShadow: NeumorphismUtils.getButtonBoxShadow(
                      shadowColor: HexColor.darkColour,
                    ),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: controller,
                    onTap: () => controller.clear(),
                    onChanged: (value) {
                      final hexColor = RegExp(r'^#?([0-9a-fA-F]{6})$');
                      if (hexColor.hasMatch(value)) {
                        onColorChanged(HexColor(value));
                      }
                    },
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: const EdgeInsets.all(8),
                      hintText: "ffffff",
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    maxLength: 6,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    style: AppTextStyles.inputText,
                  ),
                ),
              ),
            ],
          ),
          SliderController(
            title: "Size",
            min: 5,
            max: 400,
            divisions: 400,
            darkMode: model.darkMode,
            label: "${model.sideLength}",
            value: model.sideLength.toDouble(),
            onChanged: (value) {
              model.updateValues(
                sideLength: value.round(),
                shadowDistance: [
                  5,
                  (model.sideLength / 10).round(),
                ].reduce(math.max),
                blurRadius: model.shadowDistance * 2,
                radius: [
                  model.radius,
                  (model.sideLength / 2).round(),
                ].reduce(math.min),
              );
            },
          ),
          SliderController(
            title: "Radius",
            min: 0,
            max: (model.sideLength / 2).round().toDouble(),
            label: "${model.radius}",
            darkMode: model.darkMode,
            divisions: (model.sideLength / 2).round(),
            onChanged: (value) {
              model.updateValues(
                radius: value.round(),
                sideLength: model.sideLength,
              );
            },
            value: model.radius.toDouble().clamp(
              0,
              (model.sideLength / 2).round().toDouble(),
            ),
          ),
          SliderController(
            title: "Distance",
            min: 5,
            max: 50,
            label: "${model.shadowDistance}",
            darkMode: model.darkMode,
            divisions: 50,
            onChanged: (value) {
              final newDistance = value.round();
              model.updateValues(
                shadowDistance: newDistance,
                blurRadius: newDistance * 2,
              );
            },
            value: model.shadowDistance.toDouble(),
          ),
          SliderController(
            title: "Intensity",
            min: 0.01,
            max: 0.6,
            label: model.intensity.toStringAsPrecision(2).substring(0, 4),
            darkMode: model.darkMode,
            divisions: 59,
            onChanged: (value) {
              model.updateValues(intensity: value);
            },
            value: model.intensity,
          ),
          SliderController(
            title: "Blur",
            value: model.blurRadius.toDouble(),
            min: 0,
            max: 200,
            divisions: 100,
            label: "${model.blurRadius}",
            darkMode: model.darkMode,
            onChanged: (value) {
              model.updateValues(blurRadius: value.round());
            },
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Gradient background",
                  style: AppTextStyles.bodyText(model.darkMode),
                ),
              ),
              GestureDetector(
                onTap: () => model.updateValues(gradient: !model.gradient),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4),
                        ),
                        color: !model.darkMode
                            ? HexColor.darkColour
                            : Colors.white,
                      ),
                    ),
                    model.gradient
                        ? Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: !model.darkMode
                                    ? Colors.white
                                    : Colors.black,
                                width: 2,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4),
                              ),
                              color: !model.darkMode
                                  ? HexColor.darkColour
                                  : Colors.white,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Shape",
                    style: AppTextStyles.bodyText(model.darkMode),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: GestureDetector(
                          onTap: () {
                            model.updateValues(isConcave: true);
                          },
                          child: Container(
                            height: 40,
                            color: !model.darkMode
                                ? HexColor.darkColour
                                : const Color(0xfff6f5f7),
                            child: Center(
                              child: Text(
                                "Concave",
                                style: TextStyle(
                                  color: !model.darkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: GestureDetector(
                          onTap: () {
                            model.updateValues(isConcave: false);
                          },
                          child: Container(
                            height: 40,
                            color: !model.darkMode
                                ? const Color(0xff344c66)
                                : const Color(0xffc5c4c6),
                            child: Center(
                              child: Text(
                                "Convex",
                                style: TextStyle(
                                  color: !model.darkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
