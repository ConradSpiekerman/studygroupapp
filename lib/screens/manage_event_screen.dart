import 'package:flutter/material.dart';

import '../widgets/navigation_drawer.dart';
import '../screens/create_event_screen.dart';
import '../screens/user_created_events_screen.dart';

class ManageEventScreen extends StatelessWidget {
  static const routeName = '/manage_event';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: Text('Manage Events'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.list),
                text: 'My Events',
              ),
              Tab(
                icon: Icon(Icons.create),
                text: 'Create Event'
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            UserCreatedEventsScreen(),
            CreateEventScreen()
          ],
        ),
      ),
    );
  }
}
