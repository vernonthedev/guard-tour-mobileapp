import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guard_tour/screens/verify_guard.dart';

class StartPatrolPage extends StatelessWidget {
  const StartPatrolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Patrol Session'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton.filled(
              onPressed: () {
                // Add your logic for starting the patrol session here
                debugPrint('Starting Patrol Session with Guard Verification');
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const verifyGuardTag()));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(CupertinoIcons.play_circle_fill),
                  SizedBox(width: 8.0),
                  Text('Start Patrol Session'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
