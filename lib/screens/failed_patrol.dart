import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FailedPatrol extends StatelessWidget {
  const FailedPatrol({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          const SizedBox(
            height: 50,
            width: 50,
          ),
          const Text(
            'Patrol Submission',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 50,
            width: 50,
          ),
          const Text(
            'Patrol Submission Failed!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text("Details: "),
          const Text("Guard ID: "),
          const Text("Date: "),
          const Text("Time: "),
          const SizedBox(
            height: 20,
          ),
          CupertinoButton(
              child: const Text('Resubmit'),
              onPressed: () async {
                //TODO: Implement Reupload of patrol
              }),
          const SizedBox(
            height: 20,
          ),
          CupertinoButton(
              child: const Text('Save Patrol'),
              onPressed: () async {
                //TODO: Implement Save Failed Patrol
              })
        ]));
  }
}
