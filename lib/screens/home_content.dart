import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../functions/get_home_patrols.dart';
import '../models/home_model.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  List<HomeDetails> patrols = [];
  bool isNightShift = false;
  TextEditingController searchController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadPatrolsFromHive();
  }

  Future<void> _loadPatrolsFromHive() async {
    patrols = await getHomeDetails();
    patrols.sort((a, b) => b.date.compareTo(a.date));
    setState(() {});
  }

  Future<List<HomeDetails>> _filterPatrols(String query) async {
    // Wait for the future to complete and get the patrols
    List<HomeDetails> allPatrols = await getHomeDetails();

    // Filter patrols based on Guard Name
    List<HomeDetails> filteredPatrols = allPatrols
        .where((patrol) =>
            patrol
                .getSecurityGuardDetails()
                .firstName
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            patrol
                .getSecurityGuardDetails()
                .lastName
                .toLowerCase()
                .contains(query.toLowerCase()))
        .toList();

    return filteredPatrols;
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
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: double.infinity,
              child: CupertinoTextField(
                controller: searchController,
                placeholder: 'Search by Guard Name',
                onChanged: (query) {
                  // Delay the search by a short duration to avoid rapid updates
                  Future.delayed(const Duration(milliseconds: 300), () {
                    setState(() {
                      // Call _filterPatrols with the current query
                      _filterPatrols(query);
                    });
                  });
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
                      // TODO: Implement night shift filter
                    });
                  },
                ),
              ],
            ),
          ),
          const Text(
            "All Site Patrols",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text('Filter by Date'),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<HomeDetails>>(
              future: _filterPatrols(searchController.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No Patrol data available'),
                  );
                } else {
                  // Data has been fetched successfully
                  List<HomeDetails> patrols = snapshot.data!;

                  return ListView.builder(
                    itemCount: patrols.length,
                    itemBuilder: (context, index) {
                      final patrol = patrols[index];
                      return ListTile(
                        title: Text(
                          'Guard Name: ${patrol.getSecurityGuardDetails().firstName} ${patrol.getSecurityGuardDetails().lastName}',
                        ),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2024),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // Perform filtering based on the selected date
        // Update your list of patrols accordingly
        // TODO: Implement your filtering logic
      });
    }
  }
}
