/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: home_content.dart
*/

import 'package:guard_tour/screens/patrol.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../functions/get_home_patrols.dart';
import '../models/home_model.dart';

// its stateful bcoz of the over changing list of filtered and unfiltered patrol data
class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  List<HomeDetails> patrols = [];
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
    patrols = await getHomeDetails();

    // Sort patrols by date
    patrols.sort((a, b) => b.date.compareTo(a.date));

    setState(() {}); // Trigger a rebuild with the loaded patrols
  }

  @override
  void dispose() {
    // Close off the box opened for the patrols so that we save on memory in our application
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (patrols == null) {
      // Handle the case where patrols is not yet initialized
      return const Center(child: Text("No Available Patrols"));
    } else {
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
            const Text(
              "All Site Patrols",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: FutureBuilder<List<HomeDetails>>(
                future: getHomeDetails(), // Call your method to fetch data
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No Patrol data available'));
                  } else {
                    // Data has been fetched successfully
                    patrols = snapshot.data!;

                    return ListView.builder(
                      itemCount: patrols.length,
                      itemBuilder: (context, index) {
                        final patrol = patrols[index];
                        return ListTile(
                          title: Text('Guard Name: ${patrol.securityGuardId}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date: ${patrol.date}'),
                              Text(
                                  'Time: ${patrol.startTime} - ${patrol.endTime}'),
                              // Add more properties as needed
                            ],
                          ),
                          trailing: const Icon(
                            CupertinoIcons.hourglass,
                            color: CupertinoColors.systemYellow,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
