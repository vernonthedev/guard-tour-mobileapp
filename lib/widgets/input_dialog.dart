import 'package:flutter/material.dart';

Future<String?> showInputDialog(BuildContext context) async {
  String? userInput;
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Scan Your ID Tag Here'),
        content: TextField(
          onChanged: (value) {
            userInput = value;
          },
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
