import 'package:flutter/material.dart';
import 'package:flutter_neumorphism/widgets/home_view/home_view_desktop.dart';
import 'package:flutter_neumorphism/widgets/home_view/home_view_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) => const HomeViewDesktop(),
      mobile: (context) => const HomeViewMobile(),
    );
  }
}
