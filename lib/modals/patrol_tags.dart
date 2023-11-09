/*
Project Name: Guard Tour Mobile App
Developer: vernonthedev
File Name: patrol_tags.dart
*/

// model to store the patrol tags and its properties to the database
// TODO: Create a proper model to handle the tag profile data in the app
class PatrolTags {
  final String id;
  final String name;
  bool scanned;

  PatrolTags(this.id, this.name, this.scanned);
}
