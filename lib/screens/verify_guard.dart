// ignore_for_file: camel_case_types

/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: home.dart
*/
import 'package:guard_tour/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:guard_tour/functions/decode_token.dart';
import 'package:guard_tour/screens/login.dart';

import '../widgets/input_dialog.dart';

class verifyGuardTag extends StatefulWidget {
  const verifyGuardTag({super.key});

  @override
  _verifyGuardTagState createState() => _verifyGuardTagState();
}

class _verifyGuardTagState extends State<verifyGuardTag> {
  UserData? userData;
  String? userInput;

// function to display the scanning input dialog and retrieve its data
  _showInputDialog(BuildContext context) async {
    final result = await showInputDialog(context);

    userInput = result;

    if (userInput != null) {
      //Verify the tag details
      userData = await decodeTokenFromSharedPreferences();

      if (userData != null) {
        if (userInput == userData!.username) {
          //rebuild the widget after the user data has been decoded
          //and send the data to the list tiles
          setState(() {});
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please Scan Your Verified ID Tag!'),
              backgroundColor: Colors.red,
              duration:
                  Duration(seconds: 2), // You can adjust the duration as needed
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'User Token Verification Failed! Please Login Again to solve this issue'),
            backgroundColor: Colors.red,
            duration:
                Duration(seconds: 2), // You can adjust the duration as needed
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Scan Your ID Tag For Verification'),
          backgroundColor: Colors.red,
          duration:
              Duration(seconds: 2), // You can adjust the duration as needed
        ),
      );
    }
  }

// function to verify scanned tag and route to home page
  _navigateToDisplayHomeScreen(BuildContext context) async {
    // Route to the home page after successful id tags verification
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return const HomePage();
        },
      ),
    );
  }

  _cancelVerification() {
    //Cancel verification details
    Navigator.of(context).pop(); // Pop the current page
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return const LoginPage(); // Replace with the desired previous page
        },
      ),
    );

    // Show cancellation toast message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Verification Cancelled!'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2), // You can adjust the duration as needed
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
                'Verify Guard ID Credentials',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                width: 20,
              ),
              CupertinoButton(
                onPressed: () {
                  _showInputDialog(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      CupertinoIcons.camera,
                      color: Color(0xFF2E8B57),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Scan Tag',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (userInput != null)
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text(
                          'Security Guard Name:',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          userData?.firstName ?? 'verify your name',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Guard ID Tag:',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          userInput ?? 'verify your id',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Company ID:',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          userData?.companyId.toString() ??
                              'verify your company id',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Deployed Site ID:',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          userData?.deployedSiteId.toString() ??
                              'No Deployed Site ID',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Shift ID:',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          userData?.shiftId.toString() ??
                              'verify your shift id',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Issued At:',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          userData?.iat.toString() ?? 'verify issue date',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Expiration:',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          userData?.exp.toString() ?? 'verify expiration date',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CupertinoButton(
                        onPressed: () {
                          // Send user to profile page
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Welcome to Guard Tour ${userData!.firstName}'),
                              backgroundColor: Colors.green,
                              duration: const Duration(
                                  seconds:
                                      2), // You can adjust the duration as needed
                            ),
                          );
                          _navigateToDisplayHomeScreen(context);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              CupertinoIcons.check_mark_circled,
                              color: CupertinoColors.activeGreen,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Verify Tag Info',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      CupertinoButton(
                        onPressed: () {
                          // Cancel the tag details returned for verification
                          _cancelVerification();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              CupertinoIcons.person_badge_minus,
                              color: CupertinoColors.destructiveRed,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Revoke Details!',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
