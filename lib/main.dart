import 'package:flutter/material.dart';
import 'package:flutter_neumorphism/view_model/home_view_model.dart';
import 'package:flutter_neumorphism/widgets/home_view/home_view.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: MaterialApp(
        title: 'Flutter Neumorphism',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeView(),
      ),
    );
  }
}
