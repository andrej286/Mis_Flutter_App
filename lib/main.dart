import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lab04/provider/exam_provider.dart';
import 'package:lab04/screen/calendar_screen.dart';
import 'package:lab04/screen/map_screen.dart';
import 'package:lab04/service/notificationService.dart';
import 'package:provider/provider.dart';

import 'widget/new_exam.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:lab04/widget_tree.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ExamProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/home',
          routes: {
            '/calendar': (context) => const CalendarScreen(),
            '/home': (context) => const WidgetTree(),
            '/exam_list': (context) => const ExamPage(),
            '/map': (context) => const MapScreen(),
          },
          home: const WidgetTree(),
        ));
  }
}

class ExamPage extends StatefulWidget {
  const ExamPage({super.key});

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  @override
  void initState() {
    super.initState();
    Noti.initialize(flutterLocalNotificationsPlugin);
  }

  void _addExamFunction(BuildContext ct) {
    showModalBottomSheet(
        context: ct,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewExam(),
          );
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
                icon: Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/calendar');
                },
                icon: Icon(Icons.calendar_month)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/map');
                },
                icon: Icon(Icons.map_outlined))
          ],
        ),
        body: Consumer<ExamProvider>(
          builder: (context, examProvider, child) {
            final exams = examProvider.exams;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  child: exams.isEmpty
                      ? Text("No exams")
                      : ListTile(
                          title: Text(
                            exams[index].nameOfSubject,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("${exams[index].dateTime.toString()}",
                              style: TextStyle(color: Colors.grey)),
                        ),
                );
              },
              itemCount: exams.length,
            );
          },
        ));
  }
}
