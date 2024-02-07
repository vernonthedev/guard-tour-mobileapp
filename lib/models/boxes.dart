import 'package:hive_flutter/hive_flutter.dart';
import 'package:guard_tour/models/patrol_model.dart';

class Boxes {
  static Box<Patrol>? _patrolsBox;

  // Getter for the patrols box
  static Box<Patrol> get getPatrols {
    if (_patrolsBox == null) {
      throw Exception(
          'Hive has not been initialized. Call Boxes.init() before using boxes.');
    }
    return _patrolsBox!;
  }

  // Initialize Hive
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PatrolAdapter());
    _patrolsBox = await Hive.openBox<Patrol>('patrols');
  }

  // Function to delete all patrols
  static void deleteAllPatrols() {
    getPatrols.clear();
  }
}
