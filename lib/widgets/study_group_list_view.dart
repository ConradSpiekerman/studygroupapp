import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/study_groups.dart';
import './study_group_item.dart';


class StudyGroupListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final studyGroups = Provider.of<StudyGroups>(context).groups;
    return ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: studyGroups.length,
      itemBuilder: (ctx, i) => StudyGroupItem(studyGroups[i]),
    );
  }
}