import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_group_app/screens/create_event_screen.dart';

import '../widgets/navigation_drawer.dart';
import '../providers/study_groups.dart';
import '../widgets/user_event_item.dart';
import '../screens/create_event_screen.dart';

class ManageEventScreen extends StatelessWidget {
  static const routeName = '/manage_event';
  @override
  Widget build(BuildContext context) {
    final studyGroups = Provider.of<StudyGroups>(context).groups;
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('Manage Events'),
      ),
      body: Container(
        color: Colors.grey[400],
        child: ListView.builder(
          itemCount: studyGroups.length,
          itemBuilder: (_, i) => Column(
            children: <Widget>[
              UserEventItem(studyGroups[i]),
              Divider(
                color: Theme.of(context).accentColor,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                CreateEventScreen(),
          );
        },
      ),
    );
  }
}
