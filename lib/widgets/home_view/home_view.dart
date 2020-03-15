import 'package:flutter/material.dart';
import 'package:flutter_neumorphism/view_model/home_view_model.dart';
import 'package:flutter_neumorphism/widgets/base_widget.dart';
import 'package:flutter_neumorphism/widgets/home_view/home_view_desktop.dart';
import 'package:flutter_neumorphism/widgets/home_view/home_view_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
      viewModel: HomeViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context) => ScreenTypeLayout(
        desktop: HomeViewDesktop(),
        mobile: HomeViewMobile(),
      ),
    );
  }
}
