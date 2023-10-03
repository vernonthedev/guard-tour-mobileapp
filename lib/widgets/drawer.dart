import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            child: Text('Guard Tour App'),
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.home,
              color: CupertinoColors.systemBlue,
            ),
            title: const Text('Home'),
            onTap: () {
              // Handle drawer item 1 click
            },
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.person_2_alt,
              color: CupertinoColors.systemBlue,
            ),
            title: const Text('Patrol'),
            onTap: () {
              // Handle drawer item 2 click
            },
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.profile_circled,
              color: CupertinoColors.systemBlue,
            ),
            title: const Text('Profile'),
            onTap: () {
              // Handle drawer item 2 click
            },
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.person_badge_minus_fill,
              color: CupertinoColors.systemBlue,
            ),
            title: const Text('Logout'),
            onTap: () {
              // Handle drawer item 2 click
            },
          ),
        ],
      ),
    );
  }
}
