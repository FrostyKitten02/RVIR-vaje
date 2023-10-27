// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workTime.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkTimeAdapter extends TypeAdapter<WorkTime> {
  @override
  final int typeId = 1;

  @override
  WorkTime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkTime(
      name: fields[0] as String?,
      lastname: fields[1] as String?,
      workPlace: fields[2] as String?,
      birthDate: fields[3] as DateTime?,
      workStart: fields[4] as TimeOfDay?,
      workEnd: fields[5] as TimeOfDay?,
    );
  }

  @override
  void write(BinaryWriter writer, WorkTime obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.lastname)
      ..writeByte(2)
      ..write(obj.workPlace)
      ..writeByte(3)
      ..write(obj.birthDate)
      ..writeByte(4)
      ..write(obj.workStart)
      ..writeByte(5)
      ..write(obj.workEnd);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}


class TimeOfDayAdapter extends TypeAdapter<TimeOfDay> {
  @override
  final typeId = 101;

  @override
  void write(BinaryWriter writer, TimeOfDay obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.hour)
      ..writeByte(1)
      ..write(obj.minute);
  }

  TimeOfDay read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeOfDay(
        hour: fields[0] as int,
        minute: fields[1] as int
    );
  }

}