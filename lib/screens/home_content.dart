import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String?, String?>> dataList = [
    {
      'title': 'Guard Name',
      'name': 'Name 0',
    },
    {
      'title': 'Guard Name',
      'name': 'Name 1',
    },
    {
      'title': 'Guard Name',
      'name': 'vernon',
    },
    {
      'title': 'Guard Name',
      'name': 'mark',
    },
    {
      'title': 'Guard Name',
      'name': 'john',
    },
    {
      'title': 'Guard Name',
      'name': 'Name 5',
    },
    {
      'title': 'Guard Name',
      'name': 'Name 6',
    },
    {
      'title': 'Guard Name',
      'name': 'Name 7',
    },
    {
      'title': 'Guard Name',
      'name': 'Name 8',
    },
    {
      'title': 'Guard Name',
      'name': 'Name 9',
    },
    {
      'title': 'Guard Name',
      'name': 'bro',
    },
    {
      'title': 'Guard Name',
      'name': 'Name 11',
    },
    {
      'title': 'Guard Name',
      'name': 'Name 12',
    },
    {
      'title': 'Guard Name',
      'name': 'Name 13',
    },
    {
      'title': 'Guard Name',
      'name': 'Name 14',
    },
    {
      'title': 'Guard Name',
      'name': 'Name 15',
    },
    // Add more items as needed
  ];
  //the searched data
  List<Map<String?, String?>> filteredData = [];

  @override
  void initState() {
    super.initState();
    // Initialize filteredData with all data initially
    filteredData = List.from(dataList);
  }

  void filterData(String query) {
    setState(() {
      filteredData = dataList
          .where((item) =>
              (item['name'] ?? '').toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'List Of Made Patrols', // Replace with your desired text
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _searchController.text.isEmpty
                    ? dataList
                        .length // Display all items when the search query is empty
                    : filteredData
                        .length, // Use filteredData when a search query is present
                itemBuilder: (context, index) {
                  final item = _searchController.text.isEmpty
                      ? dataList[
                          index] // Use dataList when the search query is empty
                      : filteredData[
                          index]; // Use filteredData when a search query is present
                  return CustomListTile(
                    title: item['title'] ?? '',
                    subtitle1: 'Date',
                    subtitle2: 'Patrol Time',
                    trailingIcon: const Icon(
                      CupertinoIcons.cloud_upload_fill,
                      color: CupertinoColors.systemBlue,
                    ),
                    onTap: () {
                      final itemName = item['name'] ?? '';
                      debugPrint("You have pressed $itemName");
                      // Handle item tap using itemName
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Handle the FAB click event here
          },
          child: const Icon(CupertinoIcons.add),
        ));
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle1;
  final String subtitle2;
  final Widget trailingIcon;
  final VoidCallback? onTap;

  const CustomListTile({
    super.key,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.trailingIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle1),
          Text(subtitle2),
        ],
      ),
      trailing: trailingIcon,
      onTap: onTap,
    );
  }
}
