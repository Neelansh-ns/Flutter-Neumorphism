import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_neumorphism/color_converter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _sideLength;
  Color _color;
  int _shadowDistance;
  bool _gradient;
  int _blurRadius;
  int _radius;
  double _intensity;
  bool _darkMode;
  bool _isConcave;
  TextEditingController _controller;

  get getTextStyle => TextStyle(
      fontSize: 20,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w300,
      color: _darkMode ? Colors.white : HexColor.darkColour);

  @override
  void initState() {
    super.initState();
    _sideLength = 300;
    _color = Color(0xffd6d6d6);
    _shadowDistance = 30;
    _gradient = true;
    _blurRadius = 150;
    _radius = 50;
    _intensity = 0.15;
    _darkMode = false;
    _isConcave = false;
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    if (HexColor.isLight(Color(0xffc6dfd3))) {
      print("hahahahaha");
    }

    print(_getShadowColor1);
    print(_getShadowColor2);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: _color,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.height * 0.5,
                color: _color,
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
                                colors: _isConcave
                                    ? [getColor1, getColor2]
                                    : [getColor2, getColor1],
                              )
                            : null,
                        borderRadius: BorderRadius.all(
                            Radius.circular(_radius.toDouble()))),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                    color: _color,
                    boxShadow: _getBoxShadow,
                    gradient: _gradient
                        ? LinearGradient(
                            stops: [0, 1],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: _isConcave
                                ? [getColor1, getColor2]
                                : [getColor2, getColor1],
                          )
                        : null,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Pick a color",
                            style: getTextStyle,
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
                            style: getTextStyle,
                          ),
                        ),
                        Container(
                          height: 32,
                          width: 100,
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
                            onChanged: (value) {
                              RegExp hexColor = RegExp(r'^#?([0-9a-fA-F]{6})$');
                              if (hexColor.hasMatch(value))
                                changeColor(HexColor(value));
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
                    Row(
                      children: <Widget>[],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Size",
                            style: getTextStyle,
                          ),
                        ),
                        Expanded(
                          child: SliderTheme(
                            data: _sliderTheme,
                            child: Slider(
                              value: _sideLength.toDouble(),
                              min: 5,
                              max: 400,
                              divisions: 400,
                              label: "$_sideLength",
                              onChanged: (value) {
                                setState(() {
                                  _sideLength = value.round();
                                  _shadowDistance = [
                                    5,
                                    (_sideLength / 10).round()
                                  ].reduce(max);
                                  _blurRadius = _shadowDistance * 2;
                                  _radius = [_radius, (_sideLength / 2).round()]
                                      .reduce(min);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Radius",
                            style: getTextStyle,
                          ),
                        ),
                        Expanded(
                          child: SliderTheme(
                            data: _sliderTheme,
                            child: Slider(
                              value: _radius.toDouble(),
                              min: 0,
                              label: "$_radius",
                              divisions: (_sideLength / 2).round(),
                              max: (_sideLength / 2).round().toDouble(),
                              onChanged: (value) {
                                setState(() {
                                  _radius = value.round();
//                          print("$_radius ${_sideLength/2}");
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Distance",
                            style: getTextStyle,
                          ),
                        ),
                        Expanded(
                          child: SliderTheme(
                            data: _sliderTheme,
                            child: Slider(
                              value: _shadowDistance.toDouble(),
                              min: 5,
                              label: "$_shadowDistance",
                              divisions: 50,
                              max: 50,
                              onChanged: (value) {
                                setState(() {
                                  _shadowDistance = value.round();
                                  _blurRadius = _shadowDistance * 2;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Intesnsity",
                            style: getTextStyle,
                          ),
                        ),
                        Expanded(
                          child: SliderTheme(
                            data: _sliderTheme,
                            child: Slider(
                              value: _intensity,
                              min: 0.01,
                              max: 0.6,
                              divisions: 59,
                              label:
                                  "${_intensity.toStringAsPrecision(2).substring(0, 4)}",
                              onChanged: (value) {
                                setState(() {
                                  _intensity = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Blur",
                            style: getTextStyle,
                          ),
                        ),
                        Expanded(
                          child: SliderTheme(
                            data: _sliderTheme,
                            child: Slider(
                              value: _blurRadius.toDouble(),
                              min: 0,
                              max: 200,
                              divisions: 100,
                              label: "$_blurRadius",
                              onChanged: (value) {
                                setState(() {
                                  _blurRadius = value.round();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Gradient background",
                            style: getTextStyle,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() {
                            _gradient = !_gradient;
                          }),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    color: !_darkMode
                                        ? HexColor.darkColour
                                        : Colors.white),
                              ),
                              _gradient
                                  ? Container(
                                      height: 16,
                                      width: 16,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: !_darkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                              width: 2),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          color: !_darkMode
                                              ? HexColor.darkColour
                                              : Colors.white),
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
                              style: getTextStyle,
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
                                        setState(() {
                                          _isConcave = true;
                                        });
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
                                              color: !_darkMode
                                                  ? Colors.white
                                                  : Colors.black),
                                        )),
                                      ),
                                    )),
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isConcave = false;
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        color: !_darkMode
                                            ? Color(0xff344c66)
                                            : Color(0xffc5c4c6),
                                        child: Center(
                                            child: Text(
                                          "Convex",
                                          style: TextStyle(
                                              color: !_darkMode
                                                  ? Colors.white
                                                  : Colors.black),
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
            SizedBox()
          ],
        ),
      ),
    );
  }

  void changeColor(Color color) {
    setState(() {
      _color = color;
      _controller.text = color.toString().substring(10, 16);
      if (HexColor.isLight(color))
        _darkMode = true;
      else
        _darkMode = false;
    });
  }

  get _getBoxShadow => [
        BoxShadow(
          blurRadius: _blurRadius.toDouble(),
          color: _getShadowColor1,
          offset:
              Offset(_shadowDistance.toDouble(), _shadowDistance.toDouble()),
        ),
        BoxShadow(
          blurRadius: _blurRadius.toDouble(),
          color: _getShadowColor2,
          offset:
              Offset(-_shadowDistance.toDouble(), -_shadowDistance.toDouble()),
        ),
      ];

//
  get _getShadowColor1 => Color.fromARGB(
      _color.alpha,
      (_color.red - _intensity * _color.red).round(),
      (_color.green - _intensity * _color.green).round(),
      (_color.blue - _intensity * _color.blue).round());

  get _getShadowColor2 => Color.fromARGB(
      _color.alpha,
      [255, ((_color.red + _intensity * _color.red).round())].reduce(min),
      [255, ((_color.green + _intensity * _color.green).round())].reduce(min),
      [255, ((_color.blue + _intensity * _color.blue).round())].reduce(min));

  get getColor2 => Color.fromARGB(
      _color.alpha,
      (_color.red - 0.10 * _color.red).round(),
      (_color.green - 0.10 * _color.green).round(),
      (_color.blue - 0.10 * _color.blue).round());

  get getColor1 => Color.fromARGB(
      _color.alpha,
      [255, ((_color.red + 0.07 * _color.red).round())].reduce(min),
      [255, ((_color.green + 0.07 * _color.green).round())].reduce(min),
      [255, ((_color.blue + 0.07 * _color.blue).round())].reduce(min));

  get _sliderTheme => SliderThemeData(
      trackHeight: 8,
      activeTrackColor: _darkMode ? Colors.white : HexColor.darkColour,
      inactiveTrackColor: _darkMode ? Colors.white : HexColor.darkColour,
      thumbColor: _darkMode ? Colors.white : HexColor.darkColour,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8));
}
