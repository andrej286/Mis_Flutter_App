import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../model/exam_list_item.dart';

// TODO: add date_field: ^3.0.0  and  nanoid: to dependencies: in pubspec.yaml
import 'package:nanoid/nanoid.dart';
import 'package:date_field/date_field.dart';

class NewExam extends StatefulWidget {

  final Function addItem;

  NewExam(this.addItem);

  @override
  State<StatefulWidget> createState() => _NewExamState();
}

class _NewExamState extends State<NewExam>{

  final _subjectNameController = TextEditingController();

  DateTime dateTime = DateTime.now();

  void _submitData() {

    if( _subjectNameController.text.isEmpty){
      return;
    }

    final inputtedSubjectName = _subjectNameController.text;

    // TODO:   date_field: ^3.0.0  and  nanoid: have been added to dependencies: in pubspec.yaml
    final newExam = ExamListItem(
        id: nanoid(5),
        nameOfSubject: inputtedSubjectName,
        dateTime: dateTime);

    widget.addItem(newExam);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(8),
      child: Column(children: [
        TextField(
          controller: _subjectNameController,
          decoration: InputDecoration(labelText: "Subject name"),
          onSubmitted: (_) => _submitData()
        ),
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