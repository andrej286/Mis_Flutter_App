import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import '../model/exam_list_item.dart';

import 'package:nanoid/nanoid.dart';
import 'package:date_field/date_field.dart';

import '../provider/exam_provider.dart';

class NewExam extends StatefulWidget {
  const NewExam({super.key});

  @override
  State<StatefulWidget> createState() => _NewExamState();
}

class _NewExamState extends State<NewExam> {
  final _subjectNameController = TextEditingController();
  final _locationNameController = TextEditingController();

  DateTime dateTime = DateTime.now();

  Future<void> _submitData() async {
    if (_subjectNameController.text.isEmpty) {
      return;
    }

    final inputtedSubjectName = _subjectNameController.text;

    var newExam = ExamListItem(
        id: nanoid(5), nameOfSubject: inputtedSubjectName, dateTime: dateTime);

    if (_locationNameController.text != null) {
      List<Location> locations =
          await locationFromAddress(_locationNameController.text);

      if (locations != null && locations.isNotEmpty) {
        Location location = locations.first;

        newExam = ExamListItem(
            id: nanoid(5),
            nameOfSubject: inputtedSubjectName,
            dateTime: dateTime,
            subjectLatitude: location.latitude,
            subjectLongitude: location.longitude);
      }
    }

    final examProvider = Provider.of<ExamProvider>(context, listen: false);

    examProvider.addExam(newExam);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
              controller: _subjectNameController,
              decoration: InputDecoration(labelText: "Subject name"),
              onSubmitted: (_) => _submitData()),
          TextField(
              controller: _locationNameController,
              decoration: InputDecoration(labelText: "Location"),
              onSubmitted: (_) => _submitData()),
          DateTimeFormField(
            decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.black45),
              errorStyle: TextStyle(color: Colors.redAccent),
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.event_note),
              labelText: 'Only time',
            ),
            mode: DateTimeFieldPickerMode.dateAndTime,
            onDateSelected: (DateTime value) {
              dateTime = value;
            },
            onSaved: (val) => setState(() => dateTime = val!),
          ),
          TextButton(
            child: Text("Add"),
            onPressed: _submitData,
          )
        ],
      ),
    );
  }
}
