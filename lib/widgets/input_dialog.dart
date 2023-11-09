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
              children: const <Widget>[
                Icon(
                  Icons.scanner, // Icon for tag scanning
                  size: 24.0,
                  color: Colors.blue, // Customize the color
                ),
                SizedBox(width: 10.0),
                Text('Scan Your ID Tag Here'),
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
                  icon: Icon(Icons.person), // Icon for the input field
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, userInput); // Close the dialog
              },
              child: const Text('OK'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}
