import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

import '../models/study_group.dart';
import '../providers/study_groups.dart';

class StudyGroupItem extends StatelessWidget {
  final StudyGroup studyGroup;

  StudyGroupItem(this.studyGroup);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Color(0xFFf5f5f5),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Color(0xFFcec7d6),
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
                        Container(
                          margin: EdgeInsets.only(right: 8, bottom: 4),
                          child: Icon(
                            Icons.subject,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Text(
                          studyGroup.subject,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 8,  bottom: 4),
                          child: Icon(
                            Icons.access_time,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy hh:mm').format(studyGroup.dateTime),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 8,  bottom: 4),
                          child: Icon(
                            Icons.location_on,
                            color: Theme.of(context).primaryColor,
                          ),
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
                        Container(
                          margin: EdgeInsets.only(right: 8,  bottom: 4),
                          child: Icon(
                            Icons.event_note,
                            color: Theme.of(context).primaryColor,
                          ),
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
                    Container(
                      alignment: Alignment.centerRight,
                      width: 40,
                      height: 40,
                      child: FlatButton(
                        color: Theme.of(context).accentColor,
                        child: Text(
                          'RVSP',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Provider.of<StudyGroups>(context, listen: false)
                              .saveEvent(studyGroup.id);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
