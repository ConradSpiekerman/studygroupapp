import 'package:flutter/material.dart';

import './screens/home_page_screen.dart';
import './screens/create_event_screen.dart';
import './screens/user_events_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Group Planner',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepPurple
      ),
      home: HomePageScreen(),
      routes: {
        CreateEventScreen.routeName: (ctx) => CreateEventScreen(),
        UserEventsScreen.routeName: (ctx) => UserEventsScreen(),
      },
    );
  }
}
