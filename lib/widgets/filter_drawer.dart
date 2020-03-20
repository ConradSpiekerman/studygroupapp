import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/study_groups.dart';
import './filter_study_group_chip.dart';

class FilterDrawer extends StatefulWidget {

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  var dateTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final studyGroupContainer = Provider.of<StudyGroups>(context, listen: false);
    final subjects = Provider.of<StudyGroups>(context).getSubjects;
    List<FilterChipWidget> subjectsList = subjects
        .map((name) => FilterChipWidget(
            chipName: name, isSelected: studyGroupContainer.isSubjectFiltered(name)))
        .toList();
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 110,
            color: Colors.purple,
            alignment: Alignment.centerLeft,
            child: DrawerHeader(
              child: Text(
                'Apply Filters',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Pick a subject'),
            leading: Icon(Icons.subject),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Wrap(
              children: subjectsList,
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(19.0),
            alignment: Alignment.center,
            child: TextField(
                decoration: InputDecoration(
                  labelText: 'Pick a time',
                  icon: Icon(Icons.access_time),
                ),
                controller: dateTextController,
                readOnly: true,
                onTap: () => showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(3000),
                    ).then((date) {
                      if (date != null)
                        setState(() {
                          dateTextController.text =
                              new DateFormat.yMMMd().format(date);
                        });
                      studyGroupContainer.filteredDate(date);
                    })),
          ),
          Container(
            alignment: Alignment.topRight,
            width: 170,
            height: 80,
            child: FlatButton(
              color: Colors.deepPurple,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.clear,
                          color: Colors.white70,
                        )),
                    Text(
                      'Clear Filters',
                      style: TextStyle(color: Colors.white70),
                    )
                  ]),
              onPressed: () {
                studyGroupContainer.clearFilters();
              },
            ),
          ),
        ],
      ),
    );
  }
}
