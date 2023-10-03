import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

enum MenuAction { nightshift, dayshift }

class HomePage extends StatelessWidget {
  final String userInput;

  HomePage({Key? key, required this.userInput}) : super(key: key);

  // Define a GlobalKey for the ScaffoldState
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
      appBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () {
            // Open the drawer using the GlobalKey
            _scaffoldKey.currentState?.openDrawer();
          },
          child: const Icon(CupertinoIcons.bars),
        ),
        middle: const Text('Home Screen'),
        trailing: PopupMenuButton(
          onSelected: (value) {},
          itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
                value: MenuAction.dayshift,
                child: Text("Day Shift"),
              ),
              PopupMenuItem<MenuAction>(
                value: MenuAction.dayshift,
                child: Text("Night Shift"),
              ),
            ];
          },
        ),
      ),
      drawer: const MyDrawer(),
      body: const Center(
        child: Text("Home screen"),
      ),
    );
  }
}
