import 'package:flutter/material.dart';

import '../functions/get_site_details.dart';
import '../models/site_details_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final Future<SiteDetails?> _fetchSiteData;

  @override
  void initState() {
    super.initState();
    _fetchSiteData = fetchSiteDetails();
    _fetchSiteData.then((siteDetails) {
      // Ensure that the data is fetched before navigating to SiteProfileList
      if (mounted && siteDetails != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => SiteProfileList(siteDetails: siteDetails),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<SiteDetails?>(
        future: _fetchSiteData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Loading indicator
          } else if (snapshot.hasError) {
            return Center(
              child: Text('An Error Occurred ${snapshot.error}'),
            );
          } else {
            // Use the retrieved data to build the UI
            return SiteProfileList(siteDetails: snapshot.data);
          }
        },
      ),
    );
  }
}

class SiteProfileList extends StatelessWidget {
  final SiteDetails? siteDetails;

  const SiteProfileList({Key? key, required this.siteDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (siteDetails == null) {
      return const Text('No data available');
    }
    return Material(
      // Wrap the ListView in a Material widget
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildListTile('Name of Site', siteDetails?.name),
            _buildListTile('Site ID', siteDetails?.id),
            _buildListTile('Company\'s ID', siteDetails?.companyId),
            _buildListTile('Site Latitude', siteDetails?.latitude),
            _buildListTile('Site Longitude', siteDetails?.longitude),
            _buildListTile('Site Phone Number', siteDetails?.phoneNumber),
            _buildListTile('Supervisor\'s Name', siteDetails?.supervisorName),
            _buildListTile('Supervisor\'s Phone Number',
                siteDetails?.supervisorPhoneNumber),
            _buildListTile('Patrol Plan', siteDetails?.patrolPlanType),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile(String title, dynamic value) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value?.toString() ?? 'N/A'),
    );
  }
}
