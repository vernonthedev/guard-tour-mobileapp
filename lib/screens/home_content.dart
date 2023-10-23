import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  bool isNightShift = false;
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> patrols = [
    {
      'date': '2023-01-15',
      'time': '08:00 AM',
      'guardName': 'John Doe',
      'uploadStatus': 'Completed',
      'shift': 'Day',
    },
    {
      'date': '2023-01-16',
      'time': '09:30 AM',
      'guardName': 'Jane Smith',
      'uploadStatus': 'Pending',
      'shift': 'Night',
    },
    // Add more patrol data
  ];

  List<Map<String, dynamic>> filteredPatrols = [];

  @override
  void initState() {
    super.initState();
    filteredPatrols = List.from(patrols);
  }

  void filterPatrols() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredPatrols = patrols
          .where((patrol) =>
              patrol['guardName'].toLowerCase().contains(query) &&
              (isNightShift ? patrol['shift'] == 'Night' : true))
          .toList();
    });
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
                  color: CupertinoColors.activeBlue,
                  size: 24,
                ),
                SizedBox(width: 8),
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

          const SizedBox(height: 20), // Adds space between title and search
          Center(
            child: SizedBox(
              width: double.infinity,
              child: CupertinoTextField(
                controller: searchController,
                placeholder: 'Search by Guard Name',
                onChanged: (query) {
                  filterPatrols();
                },
                prefix: const Icon(CupertinoIcons.search),
              ),
            ),
          ),
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
                      isNightShift = value;
                      filterPatrols();
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPatrols.length,
              itemBuilder: (context, index) {
                final patrol = filteredPatrols[index];
                return ListTile(
                  title: Text('Guard Name: ${patrol['guardName']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: ${patrol['date']}'),
                      Text('Time: ${patrol['time']}'),
                      Text('Upload Status: ${patrol['uploadStatus']}'),
                    ],
                  ),
                  trailing: Icon(
                    patrol['uploadStatus'] == 'Completed'
                        ? CupertinoIcons.check_mark_circled
                        : CupertinoIcons.hourglass,
                    color: patrol['uploadStatus'] == 'Completed'
                        ? CupertinoColors.activeGreen
                        : CupertinoColors.systemYellow,
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
