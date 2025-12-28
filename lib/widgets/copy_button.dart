import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphism/color_converter.dart';
import 'package:flutter_neumorphism/neumorphism_utils.dart';
import 'package:flutter_neumorphism/utils/text_styles.dart';
import 'package:flutter_neumorphism/view_model/home_view_model.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, model, _) => GestureDetector(
        onTap: () async {
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
          await Clipboard.setData(ClipboardData(text: dartCode));
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Copied to Clipboard")),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            alignment: Alignment.center,
            height: 32,
            decoration: BoxDecoration(
              boxShadow: NeumorphismUtils.getButtonBoxShadow(
                shadowColor: HexColor.darkColour,
              ),
              color: model.color,
            ),
            child: Text(
              'COPY',
              style: AppTextStyles.bodyText(model.darkMode),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
