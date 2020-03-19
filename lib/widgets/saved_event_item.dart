import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/study_group.dart';

class SavedEventItem extends StatelessWidget {
  final StudyGroup _studyGroup;
  SavedEventItem(this._studyGroup);

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
              width: 30,
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
                color: Colors.purple,
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
