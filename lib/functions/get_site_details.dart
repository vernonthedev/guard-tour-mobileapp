/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: get_site_details.dart
*/
import 'dart:convert';
import 'package:guard_tour/functions/decode_token.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SiteDetails {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String phoneNumber;
  final String supervisorName;
  final String supervisorPhoneNumber;
  final String patrolPlanType;
  final int companyId;
  final List<Tag> tags;

  SiteDetails({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.phoneNumber,
    required this.supervisorName,
    required this.supervisorPhoneNumber,
    required this.patrolPlanType,
    required this.companyId,
    required this.tags,
  });

  factory SiteDetails.fromJson(Map<String, dynamic> json) {
    // Parse the tags list
    List<Tag> tags =
        (json['tags'] as List).map((tag) => Tag.fromJson(tag)).toList();

    return SiteDetails(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      latitude: json['latitude'] ?? 0,
      longitude: json['longitude'] ?? 0,
      phoneNumber: json['phoneNumber'] ?? "",
      supervisorName: json['supervisorName'] ?? "",
      supervisorPhoneNumber: json['supervisorPhoneNumber'] ?? "",
      patrolPlanType: json['patrolPlanType'] ?? "",
      companyId: json['companyId'] ?? 0,
      tags: tags,
    );
  }
}

class Tag {
  final int id;
  final String uid;
  final int siteId;

  Tag({
    required this.id,
    required this.uid,
    required this.siteId,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'] ?? 0,
      uid: json['uid'] ?? "",
      siteId: json['siteId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'siteId': siteId,
    };
  }
}

Future<void> fetchDataAndStoreInSharedPreferences(int siteId) async {
  try {
    // Retrieve the token
    String? token = await _getToken();
    UserData? userData = await decodeTokenFromSharedPreferences();
    if (userData != null && token != null) {
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

        // Store the data in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('siteId', siteDetails.id);
        prefs.setString('siteName', siteDetails.name);
        prefs.setDouble('siteLatitude', siteDetails.latitude);
        prefs.setDouble('siteLongitude', siteDetails.longitude);
        prefs.setString('sitePhoneNumber', siteDetails.phoneNumber);
        prefs.setString('supervisorName', siteDetails.supervisorName);
        prefs.setString(
            'supervisorPhoneNumber', siteDetails.supervisorPhoneNumber);
        prefs.setString('patrolPlanType', siteDetails.patrolPlanType);
        prefs.setInt('companyId', siteDetails.companyId);

        // Store tags in SharedPreferences
        List<String> tagStrings =
            siteDetails.tags.map((tag) => json.encode(tag.toJson())).toList();
        prefs.setStringList('siteTags', tagStrings);

        // Print the fetched data
        print('Fetched Data: $data');
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
}

// Function to retrieve the token from shared preference storage
Future<String?> _getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
