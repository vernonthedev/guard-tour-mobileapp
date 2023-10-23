import 'package:codezilla/screens/home.dart';
import 'package:codezilla/screens/patrol.dart';
import 'package:codezilla/screens/profile.dart';
import 'package:flutter/material.dart';

import '../widgets/input_dialog.dart';

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

  _navigateToDisplayHomeScreen(BuildContext context) {
    if (userInput != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return HomePage(userInput: userInput!);
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
                _navigateToDisplayHomeScreen(context);
              },
              child: const Text('Verify Tag Info'),
            ),
          ],
        ),
      ),
    );
  }
}
