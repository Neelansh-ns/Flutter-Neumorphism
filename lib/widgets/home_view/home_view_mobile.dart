import 'package:flutter/material.dart';
import 'package:flutter_neumorphism/widgets/home_view/home_view_content.dart';

class HomeViewMobile extends StatelessWidget {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeViewContent(layoutType: LayoutType.mobile);
  }
}
