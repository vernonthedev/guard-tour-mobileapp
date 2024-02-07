import "package:hive/hive.dart";

part 'patrol_model.g.dart';

@HiveType(typeId: 0)
class Patrol extends HiveObject {
  @HiveField(0)
  late String guardName;
  @HiveField(1)
  late DateTime scannedDate;
  @HiveField(2)
  late String startTime;
  @HiveField(3)
  late String endTime;
  @HiveField(4)
  late int guardId;
}
