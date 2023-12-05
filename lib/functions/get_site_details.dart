/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: get_site_details.dart
*/
import 'dart:convert';
import 'package:guard_tour/functions/decode_token.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/site_details_model.dart';

Future<SiteDetails?> fetchSiteDetails() async {
  try {
    // Retrieve the token
    String? token = await _getToken();
    UserData? userData = await decodeTokenFromSharedPreferences();
    if (userData != null && token != null) {
      int siteId = userData.deployedSiteId;
      print(siteId);
      // Define the API endpoint
      String apiUrl = 'https://guardtour.legitsystemsug.com/sites/$siteId';

      // Make the HTTP GET request with the token in the Authorization header
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> data = json.decode(response.body);

        // Create SiteDetails instance from JSON
        SiteDetails siteDetails = SiteDetails.fromJson(data);
        print(siteId);

        // Print the fetched data
        print('Fetched Data: $data');

        // Return the fetched SiteDetails
        return siteDetails;
      } else {
        // Handle the error, e.g., print an error message
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } else {
      // Handle the case where the token is null
      print('Token or UserData is null. Unable to fetch data.');
    }
  } catch (e) {
    // Handle any exceptions that occur during the process
    print('Error: $e');
  }

  // Return null if there's an error
  return null;
}

// Function to retrieve the token from shared preference storage
Future<String?> _getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
