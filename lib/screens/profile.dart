/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: profile.dart
*/

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedTabIndex = 0; // Index of the selected tab

  // all the profile sections
  final List<Widget> _tabPages = [
    const SiteProfileTab(),
    const ShiftTab(shift: 'Night Shift'),
    const ShiftTab(shift: 'Day Shift'),
  ];
  // change state depending on which tab has been selected
  void _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabPages[_selectedTabIndex], // Display the selected tab page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType
            .fixed, // Use fixed type to display more than three items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.building_2_fill),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.moon_stars_fill),
            label: 'Night Shift',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.sun_haze_fill),
            label: 'Day Shift',
          ),
        ],
      ),
    );
  }
}

// the site profile widget that displays all about the site where the
// deployed logged in
class SiteProfileTab extends StatelessWidget {
  const SiteProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Site Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // TODO: Get the site profile data from the api
                  ListTile(
                    title: Text('Name of Site'),
                    subtitle: Text('Your Site Name'),
                  ),
                  ListTile(
                    title: Text('District'),
                    subtitle: Text('Your District Name'),
                  ),
                  ListTile(
                    title: Text('LC1 Zone'),
                    subtitle: Text('Your LC1 Zone'),
                  ),
                  ListTile(
                    title: Text('Number of Guards'),
                    subtitle: Text('12 Guards'),
                  ),
                  ListTile(
                    title: Text('Total Notifications'),
                    subtitle: Text('25 Notifications'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// shift tab
class ShiftTab extends StatelessWidget {
  final String shift;

  const ShiftTab({super.key, required this.shift});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            shift,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          // TODO: Get the guard shift data from the api
          const ListTile(
            title: Text('Start Time'),
            subtitle: Text('8:00 PM'),
          ),
          const ListTile(
            title: Text('End Time'),
            subtitle: Text('8:00 AM'),
          ),
          const ListTile(
            title: Text('List of Guards'),
            subtitle: Text('Guard 1, Guard 2, Guard 3, ...'),
          ),
        ],
      ),
    );
  }
}
