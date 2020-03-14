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
              children: list,
            ),
          ),
          Divider(),
          Container(
            alignment: Alignment.topLeft,
            width: 200,
            height: 50,
            child: OutlineButton(
               borderSide: BorderSide(color: Colors.purple),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                child: Row(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.access_time)),
                  Text('Pick a date')
                ]),
                onPressed: () => showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(3000),
                    ).then((date) {
                      studyGroupContainer.filteredDate(date);
                    })),
          ),
          Container(
            alignment: Alignment.topLeft,
            width: 200,
            height: 50,
            child: OutlineButton(
              borderSide: BorderSide(color: Colors.purple),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
              ),
              child: Row(children: <Widget>[
                Padding(padding: EdgeInsets.all(8), child: Icon(Icons.clear)),
                Text('Clear Filters')
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
