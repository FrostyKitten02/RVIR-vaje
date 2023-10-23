import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/workTimesTable.dart';

import 'model/workTime.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();

  String workPlace = "";

  DateTime birthDate = DateTime.now();
  TimeOfDay workStart = TimeOfDay.now();
  TimeOfDay workEnd = TimeOfDay.now();

  void toTable() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WorkTimesTable(
                workTimes: Storage.workTimes,
              )),
    );
  }

  void save() {
    WorkTime newWt = WorkTime(
      name: controllerName.text,
      lastname: controllerLastName.text,
      birthDate: birthDate,
      workStart: workStart,
      workEnd: workEnd,
    );
    Storage.workTimes.add(newWt);

    //reset fields
    setState(() {
      controllerName.text = "";
      controllerLastName.text = "";
      workPlace = "";
      birthDate = DateTime.now();
      workStart = TimeOfDay.now();
      workEnd = TimeOfDay.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SigninScreen'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            children: [
              const Text('Ime'),
              TextField(
                controller: controllerName,
              ),
              const Text('Priimek'),
              TextField(
                controller: controllerLastName,
              ),
              const Text('Delovno mesto'),
              DropdownMenu<String>(
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: "MB", label: "Maribor"),
                  DropdownMenuEntry(value: "LJ", label: "Ljubljana"),
                ],
                onSelected: (value) {
                  workPlace = value ?? "";
                },
              ),
              DatePicker(
                  onSelected: (value) {
                    birthDate = value;
                  },
                  initialDate: birthDate,
              ),
              TimePicker(
                labelText: "Ura prihoda",
                onSelected: (value) {
                  workStart = value;
                },
                initialTime: workStart,
              ),
              TimePicker(
                labelText: "Ura odhoda",
                onSelected: (value) {
                  workEnd = value;
                },
                initialTime: workEnd,
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: save,
                      child: const Text("Dodaj"),
                  ),
                  TextButton(
                    onPressed: toTable,
                    child: const Text("Pregled"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DatePicker extends StatelessWidget {
  final void Function(DateTime dateTime) onSelected;
  final DateTime initialDate;
  final String? textLabel;

  const DatePicker({Key? key, required this.onSelected, required this.initialDate, this.textLabel}) : super(key: key);

  String _formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text = _formatDate(initialDate);

    return TextField(
      controller: controller,
      decoration: InputDecoration(
          icon: const Icon(Icons.calendar_today),
          labelText: textLabel??"Vnesite datum"),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          controller.text = _formatDate(pickedDate);
        }
      },
    );
  }
}


class TimePicker extends StatelessWidget {
  final void Function(TimeOfDay timeOfDay) onSelected;
  final TimeOfDay initialTime;
  final String? labelText;

  const TimePicker(
      {Key? key,
      required this.onSelected,
      required this.initialTime,
      this.labelText})
      : super(key: key);

  String _timeOfDayToString(TimeOfDay timeOfDay) {
    return "${timeOfDay.hour}:${timeOfDay.minute}";
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text = _timeOfDayToString(initialTime);

    return TextField(
      controller: controller,
      decoration: InputDecoration(
          icon: const Icon(Icons.timelapse_outlined),
          labelText: labelText ?? "Vnesite uro"),
      readOnly: true,
      onTap: () async {
        TimeOfDay? timeOfDay = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (timeOfDay != null) {
          controller.text = _timeOfDayToString(timeOfDay);
          onSelected(timeOfDay);
        }
      },
    );
  }
}
