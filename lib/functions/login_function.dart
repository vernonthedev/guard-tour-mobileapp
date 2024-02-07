import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> loginUser(String siteId) async {
  var url = Uri.parse('https://guardtour.legitsystemsug.com/sites/$siteId');

  try {
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      if (jsonResponse.isNotEmpty) {
        // Assuming you want to parse the response and extract specific fields
        String? tagId = jsonResponse['tagId'];
        String? name = jsonResponse['name'];
        List<Map<String, dynamic>> tags =
            List<Map<String, dynamic>>.from(jsonResponse['tags']);
        String message = 'Successful Login';
        debugPrint("Name: $name And Tag ID: $tagId And Tags Include: $tags");

        return message;
      } else {
        return 'No data found for the provided site ID.';
      }
    } else {
      return 'Timeout! with status code: ${response.statusCode}';
    }
  } catch (e) {
    debugPrint('Exception occurred: $e');
    return 'Incorrect Site ID';
  }
}

// Future<void> _saveToken(String token) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString('token', token);
// }
