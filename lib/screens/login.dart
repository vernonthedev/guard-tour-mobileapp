import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // defining the constants for the text fields
  late final TextEditingController _siteID;
  late final TextEditingController _password;

  @override
  void initState() {
    //bind the text controllers to the fields specified
    _siteID = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    //we dispose the editing controllers
    _siteID.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login to Guardtour"),
        elevation: 0,
      ),
      body: Column(
        children: [
          TextField(
            controller: _siteID,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration:
                const InputDecoration(hintText: "Enter Your Site ID here"),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: "Enter Password"),
          ),
          TextButton(
              onPressed: () async {
                final siteID = _siteID.text;
                final password = _password.text;

                debugPrint("Site Id is: $siteID and Password is $password");
              },
              child: const Text("Login"))
        ],
      ),
    );
  }
}
