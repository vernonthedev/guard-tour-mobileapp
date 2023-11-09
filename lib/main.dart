import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home.dart';
import 'screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor customColor = _createMaterialColor(
        const Color(0xFF2E8B57)); // Convert hex to MaterialColor

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guard Tour App',
      theme: ThemeData(
        primarySwatch:
            customColor, // Use the custom color as the primary swatch
      ),
      home: const CheckTokenAndNavigate(),
    );
  }

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

class CheckTokenAndNavigate extends StatelessWidget {
  const CheckTokenAndNavigate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data != null) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
