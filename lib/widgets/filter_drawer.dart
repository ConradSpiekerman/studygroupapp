import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../providers/study_groups.dart';
import './filter_study_group_chip.dart';

class FilterDrawer extends StatefulWidget {
  final Set<String> filteredSubjects = {};

  FilterDrawer(Set<String> set) {
    this.filteredSubjects.addAll(set);
  }

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  @override
  Widget build(BuildContext context) {
    final studyGroupContainer =
        Provider.of<StudyGroups>(context, listen: false);
    print("Drawer");
    final subjects = Provider.of<StudyGroups>(context).map.keys;
    List<FilterChipWidget> list = subjects
        .map((name) => FilterChipWidget(
            chipName: name, isSelected: studyGroupContainer.isFiltered(name)))
        .toList();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
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
              children: list,
            ),
          ),
          OutlineButton(
              child: ListTile(
                title: Text('Pick a date'),
                leading: Icon(Icons.access_time),
              ),
              onPressed: () => showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(3000),
                  ).then((date) {
                    studyGroupContainer.filteredDate(date);
                  })),
          OutlineButton(
            child: ListTile(
              title: Text('Clear Filters'),
              leading: Icon(Icons.clear),
            ),
            onPressed: () {
              studyGroupContainer.clearFilters();
            },
          ),
        ],
      ),
    );
  }
}
