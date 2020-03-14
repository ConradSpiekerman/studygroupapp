import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../screens/create_event_screen.dart';
import '../screens/user_events_screen.dart';

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
            onTap: () {Navigator.of(context).pushReplacementNamed('/');},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Create Event'),
            onTap: () {Navigator.of(context).pushReplacementNamed(CreateEventScreen.routeName);},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.event),
            title: Text('Your Events'),
            onTap: () {Navigator.of(context).pushReplacementNamed(UserEventsScreen.routeName); },
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
