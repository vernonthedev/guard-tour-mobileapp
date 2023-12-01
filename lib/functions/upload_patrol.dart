import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> postData(
    String date, String startTime, String endTime, int securityGuardId) async {
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
      String successResponse = 'Patrol has been uploaded Successfully';
      print(jsonData);
      return successResponse;
    } else {
      // Parse the error message from the response
      Map<String, dynamic> errorResponse = jsonDecode(response.body);
      String errorMessage = errorResponse['message'] ?? 'Unknown error';
      print(errorResponse);
      return 'Post request failed with status ${response.statusCode}: $errorMessage';
    }
  } catch (e) {
    return 'Error making post request: $e';
  }
}

// Retrieve token from SharedPreferences
Future<String?> _getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
