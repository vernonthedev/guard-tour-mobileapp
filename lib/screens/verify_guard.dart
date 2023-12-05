// ignore_for_file: camel_case_types

/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: home.dart
*/
import 'package:guard_tour/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:guard_tour/screens/patrol.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../functions/get_security_guard_details.dart';
import '../functions/user_input_provider.dart';
import '../models/security_guard_model.dart';
import '../widgets/input_dialog.dart';

class verifyGuardTag extends StatefulWidget {
  const verifyGuardTag({super.key});

  @override
  _verifyGuardTagState createState() => _verifyGuardTagState();
}

class _verifyGuardTagState extends State<verifyGuardTag> {
  String? userInput;

// Declare guardDetails as a single SecurityGuardDetails
  SecurityGuardDetails? guardDetails;

// Function to display the scanning input dialog and retrieve its data
  _showInputDialog(BuildContext context) async {
    final userInput = await showInputDialog(context);

    if (userInput != null) {
      // Fetch security guard details based on the scanned tag
      SecurityGuardDetails? fetchedGuardDetails =
          await fetchSecurityGuardDetails(userInput);

      setState(() {
        // Update the UI with the scanned tag and fetched guard details
        this.userInput = userInput;
        guardDetails = fetchedGuardDetails;
      });

      if (guardDetails != null) {
        // Store the user input to SharedPreferences only if the guard is verified in the system
        // await _storeUserInput(userInput);

        //pass the user input to provider for statemmgt across the diff screens
        // Get the provider and set the userInput
        UserInputProvider userInputProvider =
            Provider.of<UserInputProvider>(context, listen: false);
        userInputProvider.setUserInput(userInput);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tag Verified!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid Tag!'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Scan Your ID Tag For Verification'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
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

  _cancelVerification() {
    //Cancel verification details
    Navigator.of(context).pop(); // Pop the current page
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return const HomePage(); // Replace with the desired previous page
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
                'Verify Guard Making Patrol',
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
                          '${guardDetails?.firstName ?? 'verify your name'} ${guardDetails?.lastName ?? ''}',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Date of Birth:',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          guardDetails?.dateOfBirth ?? 'verify your DOB',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Gender:',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          guardDetails?.gender.toString() ??
                              'verify your gender',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Armed Status',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          guardDetails?.armedStatus.toString() ??
                              'Armed Status',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Shift ID:',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          guardDetails?.shiftId.toString() ??
                              'verify your shift id',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Phone Number',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          guardDetails?.phoneNumber.toString() ??
                              'verify phone Number',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Username:',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          guardDetails?.username.toString() ??
                              'verify username',
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
                                  'Your Patrol Session Has Began ${guardDetails!.firstName}'),
                              backgroundColor: Colors.green,
                              duration: const Duration(
                                  seconds:
                                      2), // You can adjust the duration as needed
                            ),
                          );
                          _navigateToDisplayPatrolScreen(context);
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
                              'Start Patrolling',
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

// Function to store user input to SharedPreferences
Future<void> _storeUserInput(String userInput) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userInput', userInput);
}
