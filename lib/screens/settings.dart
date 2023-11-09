import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.archivebox_fill),
            title: const Text('View Archived Patrols'),
            onTap: () {
              // Navigate to view archived patrols page
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(CupertinoIcons.star_circle_fill),
            title: const Text('Rate Us'),
            onTap: () {
              // Handle logout
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(CupertinoIcons.globe),
            title: const Text('Visit Webapp'),
            onTap: () {
              // Navigate to the web app or open a web URL
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(CupertinoIcons.person_crop_square_fill),
            title: const Text('About Us'),
            onTap: () {
              // Navigate to the About Us page
            },
          ),
          const Divider(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.browser_updated_rounded),
            title: const Text('Update Guard Information'),
            onTap: () {
              // Navigate to the About Us page
            },
          ),
          const Divider(),
          ListTile(
            leading:
                const Icon(CupertinoIcons.arrow_counterclockwise_circle_fill),
            title: const Text('Logout'),
            onTap: () async {
              await _logout(context);
              // Implement contact support functionality
            },
          ),
          const Divider(),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Remove token from SharedPreferences

    // Navigate back to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    ); // Replace with your route name for the login page
  }
}
