import 'package:codezilla/modals/patrol_tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// class PatrolPage extends StatelessWidget {
//   const PatrolPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

class PatrolPage extends StatefulWidget {
  const PatrolPage({super.key});

  @override
  _PatrolPageState createState() => _PatrolPageState();
}

class _PatrolPageState extends State<PatrolPage> {
  List<PatrolTags> items = [
    PatrolTags("Tag 1", "ID123", false),
    PatrolTags("Tag 2", "ID123", true),
    PatrolTags("Tag 3", "ID123", false),
    PatrolTags("Tag 4", "ID123", true),
    PatrolTags("Tag 5", "ID123", true),
    PatrolTags("Tag 6", "ID123", false),
    PatrolTags("Tag 7", "ID123", false),
    PatrolTags("Tag 8", "ID123", true),
    PatrolTags("Tag 9", "ID123", true),
    PatrolTags("Tag 10", "ID123", false),
    PatrolTags("Tag 11", "ID123", true),
    PatrolTags("Tag 12", "ID123", false),
    PatrolTags("Tag 13", "ID123", true),
    PatrolTags("Tag 14", "ID123", false),
    PatrolTags("Tag 15", "ID123", true),
    PatrolTags("Tag 16", "ID123", true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patrol Tag Status"),
      ),
      body: ListView.builder(
        itemCount: items.length + 1, // +1 for the submit button
        itemBuilder: (context, index) {
          if (index < items.length) {
            final item = items[index];
            return ListTile(
              leading: const Icon(CupertinoIcons.tag_circle_fill),
              title: GestureDetector(
                onTap: () {
                  // Print the name of the tapped item
                  _showItemDialog(context, item);
                },
                child: Text(item.name),
              ),
              trailing: item.scanned
                  ? const Icon(CupertinoIcons.check_mark_circled,
                      color: Colors.green)
                  : const Icon(CupertinoIcons.circle, color: Colors.red),
            );
          } else {
            // Return the submit button

            const SizedBox(height: 20);
            return ElevatedButton.icon(
              onPressed: () {
                // Handle submit action here
                _showConfirmationDialog(context);
              },
              label: const Text("Submit Patrol Session"),
              icon: const Icon(
                CupertinoIcons.arrow_up_bin_fill,
                size: 25.0, // Adjust the size as needed
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(
                    50.0, 40.0), // Adjust the width and height as needed
              ),
            );
          }
        },
      ),
    );
  }
}

void _showItemDialog(BuildContext context, PatrolTags item) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Tag Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tag Name: ${item.name}"),
            Text("Tag ID: ${item.id}"),
            Text("Status: ${item.scanned ? 'Scanned' : 'Not Scanned'}"),
            const SizedBox(height: 16.0),
            Center(
              child: item.scanned
                  ? const Icon(Icons.check, color: Colors.green, size: 40.0)
                  : const Icon(Icons.cancel, color: Colors.red, size: 40.0),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Close"),
          ),
        ],
      );
    },
  );
}

void _showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text("Upload Patrol Session"),
        content: const Text(
          "Do you want to store and upload the patrol session?",
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: Row(
              children: const [
                Icon(
                  CupertinoIcons.square_arrow_left_fill,
                  size: 40.0,
                ),
                Text(" Store for future Upload"),
              ],
            ),
            onPressed: () {
              // Handle store action here
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Row(
              children: const [
                Icon(
                  CupertinoIcons.cloud_upload_fill,
                  size: 40.0,
                ),
                Text(
                  " Upload to Web System",
                  style: TextStyle(
                    fontSize: 20.0, // Adjust the font size as needed
                  ),
                ),
              ],
            ),
            onPressed: () {
              // Handle upload action here
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Row(
              children: const [
                Icon(
                  CupertinoIcons.xmark_circle_fill,
                  size: 40.0,
                ),
                Text(
                  " Cancel Patrol Session",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            onPressed: () {
              // Handle cancel action here
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _errorConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text("Not All Tags Are Scanned"),
        content: const Text(
          "Please Make sure you scan all tags before you make a submission!",
          style: TextStyle(
            fontSize: 15.0, // Adjust the font size as needed
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: Row(
              children: const [
                Icon(
                  CupertinoIcons.arrow_2_circlepath_circle_fill,
                  size: 40.0,
                ),
                Text(" Scan Missing Tags"),
              ],
            ),
            onPressed: () {
              // Handle upload action here
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Row(
              children: const [
                Icon(
                  CupertinoIcons.xmark_circle_fill,
                  size: 40.0,
                ),
                Text(
                  " Cancel Patrol Session",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            onPressed: () {
              // Handle cancel action here
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
