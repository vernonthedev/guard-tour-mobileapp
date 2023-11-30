import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:guard_tour/functions/decode_token.dart';
import 'package:guard_tour/functions/get_site_tags.dart';
import 'package:guard_tour/functions/upload_patrol.dart';
import 'package:guard_tour/models/boxes.dart';
import 'package:guard_tour/models/patrol_model.dart';
import 'package:guard_tour/screens/home.dart';
import 'package:intl/intl.dart';

class PatrolPage extends StatefulWidget {
  const PatrolPage({Key? key}) : super(key: key);

  @override
  State<PatrolPage> createState() => _PatrolPageState();
}

class _PatrolPageState extends State<PatrolPage> {
  UserData? userData;
  int? guardId;

  String? firstScannedTag;
  String? lastScannedTag;
  int totalVerifiedTags = 0;
  DateTime? firstScannedTime;
  DateTime? lastScannedTime;

  late List<bool> tagScannedStatus;
  List<Tag> siteTags = [];
  late PatrolPlan patrolPlan;

  Set<String> _scannedTags = Set<String>();

  @override
  void initState() {
    super.initState();
    tagScannedStatus = <bool>[];
    _initUserData();
  }

  Future<void> _initUserData() async {
    userData = await decodeTokenFromSharedPreferences();
    if (userData != null) {
      print('Initialized userData: $userData');
      await _loadPatrolPlan();
      setState(() {});
    } else {
      print('Failed to initialize userData.');
    }
  }

  Future<void> _loadPatrolPlan() async {
    print("============RUNNING============");
    if (userData != null) {
      guardId = userData?.guardId;
      print("Loaded guardid");

      if (guardId != null) {
        PatrolPlan? fetchedPlan = await fetchPatrolPlan(guardId ?? 0);

        if (fetchedPlan != null) {
          print('Fetched Plan: $fetchedPlan');
          setState(() {
            patrolPlan = fetchedPlan;
            tagScannedStatus =
                List.generate(patrolPlan.tags.length, (index) => false);
            siteTags = patrolPlan.tags;
          });
        } else {
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
      return const Center(child: CircularProgressIndicator());
    } else {
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
                  final siteTag = "Scan Tag Here";
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
                onPressed: () async {
                  //TODO:
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
        floatingActionButton: CupertinoButton(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                CupertinoIcons.cloud_download_fill,
                color: CupertinoColors.systemRed,
              ),
              SizedBox(width: 10),
              Text(
                'Archive',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          onPressed: () {
            //TODO: Save the made patrol to db
            _showArchiveDialog();
            print("Patrol has been archived");
          },
        ),
      );
    }
  }

  Widget _buildScanInput(String siteTag, int index, bool isScanned) {
    return SizedBox(
      width: 70,
      child: TextFormField(
        enabled: !tagScannedStatus[index],
        onChanged: (value) {
          if (value.isNotEmpty && !tagScannedStatus[index]) {
            bool isTagMatched = siteTags.any((tag) => tag.uid == value);

            if (isTagMatched && !_scannedTags.contains(value)) {
              setState(() {
                tagScannedStatus[index] = true;
                _scannedTags.add(value);
              });

              if (firstScannedTag == null) {
                firstScannedTag = value;
                firstScannedTime = DateTime.now();
                debugPrint('Time of first tag scanned: $firstScannedTime');
              }
              lastScannedTag = value;
              lastScannedTime = DateTime.now();

              totalVerifiedTags++;

              debugPrint('Time of last tag scanned: $lastScannedTime');
              debugPrint(
                  'Tag $value verified. Total verified tags: $totalVerifiedTags');

              if (tagScannedStatus.every((scanned) => scanned)) {
                debugPrint(
                    'All tags are scanned. You can perform further actions.');
              }
            } else if (!isTagMatched) {
              debugPrint('Tag $value does not match. Scan another tag.');
            } else {
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

  void uploadPatrol() async {
    // Ensure that at least one tag has been scanned
    if (_scannedTags.isNotEmpty) {
      // Use the date when the first scan was made
      String date = DateFormat("yyyy-MM-dd").format(firstScannedTime!);

      // Format the startTime and endTime
      String startTime = DateFormat("HH:mm").format(firstScannedTime!);
      String endTime = DateFormat("HH:mm").format(lastScannedTime!);

      // Call the function to make the POST request
      await postData(
        date,
        startTime,
        endTime,
        guardId ?? 0,
      );

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Patrol Uploaded Successfully'),
            content:
                const Text('The patrol session has been successfully uploaded'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomePage()));
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Display a message if no tags have been scanned
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('No tags have been scanned Patrol was no Uploaded'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _showArchiveDialog() async {
    // Ensure that at least one tag has been scanned
    if (_scannedTags.isNotEmpty) {
      // Use the date when the first scan was made
      String date = DateFormat("yyyy-MM-dd").format(firstScannedTime!);

      // Format the startTime and endTime
      String startTime = DateFormat("HH:mm").format(firstScannedTime!);
      String endTime = DateFormat("HH:mm").format(lastScannedTime!);

      // Archive the patrol session in Hive
      await archivePatrol(
        userData?.firstName,
        guardId,
        startTime,
        endTime,
        patrolPlan.shiftId,
      );

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Patrol Archived Successfully'),
            content: const Text(
                'The patrol session has been successfully archived.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomePage()));
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Display a message if no tags have been scanned
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'No tags have been scanned. And No Archiving Took Place'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future archivePatrol(guardName, guardId, startTime, endTime, shiftId) async {
    final patrol = Patrol()
      ..guardName = guardName
      ..guardId = guardId
      ..scannedDate = DateTime.now()
      ..startTime = startTime
      ..endTime = endTime
      ..shiftId = shiftId;
    final box = Boxes.getPatrols();
    box.add(patrol);
  }
}
