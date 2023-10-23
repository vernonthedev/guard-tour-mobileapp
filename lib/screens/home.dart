// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../widgets/drawer.dart';

// enum MenuAction { nightshift, dayshift, startPatrol }

// class HomePage extends StatefulWidget {
//   final String userInput;

//   const HomePage({Key? key, required this.userInput}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final TextEditingController _searchController = TextEditingController();

//   final List<Map<String?, String?>> dataList = [
//     {
//       'title': 'Guard Name',
//       'name': 'Name 0',
//     },
//     {
//       'title': 'Guard Name',
//       'name': 'Name 1',
//     },
//     {
//       'title': 'Guard Name',
//       'name': 'vernon',
//     },
//     {
//       'title': 'Guard Name',
//       'name': 'mark',
//     },
//     {
//       'title': 'Guard Name',
//       'name': 'john',
//     },
//     {
//       'title': 'Guard Name',
//       'name': 'Name 5',
//     },
//     {
//       'title': 'Guard Name',
//       'name': 'Name 6',
//     },
//     {
//       'title': 'Guard Name',
//       'name': 'Name 7',
//     },
//     {
//       'title': 'Guard Name',
//       'name': 'Name 8',
//     },
//     {
//       'title': 'Guard Name',
//       'name': 'Name 9',
//     },
//     {
//       'title': 'Guard Name',
//       'name': 'bro',
//     },
//     {
//       'title': 'Guard Name',
//       'name': 'Name 11',
//     },
//     {
//       'title': 'Guard Name',
//       'name': 'Name 12',
//     },
//     {
//       'title': 'Guard Name',
//       'name': 'Name 13',
//     },
//     {
//       'title': 'Guard Name',
//       'name': 'Name 14',
//     },
//     {
//       'title': 'Guard Name',
//       'name': 'Name 15',
//     },
//     // Add more items as needed
//   ];
//   //the searched data
//   List<Map<String?, String?>> filteredData = [];

//   @override
//   void initState() {
//     super.initState();
//     // Initialize filteredData with all data initially
//     filteredData = List.from(dataList);
//   }

//   void filterData(String query) {
//     setState(() {
//       filteredData = dataList
//           .where((item) =>
//               (item['name'] ?? '').toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: CupertinoNavigationBar(
//         leading: GestureDetector(
//           onTap: () {
//             _scaffoldKey.currentState?.openDrawer();
//           },
//           child: const Icon(CupertinoIcons.bars),
//         ),
//         middle: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//           decoration: BoxDecoration(
//             color: CupertinoColors.lightBackgroundGray,
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: CupertinoTextField(
//                   controller: _searchController,
//                   placeholder: 'Search',
//                   padding: EdgeInsets.zero,
//                   decoration: const BoxDecoration(
//                     color: CupertinoColors.lightBackgroundGray,
//                   ),
//                   onChanged: (query) {
//                     filterData(query);
//                     debugPrint(query);
//                   },
//                 ),
//               ),
//               CupertinoButton(
//                 onPressed: () {
//                   // Handle search button click
//                   // You can implement the search functionality here
//                 },
//                 minSize: 0,
//                 padding: EdgeInsets.zero,
//                 child: const Icon(
//                   CupertinoIcons.search,
//                   color: CupertinoColors.activeBlue,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         trailing: PopupMenuButton<MenuAction>(
//           elevation: 0,
//           onSelected: (value) {},
//           itemBuilder: (context) {
//             return [
//               const PopupMenuItem<MenuAction>(
//                 value: MenuAction.dayshift,
//                 child: ListTile(
//                   leading: Icon(CupertinoIcons.sun_max),
//                   title: Text("Day Shift"),
//                 ),
//               ),
//               const PopupMenuItem<MenuAction>(
//                 value: MenuAction.nightshift,
//                 child: ListTile(
//                   leading: Icon(CupertinoIcons.moon_fill),
//                   title: Text("Night Shift"),
//                 ),
//               ),
//               const PopupMenuItem<MenuAction>(
//                 value: MenuAction.startPatrol,
//                 child: ListTile(
//                   leading: Icon(CupertinoIcons.arrow_up_right_diamond_fill),
//                   title: Text("Make Patrol"),
//                 ),
//               ),
//             ];
//           },
//         ),
//       ),
//       drawer: const MyDrawer(),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(12.0),
//             child: Text(
//               'List Of Made Patrols', // Replace with your desired text
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _searchController.text.isEmpty
//                   ? dataList
//                       .length // Display all items when the search query is empty
//                   : filteredData
//                       .length, // Use filteredData when a search query is present
//               itemBuilder: (context, index) {
//                 final item = _searchController.text.isEmpty
//                     ? dataList[
//                         index] // Use dataList when the search query is empty
//                     : filteredData[
//                         index]; // Use filteredData when a search query is present
//                 return CustomListTile(
//                   title: item['title'] ?? '',
//                   subtitle1: 'Date',
//                   subtitle2: 'Patrol Time',
//                   trailingIcon: const Icon(
//                     CupertinoIcons.cloud_upload_fill,
//                     color: CupertinoColors.systemBlue,
//                   ),
//                   onTap: () {
//                     final itemName = item['name'] ?? '';
//                     debugPrint("You have pressed $itemName");
//                     // Handle item tap using itemName
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Handle the FAB click event here
//         },
//         child: const Icon(CupertinoIcons.add),
//       ),
//     );
//   }
// }

// class CustomListTile extends StatelessWidget {
//   final String title;
//   final String subtitle1;
//   final String subtitle2;
//   final Widget trailingIcon;
//   final VoidCallback? onTap;

//   const CustomListTile({
//     super.key,
//     required this.title,
//     required this.subtitle1,
//     required this.subtitle2,
//     required this.trailingIcon,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(title),
//       subtitle: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(subtitle1),
//           Text(subtitle2),
//         ],
//       ),
//       trailing: trailingIcon,
//       onTap: onTap,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'home_content.dart';
import 'patrol.dart';
import 'profile.dart';
import 'settings.dart';

class HomePage extends StatefulWidget {
  final String userInput;

  const HomePage({Key? key, required this.userInput}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTabIndex = 0; // Index of the selected tab

  final List<Widget> _pages = [
    const HomePageContent(),
    const PatrolPage(),
    const ProfilePage(userInput: ''),
    const Settings(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedTabIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType
            .fixed, // Use fixed type to display more than three items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.checkmark_shield_fill),
            label: 'Patrols',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_alt_circle_fill),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings_solid),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle the FAB click event here
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
