// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patrol_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PatrolAdapter extends TypeAdapter<Patrol> {
  @override
  final int typeId = 0;

  @override
  Patrol read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Patrol()
      ..guardName = fields[0] as String
      ..scannedDate = fields[1] as DateTime
      ..startTime = fields[2] as String
      ..endTime = fields[3] as String
      ..guardId = fields[4] as int
      ..shiftId = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, Patrol obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.guardName)
      ..writeByte(1)
      ..write(obj.scannedDate)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.guardId)
      ..writeByte(5)
      ..write(obj.shiftId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatrolAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
