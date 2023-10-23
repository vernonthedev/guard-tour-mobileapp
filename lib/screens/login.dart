import 'package:flutter/material.dart';
import 'verifyGuard.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              color: Colors.blue,
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
                  hintText: "Enter Your Site ID here",
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => VerifyGuardTag()));
              },
              color: CupertinoColors.activeBlue,
              child: const Text("Login"), // Change button color if needed
            ),
          ],
        ),
      ),
    );
  }
}
