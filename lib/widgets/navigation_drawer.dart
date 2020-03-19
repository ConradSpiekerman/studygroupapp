import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:study_group_app/screens/manage_event_screen.dart';

import '../screens/manage_event_screen.dart';
import '../screens/saved_events_screen.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Drawer");
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 90,
            color: Colors.purple,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Manage Events'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ManageEventScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.event),
            title: Text('Saved Events'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(SavedEventsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: RotationTransition(
              turns: new AlwaysStoppedAnimation(180 / 360),
              child: Icon(
                Icons.exit_to_app,
              ),
            ),
            title: Text('Log out'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
