import 'package:flutter/material.dart';

Future<String?> showInputDialog(BuildContext context) async {
  String? userInput;

  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: <Widget>[
            const Icon(
              Icons.scanner, // Icon for tag scanning
              size: 24.0,
              color: Colors.blue, // Customize the color
            ),
            const SizedBox(width: 10.0),
            const Text('Scan Your ID Tag Here'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                userInput = value;
              },
              decoration: const InputDecoration(
                labelText: 'Enter your input',
                icon: Icon(Icons.person), // Icon for the input field
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(userInput);
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
