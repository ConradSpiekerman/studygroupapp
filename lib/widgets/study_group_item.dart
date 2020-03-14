import 'package:flutter/material.dart';
// import 'dart:math';
// import 'package:intl/intl.dart';

import '../models/study_group.dart';

class StudyGroupItem extends StatelessWidget {
  final StudyGroup studyGroup;

  StudyGroupItem(this.studyGroup);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.grey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Colors.white70,
                height: 40,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  studyGroup.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          color: Colors.purple,
                        ),
                        Text(
                          studyGroup.dateTime.toString(),
                           // DateFormat('dd/MM/yyyy hh:mm').format(studyGroup.dateTime),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.purple,
                        ),
                        Text(
                          studyGroup.location,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.event_note,
                          color: Colors.purple,
                        ),
                        Expanded(
                          child: Text(
                            studyGroup.description,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  OutlineButton(
                    onPressed: () {},
                    child: Text('RVSP'),
                  )
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
