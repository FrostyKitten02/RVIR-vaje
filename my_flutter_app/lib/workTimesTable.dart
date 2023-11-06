import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'model/workTime.dart';

class WorkTimeTable extends StatefulWidget {
  const WorkTimeTable({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WorkTimesTableState();
}


class _WorkTimesTableState extends State<WorkTimeTable> {
  List<WorkTime> workTimes = List.empty(growable: true);
  var box = Hive.box('local');

  @override
  void initState() {
    super.initState();
    List<dynamic> all = box.get("worktimes")??[];
    workTimes = [];
    for (dynamic d in all) {
      if (d.runtimeType == WorkTime) {
        workTimes.add(d);
      }
    }
  }

  List<DataColumn> _getColumns() {
    return const [
      DataColumn(label: Text("Ime")),
      DataColumn(label: Text("Priimek")),
      DataColumn(label: Text("Več")),
      DataColumn(label: Text("Izbriši")),
      DataColumn(label: Text("Uredi"))
    ];
  }

  List<DataRow> _getRows() {
    return workTimes.map((wt) {
      return DataRow(
          cells: [
            DataCell(Text(wt.name ?? "")),
            DataCell(Text(wt.lastname ?? "")),
            DataCell(
              IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {
                  showDialog(context: context, builder: (context) {

                    return Container(
                      width: 300,
                      height: 300,
                      child: Column(
                        children: [
                          Text(wt.name ?? ""),
                          Text(wt.lastname ?? ""),
                          Text(wt.workPlace ?? ""),
                          Text(wt.birthDate.toString()),
                          Text(wt.workStart.toString()),
                          Text(wt.workEnd.toString()),
                          TextButton(onPressed: () {Navigator.pop(context);}, child: Text("Nazaj"))
                        ],
                      ),
                    );
                  });
                },
              )
            ),
            DataCell(
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  workTimes.remove(wt);
                  box.delete("worktimes");
                  box.put("worktimes", workTimes);
                  setState(() {});
                },
              )
            ),
            DataCell(
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              )
            ),
      ]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WorkTimesTable'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: _getColumns(),
                rows: _getRows(),
              ),
            ),
          ),
        ],
      )
    );
  }
}
