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
    final studyGroupfContainer = Provider.of<StudyGroups>(context, listen: false);
    print("Drawer");
    final subjects = Provider.of<StudyGroups>(context).map.keys;
    List<FilterChipWidget> list = subjects
        .map((name) => FilterChipWidget(
            chipName: name,
            isSelected: studyGroupfContainer.isFiltered(name)))
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
            title: Text('Pick Subject'),
            trailing: Icon(Icons.subject),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Wrap(
              children: list,
            ),
          ),
          ListTile(
            title: Text('Pick Date'),
            trailing: Icon(Icons.access_time),
          ),
        ],
      ),
    );
  }
}
