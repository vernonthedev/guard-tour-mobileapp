import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:guard_tour/functions/decode_token.dart';
import 'package:guard_tour/functions/get_site_tags.dart';

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
                onPressed: () async {
                  //TODO: Post archive details
                  _showArchiveDialog();
                  Navigator.of(context).pushReplacementNamed('/home');
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
                      'Archive Patrol',
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

  void _showArchiveDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Patrol Session Archived'),
          content: Text('The patrol session has been successfully archived.'),
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
