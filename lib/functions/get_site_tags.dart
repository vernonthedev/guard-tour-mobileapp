import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Tag {
  int id;
  String uid;
  int siteId;

  Tag({
    required this.id,
    required this.uid,
    required this.siteId,
  });
}

class PatrolPlan {
  int id;
  int siteId;
  List<Tag> tags;

  PatrolPlan({
    required this.id,
    required this.siteId,
    required this.tags,
  });
}

Future<PatrolPlan?> fetchPatrolPlan(int deployedSiteId) async {
  try {
    final apiUrl = 'https://guardtour.legitsystemsug.com/sites/$deployedSiteId';

    // Retrieve the token from SharedPreferences
    final token = await _getToken();

    if (token == null) {
      print('Token not found in SharedPreferences');
      return null;
    }

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      print(jsonData);

      List<Tag> tags = [];
      if (jsonData['tags'] != null) {
        for (var tagData in jsonData['tags']) {
          tags.add(Tag(
            id: tagData['id'],
            uid: tagData['uid'],
            siteId: tagData['siteId'],
          ));
        }
      }

      return PatrolPlan(
        id: jsonData['id'] ?? 0,
        siteId: jsonData['siteId'] ?? 0,
        tags: tags,
      );
    } else {
      print('Failed to fetch patrol plan. Status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching patrol plan: $e');
    return null;
  }
}

// Function to retrieve the token from shared preference storage
Future<String?> _getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
