import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guard_tour/screens/patrol.dart';

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
                print('Starting Patrol Session');
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PatrolPage()));
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
