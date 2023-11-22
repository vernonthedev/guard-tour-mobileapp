import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:guard_tour/functions/decode_token.dart';
import '../functions/get_site_tags.dart';

class PatrolPage extends StatefulWidget {
  const PatrolPage({Key? key}) : super(key: key);

  @override
  _PatrolPageState createState() => _PatrolPageState();
}

class _PatrolPageState extends State<PatrolPage> {
  UserData? userData;
  int? guardId;

  String? firstScannedTag;
  String? lastScannedTag;
  int totalVerifiedTags = 0;
  DateTime? firstScannedTime;
  DateTime? lastScannedTime;

  String? scannedTag;

  late List<bool> tagScannedStatus;
  List<Tag> siteTags = []; // Initialize as an empty list
  late PatrolPlan patrolPlan; // Define patrolPlan variable

  // Define the set to keep track of scanned tags
  Set<String> _scannedTags = Set<String>();

  @override
  void initState() {
    super.initState();
    tagScannedStatus = <bool>[]; // Initialize as an empty list
    _initUserData(); // Call the function to initialize userData
  }

  Future<void> _initUserData() async {
    // Initialize userData
    userData = await decodeTokenFromSharedPreferences();
    if (userData != null) {
      // If userData is not null, proceed to load the patrol plan
      print('Initialized userData: $userData');
      await _loadPatrolPlan(); // Await _loadPatrolPlan after initializing userData
      setState(() {}); // Trigger a rebuild to reflect the changes
    } else {
      // Handle the case where userData is null
      print('Failed to initialize userData.');
    }
  }

  Future<void> _loadPatrolPlan() async {
    print("============RUNNING============");
    // get the guard id from the decoded token
    if (userData != null) {
      guardId = userData?.guardId;
      print("Loaded guardid");

      if (guardId != null) {
        // Fetch the patrol plan using the guard ID
        PatrolPlan? fetchedPlan = await fetchPatrolPlan(guardId ?? 0);

        if (fetchedPlan != null) {
          print('Fetched Plan: $fetchedPlan');
          setState(() {
            patrolPlan = fetchedPlan;
            tagScannedStatus =
                List.generate(patrolPlan.tags.length, (index) => false);
            siteTags = patrolPlan.tags; // Update siteTags with fetched data
          });
        } else {
          // Handle the case where fetching patrol plan failed
          print('Failed to load patrol plan.');
        }
      } else {
        print("Token is null");
      }
    } else {
      print("Token is empty and not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (siteTags.isEmpty) {
      // Display loading indicator while tags are being loaded
      return const Center(child: CircularProgressIndicator());
    } else {
      // Display the content once tags are loaded
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
                itemCount: siteTags.length,
                itemBuilder: (context, index) {
                  final siteTag = siteTags[index].uid;
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
                  // TODO: Handle the upload patrol action
                },
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
                        fontSize: 16,
                        color: CupertinoColors.activeGreen,
                      ),
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
            // TODO: Add your archive action here
          },
        ),
      );
    }
  }

  Widget _buildScanInput(String siteTag, int index, bool isScanned) {
    return SizedBox(
      width: 70,
      child: TextFormField(
        enabled:
            !tagScannedStatus[index], // Enable input if the tag is not scanned
        onChanged: (value) {
          if (value.isNotEmpty && !tagScannedStatus[index]) {
            bool isTagMatched = siteTags.any((tag) => tag.uid == value);

            // Check if the tag UID has already been scanned
            if (isTagMatched && !_scannedTags.contains(value)) {
              // Update the scanned status and log the time
              setState(() {
                tagScannedStatus[index] = true;
                _scannedTags
                    .add(value); // Add the UID to the set of scanned tags
              });

              // Keep track of the first and last scanned tags
              if (firstScannedTag == null) {
                firstScannedTag = value;
                firstScannedTime = DateTime.now();
                debugPrint('Time of first tag scanned: $firstScannedTime');
              }
              lastScannedTag = value;
              lastScannedTime = DateTime.now();

              // Increment the total number of verified tags
              totalVerifiedTags++;

              // Log the time of the last scanned tag
              debugPrint('Time of last tag scanned: $lastScannedTime');

              // Print debug information
              debugPrint(
                  'Tag $value verified. Total verified tags: $totalVerifiedTags');

              // Check if all tags are scanned
              if (tagScannedStatus.every((scanned) => scanned)) {
                debugPrint(
                    'All tags are scanned. You can perform further actions.');
              }
            } else if (!isTagMatched) {
              // Tag does not match
              debugPrint('Tag $value does not match. Scan another tag.');
            } else {
              // Tag UID has already been scanned
              debugPrint(
                  'Tag $value has already been scanned. Scan another tag.');
            }
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
