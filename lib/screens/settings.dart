/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: settings.dart
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';

// stless bcoz it only contains a list of tiles, doing minimalistic state changing functions
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
            title: const Text('View Failed Patrols'),
            onTap: () {
              //
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(CupertinoIcons.delete_solid),
            title: const Text('Delete All Failed Patrols'),
            onTap: () {
              // Call the function to delete all patrols
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(CupertinoIcons.star_circle_fill),
            title: const Text('Rate Us'),
            onTap: () {
              //TODO: Handle Rate Us action
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(CupertinoIcons.globe),
            title: const Text('Visit Webapp'),
            onTap: () {
              //TODO: Navigate to the web app or open a web URL action
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(CupertinoIcons.person_crop_square_fill),
            title: const Text('About Us'),
            onTap: () {
              //TODO: Navigate to the About Us page action
            },
          ),
          const Divider(),
          ListTile(
            leading:
                const Icon(CupertinoIcons.arrow_counterclockwise_circle_fill),
            title: const Text('Logout'),
            onTap: () async {
              // logout the user
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
