/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: home.dart
*/

import 'package:flutter/material.dart';
import 'package:guard_tour/screens/home.dart';
import 'package:flutter/cupertino.dart';
import '../functions/login_function.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  late final TextEditingController _siteID;

  @override
  void initState() {
    _siteID = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _siteID.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              CupertinoIcons.xmark_shield_fill,
              size: 100,
              color: Color(0xFF2E8B57),
            ),
            const SizedBox(height: 20),
            const Text(
              "Login to Guard Tour System!",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _siteID,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Scan Site tag",
                  prefixIcon: Icon(CupertinoIcons.building_2_fill),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              onPressed: () async {
                final siteID = _siteID.text;
                setState(() {
                  _isLoading = true;
                });
                String? message = await loginUser(siteID);
                setState(() {
                  _isLoading = false;
                });
                if (message != null && message == "Successful Login") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("$message Welcome To Guard Tour"),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  //route to home
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomePage()));
                } else if (message != null && message == "Incorrect Site ID") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Time Out!"),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              color: const Color(0xFF2E8B57),
              child: const Text("Login"),
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
