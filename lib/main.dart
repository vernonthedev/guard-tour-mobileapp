/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: main.dart
*/

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home.dart';
import 'screens/login.dart';

// Main starter function for the whole application
void main() {
  runApp(const MyApp());
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
      home: const CheckTokenAndNavigate(),
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

// checking if the token is available in sharedpreferences of the application storage
// so that we route the user to home if found or to the login page to start a new login session
class CheckTokenAndNavigate extends StatelessWidget {
  const CheckTokenAndNavigate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      // wait to the getting token functionality(that's why its a future)
      future: _getToken(),
      builder: (context, snapshot) {
        // incase we are done getting a snapshot of the retrieved storage info
        if (snapshot.connectionState == ConnectionState.done) {
          // incase that snapshot has some token value and its not null then we route accordingly
          if (snapshot.hasData && snapshot.data != null) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        }
        // display a circular progress indicator incase we are performing the
        // retrieval operations
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  // Function to retrieve the token from shared preference storage
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
