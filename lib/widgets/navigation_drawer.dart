import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
            leading: Icon(Icons.add),
            title: Text('Create Event'),
            onTap: () {},
          ),
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
