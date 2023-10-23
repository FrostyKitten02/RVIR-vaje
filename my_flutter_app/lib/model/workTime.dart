import 'package:flutter/material.dart';

class WorkTime {
  final String? name;
  final String? lastname;
  final String? workPlace;
  final DateTime? birthDate;
  final TimeOfDay? workStart;
  final TimeOfDay? workEnd;

  const WorkTime({this.name, this.lastname, this.workPlace, this.birthDate, this.workStart, this.workEnd});
}


class Storage {
  const Storage._();
  static List<WorkTime> workTimes = List.empty(growable: true);
}
