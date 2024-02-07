import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  int guardId;
  String username;
  String firstName;
  int companyId;
  int deployedSiteId;
  int shiftId;
  int iat;
  int exp;

  UserData({
    required this.guardId,
    required this.username,
    required this.firstName,
    required this.companyId,
    required this.deployedSiteId,
    required this.shiftId,
    required this.iat,
    required this.exp,
  });
}

Future<UserData?> decodeTokenFromSharedPreferences() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      debugPrint('Retrieved token: $token');

      try {
        return decodeToken(token);
      } catch (e) {
        debugPrint('Error decoding token: $e');
        return null;
      }
    } else {
      debugPrint('Token is null. Unable to decode.');
      return null;
    }
  } catch (e) {
    debugPrint('Error retrieving SharedPreferences: $e');
    return null;
  }
}

UserData decodeToken(String token) {
  // Split the token into header, payload, and signature
  List<String> parts = token.split('.');

  // Ensure that the payload length is a multiple of 4 by adding padding if needed
  String paddedPayload = parts[1] +
      '=' * ((4 - parts[1].length % 4) % 4); // Add '=' characters for padding

  // Use base64 decoding
  String decodedPayload = utf8.decode(base64.decode(paddedPayload));

  // Parse the JSON payload
  Map<String, dynamic> payload = json.decode(decodedPayload);
  debugPrint('Decoded payload: $payload');

  // Extract the required fields
  int guardId = payload['sub'];
  String username = payload['username'];
  String firstName = payload['firstName'];
  int companyId = payload['companyId'];
  int deployedSiteId = payload['deployedSiteId'];
  int shiftId = payload['shiftId'];
  int iat = payload['iat'];
  int exp = payload['exp'];

  // Create and return UserData object
  return UserData(
    guardId: guardId,
    username: username,
    firstName: firstName,
    companyId: companyId,
    deployedSiteId: deployedSiteId,
    shiftId: shiftId,
    iat: iat,
    exp: exp,
  );
}
