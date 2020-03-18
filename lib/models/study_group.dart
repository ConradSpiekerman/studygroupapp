import 'package:flutter/foundation.dart';

class StudyGroup {
  @required int id;
  @required String title;
  @required DateTime dateTime;
  @required String location;
  @required String subject;
  String description = '';
  StudyGroup(
      {
      this.id, 
      this.title, 
      this.subject,
      this.description,
      this.dateTime,
      this.location
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
