import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedTabIndex = 0; // Index of the selected tab

  final List<Widget> _tabPages = [
    SiteProfileTab(),
    const ShiftTab(shift: 'Night Shift'),
    const ShiftTab(shift: 'Day Shift'),
  ];

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

class SiteProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

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
