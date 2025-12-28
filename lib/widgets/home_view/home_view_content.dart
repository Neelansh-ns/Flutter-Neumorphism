import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphism/color_converter.dart';
import 'package:flutter_neumorphism/neumorphism_utils.dart';
import 'package:flutter_neumorphism/utils/text_styles.dart';
import 'package:flutter_neumorphism/view_model/home_view_model.dart';
import 'package:flutter_neumorphism/widgets/copy_button.dart';
import 'package:flutter_neumorphism/widgets/control_panel.dart';
import 'package:flutter_neumorphism/widgets/neumorphic_container.dart';

enum LayoutType { desktop, mobile }

class HomeViewContent extends StatefulWidget {
  final LayoutType layoutType;

  const HomeViewContent({super.key, required this.layoutType});

  @override
  State<HomeViewContent> createState() => _HomeViewContentState();
}

class _HomeViewContentState extends State<HomeViewContent> {
  late TextEditingController _controller;
  HomeViewModel? _model;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = context.read<HomeViewModel>();
    if (_model != model) {
      _model?.removeListener(_updateControllerText);
      _model = model;
      model.addListener(_updateControllerText);
      _controller.text = HexColor.colorToHexString(model.color);
    }
  }

  void _updateControllerText() {
    if (_model != null && mounted) {
      _controller.text = HexColor.colorToHexString(_model!.color);
    }
  }

  @override
  void dispose() {
    _model?.removeListener(_updateControllerText);
    _controller.dispose();
    super.dispose();
  }

  Widget _buildMarkdown() {
    return Consumer<HomeViewModel>(
      builder: (context, model, _) {
        final dartCode = NeumorphismUtils.generateDartCode(
          sideLength: model.sideLength,
          color: model.color,
          blurRadius: model.blurRadius,
          shadowDistance: model.shadowDistance,
          intensity: model.intensity,
          gradient: model.gradient,
          isConcave: model.isConcave,
          radius: model.radius,
        );

        return Markdown(
          physics: const NeverScrollableScrollPhysics(),
          selectable: true,
          styleSheet: MarkdownStyleSheet(
            code: AppTextStyles.codeText(model.darkMode),
            codeblockPadding: const EdgeInsets.all(24),
            codeblockDecoration: BoxDecoration(
              color: model.color,
              boxShadow: NeumorphismUtils.getCodeBoxShadow(
                color: model.color,
                intensity: model.intensity,
              ),
            ),
          ),
          shrinkWrap: true,
          data: '''```dart
  $dartCode''',
        );
      },
    );
  }

  Widget _buildPreview() {
    return Consumer<HomeViewModel>(
      builder: (context, model, _) => NeumorphicContainer(
        color: model.color,
        width: model.sideLength.toDouble(),
        height: model.sideLength.toDouble(),
        intensity: model.intensity,
        blurRadius: model.blurRadius,
        shadowDistance: model.shadowDistance,
        gradient: model.gradient,
        isConcave: model.isConcave,
        radius: model.radius.toDouble(),
      ),
    );
  }

  Widget _buildControlPanel() {
    return Consumer<HomeViewModel>(
      builder: (context, model, _) => NeumorphicContainer(
        color: model.color,
        width: widget.layoutType == LayoutType.desktop ? 450 : null,
        height: widget.layoutType == LayoutType.desktop ? 540 : null,
        intensity: model.intensity,
        blurRadius: model.blurRadius,
        shadowDistance: model.shadowDistance,
        gradient: model.gradient,
        isConcave: model.isConcave,
        radius: 25,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ControlPanel(
            controller: _controller,
            onColorChanged: (color) {
              model.updateValues(color: color);
              _controller.text = HexColor.colorToHexString(color);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCodeSection() {
    return SizedBox(
      width: widget.layoutType == LayoutType.desktop ? 450 : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[_buildMarkdown(), const CopyButton()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.layoutType == LayoutType.desktop) {
      return Selector<HomeViewModel, Color>(
        selector: (_, model) => model.color,
        builder: (context, color, _) => Scaffold(
          backgroundColor: color,
          body: Center(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(flex: 1, child: Center(child: _buildPreview())),
                Flexible(flex: 1, child: _buildControlPanel()),
                Flexible(flex: 1, child: Center(child: _buildCodeSection())),
              ],
            ),
          ),
        ),
      );
    } else {
      return Selector<HomeViewModel, Color>(
        selector: (_, model) => model.color,
        builder: (context, color, _) => Scaffold(
          backgroundColor: color,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.width - 48,
                      maxWidth: MediaQuery.of(context).size.width,
                    ),
                    child: Center(child: _buildPreview()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: _buildControlPanel(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 64),
                  child: Center(child: _buildCodeSection()),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
