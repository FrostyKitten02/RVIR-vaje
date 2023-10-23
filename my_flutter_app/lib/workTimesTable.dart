import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/workTime.dart';

class WorkTimesTable extends StatelessWidget {
  final List<WorkTime> workTimes;

  //should use const, but issues with Storage
  WorkTimesTable({required this.workTimes, Key? key}) : super(key: key);

  List<DataColumn> _getColumns() {
    return const [
      DataColumn(label: Text("Ime")),
      DataColumn(label: Text("Priimek")),
    ];
  }

  List<DataRow> _getRows() {
    return workTimes.map((wt) {
      return DataRow(cells: [
        DataCell(Text(wt.name ?? "")),
        DataCell(Text(wt.lastname ?? "")),
      ]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WorkTimesTable'),
      ),
      body: DataTable(
        columns: _getColumns(),
        rows: _getRows(),
      )
    );
  }
}
