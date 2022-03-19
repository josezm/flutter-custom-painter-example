import 'package:custom_painter_test/CustomBottomNavigation/custom_bottom_navigation.dart';
import 'package:custom_painter_test/CustomChart/custom_chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandbox',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomNavigationPage(),
    );
  }
}
