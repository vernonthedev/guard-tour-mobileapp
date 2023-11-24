import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> postData(
    String date, String startTime, String endTime, int securityGuardId) async {
  final url = 'https://guardtour.legitsystemsug.com/patrols';

  // Retrieve token from SharedPreferences
  String? authToken = await _getToken();

  // Check if authToken is available
  if (authToken == null || authToken.isEmpty) {
    print('Failed to retrieve authentication token. Aborting post request.');
    return;
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

    if (response.statusCode == 200) {
      print('Post request successful');
      print('Response: ${response.body}');
    } else {
      print('Post request failed with status ${response.statusCode}');
      print('Response: ${response.body}');
    }
  } catch (e) {
    print('Error making post request: $e');
  }
}

// Retrieve token from SharedPreferences
Future<String?> _getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
