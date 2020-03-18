import 'package:flutter/foundation.dart';

class StudyGroup {
  int id;
  String title;
  DateTime dateTime;
  String location;
  String subject;
  String description = '';
  StudyGroup(
      {
      @required this.id, 
      @required this.title, 
      @required this.subject,
      @required this.description,
      @required this.dateTime,
      @required this.location
      });

  StudyGroup.explicit(id, title, subject, description, dateTime, location) {
    this.id = id;
    this.title = title;
    this.subject = subject;
    this.description = description;
    this.dateTime = dateTime;
    this.location = location;
  }
}
