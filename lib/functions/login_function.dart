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
        //save the site data coming from the api only if the response is not empty
        await _saveSiteData(jsonResponse);
        return 'Successful Login';
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

//function to save the received site data into shared preferences
Future<void> _saveSiteData(Map<String, dynamic> siteData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('siteData', jsonEncode(siteData));
}
