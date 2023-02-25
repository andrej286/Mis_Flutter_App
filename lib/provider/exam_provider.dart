import 'package:flutter/foundation.dart';

import '../model/exam_list_item.dart';


class ExamProvider extends ChangeNotifier {
  List<ExamListItem> _exams = [
    ExamListItem(id: "1", nameOfSubject: "Calculus", dateTime: DateTime(2023, 1, 1, 17, 30),subjectLatitude: 42.004275, subjectLongitude: 21.408719),
    ExamListItem(id: "2", nameOfSubject: "Web Design", dateTime: DateTime(2023, 1, 3, 18),subjectLatitude: 42.001276, subjectLongitude: 21.12715),
    ExamListItem(id: "3", nameOfSubject: "TEST TEST", dateTime: DateTime(2023, 1, 3, 18),subjectLatitude: 42.005216, subjectLongitude: 21.408729),
  ];

  List<ExamListItem> get exams => _exams;

  set exams(List<ExamListItem> exams) {
    _exams = exams;
    notifyListeners();
  }

  void addExam(ExamListItem exam) {
    _exams.add(exam);
    notifyListeners();
  }

  void removeExam(ExamListItem exam) {
    _exams.remove(exam);
    notifyListeners();
  }
}