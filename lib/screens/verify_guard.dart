// ignore_for_file: camel_case_types

/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: home.dart
*/

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:guard_tour/screens/patrol.dart';
import 'package:shared_preferences/shared_preferences.dart';

class verifyGuardTag extends StatefulWidget {
  const verifyGuardTag({super.key});

  @override
  _verifyGuardTagState createState() => _verifyGuardTagState();
}

class _verifyGuardTagState extends State<verifyGuardTag> {
  late final TextEditingController _guardID;

  @override
  void initState() {
    _guardID = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _guardID.dispose();
    super.dispose();
  }

// function to verify scanned tag and route to home page
  _navigateToDisplayPatrolScreen(BuildContext context) async {
    // Route to the home page after successful id tags verification
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return const PatrolPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verification Screen"),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  CupertinoIcons.tag_circle_fill,
                  size: 100,
                  color: Color(0xFF2E8B57),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Verify Guard ID Tag',
                  style: TextStyle(fontSize: 20),
                ),
                //enter the security guard id
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _guardID,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Scan Guard Tag",
                      prefixIcon: Icon(CupertinoIcons.checkmark_shield_fill),
                    ),
                  ),
                ),

                const SizedBox(
                  width: 20,
                  height: 20,
                ),
                CupertinoButton(
                  onPressed: () {
                    final String guardId = _guardID.text
                        .trim(); // Trim to remove leading and trailing spaces
                    if (guardId.isNotEmpty) {
                      // Check if guardId is not empty
                      debugPrint(guardId);
                      _storeUserInput(guardId);
                      _navigateToDisplayPatrolScreen(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter an ID'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  color: const Color(0xFF2E8B57),
                  child: const Text("Enter"),
                ),
                const SizedBox(height: 20),
              ]),
        ),
      ),
    );
  }
}

// Function to store user input to SharedPreferences
Future<void> _storeUserInput(String guardID) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('guardID', guardID);
}
