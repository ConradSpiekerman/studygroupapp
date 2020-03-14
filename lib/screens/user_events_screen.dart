import 'package:flutter/material.dart';

import '../widgets/navigation_drawer.dart';

class UserEventsScreen extends StatelessWidget {
  static const routeName = '/your_events';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Events'),
      ),
      drawer: NavigationDrawer(),
    );
  }
}
