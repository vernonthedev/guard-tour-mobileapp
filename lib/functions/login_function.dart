import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> loginUser(String username, String password) async {
  var url = Uri.parse('http://app.legitsystemsug.com:3000/auth/signin');

  try {
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('access_token')) {
        String token = jsonResponse['access_token'];
        // Store token in SharedPreferences
        await _saveToken(token);

        return token;
      } else {
        debugPrint('Token not found in the response.');
        return null;
      }
    } else {
      debugPrint('Request failed with status: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    debugPrint('Exception occurred: $e');
    return null;
  }
}

Future<void> _saveToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}
