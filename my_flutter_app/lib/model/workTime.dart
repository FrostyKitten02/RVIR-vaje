import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'workTime.g.dart';


@HiveType(typeId: 1)
class WorkTime {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? lastname;
  @HiveField(2)
  final String? workPlace;
  @HiveField(3)
  final DateTime? birthDate;
  @HiveField(4)
  final TimeOfDay? workStart;
  @HiveField(5)
  final TimeOfDay? workEnd;

  const WorkTime({this.name, this.lastname, this.workPlace, this.birthDate, this.workStart, this.workEnd});
}