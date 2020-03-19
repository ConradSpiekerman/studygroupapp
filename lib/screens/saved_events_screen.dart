import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/navigation_drawer.dart';
import '../providers/study_groups.dart';
import '../widgets/saved_event_item.dart';

class SavedEventsScreen extends StatelessWidget {
  static const routeName = '/saved_events';

  @override
  Widget build(BuildContext context) {
    final savedEvents = Provider.of<StudyGroups>(context).getSavedEvents();
    print(savedEvents.length);
    Widget child;
    if (savedEvents.isNotEmpty)
      child = ListView.builder(
        itemCount: savedEvents.length,
        itemBuilder: (_, i) => Column(
          children: <Widget>[
            SavedEventItem(savedEvents[i]),
            Divider(
              color: Colors.deepPurple,
            ),
          ],
        ),
      );
    else
      child = Container(
        padding: EdgeInsets.all(8),
        child: Text("You have no saved events yet!"));

    return Scaffold(
        appBar: AppBar(
          title: Text('Saved Events'),
        ),
        drawer: NavigationDrawer(),
        backgroundColor: Colors.grey[400],
        body: child);
  }
}
