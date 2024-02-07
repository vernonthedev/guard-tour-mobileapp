import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String?> showInputDialog(BuildContext context) async {
  String? userInput;

  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the content horizontally
              children: const <Widget>[
                Icon(
                  CupertinoIcons.tag_solid,
                  size: 30.0,
                  color: Colors.green, // Change the color to green
                ),
                SizedBox(width: 10.0),
                Text(
                  'Scan Your ID Tag Here',
                  style: TextStyle(color: Colors.black), // Set text color
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                onChanged: (value) {
                  userInput = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Enter your input',
                  icon: Icon(CupertinoIcons
                      .person_2_square_stack_fill), // Icon for the input field
                ),
              ),
            ),
            CupertinoButton(
              onPressed: () {
                Navigator.pop(context, userInput); // Close the dialog
              },
              color: const Color(0xFF2E8B57),
              child: const Text('OK'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}
