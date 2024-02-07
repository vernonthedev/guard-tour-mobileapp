/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: login_function.dart
*/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Logging user, by hitting the api endpoint and retrieving the token
Future<String?> loginUser(String username, String password) async {
  // hit the endpoint using the http package
  var url = Uri.parse('https://guardtour.legitsystemsug.com/auth/signin');
  try {
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      // make sure you post the data recieved from input as json to the api
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    // on successful api requesting
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

// saving token data to storage of sharedpreferences
Future<void> _saveToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}
