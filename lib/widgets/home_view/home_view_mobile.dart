import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_neumorphism/color_converter.dart';
import 'package:flutter_neumorphism/view_model/home_view_model.dart';
import 'package:flutter_neumorphism/widgets/base_model_widget.dart';
import 'package:flutter_neumorphism/widgets/slider_controller.dart';

class HomeViewMobile extends BaseModelWidget<HomeViewModel> {
  Color _color;
  int _sideLength;

  int _shadowDistance;

  bool _gradient;
  int _blurRadius;
  int _radius;

  double _intensity;

  bool _darkMode;

  bool _isConcave;

  TextEditingController _controller;
  HomeViewModel _model;

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    _color = model.color;
    _sideLength = model.sideLength;
    _shadowDistance = model.shadowDistance;
    _gradient = model.gradient;
    _blurRadius = model.blurRadius;
    _radius = model.radius;
    _intensity = model.intensity;
    _darkMode = model.darkMode;
    _isConcave = model.isConcave;
    _model = model;
    _controller = TextEditingController();
    _controller.text = _color.toString().substring(10, 16);

    return Scaffold(
      backgroundColor: _color,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  constraints: BoxConstraints(
                      maxHeight: min(MediaQuery.of(context).size.width - 48, 400),
                      maxWidth: MediaQuery.of(context).size.width),
                  child: Center(
                    child: Container(
                      height: _sideLength.toDouble(),
                      width: _sideLength.toDouble(),
                      decoration: BoxDecoration(
                          color: _color,
                          boxShadow: _getBoxShadow,
                          gradient: _gradient
                              ? LinearGradient(
                                  stops: [0, 1],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors:
                                      _isConcave ? [getColor1, getColor2] : [getColor2, getColor1],
                                )
                              : null,
                          borderRadius: BorderRadius.all(Radius.circular(_radius.toDouble()))),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: _color,
                      boxShadow: _getBoxShadow,
                      gradient: _gradient
                          ? LinearGradient(
                              stops: [0, 1],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: _isConcave ? [getColor1, getColor2] : [getColor2, getColor1],
                            )
                          : null,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  "Pick a color",
                                  overflow: TextOverflow.ellipsis,
                                  style: _getTextStyle,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    child: AlertDialog(
                                        content: SingleChildScrollView(
                                            child: ColorPicker(
                                      displayThumbColor: true,
                                      enableLabel: true,
                                      enableAlpha: false,
                                      paletteType: PaletteType.hsl,
                                      pickerAreaHeightPercent: 0.4,
                                      onColorChanged: changeColor,
                                      pickerColor: _color,
                                    ))));
                              },
                              child: Container(
                                height: 32,
                                width: 32,
//                          color: _color,
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color: HexColor.darkColour,
                                      offset: Offset(2, 0),
                                      blurRadius: 5),
                                  BoxShadow(
                                      color: HexColor.darkColour,
                                      offset: Offset(-2, 0),
                                      blurRadius: 5),
                                  BoxShadow(
                                      color: HexColor.darkColour,
                                      offset: Offset(0, 2),
                                      blurRadius: 5),
                                  BoxShadow(
                                      color: HexColor.darkColour,
                                      offset: Offset(0, -2),
                                      blurRadius: 5),
                                ], color: _color),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "or",
                                style: _getTextStyle,
                              ),
                            ),
                            Container(
                              height: 32,
//                              width: 80,
                              constraints: BoxConstraints(maxWidth: 80),
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: HexColor.darkColour,
                                    offset: Offset(2, 0),
                                    blurRadius: 5),
                                BoxShadow(
                                    color: HexColor.darkColour,
                                    offset: Offset(-2, 0),
                                    blurRadius: 5),
                                BoxShadow(
                                    color: HexColor.darkColour,
                                    offset: Offset(0, 2),
                                    blurRadius: 5),
                                BoxShadow(
                                    color: HexColor.darkColour,
                                    offset: Offset(0, -2),
                                    blurRadius: 5),
                              ], color: Colors.white),
                              child: TextFormField(
                                controller: _controller,
                                onTap: () => _controller.clear(),
                                onChanged: (value) {
                                  RegExp hexColor = RegExp(r'^#?([0-9a-fA-F]{6})$');
                                  if (hexColor.hasMatch(value)) changeColor(HexColor(value));
                                },
                                decoration: InputDecoration(
                                    counterText: "",
                                    contentPadding: EdgeInsets.all(8),
                                    hintText: "ffffff",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[500],
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                        fontStyle: FontStyle.normal)),
                                textAlign: TextAlign.center,
                                maxLength: 6,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w300,
                                    color: HexColor.darkColour),
                              ),
                            )
                          ],
                        ),
                        SliderController(
                          title: "Size",
                          min: 5,
                          max: 400,
                          divisions: 400,
                          darkMode: _darkMode,
                          sideLength: _sideLength,
                          label: "$_sideLength",
                          value: _sideLength.toDouble(),
                          onChanged: (value) {
                            model.updateValues(
                              sideLength: value.round(),
                              shadowDistance: [5, (_sideLength / 10).round()].reduce(max),
                              blurRadius: _shadowDistance * 2,
                              radius: [_radius, (_sideLength / 2).round()].reduce(min),
                            );
                          },
                        ),
                        SliderController(
                          title: "Radius",
                          min: 0,
                          max: (_sideLength / 2).round().toDouble(),
                          label: "$_radius",
                          sideLength: _sideLength,
                          darkMode: _darkMode,
                          divisions: (_sideLength / 2).round(),
                          onChanged: (value) {
                            model.updateValues(radius: value.round(), sideLength: _sideLength);
                          },
                          value: _radius.toDouble().clamp(0, (_sideLength / 2).round().toDouble()),
                        ),
                        SliderController(
                          title: "Distance",
                          min: 5,
                          max: 50,
                          label: "$_shadowDistance",
                          sideLength: _sideLength,
                          darkMode: _darkMode,
                          divisions: 50,
                          onChanged: (value) {
                            model.updateValues(
                                shadowDistance: value.round(), blurRadius: _shadowDistance * 2);
                          },
                          value: _shadowDistance.toDouble(),
                        ),
                        SliderController(
                          title: "Intensity",
                          min: 0.01,
                          max: 0.6,
                          label: "${_intensity.toStringAsPrecision(2).substring(0, 4)}",
                          sideLength: _sideLength,
                          darkMode: _darkMode,
                          divisions: 59,
                          onChanged: (value) {
                            model.updateValues(intensity: value);
                          },
                          value: _intensity,
                        ),
                        SliderController(
                          title: "Blur",
                          value: _blurRadius.toDouble(),
                          min: 0,
                          max: 200,
                          divisions: 100,
                          label: "$_blurRadius",
                          sideLength: _sideLength,
                          darkMode: _darkMode,
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
                                style: _getTextStyle,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => model.updateValues(gradient: !_gradient),
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(4)),
                                        color: !_darkMode ? HexColor.darkColour : Colors.white),
                                  ),
                                  _gradient
                                      ? Container(
                                          height: 16,
                                          width: 16,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: !_darkMode ? Colors.white : Colors.black,
                                                  width: 2),
                                              borderRadius: BorderRadius.all(Radius.circular(4)),
                                              color:
                                                  !_darkMode ? HexColor.darkColour : Colors.white),
                                        )
                                      : Container()
                                ],
                              ),
                            )
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
                                  style: _getTextStyle,
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
                                            color: !_darkMode
                                                ? HexColor.darkColour
                                                : Color(0xfff6f5f7),
                                            child: Center(
                                                child: Text(
                                              "Concave",
                                              style: TextStyle(
                                                  color: !_darkMode ? Colors.white : Colors.black),
                                            )),
                                          ),
                                        )),
                                    Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: GestureDetector(
                                          onTap: () {
                                            model.updateValues(isConcave: false);
                                          },
                                          child: Container(
                                            height: 40,
                                            color:
                                                !_darkMode ? Color(0xff344c66) : Color(0xffc5c4c6),
                                            child: Center(
                                                child: Text(
                                              "Convex",
                                              style: TextStyle(
                                                  color: !_darkMode ? Colors.white : Colors.black),
                                            )),
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.red,
                height: 540,
                width: 450,
                child: MarkdownBody(data: '''```dart
Container(
    height: ${_sideLength.toDouble()},
    width: ${_sideLength.toDouble()},
    decoration: BoxDecoration(
        color: $_color,
        boxShadow: [
        BoxShadow(
          blurRadius: ${_blurRadius.toDouble()},
          color: $_getShadowColor1,
          offset: Offset(
            ${_shadowDistance.toDouble()},
            ${_shadowDistance.toDouble()},
          ),
        ),
        BoxShadow(
          blurRadius: ${_blurRadius.toDouble()},
          color: $_getShadowColor2,
          offset: Offset(
            -${_shadowDistance.toDouble()},
            -${_shadowDistance.toDouble()},
          ),
        ),
      ];,
    gradient: ${_gradient ? '''LinearGradient(
      stops: [0, 1],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors:
          ${_isConcave ? [getColor1, getColor2] : [getColor2, getColor1]},
    ),''' : '''null, '''}
    borderRadius: BorderRadius.all(
      Radius.circular(
        ${_radius.toDouble()},
    )
  )
)
```'''),
              ),
            ],
          ),
        ),
      ),
    );
  }

  get _getShadowColor1 => Color.fromARGB(
        _color.alpha,
        (_color.red - _intensity * _color.red).round(),
        (_color.green - _intensity * _color.green).round(),
        (_color.blue - _intensity * _color.blue).round(),
      );

  get _getShadowColor2 => Color.fromARGB(
      _color.alpha,
      min(255, ((_color.red + _intensity * _color.red).round())),
      min(255, ((_color.green + _intensity * _color.green).round())),
      min(255, ((_color.blue + _intensity * _color.blue).round())));

  get getColor2 => Color.fromARGB(
        _color.alpha,
        (_color.red - 0.10 * _color.red).round(),
        (_color.green - 0.10 * _color.green).round(),
        (_color.blue - 0.10 * _color.blue).round(),
      );

  get getColor1 => Color.fromARGB(
      _color.alpha,
      min(255, ((_color.red + 0.07 * _color.red).round())),
      min(255, ((_color.green + 0.07 * _color.green).round())),
      min(255, ((_color.blue + 0.07 * _color.blue).round())));

  void changeColor(Color color) {
    bool _darkMode;
    print(color);
    if (HexColor.isLight(color))
      _darkMode = true;
    else
      _darkMode = false;
    _model.updateValues(color: color, darkMode: _darkMode);
  }

  get _getBoxShadow => [
        BoxShadow(
          blurRadius: _blurRadius.toDouble(),
          color: _getShadowColor1,
          offset: Offset(
            _shadowDistance.toDouble(),
            _shadowDistance.toDouble(),
          ),
        ),
        BoxShadow(
          blurRadius: _blurRadius.toDouble(),
          color: _getShadowColor2,
          offset: Offset(
            -_shadowDistance.toDouble(),
            -_shadowDistance.toDouble(),
          ),
        ),
      ];

  get _getTextStyle => TextStyle(
      fontSize: 20,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w300,
      color: _darkMode ? Colors.white : HexColor.darkColour);
}
