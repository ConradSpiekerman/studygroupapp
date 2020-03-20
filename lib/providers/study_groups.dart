import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/study_group.dart';

import 'package:shared_preferences/shared_preferences.dart';

class StudyGroups with ChangeNotifier {
  CollectionReference _groupDocRef;
  Map<String, int> _subjects = {};
  SharedPreferences prefs;
  var lastId;
  Set<int> _savedEvents = {};
  bool _isFiltered = false;

  StudyGroups() {
    init();
  }

  // Dummy Data
  List<StudyGroup> _groups = [
    /*StudyGroup(
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
    ),*/
  ];

  Set<String> _filteredSubjects = {};
  DateTime _filteredDate;

  List<StudyGroup> get filteredGroups {
    if (_filteredSubjects.isEmpty)
      return _groups.where((item) => _isAtTheSameDate(item.dateTime)).toList();
    return _groups
        .where((item) =>
            _filteredSubjects.contains(item.subject) &&
            _isAtTheSameDate(item.dateTime))
        .toList();
  }

  List<StudyGroup> get groups {
    return [..._groups];
  }

  bool _isAtTheSameDate(date) {
    return (_filteredDate == null ||
        (date.year == _filteredDate.year &&
            date.month == _filteredDate.month &&
            date.day == _filteredDate.day));
  }

  void removeSubject(String subject) {
    if (_filteredSubjects.isEmpty) _isFiltered = false;
    _filteredSubjects.remove(subject);
    notifyListeners();
  }

  void addSubject(String subject) {
    _isFiltered = true;
    _filteredSubjects.add(subject);
    notifyListeners();
  }

  bool isSubjectFiltered(String subject) {
    return _filteredSubjects.contains(subject);
  }

  bool isFiltered() {
    return _isFiltered;
  }

  void filteredDate(DateTime date) {
    _isFiltered = true;
    this._filteredDate = date;
    notifyListeners();
  }

  void clearFilters() {
    _filteredDate = null;
    _isFiltered = false;
    _filteredSubjects.clear();
    notifyListeners();
  }

  StudyGroup findById(int id) {
    try {
      StudyGroup item = _groups.singleWhere((item) => item.id == id);
      return _copyStudyGroup(item);
    } on StateError {
      print("No item found with the provided id");
      return null;
    }
  }

  Set<String> get getSubjects {
    Set<String> copy = new Set<String>();
    copy.addAll(_subjects.keys);
    return copy;
  }

  void addEvent(StudyGroup studyGroup) {
    StudyGroup newGroup = _copyStudyGroup(studyGroup);
    newGroup.id = lastId++;
    prefs.setInt('lastId', lastId); // write to disk

    _groups.insert(0, newGroup);

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
    final index = _groups.indexWhere((item) {
      var found = false;
      if (item.id == id) {
        if (_subjects.containsKey(item.subject)) {
          if (_subjects[item.subject] == 1) {
            _subjects.remove(item.subject);
          }
          if (_subjects.containsKey(newStudyGroup.subject)) {
            _subjects[newStudyGroup.subject] += 1;
          } else {
            _subjects[newStudyGroup.subject] = 1;
          }
        }
        found = true;
      }
      return found;
    });
    if (index >= 0) {
      _groups[index] = _copyStudyGroup(newStudyGroup);

      debugPrint('updateStudyGroup');
      CollectionReference ref = Firestore.instance.collection('groups');
      Map<String, dynamic> doc = new Map();
      doc['id'] = _groups[index].id;
      doc['title'] = _groups[index].title;
      doc['subject'] = _groups[index].subject;
      doc['dateTime'] = _groups[index].dateTime.toIso8601String();
      doc['description'] = _groups[index].description;
      doc['location'] = _groups[index].location;
      ref.document(_groups[index].id.toString()).setData(doc);

      notifyListeners();
    }
  }

  void deleteEvent(int id) {
    _groups.removeWhere((item) {
      var found = false;
      if (item.id == id) {
        if (_subjects.containsKey(item.subject)) {
          _subjects[item.subject] -= 1;
          if (_subjects[item.subject] == 0){
           _subjects.remove(item.subject);
          }
        }
        found = true;
      }
      return found;
    });

    // delete document on server
    Firestore.instance.collection('groups').document(id.toString()).delete();
    deleteSavedEvent(id);
    notifyListeners();
  }

  void deleteSavedEvent(int deleteId) {
    _savedEvents.removeWhere((id) => id == deleteId);

    List<String> stringList = []; // delete from list on disk
    _savedEvents.forEach((elt) {
      stringList.add(elt.toString());
    });

    prefs.setStringList('savedEvents', stringList);
    notifyListeners();
  }

  void saveEvent(int id) {
    _savedEvents.add(id);

    List<String> stringList = [];

    _savedEvents.forEach((elt) {
      stringList.add(elt.toString());
    });
    prefs.setStringList('savedEvents', stringList);

    notifyListeners();
  }

  List<StudyGroup> getSavedEvents() {
    List<StudyGroup> temp = _savedEvents.map((id) => findById(id)).toList();
    temp.remove(null);
    return temp; // fix because there's some weird stuff with the savedEvents
    // I think it's fixed now but keeping this just in case
    //return _savedEvents.map((id) => findById(id)).toList();
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

  void init() async {
    // get last sequence number from disk
    prefs = await SharedPreferences.getInstance();
    lastId = prefs.getInt('lastId');
    List<String> stringList =
        prefs.getStringList('savedEvents'); // initialize saved
    // events from disk
    if (stringList != null) {
      stringList.forEach((elt) {
        _savedEvents.add(int.parse(elt));
      });
    } else {
      _savedEvents = {};
    }

    debugPrint('savedEvents on disk: $_savedEvents');

    // initialize the sequence number to use for id's
    if (lastId == null) {
      lastId = 0;
    } else {
      lastId = lastId + 2; // skip 2 id's for safety
    }
  }

  Future<void> fetchGroups() async {
    try {
      _groupDocRef = Firestore.instance.collection('groups');
      final snapshots = await _groupDocRef.getDocuments();
      List<StudyGroup> groups = [];
      snapshots.documents.forEach((doc) {
        DateTime time = DateTime.parse(doc.data['dateTime']);
        groups.add(StudyGroup.explicit(
            doc.data['id'],
            doc.data['title'],
            doc.data['subject'],
            doc.data['description'],
            time,
            doc.data['location']));
      });
      _groups.clear();
      _groups.addAll(groups);
      _subjects.clear();
      _groups.forEach((item) {
        if (_subjects.containsKey(item.subject)) {
          _subjects[item.subject] += 1;
        } else {
          _subjects[item.subject] = 1;
        }
      });

      notifyListeners();
    } catch (error) {
      print("Error while fetching data!");
      throw error;
    }
  }
}
