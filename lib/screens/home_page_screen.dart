import 'package:flutter/material.dart';
import 'package:study_group_app/widgets/navigation_drawer.dart';

import '../widgets/filter_drawer.dart';

import '../widgets/study_group_item.dart';

import 'package:provider/provider.dart';
import '../providers/study_groups.dart';

class HomePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Group Planner', 
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
        ),
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
      body: FutureBuilder(
        future: Provider.of<StudyGroups>(context, listen: false).fetchGroups(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('An error occured!'));
          } else {
            bool filtered = Provider.of<StudyGroups>(context).isFiltered();
            final groups =
                filtered? Provider.of<StudyGroups>(context).filteredGroups:
                Provider.of<StudyGroups>(context).groups; // update _items
            return ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: groups.length,
                itemBuilder: (context, i) => StudyGroupItem(groups[i]));
          }
        },
      ),
      drawer: NavigationDrawer(),
      endDrawer: FilterDrawer(),
    );
  }
}
