/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: get_security_guard_details.dart
*/
import 'dart:convert';
import 'package:guard_tour/functions/decode_token.dart';
import 'package:http/http.dart' as http;
import 'package:guard_tour/models/security_guard_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SecurityGuardDetails?> fetchSecurityGuardDetails(
    String enteredUniqueId) async {
  try {
    // Retrieve user data and token from SharedPreferences
    UserData? userData = await decodeTokenFromSharedPreferences();
    String? token = await _getToken();

    if (userData != null && token != null) {
      // Check if guardId is not null
      int deployedSiteId =
          userData.deployedSiteId; // Replace 0 with a suitable default value
      // Define the API endpoint for security guard details
      String apiUrl =
          'https://guardtour.legitsystemsug.com/sites/$deployedSiteId';

      // Make the HTTP GET request with the token in the Authorization header
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse the JSON response
        Map<String, dynamic> siteData = json.decode(response.body);
        // Get the shifts data
        List<dynamic> shiftsData = siteData['shifts'];
// Find the security guard with the entered unique ID
        SecurityGuardDetails? selectedGuard;
        for (var shiftData in shiftsData) {
          List<dynamic> guardsData = shiftData['securityGuards'];
          selectedGuard = guardsData
              .map((guardData) => SecurityGuardDetails.fromJson(guardData))
              .firstWhere(
                (guard) => guard.uniqueId.toString() == enteredUniqueId,
                orElse: () => null as SecurityGuardDetails,
              );
        }

        return selectedGuard;
      } else {
        // Handle the error, e.g., print an error message
        print('Failed to fetch data. Status code: ${response.statusCode}');
        // If an error occurs, you might want to throw an exception or return null.
        throw Exception(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } else {
      print("User Data or Token is null");
      // If user data or token is null, you might want to throw an exception or return null.
      throw Exception('User Data or Token is null');
    }
  } catch (e) {
    // Handle any exceptions that occur during the process
    print('Error: $e');
    // If an error occurs, you might want to throw an exception or return null.
    throw Exception('Error: $e');
  }
}

// Function to retrieve the token from shared preference storage
Future<String?> _getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
