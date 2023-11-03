import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PatrolPage extends StatefulWidget {
  @override
  _PatrolPageState createState() => _PatrolPageState();
}

class _PatrolPageState extends State<PatrolPage> {
  List<bool> tagScannedStatus =
      List.generate(50, (index) => false); // Initialize all tags as not scanned

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Icon(
                    CupertinoIcons.checkmark_shield_fill,
                    color: CupertinoColors.activeBlue,
                    size: 40,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Make Patrol',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Text(
            'Please Scan The Tags And Verify For Upload..',
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 50,
              itemBuilder: (context, index) {
                final siteTag = "Site Tag $index";
                final isScanned = tagScannedStatus[index];

                return GestureDetector(
                  onTap: () {
                    _showTagDescriptionDialog(siteTag, isScanned);
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(siteTag),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _buildScanInput(siteTag, index, isScanned),
                          const SizedBox(width: 8),
                          Text(isScanned ? 'Scanned' : 'Not Scanned'),
                          const SizedBox(width: 8),
                          _buildScanStatusIcon(isScanned),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: CupertinoButton(
              onPressed: () {
                // Handle the upload patrol action
              },
              // color: CupertinoColors.activeBlue,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Icon(
                    CupertinoIcons.cloud_upload_fill,
                    color: CupertinoColors.activeGreen,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Upload Patrol',
                    style: TextStyle(
                        fontSize: 16, color: CupertinoColors.activeGreen),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
            // CupertinoIcons.archivebox_fill,
            // color: CupertinoColors.activeOrange,
            Icons.archive),
        onPressed: () {
          // Add your archive action here
          // This is what happens when the button is pressed.
        },
      ),
    );
  }

  Widget _buildScanInput(String siteTag, int index, bool isScanned) {
    return SizedBox(
      width: 70,
      child: TextFormField(
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              tagScannedStatus[index] = true;
            });
          }
        },
        decoration: InputDecoration(
          labelText: 'Scan',
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isScanned
                  ? CupertinoColors.systemGreen
                  : CupertinoColors.systemRed,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScanStatusIcon(bool isScanned) {
    return Icon(
      isScanned ? CupertinoIcons.check_mark : CupertinoIcons.xmark,
      color:
          isScanned ? CupertinoColors.systemGreen : CupertinoColors.systemRed,
    );
  }

  void _showTagDescriptionDialog(String siteTag, bool isScanned) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tag Description - $siteTag'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Status: ${isScanned ? 'Scanned' : 'Not Scanned'}'),
              // You can add more details here
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: PatrolPage(),
      ),
    ),
  );
}
