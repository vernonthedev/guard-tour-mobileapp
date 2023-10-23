// import 'package:codezilla/screens/home.dart';
// import 'package:codezilla/screens/patrol.dart';
// import 'package:codezilla/screens/profile.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class MyDrawer extends StatelessWidget {
//   const MyDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         children: <Widget>[
//           Container(
//             color: Colors.grey,
//             child: const DrawerHeader(
//               child: Text('Guard Tour App'),
//             ),
//           ),
//           ListTile(
//             leading: const Icon(
//               CupertinoIcons.home,
//               color: CupertinoColors.systemBlue,
//             ),
//             title: const Text('Home'),
//             onTap: () {
//               Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   builder: (context) => const HomePage(
//                         userInput: '',
//                       )));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               CupertinoIcons.person_2_alt,
//               color: CupertinoColors.systemBlue,
//             ),
//             title: const Text('Patrol'),
//             onTap: () {
//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => const PatrolPage()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               CupertinoIcons.profile_circled,
//               color: CupertinoColors.systemBlue,
//             ),
//             title: const Text('Profile'),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const ProfilePage(
//                         userInput: '',
//                       )));
//             },
//           ),
//           const Spacer(),
//           ListTile(
//             leading: const Icon(
//               CupertinoIcons.person_badge_minus_fill,
//               color: CupertinoColors.systemBlue,
//             ),
//             title: const Text('Logout'),
//             onTap: () {
//               // Handle drawer item 2 click
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
