import 'package:flutter/foundation.dart';

class StudyGroup {
  @required final int id;
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
}
