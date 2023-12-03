/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: home_content.dart
*/

import 'package:guard_tour/screens/patrol.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/boxes.dart';
import '../models/patrol_model.dart';

// its stateful bcoz of the over changing list of filtered and unfiltered patrol data
class ArchivedPatrols extends StatefulWidget {
  const ArchivedPatrols({Key? key}) : super(key: key);

  @override
  _ArchivedPatrolsState createState() => _ArchivedPatrolsState();
}

class _ArchivedPatrolsState extends State<ArchivedPatrols> {
  late List<Patrol> patrols;
  // choosing the display all the night shift patrols or day shift
  bool isNightShift = false;
  // setting the search input
  TextEditingController searchController = TextEditingController();

// initialising the night shift and day shift state
  @override
  void initState() {
    super.initState();
    _loadPatrolsFromHive();
  }

  Future<void> _loadPatrolsFromHive() async {
    // Load patrols from Hive box
    patrols = Boxes.getPatrols.values.toList();

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
    if (patrols == null) {
      // Handle the case where patrols is not yet initialized
      return const Center(child: CircularProgressIndicator());
    }

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
                  'All Archived Patrols',
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
          // THE NIGHT SHIFT AND DAY SHIFT SWITCH WIDGET
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
                  trailing: const Icon(
                    CupertinoIcons.hourglass,
                    color: CupertinoColors.systemYellow,
                  ),
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
