import 'package:hive_flutter/hive_flutter.dart';
import 'package:guard_tour/models/patrol_model.dart';

class Boxes {
  static Box<Patrol> getPatrols() => Hive.box<Patrol>('patrols');
}
