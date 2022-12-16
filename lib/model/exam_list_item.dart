import 'package:flutter/material.dart';

class ExamListItem {

  final String id;
  final String nameOfSubject;
  final DateTime dateTime;

  ExamListItem({
    required this.id,
    required this.nameOfSubject,
    required this.dateTime,
  });
}