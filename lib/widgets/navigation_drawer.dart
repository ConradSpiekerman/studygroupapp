import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_group_app/screens/account_screen.dart';
import 'package:study_group_app/screens/manage_event_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/manage_event_screen.dart';
import '../screens/saved_events_screen.dart';
import '../main.dart';


class NavigationDrawer extends StatelessWidget {
//  final GoogleSignIn googleSignIn;
//  NavigationDrawer({this.googleSignIn});


  Future<void> _signOut(context) async {
    try {
      Navigator.of(context)
          .pushReplacementNamed('/');
      googleSignIn.signOut();
      googleSignIn.signIn();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 90,
            color: Theme.of(context).primaryColor,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Events', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ManageEventScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.event),
            title: Text('Saved Events', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(SavedEventsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.person),
              title: Text('Current User', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(AccountScreen.routeName);
              }
          ),
          Divider(),
          ListTile(
            leading: RotationTransition(
              turns: new AlwaysStoppedAnimation(180 / 360),
              child: Icon(
                Icons.exit_to_app,
              ),
            ),
            title: Text('Log out', style: TextStyle(fontSize: 18)),
            onTap: () =>_signOut(context),
          ),

        ],
      ),
    );
  }
}
