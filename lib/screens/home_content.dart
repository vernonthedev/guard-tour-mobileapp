import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../functions/get_home_patrols.dart';
import '../models/home_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  List<HomeDetails> patrols = [];

  // DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadPatrolsFromHive();
  }

  Future<void> _loadPatrolsFromHive() async {
    List<HomeDetails> allPatrols = await getHomeDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          FutureBuilder<String?>(
            future: _getSiteName(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                String siteName = snapshot.data ??
                    'Guard Tour Home'; // Use a default value if site name is not available
                return Text(
                  siteName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 30),
          CupertinoButton(
            onPressed: () {},
            color: const Color(0xFF2E8B57),
            child: const Text("Submit All"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: patrols.length,
              itemBuilder: (context, index) {
                final patrol = patrols[index];
                String formattedDate = DateFormat('MMM dd, yyyy')
                    .format(DateTime.parse(patrol.date));
                int listNumber = index + 1;
                return ListTile(
                  leading: Text('$listNumber'),
                  title: Text(
                    'Guard Name: ${patrol.getSecurityGuardDetails().firstName} ${patrol.getSecurityGuardDetails().lastName}',
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: $formattedDate'),
                      Text('Time: ${patrol.startTime} - ${patrol.endTime}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Get the site name sharedpreferences
Future<String?> _getSiteName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? siteData = prefs.getString('siteData');
  if (siteData != null) {
    Map<String, dynamic> decodedData = jsonDecode(siteData);
    return decodedData['name']; // Accessing the 'name' field directly
  } else {
    return null;
  }
}
