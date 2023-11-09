/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: home.dart
*/

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'home_content.dart';
import 'patrol.dart';
import 'profile.dart';
import 'settings.dart';

// stateful because it handles the switching between the diff
// bottom navigation sections
class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Index of the selected tab
  int _selectedTabIndex = 0;

  // all the navigation pages
  final List<Widget> _pages = [
    const HomePageContent(),
    PatrolPage(),
    const ProfilePage(),
    const Settings(),
  ];

  // when we press a tab, select its appropriate page
  void _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedTabIndex], // Display the selected page
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTabIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType
              .fixed, // Use fixed type to display more than three items
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.checkmark_shield_fill),
              label: 'Patrol',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_alt_circle_fill),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings_solid),
              label: 'Settings',
            ),
          ],
        ));
  }
}
