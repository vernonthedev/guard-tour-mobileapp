import 'package:codezilla/screens/profile.dart';
import 'package:flutter/material.dart';

import '../widgets/input_dialog.dart';

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
                //assigning values of the text fields to the variables
                final siteID = _siteID.text;
                final password = _password.text;
                //print values to terminal
                debugPrint("Site Id is: $siteID and Password is $password");
                //show the guard id tag verification widget
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => VerifyGuardTag()));
              },
              child: const Text("Login"))
        ],
      ),
    );
  }
}

class VerifyGuardTag extends StatefulWidget {
  @override
  _VerifyGuardTagState createState() => _VerifyGuardTagState();
}

class _VerifyGuardTagState extends State<VerifyGuardTag> {
  String? userInput;

  _showInputDialog(BuildContext context) async {
    final result = await showInputDialog(context);
    setState(() {
      userInput = result;
    });
  }

  _navigateToDisplayProfileScreen(BuildContext context) {
    if (userInput != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return Builder(
              builder: (BuildContext innerContext) {
                return ProfilePage(userInput: userInput!);
              },
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Guard ID Credentials'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Security Guard Name:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              userInput ?? 'Name Goes Here',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            const Text(
              'Guard ID Tag:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              userInput ?? 'No Tag Id Scanned',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showInputDialog(context);
              },
              child: const Text('Scan Tag'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //verify the tag details

                //send user to profile page
                _navigateToDisplayProfileScreen(context);
              },
              child: const Text('Verify Tag Info'),
            ),
          ],
        ),
      ),
    );
  }
}
