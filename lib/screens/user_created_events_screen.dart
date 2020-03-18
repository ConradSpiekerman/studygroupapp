import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/study_groups.dart';
import '../widgets/user_event_item.dart';

class UserCreatedEventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final studyGroups = Provider.of<StudyGroups>(context).items;

    return Container(
      //padding: EdgeInsets.all(10),
      color: Colors.grey,
      child: ListView.builder(
        itemCount: studyGroups.length,
        itemBuilder: (_, i) => Column(
          children: <Widget>[UserEventItem(studyGroups[i]),
          Divider(color: Colors.deepPurple,),
          ],
        ),
      ),
    );
  }
}
