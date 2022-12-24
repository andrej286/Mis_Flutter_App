import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/exam_list_item.dart';

class CustomTableCalender extends StatefulWidget {

  const CustomTableCalender({super.key});

  // TODO: conect and map the list of ExamListItem in the main page to a map of lists or load it from the db again

  @override
  State<StatefulWidget> createState() => _CustomTableCalenderState();
}

class _CustomTableCalenderState extends State<CustomTableCalender> {
  Map<DateTime, List<ExamListItem>> selectedEvents = {
    DateTime(2022, 12, 1): [ExamListItem(id: '3', nameOfSubject: 'test1', dateTime: DateTime(2022, 12, 1))],
    DateTime(2022, 12, 2): [ExamListItem(id: '4', nameOfSubject: 'test2', dateTime: DateTime(2022, 12, 2))]
  };

  CalendarFormat format = CalendarFormat.month;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    selectedEvents = {
      DateTime(2022, 12, 1): [ExamListItem(id: '3', nameOfSubject: 'test1', dateTime: DateTime(2022, 12, 1))],
      DateTime(2022, 12, 2): [ExamListItem(id: '4', nameOfSubject: 'test2', dateTime: DateTime(2022, 12, 2)),ExamListItem(id: '4', nameOfSubject: 'test3', dateTime: DateTime(2022, 12, 2))]
    };

    super.initState();
  }

  List<ExamListItem> _getEventsfromDay(DateTime date) {
    var temp = date;
    var d1 = DateTime(temp.year,temp.month,temp.day);

    return selectedEvents[d1] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exam Calendar"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: selectedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,

            //Day Changed
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
              print(focusedDay);
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },

            eventLoader: _getEventsfromDay,

            //To style the Calendar
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ..._getEventsfromDay(selectedDay).map(
                (ExamListItem exam) => ListTile(
              title: Text(
                exam.nameOfSubject,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
