import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:guard_tour/functions/decode_token.dart';
import '../functions/get_site_details.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserData? userData;

  late Future<void> _fetchSiteData =
      Future.value(); // Initialize with a completed future
  int _selectedTabIndex = 0; // Index of the selected tab

  // all the profile sections
  final List<Widget> _tabPages = [
    const SiteProfileTab(), // Removed 'const' to allow parameters
    const ShiftTab(shift: 'Night Shift'),
    const ShiftTab(shift: 'Day Shift'),
  ];

  // change state depending on which tab has been selected
  void _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });

    if (_selectedTabIndex == 0) {
      int? siteId; // Declare siteId outside the if statement

      if (userData != null) {
        siteId = userData?.deployedSiteId;
      }

      // Fetch site data when the "Profile" tab is selected
      _fetchSiteData = fetchDataAndStoreInSharedPreferences(
        siteId ?? 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _fetchSiteData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Loading indicator
          } else if (snapshot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('An Error Occurred ${snapshot.error}'),
                backgroundColor: Colors.red,
                duration: const Duration(
                    seconds: 2), // You can adjust the duration as needed
              ),
            );
            return const Center(
              child: Text("An Error Occured! Please Contact Support!"),
            );
          } else {
            // Use the retrieved data to build the UI
            return _tabPages[_selectedTabIndex];
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.building_2_fill),
            label: 'Site Profile',
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
  const SiteProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<dynamic, dynamic>>(
      // Use FutureBuilder to asynchronously retrieve data from SharedPreferences
      future: _getSiteDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the Future is still running, show a loading indicator
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If an error occurs during the Future execution, display an error message
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          // If the Future completes successfully, display the site details
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Site Profile',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _buildListTile(
                            'Name of Site', snapshot.data?['siteName']),
                        _buildListTile('Site ID', snapshot.data?['siteId']),
                        _buildListTile(
                            'Company\'s ID', snapshot.data?['companyId']),
                        _buildListTile(
                            'Site Latitude', snapshot.data?['siteLatitude']),
                        _buildListTile(
                            'Site Longitude', snapshot.data?['siteLongitude']),
                        _buildListTile('Site Phone Number',
                            snapshot.data?['sitePhoneNumber']),
                        _buildListTile('Supervisor\'s Name ',
                            snapshot.data?['supervisorName']),
                        _buildListTile('Supervisor\'s Phone Number',
                            snapshot.data?['supervisorPhoneNumber']),
                        _buildListTile(
                            'Patrol Plan', snapshot.data?['patrolPlanType']),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          // Handle the case where the Future has no data
          return const Text('No data available');
        }
      },
    );
  }

  // Helper function to build ListTiles
  ListTile _buildListTile(String title, dynamic value) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value?.toString() ?? 'N/A'),
    );
  }

  // Function to retrieve site details from SharedPreferences
  Future<Map<String, dynamic>> _getSiteDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Retrieve site details from SharedPreferences
      int siteId = prefs.getInt('siteId') ?? 0;
      String siteName = prefs.getString('siteName') ?? 'Your Deployed Site';
      double siteLatitude = prefs.getDouble('siteLatitude') ?? 0.0;
      double siteLongitude = prefs.getDouble('siteLongitude') ?? 0.0;
      String sitePhoneNumber =
          prefs.getString('sitePhoneNumber') ?? '+256-000-000-000';
      String supervisorName = prefs.getString('supervisorName') ?? 'admin';
      String supervisorPhoneNumber =
          prefs.getString('supervisorPhoneNumber') ?? '+256-000-000-000';
      String patrolPlan = prefs.getString('patrolPlanType') ?? 'patrol plan';
      int companyId = prefs.getInt('companyId') ?? 0;

      // Print retrieved values for debugging
      print('Site Id: $siteId');
      print('Site Name: $siteName');
      print('Latitude: $siteLatitude');
      print('Longitude: $siteLongitude');
      print('Phone No: $sitePhoneNumber');
      print('Supervisor: $supervisorName');
      print('supervisor phone number: $supervisorPhoneNumber');
      print('Patrol Plan: $patrolPlan');
      print('Company Id: $companyId');

      // Return the retrieved values as a map
      return {
        'siteId': siteId,
        'siteName': siteName,
        'siteLatitude': siteLatitude,
        'siteLongitude': siteLongitude,
        'sitePhoneNumber': sitePhoneNumber,
        'supervisorName': supervisorName,
        'patrolPlanType': patrolPlan,
        'supervisorPhoneNumber': supervisorPhoneNumber,
        'companyId': companyId,
      };
    } catch (e) {
      print('Error retrieving site details: $e');
      // Handle any exceptions that occur during the process
      return {}; // Return an empty map in case of an error
    }
  }
}

// shift tab
class ShiftTab extends StatelessWidget {
  final String shift;

  const ShiftTab({Key? key, required this.shift}) : super(key: key);

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
