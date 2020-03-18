import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/study_group.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _subjectFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();
  final _dateFocusNode = FocusNode();
  final _timeFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var dateText = TextEditingController();
  var timeText = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  var _editedStudyGroup = StudyGroup(
    id: null,
    title: '',
    subject: '',
    location: '',
    description: '',
    dateTime: null,
  );

  // Avoid memory leaks, focus node remain
  // in memory otherwise
  @override
  void dispose() {
    _subjectFocusNode.dispose();
    _locationFocusNode.dispose();
    _dateFocusNode.dispose();
    _timeFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("REBUILT");
    print(selectedDate);
    print(selectedTime);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Form(
        key: _form,
        child: ListView(
          children: <Widget>[
            _buildTitleTextField(),
            _buildSubjectTextField(),
            _buildLocationTextField(),
            _buildDateTimePicker(),
            _buildDescriptionTextField(),
            RaisedButton(
              child: Text("submit"),
              color: Colors.deepPurple,
              onPressed: () => _saveForm(),
              focusNode: _subjectFocusNode,
            ),
          ],
        ),
      ),
    );
  }

  void _saveForm() {
    _form.currentState.save();
    print(_editedStudyGroup.title);
    print(_editedStudyGroup.subject);
    print(_editedStudyGroup.location);
    print(_editedStudyGroup.dateTime);
    print(_editedStudyGroup.description);
  }

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Title'),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_subjectFocusNode);
      },
      onSaved: (String value) {
        _editedStudyGroup.title = value;
      },
    );
  }

  Widget _buildSubjectTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Subject'),
      textInputAction: TextInputAction.next,
      focusNode: _subjectFocusNode,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_locationFocusNode);
      },
      onSaved: (String value) {
        _editedStudyGroup.subject = value;
      },
    );
  }

  Widget _buildLocationTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Location'),
      textInputAction: TextInputAction.next,
      focusNode: _locationFocusNode,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_dateFocusNode);
      },
      onSaved: (String value) {
        _editedStudyGroup.location = value;
      },
    );
  }

  Widget _buildDateTimePicker() {
    print("PICK");
    print(selectedDate);
    print(selectedTime);
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Expanded(
            flex: 4,
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Date'),
              textInputAction: TextInputAction.next,
              controller: dateText,
              readOnly: true,
              focusNode: _dateFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_timeFocusNode);
              },
              onTap: () => _selectDate(context),
              onSaved: (String value) {
                _editedStudyGroup.dateTime = new DateTime(
                  DateTime.parse(value).year,
                  DateTime.parse(value).month,
                  DateTime.parse(value).day,
                  _editedStudyGroup.dateTime.hour,
                  _editedStudyGroup.dateTime.minute,
                );
              },
            )),
        const SizedBox(width: 12.0),
        new Expanded(
            flex: 3,
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Time'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _timeFocusNode,
              readOnly: true,
              controller: timeText,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              onTap: () => _selectTime(context),
              onSaved: (String value) {
                TimeOfDay time = TimeOfDay(
                    hour: int.parse(value.split(":")[0]),
                    minute: int.parse(value.split(":")[1]));
                _editedStudyGroup.dateTime = new DateTime(
                  _editedStudyGroup.dateTime.year,
                  _editedStudyGroup.dateTime.month,
                  _editedStudyGroup.dateTime.day,
                  time.hour,
                  time.minute,
                );
              },
            )),
      ],
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      maxLines: 3,
      decoration: InputDecoration(labelText: 'Description'),
      focusNode: _descriptionFocusNode,
      keyboardType: TextInputType.multiline,
      onSaved: (String value) {
        _editedStudyGroup.description = value;
      },
    );
  }

  Future<void> _selectDate(
    BuildContext context,
  ) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: new DateTime(1970, 8),
        lastDate: new DateTime(2101));
    if (picked != null && picked != selectedDate) setState(() {
      dateText.text = new DateFormat.yMMMd().format(picked);
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime) setState(() {
      timeText.text = picked.format(context);
    });
  }
}
