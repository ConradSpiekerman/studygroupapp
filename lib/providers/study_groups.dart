import 'package:flutter/material.dart';

import '../models/study_group.dart';

class StudyGroups with ChangeNotifier {
  Map <String, StudyGroup> _map = {};
  StudyGroups() {
    print("Study Groups");
    _items.forEach((item) => {_map[item.subject] = item});
    print(_map.length);
  }

  // Dumy Data
  List<StudyGroup> _items = [
    StudyGroup(
      id: 1,
      title: 'CSE461 Midterm Study',
      subject: 'CSE461',
      dateTime: DateTime(2020, 3, 18, 2, 30),
      description: 'Let\'s get together and prepare for the midterm!',
      location: 'CSE2 Lab 124',
    ),
    StudyGroup(
      id: 2,
      title: 'CSE311 HW2 Work Time',
      subject: 'CSE311',
      dateTime: DateTime(2020, 3, 15, 12, 0),
      description:
          'We will gather to work on and discuss about HW2. Feel free to join us!',
      location: 'CSE2 Lab 110',
    ),
    StudyGroup(
      id: 3,
      title: 'CSE332 Final Study',
      subject: 'CSE332',
      dateTime: DateTime(2020, 3, 15, 4, 30),
      description:
          'Let\s gather for the last time of this quarter to prepare for the final exam!' +
              'Bring your questions to work on tegether.',
      location: 'CSE1 Lab 003',
    ),
    StudyGroup(
      id: 4,
      title: 'CSE461 Midterm Study',
      subject: 'CSE461',
      dateTime: DateTime(2020, 2, 10, 2, 45),
      description:
          'Feel free to come if you want to work on past midterm samples together!',
      location: 'CSE2 Lab 124',
    ),
     StudyGroup(
      id: 4,
      title: 'CSE344 Final Prepration',
      subject: 'CSE344',
      dateTime: DateTime(2020, 2, 10, 2, 45),
      description:
          'Let\'s get together and prepare for the Final!',
      location: 'CSE2 Lab 110',
    ),
  ];
  Set<String> _filteredSubjects = {};

  List<StudyGroup> get items {
    if(_filteredSubjects.isEmpty)
      return [..._items];
    return _items.where((item) => _filteredSubjects.contains(item.subject)).toList();
  }

  void removeSubject(String subject){
    _filteredSubjects.remove(subject);
    notifyListeners();
  }

  void addSubject(String subject) {
     _filteredSubjects.add(subject);
     notifyListeners();
  }
  bool isFiltered(String subject) {
     return  _filteredSubjects.contains(subject);
  }
  
   Map<String, StudyGroup> get map {
    // TODO: Do a deep copy 
    return _map;
  }

  void addStudyGroup() {
    // _items.add();
    notifyListeners();
  }
}
