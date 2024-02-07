import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../functions/get_home_patrols.dart';
import '../models/home_model.dart';
import 'package:intl/intl.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  DateTime? selectedDate; // Initialize as null
  List<HomeDetails> patrols = [];
  TextEditingController searchController = TextEditingController();
  // DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadPatrolsFromHive();
  }

  Future<void> _loadPatrolsFromHive() async {
    List<HomeDetails> allPatrols = await getHomeDetails();
    List<HomeDetails> filteredPatrols = List.from(allPatrols);

    if (selectedDate != null) {
      // Apply date filter
      filteredPatrols = filteredPatrols
          .where((patrol) =>
              patrol.date == selectedDate?.toLocal().toString().split(' ')[0])
          .toList();
    }

    if (searchController.text.isNotEmpty) {
      // Apply search filter
      filteredPatrols = filteredPatrols
          .where((patrol) =>
              patrol
                  .getSecurityGuardDetails()
                  .firstName
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()) ||
              patrol
                  .getSecurityGuardDetails()
                  .lastName
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()) ||
              ('${patrol.getSecurityGuardDetails().firstName} ${patrol.getSecurityGuardDetails().lastName}')
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()))
          .toList();
    }

    setState(() {
      patrols = filteredPatrols;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
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
          const SizedBox(height: 50),
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
                  value: false,
                  onChanged: (value) {
                    setState(() {
                      // TODO: Implement night shift filter
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: searchController,
              decoration:
                  const InputDecoration(labelText: 'Search by Guard Name'),
              onChanged: (query) {
                _loadPatrolsFromHive();
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: const Text('Filter by Date'),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ??
          DateTime.now(), // Use DateTime.now() if selectedDate is null
      firstDate: DateTime(2022),
      lastDate: DateTime(2024),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
      _loadPatrolsFromHive();
    }
  }
}
