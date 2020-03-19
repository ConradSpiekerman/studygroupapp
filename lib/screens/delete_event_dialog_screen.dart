import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/study_groups.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class DeleteEventScreen extends StatelessWidget {
  final int _idToDelete;
  final bool _isSavedEvent;

  DeleteEventScreen(this._idToDelete, this._isSavedEvent);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text('Are you sure?'),
        actions: <Widget>[
          FlatButton(
            child: const Text('NO'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: const Text('YES'),
            onPressed: () {
              if (_isSavedEvent)
                Provider.of<StudyGroups>(context, listen: false)
                    .deleteSavedEvent(_idToDelete);
              else
                Provider.of<StudyGroups>(context, listen: false)
                    .deleteEvent(_idToDelete);
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      ),
    );
  }
}
