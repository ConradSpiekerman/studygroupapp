import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_group_app/screens/account_screen.dart';

import 'package:google_sign_in/google_sign_in.dart';

import './screens/manage_event_screen.dart';
import './screens/saved_events_screen.dart';
import './providers/study_groups.dart';
import './screens/create_event_screen.dart';
import './screens/landing_screen.dart';

GoogleSignIn googleSignIn = new GoogleSignIn(
    scopes: [
      'profile',
      'email',
      'openid'
    ]
);

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
          AccountScreen.routeName: (ctx) => AccountScreen(),
        },
      ),
    );
  }
}
