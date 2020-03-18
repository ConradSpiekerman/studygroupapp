import 'package:flutter/material.dart';
import 'package:study_group_app/widgets/navigation_drawer.dart';

import '../widgets/study_group_list_view.dart';
import '../widgets/filter_drawer.dart';

class HomePageScreen extends StatelessWidget {
  final Set<String> filteredSet = {};

  @override
  Widget build(BuildContext context) {
    print(filteredSet.length);
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            // change the endDrawer default icon to filter icon
            Builder(
              builder: (context) => IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
            ),
          ],
        ),
        drawer: NavigationDrawer(),
        endDrawer: FilterDrawer(filteredSet),
        body: StudyGroupListView(),
      );
  }
}

