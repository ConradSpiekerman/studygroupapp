import 'package:flutter/material.dart';
import 'package:study_group_app/models/study_group.dart';
import 'package:intl/intl.dart';

import '../screens/create_event_screen.dart';
import '../screens/delete_event_dialog_screen.dart';

class UserEventItem extends StatelessWidget {
  final StudyGroup _studyGroup;
  UserEventItem(this._studyGroup);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          child: ListTile(
            title: Text(
              _studyGroup.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.deepPurple[400],
              ),
            ),
            trailing: Container(
              width: 100,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            CreateEventScreen(groupId: _studyGroup.id),
                      );
                    },
                    color: Colors.deepPurple,
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                       showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            DeleteEventScreen(_studyGroup.id),
                      );
                    },
                    color: Colors.purple,
                  ),
                ],
              ),
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
                      color: Colors.purple,
                    ),
                  ),
                  Text(
                    _studyGroup.subject,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 8, bottom: 4),
                    child: Icon(
                      Icons.access_time,
                      color: Colors.purple,
                    ),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy hh:mm').format(_studyGroup.dateTime),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 8, bottom: 4),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.purple,
                    ),
                  ),
                  Text(
                    _studyGroup.location,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 8, bottom: 4),
                    child: Icon(
                      Icons.event_note,
                      color: Colors.purple,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _studyGroup.description,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
