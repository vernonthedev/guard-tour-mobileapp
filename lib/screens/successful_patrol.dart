import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

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
              'Patrol Submitted Successfully',
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
                color: const Color(0xFF2E8B57),
                child: const Text('OK'),
                onPressed: () async {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                })
          ]),
    );
  }
}
