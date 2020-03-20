import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/study_group.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class StudyGroups with ChangeNotifier {
  Map<String, StudyGroup> _map = {};
  var lastId = 6;
  List<int> _savedEvents = [];

  StudyGroups() {
    print("Study Groups");
    _items.forEach((item) => {_map[item.subject] = item});
    print(_map.length);
  }

  // Dummy Data
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
      id: 9,
      title: 'CSE344 Final Prepration',
      subject: 'CSE344',
      dateTime: DateTime(2020, 2, 10, 2, 45),
      description: 'Let\'s get together and prepare for the Final!',
      location: 'CSE2 Lab 110',
    ),
  ];

  Set<String> _filteredSubjects = {};
  DateTime _filteredDate;

  List<StudyGroup> get items {
    if (_filteredSubjects.isEmpty)
      return _items.where((item) => _isAtTheSameDate(item.dateTime)).toList();
    return _items
        .where((item) =>
            _filteredSubjects.contains(item.subject) &&
            _isAtTheSameDate(item.dateTime))
        .toList();
  }

  bool _isAtTheSameDate(date) {
    return (_filteredDate == null ||
        (date.year == _filteredDate.year &&
            date.month == _filteredDate.month &&
            date.day == _filteredDate.day));
  }

  void removeSubject(String subject) {
    _filteredSubjects.remove(subject);
    notifyListeners();
  }

  void addSubject(String subject) {
    _filteredSubjects.add(subject);
    notifyListeners();
  }

  bool isFiltered(String subject) {
    return _filteredSubjects.contains(subject);
  }

  void filteredDate(DateTime date) {
    print(date);
    this._filteredDate = date;
    notifyListeners();
  }

  void clearFilters() {
    _filteredDate = null;
    _filteredSubjects.clear();
    notifyListeners();
  }

  StudyGroup findById(int id) {
    try {
      StudyGroup item = _items.singleWhere((item) => item.id == id);
      return _copyStudyGroup(item);
    } on StateError {
      print("No item found with the provided id");
      return null;
    }
  }

  Map<String, StudyGroup> get map {
    // TODO: Do a deep copy
    return _map;
  }

  void addEvent(StudyGroup studyGroup) {
    StudyGroup newGroup = _copyStudyGroup(studyGroup);
    newGroup.id = lastId++;
    _items.insert(0, newGroup);

    debugPrint('addStudyGroup');
    CollectionReference ref = Firestore.instance.collection('groups');
    Map<String, dynamic> doc = new Map();
    doc['id'] = newGroup.id;
    doc['title'] = newGroup.title;
    doc['subject'] = newGroup.subject;
    doc['dateTime'] = newGroup.dateTime.toIso8601String();
    doc['description'] = newGroup.description;
    doc['location'] = newGroup.location;
    ref.document(newGroup.id.toString()).setData(doc);

    notifyListeners();
  }

  void updateEvent(int id, StudyGroup newStudyGroup) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _items[index] = _copyStudyGroup(newStudyGroup);

      debugPrint('updateStudyGroup');
      CollectionReference ref = Firestore.instance.collection('groups');
      Map<String, dynamic> doc = new Map();
      doc['id'] = _items[index].id;
      doc['title'] = _items[index].title;
      doc['subject'] = _items[index].subject;
      doc['dateTime'] = _items[index].dateTime.toIso8601String();
      doc['description'] = _items[index].description;
      doc['location'] = _items[index].location;
      ref.document(_items[index].id.toString()).setData(doc);
      
      notifyListeners();
    }
  }

  void deleteEvent(int id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void deleteSavedEvent(int deleteId) {
    _savedEvents.removeWhere((id) => id == deleteId);
    notifyListeners();
  }

  void saveEvent(int id) {
    _savedEvents.add(id);
    notifyListeners();
  }

  List<StudyGroup> getSavedEvents() {
    return _savedEvents.map((id) => findById(id)).toList();
  }

  StudyGroup _copyStudyGroup(StudyGroup studyGroup) {
    return new StudyGroup(
        id: studyGroup.id,
        title: studyGroup.title,
        subject: studyGroup.subject,
        location: studyGroup.location,
        dateTime: studyGroup.dateTime,
        description: studyGroup.description);
  }
}
