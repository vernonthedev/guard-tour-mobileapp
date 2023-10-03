import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String userInput;
  const HomePage({super.key, required this.userInput});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text("Home screen"),
      ),
    );
  }
}
