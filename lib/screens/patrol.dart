import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:guard_tour/functions/upload_patrol.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PatrolPage extends StatefulWidget {
  const PatrolPage({Key? key}) : super(key: key);

  @override
  State<PatrolPage> createState() => _PatrolPageState();
}

class _PatrolPageState extends State<PatrolPage> {
  late Future<void> _userDataFuture;
  List<Map<String, dynamic>>? siteTags;
  late List<bool> tagScannedStatus;
  final Set<String> _scannedTags = <String>{};

  @override
  void initState() {
    super.initState();
    _userDataFuture = _initUserData();
  }

  Future<void> _initUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? siteDataString = prefs.getString('siteData');
    if (siteDataString != null) {
      Map<String, dynamic> siteData = jsonDecode(siteDataString);
      siteTags = List<Map<String, dynamic>>.from(siteData['tags']);
      tagScannedStatus = List<bool>.filled(siteTags!.length, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            if (siteTags == null) {
              return const Center(
                  child: Text("No Tags Available For This Site."));
            } else {
              return Scaffold(
                body: Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.checkmark_shield_fill,
                              color: CupertinoColors.activeGreen,
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
                        itemCount: siteTags!.length,
                        itemBuilder: (context, index) {
                          final siteTag = siteTags![index]['uid'];
                          final isScanned = tagScannedStatus[index];

                          return GestureDetector(
                            onTap: () {
                              _showTagDescriptionDialog(siteTag, isScanned);
                            },
                            child: Card(
                              margin: const EdgeInsets.all(8),
                              child: ListTile(
                                title: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: _buildScanInput(
                                            siteTag, index, isScanned),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const SizedBox(width: 10),
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
                          //upload the patrol from here
                          // uploadPatrol();
                          debugPrint("Patrol has been uploaded");
                        },
                        color: const Color(0xFF2E8B57),
                        child: const Text("Submit Patrol"),
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }

  Widget _buildScanInput(String siteTag, int index, bool isScanned) {
    return SizedBox(
      width: 100,
      child: TextFormField(
        enabled: !tagScannedStatus[index],
        onChanged: (value) {
          if (value.isNotEmpty && !tagScannedStatus[index]) {
            bool isTagMatched = siteTags!.any((tag) => tag['uid'] == value);

            if (isTagMatched && !_scannedTags.contains(value)) {
              setState(() {
                tagScannedStatus[index] = true;
                _scannedTags.add(value);
              });

              if (_scannedTags.length == 1) {
                debugPrint('Time of first tag scanned: ${DateTime.now()}');
              }

              debugPrint(
                  'Tag $value verified. Total verified tags: ${_scannedTags.length}');

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
        enableSuggestions: false,
        autocorrect: false,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Scan Tag',
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
      isScanned ? CupertinoIcons.rectangle_fill : CupertinoIcons.rectangle_fill,
      size: 50,
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
  // void uploadPatrol() async {
  //   // Ensure that at least one tag has been scanned
  //   if (_scannedTags.isNotEmpty) {
  //     // Use the date when the first scan was made
  //     String date = DateFormat("yyyy-MM-dd").format(firstScannedTime!);

  //     // Format the startTime and endTime
  //     String startTime = DateFormat("HH:mm").format(firstScannedTime!);
  //     String endTime = DateFormat("HH:mm").format(lastScannedTime!);

  //     UserInputProvider userInputProvider =
  //         Provider.of<UserInputProvider>(context, listen: false);
  //     String? securityGuardId = userInputProvider.userInput;
  //     //TODO:PLACE THE SECURITY ID HERE

  //     debugPrint(securityGuardId);
  //     // Call the function to make the POST request
  //     debugPrint(
  //         '**************DETAILS: $date, $startTime, $endTime, $securityGuardId');

  //     String message = 'Patrol was not uploaded.';

  //     try {
  //       // Call the function to make the POST request
  //       await postData(date, startTime, endTime, securityGuardId ?? "");

  //       // Update the success message
  //       message = 'Patrol was uploaded successfully.';
  //     } catch (e) {
  //       // Handle any errors if needed
  //       debugPrint('Error: $e');
  //     }

  //     // Display message using SnackBar if widget is still mounted
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(message),
  //           backgroundColor:
  //               message.contains('success') ? Colors.green : Colors.red,
  //           duration: const Duration(seconds: 5),
  //         ),
  //       );
  //     }

  //     // Wait for SnackBar to complete before navigating
  //     await Future.delayed(const Duration(seconds: 5));

  //     // Navigate to the home screen if widget is still mounted
  //     if (mounted) {
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => const HomePage()),
  //       );
  //     }
  //   } else {
  //     // Display a message if no tags have been scanned
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text('Error'),
  //           content: const Text(
  //               'No tags have been scanned. Patrol was not uploaded.'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }
}
