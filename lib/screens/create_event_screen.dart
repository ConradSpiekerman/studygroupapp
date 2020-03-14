import 'package:flutter/material.dart';
import 'package:study_group_app/widgets/navigation_drawer.dart';

class CreateEventScreen extends StatelessWidget {
  static const routeName = '/create_event';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Events'),
      ),
      drawer: NavigationDrawer(),
    );
  }
}
