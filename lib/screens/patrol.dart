/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: patrol.dart
*/

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// stful because most logic is here for scanning the tags during a patrol session
class PatrolPage extends StatefulWidget {
  const PatrolPage({super.key});

  @override
  _PatrolPageState createState() => _PatrolPageState();
}

class _PatrolPageState extends State<PatrolPage> {
  List<bool> tagScannedStatus =
      // Initialize all tags as not scanned
      List.generate(50, (index) => false);

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
                  // on every entry to the scan input for the tag list card
                  // state of isScanned var is changed to show the relevant scan status
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
                          // embedded input in the list, for scanning option for the tags
                          _buildScanInput(siteTag, index, isScanned),
                          const SizedBox(width: 8),
                          Text(isScanned ? 'Scanned' : 'Not Scanned'),
                          const SizedBox(width: 8),
                          // icon changing according to scanning state for each list tag
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
                //TODO: Handle the upload patrol action
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
        child: const Icon(Icons.archive),
        onPressed: () {
          //TODO: Add your archive action here
        },
      ),
    );
  }

  // a realtime input that will be used as a scanner for the tag
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

  // a realtime icon that will be used as a scanner for the tag
  Widget _buildScanStatusIcon(bool isScanned) {
    return Icon(
      isScanned ? CupertinoIcons.check_mark : CupertinoIcons.xmark,
      color:
          isScanned ? CupertinoColors.systemGreen : CupertinoColors.systemRed,
    );
  }

// tag description card leading section for the text and ending section for scan status
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
