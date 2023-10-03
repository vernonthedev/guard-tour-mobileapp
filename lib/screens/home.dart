import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

enum MenuAction { nightshift, dayshift, startPatrol }

class HomePage extends StatelessWidget {
  final String userInput;

  HomePage({Key? key, required this.userInput}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      'name': 'Name 2',
    },
    {
      'title': 'Guard Name',
      'name': 'Name 3',
    },
    {
      'title': 'Guard Name',
      'name': 'Name 4',
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
      'name': 'Name 10',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: const Icon(CupertinoIcons.bars),
        ),
        middle: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: CupertinoColors.lightBackgroundGray,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              const Expanded(
                child: CupertinoTextField(
                  placeholder: 'Search',
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: CupertinoColors.lightBackgroundGray,
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  // Handle search button click
                  // You can implement the search functionality here
                },
                minSize: 0,
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.search,
                  color: CupertinoColors.activeBlue,
                ),
              ),
            ],
          ),
        ),
        trailing: PopupMenuButton<MenuAction>(
          elevation: 0,
          onSelected: (value) {},
          itemBuilder: (context) {
            return [
              const PopupMenuItem<MenuAction>(
                value: MenuAction.dayshift,
                child: ListTile(
                  leading: Icon(CupertinoIcons.sun_max),
                  title: Text("Day Shift"),
                ),
              ),
              const PopupMenuItem<MenuAction>(
                value: MenuAction.nightshift,
                child: ListTile(
                  leading: Icon(CupertinoIcons.moon_fill),
                  title: Text("Night Shift"),
                ),
              ),
              const PopupMenuItem<MenuAction>(
                value: MenuAction.startPatrol,
                child: ListTile(
                  leading: Icon(CupertinoIcons.arrow_up_right_diamond_fill),
                  title: Text("Make Patrol"),
                ),
              ),
            ];
          },
        ),
      ),
      drawer: const MyDrawer(),
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
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final item = dataList[index];
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
    );
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
