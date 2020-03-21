import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/manage_event_screen.dart';
import './screens/saved_events_screen.dart';
import './providers/study_groups.dart';
import './screens/create_event_screen.dart';
import './screens/landing_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: StudyGroups(),
        ),
      ],
      child: MaterialApp(
        title: 'Study Group Planner',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepPurple,
          fontFamily: 'AdventPro',
        ),
        home: LandingScreen(),
        routes: {
          ManageEventScreen.routeName: (ctx) => ManageEventScreen(),
          SavedEventsScreen.routeName: (ctx) => SavedEventsScreen(),
          CreateEventScreen.routeName: (ctx) => CreateEventScreen(),
        },
      ),
    );
  }
}
