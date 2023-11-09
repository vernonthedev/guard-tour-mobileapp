import 'package:flutter/material.dart';
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
              color: Color(0xFF2E8B57), // Full hex code with 100% opacity
            ),
            const SizedBox(height: 20),
            const Text(
              "Login to Guard Tour System!",
              style: TextStyle(
                fontSize: 20, // Adjust the font size as needed
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
            CupertinoButton(
              onPressed: () async {
                final siteID = _siteID.text;
                final password = _password.text;
                debugPrint("Site Id is: $siteID and Password is $password");
                setState(() {
                  _isLoading =
                      true; // Set the loading state to true when authentication starts
                });
                String? token = await loginUser(siteID, password);
                setState(() {
                  _isLoading =
                      false; // Set the loading state to false once authentication is complete
                });

                if (token != null) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const verify_guardTag()));
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
