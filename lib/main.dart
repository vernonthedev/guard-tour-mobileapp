/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: main.dart
*/

import 'package:flutter/material.dart';
import 'screens/login.dart';

// Main starter function for the whole application
void main() async {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert hex to MaterialColor
    // using hex code for the seagreen as the theme color
    MaterialColor customColor = _createMaterialColor(const Color(0xFF2E8B57));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guard Tour App',
      theme: ThemeData(
        primarySwatch:
            // Use the custom color as the primary swatch
            customColor,
      ),
      home: const LoginPage(),
    );
  }

// Created a custom material color for sea green to be used as the
// theme color
  MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[
      0.05,
      0.1,
      0.2,
      0.3,
      0.4,
      0.5,
      0.6,
      0.7,
      0.8,
      0.9
    ];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 0; i < 10; i++) {
      swatch[(strengths[i] * 1000).round()] =
          Color.fromRGBO(r, g, b, strengths[i]);
    }

    return MaterialColor(color.value, swatch);
  }
}
