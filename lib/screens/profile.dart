import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<String?> _fetchSiteProfile;

  @override
  void initState() {
    super.initState();
    _fetchSiteProfile = _getSiteProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String?>(
        future: _fetchSiteProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('An Error Occurred ${snapshot.error}'),
            );
          } else {
            return SiteProfileList(siteProfileData: snapshot.data);
          }
        },
      ),
    );
  }
}

class SiteProfileList extends StatelessWidget {
  final String? siteProfileData;

  const SiteProfileList({Key? key, required this.siteProfileData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (siteProfileData == null) {
      return const Text('No data available');
    }

    // Parse the JSON string to extract site profile details
    Map<String, dynamic> profileData = jsonDecode(siteProfileData!);
    String name = profileData['name'];
    String siteID = profileData['siteID'];
    List<Map<String, dynamic>> tags =
        List<Map<String, dynamic>>.from(profileData['tags']);

    return Material(
      // Wrap the ListView in a Material widget
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Site Details",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildListTile('Name of Site', name),
            _buildListTile('Site ID', siteID),
            ListTile(
              title: const Text(
                'Site Tags:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: tags.map((tag) {
                  return Text(tag['uid'].toString());
                }).toList(),
              ),
            ),

            // Display other details as needed
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile(String title, String value) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(value),
    );
  }
}

Future<String?> _getSiteProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? siteData = prefs.getString('siteData');
  if (siteData != null) {
    Map<String, dynamic> siteContent = jsonDecode(siteData);
    String name = siteContent['name'];
    String siteID = siteContent['tagId'];
    List<Map<String, dynamic>> tags =
        List<Map<String, dynamic>>.from(siteContent['tags']);

    Map<String, dynamic> profileData = {
      'name': name,
      'siteID': siteID,
      'tags': tags,
    };

    String profileDataJson = jsonEncode(profileData);
    return profileDataJson;
  } else {
    return null;
  }
}
