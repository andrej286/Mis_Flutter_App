import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/table_calender.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {


  @override
  Widget build(BuildContext context) {

    return CustomTableCalender();
  }
}