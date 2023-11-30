/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: home_content.dart
*/

import 'package:guard_tour/screens/patrol.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/patrol_model.dart';

// its stateful bcoz of the over changing list of filtered and unfiltered patrol data
class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  late List<Patrol> patrols;
  // choosing the display all the night shift patrols or day shift
  bool isNightShift = false;
  // setting the search input
  TextEditingController searchController = TextEditingController();

  // A list of the filtered patrols from the api endpoint
  // they come already filtered
  // TODO: Get the filtered patrol data and insert it in this list
  List<Map<String, dynamic>> filteredPatrols = [];

// initialising the night shift and day shift state
  @override
  void initState() {
    super.initState();
    _loadPatrolsFromHive();
  }

  Future<void> _loadPatrolsFromHive() async {
    // Open the Hive box for patrols
    final box = await Hive.openBox<Patrol>('patrols');

    // Load patrols from Hive box
    patrols = box.values.toList();

    // Sort patrols by date
    patrols.sort((a, b) => b.scannedDate.compareTo(a.scannedDate));

    setState(() {}); // Trigger a rebuild with the loaded patrols
  }

  @override
  void dispose() {
    // Close off the box opened for the patrols so that we save on memory in our application
    var patrolBox = Hive.box('patrols');
    if (patrolBox.isOpen) {
      patrolBox.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50), // Adds space at the top
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Icon(
                  CupertinoIcons.xmark_shield_fill,
                  color: Color(0xFF2E8B57),
                  size: 24,
                ),
                SizedBox(width: 8),
                // THE HOME TITLE WIDGET
                Text(
                  'Guard Tour Home',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // THE SEARCH BOX WIDGET
          const SizedBox(height: 20), // Adds space between title and search
          Center(
            child: SizedBox(
              width: double.infinity,
              child: CupertinoTextField(
                controller: searchController,
                placeholder: 'Search by Guard Name',
                onChanged: (query) {
                  // when we start entering the search text, then do
                  //TODO: a live search
                },
                prefix: const Icon(CupertinoIcons.search),
              ),
            ),
          ),
          // THE NIGHT SHIFT AND DAY SHIFT SWITCH WIDGET
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Night Shift',
                  style: TextStyle(fontSize: 18),
                ),
                CupertinoSwitch(
                  value: isNightShift,
                  onChanged: (value) {
                    setState(() {
                      // filter and display the required night or day shift data
                      // depending on the switch value
                      isNightShift = value;
                      //TODO: lIVESEARCH HERE
                    });
                  },
                ),
              ],
            ),
          ),
          // THE LIST WIDGET DISPLAYING THE PATROL DATA
          Expanded(
            child: ListView.builder(
              itemCount: patrols.length,
              itemBuilder: (context, index) {
                final patrol = patrols[index];
                return ListTile(
                  title: Text('Guard Name: ${patrol.guardName}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Date: ${patrol.scannedDate.toString()}'), // Update this based on your Patrol model
                      Text('Time: ${patrol.startTime} - ${patrol.endTime}'),
                      // Text('Upload Status: ${patrol.uploadStatus}'),
                    ],
                  ),
                  // trailing: Icon(
                  //   patrol.uploadStatus == 'Completed'
                  //       ? CupertinoIcons.check_mark_circled
                  //       : CupertinoIcons.hourglass,
                  //   color: patrol.uploadStatus == 'Completed'
                  //       ? CupertinoColors.activeGreen
                  //       : CupertinoColors.systemYellow,
                  // ),
                );
              },
            ),
          ),
        ],
      ),
      // FLOATING BUTTON TO START PATROL
      floatingActionButton: CupertinoButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              CupertinoIcons.add_circled_solid,
              color: CupertinoColors.activeBlue,
            ),
            SizedBox(width: 10),
            Text(
              'Start Patrol',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const PatrolPage()));
        },
      ),
    );
  }
}
