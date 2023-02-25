import 'dart:ffi';

import 'package:flutter/material.dart';

class ExamListItem {

  final String id;
  final String nameOfSubject;
  final DateTime dateTime;
  double? subjectLatitude;
  double? subjectLongitude;

  ExamListItem({
    required this.id,
    required this.nameOfSubject,
    required this.dateTime,
    this.subjectLatitude,
    this.subjectLongitude,
  });
}