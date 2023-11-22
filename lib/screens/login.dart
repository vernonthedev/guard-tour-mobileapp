/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: home.dart
*/

import 'package:flutter/material.dart';
import 'verify_guard.dart';
import 'package:flutter/cupertino.dart';
import '../functions/login_function.dart';

// stful b'coz we are going to be checking for token availability state
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // circular progress indicator state
  bool _isLoading = false;
  // set controllers to handle the way retrieve data from the inputs
  late final TextEditingController _siteID;
  late final TextEditingController _password;

  // initialise the controllers
  @override
  void initState() {
    _siteID = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  // always dispose the state that we create
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
              color: Color(0xFF2E8B57), // Full hex code with 100% opacity
            ),
            const SizedBox(height: 20),
            // HEADING
            const Text(
              "Login to Guard Tour System!",
              style: TextStyle(
                fontSize: 20, // Adjust the font size as needed
              ),
            ),
            const SizedBox(height: 20),
            // USERNAME INPUT BOX WIDGET
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
            // PASSWORD INPUT BOX WIDGET
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: "Enter Password",
                  prefixIcon: Icon(CupertinoIcons.lock_shield_fill),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // LOGIN SUBMIT BUTTON
            CupertinoButton(
              onPressed: () async {
                // pick data from the text inputs and assign it to vars
                final siteID = _siteID.text;
                final password = _password.text;
                setState(() {
                  _isLoading =
                      true; // Set the loading state to true when authentication starts
                });
                String? token = await loginUser(siteID, password);
                setState(() {
                  _isLoading =
                      false; // Set the loading state to false once authentication is complete
                });
                // move to guard verification screen when we return the token from the auth function
                if (token != null) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const verifyGuardTag()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Login Failed! Please Enter Correct Credentials'),
                      backgroundColor: Colors.red,
                      duration: Duration(
                          seconds: 2), // You can adjust the duration as needed
                    ),
                  );
                }
              },
              color: const Color(0xFF2E8B57),
              child: const Text("Login"), // Change button color if needed
            ),
            // DISPLAY THE CIRCULAR PROGRESS FOR THE LOGIN REQUESTS
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
