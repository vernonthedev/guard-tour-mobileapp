import 'package:codezilla/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/input_dialog.dart';

class verify_guardTag extends StatefulWidget {
  const verify_guardTag({super.key});

  @override
  _verify_guardTagState createState() => _verify_guardTagState();
}

// ignore: camel_case_types
class _verify_guardTagState extends State<verify_guardTag> {
  String? userInput;

  _showInputDialog(BuildContext context) async {
    final result = await showInputDialog(context);
    setState(() {
      userInput = result;
    });
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
      body: Center(
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
            CupertinoButton(
              onPressed: () {
                // Verify the tag details

                // Send user to profile page
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
                        userInput ?? 'Name Goes Here',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'Guard ID Tag:',
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        userInput ?? 'No Tag Id Scanned',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
