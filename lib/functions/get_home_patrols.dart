/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: get_site_details.dart
*/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:guard_tour/functions/decode_token.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:guard_tour/models/home_model.dart';

Future<List<HomeDetails>> getHomeDetails() async {
  try {
    // Retrieve user data and token from SharedPreferences
    UserData? userData = await decodeTokenFromSharedPreferences();
    String? token = await _getToken();

    if (userData != null && token != null) {
      // Check if guardId is not null
      int guardId = userData.guardId; // Replace 0 with a suitable default value
      // Define the API endpoint
      String apiUrl =
          'https://guardtour.legitsystemsug.com/users/security-guards/$guardId/patrols';

      // Make the HTTP GET request with the token in the Authorization header
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse the JSON response
        List<dynamic> patrolList = json.decode(response.body)['data'];

        // Convert the list of patrol data to a list of HomeDetails
        List<HomeDetails> homeDetailsList = patrolList
            .map((patrolData) => HomeDetails.fromJson(patrolData))
            .toList();

        // Return the fetched data
        return homeDetailsList;
      } else {
        // Handle the error, e.g., debugPrint an error message
        debugPrint('Failed to fetch data. Status code: ${response.statusCode}');
        // If an error occurs, you might want to throw an exception or return an empty list.
        throw Exception(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } else {
      debugPrint("User Data or Token is null");
      // If user data or token is null, you might want to throw an exception or return an empty list.
      throw Exception('User Data or Token is null');
    }
  } catch (e) {
    // Handle any exceptions that occur during the process
    debugPrint('Error: $e');
    // If an error occurs, you might want to throw an exception or return an empty list.
    throw Exception('Error: $e');
  }
}

// Function to retrieve the token from shared preference storage
Future<String?> _getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
