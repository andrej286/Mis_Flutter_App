import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lab04/widget/table_calender.dart';

import 'model/exam_list_item.dart';
import 'widget/new_exam.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<ExamListItem> _examList = [
    ExamListItem(id: "1", nameOfSubject: "Calculus", dateTime: DateTime(2023, 1, 1, 17, 30)),
    ExamListItem(id: "2", nameOfSubject: "Web Design", dateTime: DateTime(2023, 1, 3, 18)),
  ];

  void _addExamFunction(BuildContext ct) {
    
    showModalBottomSheet(context: ct, builder: (_) {
      return GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.opaque,
        child: NewExam(_addNewExamToList),
       );
      }
    );
  }

  void _addNewExamToList(ExamListItem item) {

    setState(() {
      _examList.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Exams list"),
        actions: <Widget>[
          IconButton(
              onPressed: () => _addExamFunction(context),
              icon: Icon(Icons.add)
          )
        ],
      ),
      body: Column(children: [
        const CustomTableCalender(),
        Center(
           child: ListView.builder(
             scrollDirection: Axis.vertical,
             shrinkWrap: true,
             itemBuilder: (ctx,index) {
             return Card(
               elevation: 3,
               margin: EdgeInsets.symmetric(
                 vertical: 8,
                 horizontal: 10,
               ),
               child: _examList.isEmpty ?
               Text("No exams") :
               ListTile(
                 title: Text(_examList[index].nameOfSubject,
                   style: TextStyle(fontWeight: FontWeight.bold),),
                 subtitle: Text("${_examList[index].dateTime.toString()}",
                   style: TextStyle(color: Colors.grey)),
               ),
               );
             },
             itemCount: _examList.length,
            ),
           ),
      ]
      )
     );
  }
}