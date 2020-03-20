import 'package:flutter/material.dart';
import 'package:study_group_app/widgets/navigation_drawer.dart';

import '../widgets/filter_drawer.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/study_group_item.dart';
import '../models/study_group.dart';

import 'package:provider/provider.dart';
import '../providers/study_groups.dart';


class HomePageScreen extends StatelessWidget {
  final Set<String> filteredSet = {};

  @override
  Widget build(BuildContext context) {
    print(filteredSet.length);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          // change the endDrawer default icon to filter icon
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('groups').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Text('Loading...');
          }
          List<DocumentSnapshot> docs = snapshot.data.documents;
          List<StudyGroup> groups = [];

          docs.forEach((item) {
            DateTime time = DateTime.parse(item.data['dateTime']);
            groups.add(StudyGroup.explicit(item.data['id'], item.data['title'], item.data['subject'], item.data['description'], time, item.data['location']));
          });
          Provider.of<StudyGroups>(context).items = groups;  // update _items

          return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: groups.length,
              itemBuilder: (context, i) => StudyGroupItem(groups[i])
          );
        },
      ),
      drawer: NavigationDrawer(),
      endDrawer: FilterDrawer(filteredSet),
    );
  }
}

