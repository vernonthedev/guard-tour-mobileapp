import 'package:codezilla/constants/routes.dart';
import 'package:codezilla/screens/login.dart';
import 'package:codezilla/screens/patrol.dart';
import 'package:flutter/material.dart';

import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guard Tour App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      routes: {
        loginRoute: (context) => const LoginPage(),
        homeRoute: (context) => const HomePage(),
        patrolRoute: (context) => const PatrolPage(),
      },
    );
  }
}
