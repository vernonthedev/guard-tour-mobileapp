/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: home.dart
*/

import 'package:flutter/material.dart';
import 'package:guard_tour/screens/home.dart';
import 'verify_guard.dart';
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
  late final TextEditingController _password;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    _siteID = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _siteID.dispose();
    _password.dispose();
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
                  hintText: "Enter Your Unique ID/Scan UID tag",
                  prefixIcon: Icon(CupertinoIcons.building_2_fill),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _password,
                obscureText: !_isPasswordVisible,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  prefixIcon: Icon(CupertinoIcons.lock_shield_fill),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? CupertinoIcons.eye_slash_fill
                          : CupertinoIcons.eye_fill,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              onPressed: () async {
                final siteID = _siteID.text;
                final password = _password.text;
                setState(() {
                  _isLoading = true;
                });
                String? token = await loginUser(siteID, password);
                setState(() {
                  _isLoading = false;
                });
                if (token != null) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomePage()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Login Failed! Please Enter Correct Credentials'),
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
