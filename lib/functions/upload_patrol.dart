import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> postData(String date, String startTime) async {
  // get data from shared preferences
  final String? guardID = await getGuardId();
  final String? siteID = await _getSiteID();

  if (guardID == null && siteID == null) {
    debugPrint('Guard ID and Site ID not found in SharedPreferences');
    return 'Guard ID and Site ID not found in SharedPreferences';
  }

  const url = 'https://guardtour.legitsystemsug.com/patrols';

  // Your JSON payload
  final Map<String, dynamic> data = {
    'date': date,
    'startTime': startTime,
    'securityGuardUniqueId': guardID,
    'siteTagId': siteID,
  };

  // Encode the payload to JSON
  final String jsonData = jsonEncode(data);

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // Parse the JSON response into a Map
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint(jsonResponse.toString());
      return 'success';
    } else {
      debugPrint('Error: ${response.statusCode} - ${response.reasonPhrase}');
    }
  } catch (e) {
    debugPrint('Error making post request: $e');
    return 'Error Uploading Patrol';
  }
  return null;
}

// Get the siteId from shared preferences
Future<String?> _getSiteID() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? siteData = prefs.getString('siteData');
  if (siteData != null) {
    final Map<String, dynamic> decodedData = jsonDecode(siteData);
    return decodedData['tagId'];
  } else {
    return null;
  }
}

//get the security guard id from shared preferences
Future<String?> getGuardId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('guardID');
}
