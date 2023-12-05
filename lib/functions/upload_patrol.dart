import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> postData(String date, String startTime, String endTime,
    String securityGuardId) async {
  const url = 'https://guardtour.legitsystemsug.com/patrols';

  // Retrieve token from SharedPreferences
  String? authToken = await _getToken();

  // Check if authToken is available
  if (authToken == null || authToken.isEmpty) {
    return 'Failed to retrieve authentication token. Aborting post request.';
  }

  // Your JSON payload
  final Map<String, dynamic> data = {
    'date': date,
    'startTime': startTime,
    'endTime': endTime,
    'securityGuardId': securityGuardId,
  };

  // Encode the payload to JSON
  final String jsonData = jsonEncode(data);

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonData,
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse.containsKey('id')) {
        // If there is an 'id' field in the response, consider it a success
        String successResponse = 'Patrol has been uploaded Successfully';
        print(jsonData);
        return successResponse;
      } else {
        // Handle the case where the success response does not have the expected structure
        print('Unexpected success response format');
        return 'Unexpected success format';
      }
    } else {
      print("Error");
      return "Error occrued";

      // Parse the error message from the response dynamically
      // Map<String, dynamic> errorResponse = jsonDecode(response.body);

      // if (errorResponse.containsKey('message')) {
      //   String errorMessage = errorResponse['message'] ?? 'Unknown error';
      //   print(errorMessage);
      //   return 'Post request failed with status ${response.statusCode}: $errorMessage';
      // } else {
      //   // Handle the case where the error response does not have the expected structure
      //   print('Unexpected error response format');
      //   return 'Unexpected error format';
      // }
    }
  } catch (e) {
    print(e);
    return 'Error making post request: $e';
  }
}

// Retrieve token from SharedPreferences
Future<String?> _getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
