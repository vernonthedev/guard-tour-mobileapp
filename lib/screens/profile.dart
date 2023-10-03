import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String userInput;
  const ProfilePage({super.key, required this.userInput});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Guard ID:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              userInput,
              style: const TextStyle(fontSize: 24),
            ),
            const Text(
              'Guard Name:',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'Site ID:',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'District:',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'LC1 Zone:',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'Number of Guards:',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'Number of Notifications:',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'List of Site UID Tags:',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
