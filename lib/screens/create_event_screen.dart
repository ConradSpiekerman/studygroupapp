import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/study_group.dart';
import '../providers/study_groups.dart';

class CreateEventScreen extends StatefulWidget {
  static const routeName = '/create_event';
  final int groupId;
  CreateEventScreen({this.groupId});
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
  var _dateTextController = TextEditingController();
  var _timeTextController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isInit = true;
  var _editedStudyGroup = StudyGroup(
    id: null,
    title: '',
    subject: '',
    location: '',
    description: '',
    dateTime: null,
  );
  var _initValues = {
    'title': '',
    'subject': '',
    'location': '',
    'description': '',
    'date': '',
    'time': '',
  };

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (widget.groupId != null) {
        _editedStudyGroup = Provider.of<StudyGroups>(context, listen: false)
            .findById(widget.groupId);
        _initValues = {
          'title': _editedStudyGroup.title,
          'subject': _editedStudyGroup.subject,
          'location': _editedStudyGroup.location,
          'description': _editedStudyGroup.description,
          'date': '',
          'time': ''
        };
        _selectedDate = new DateTime(
            _editedStudyGroup.dateTime.year,
            _editedStudyGroup.dateTime.month,
            _editedStudyGroup.dateTime.day);
        _selectedTime = new TimeOfDay(
                hour: _editedStudyGroup.dateTime.hour,
                minute: _editedStudyGroup.dateTime.minute);
        _dateTextController.text = new DateFormat.yMMMd().format(_selectedDate);
        _timeTextController.text = _selectedTime.format(context);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // Avoid memory leaks, focus node remains
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
    return AlertDialog(
      content: Container(
        width: double.maxFinite,
        height: 470,
        alignment: Alignment.center,
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              _buildTitleTextField(),
              _buildSubjectTextField(),
              _buildLocationTextField(),
              _buildDateTimePicker(),
              _buildDescriptionTextField(),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(color: Colors.white70),
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    if (_saveForm()) Navigator.pop(context);
                  },
                  focusNode: _subjectFocusNode,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) return false;
    _form.currentState.save();
    if (widget.groupId != null) {
      _editedStudyGroup.id = widget.groupId;
      Provider.of<StudyGroups>(context, listen: false)
          .updateEvent(widget.groupId, _editedStudyGroup);
    } else {
      Provider.of<StudyGroups>(context, listen: false)
          .addEvent(_editedStudyGroup);
    }
    return true;
  }

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Title'),
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value.isEmpty)
          return "Please enter a title.";
        else
          return null;
      },
      initialValue: _initValues['title'],
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
      initialValue: _initValues['subject'],
      validator: (value) {
        if (value.isEmpty)
          return "Please enter a subject.";
        else
          return null;
      },
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
      initialValue: _initValues['location'],
      validator: (value) {
        if (value.isEmpty)
          return "Please enter a location.";
        else
          return null;
      },
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_dateFocusNode);
      },
      onSaved: (String value) {
        _editedStudyGroup.location = value;
      },
    );
  }

  Widget _buildDateTimePicker() {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Expanded(
            flex: 4,
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Date'),
              textInputAction: TextInputAction.next,
              controller: _dateTextController,
              readOnly: true,
              focusNode: _dateFocusNode,
              validator: (value) {
                if (value.isEmpty) return "Please enter a date.";
                DateTime currentDate = new DateTime(DateTime.now().year,
                    DateTime.now().month, DateTime.now().day);
                if (_selectedDate.isBefore(currentDate))
                  return "Please enter a valid date.";
                else
                  return null;
              },
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_timeFocusNode);
              },
              onTap: () => _selectDate(context),
              onSaved: (String value) {
                _editedStudyGroup.dateTime = new DateTime(
                  _selectedDate.year,
                  _selectedDate.month,
                  _selectedDate.day,
                  (_editedStudyGroup.dateTime != null)
                      ? _editedStudyGroup.dateTime.hour
                      : 0,
                  (_editedStudyGroup.dateTime != null)
                      ? _editedStudyGroup.dateTime.minute
                      : 0,
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
              validator: (value) {
                if (value.isEmpty) return "Please enter a time.";
                if (!isValidTime(_selectedTime))
                  return "Please enter a valid time.";
                else
                  return null;
              },
              readOnly: true,
              controller: _timeTextController,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              onTap: () => _selectTime(context),
              onSaved: (String value) {
                _editedStudyGroup.dateTime = new DateTime(
                  (_editedStudyGroup.dateTime != null)
                      ? _editedStudyGroup.dateTime.year
                      : 0,
                  (_editedStudyGroup.dateTime != null)
                      ? _editedStudyGroup.dateTime.month
                      : 0,
                  (_editedStudyGroup.dateTime != null)
                      ? _editedStudyGroup.dateTime.day
                      : 0,
                  _selectedTime.hour,
                  _selectedTime.minute,
                );
              },
            )),
      ],
    );
  }

  bool isValidTime(TimeOfDay time) {
    final currentDate = DateTime.now();
    final chosenDate = new DateTime(_selectedDate.year, _selectedDate.month,
        _selectedDate.day, _selectedTime.hour, _selectedTime.minute);
    return chosenDate.isAfter(currentDate);
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      maxLines: 3,
      decoration: InputDecoration(labelText: 'Description'),
      focusNode: _descriptionFocusNode,
      keyboardType: TextInputType.multiline,
      initialValue: _initValues['description'],
      inputFormatters: [
        LengthLimitingTextInputFormatter(300),
      ],
      onSaved: (String value) {
        _editedStudyGroup.description = value;
      },
    );
  }

  Future<void> _selectDate( BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: new DateTime(1970, 8),
        lastDate: new DateTime(2101));
    if (picked != null)
      setState(() {
        _dateTextController.text = new DateFormat.yMMMd().format(picked);
        _selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _selectedTime);
    if (picked != null)
      setState(() {
        _timeTextController.text = picked.format(context);
        _selectedTime = picked;
      });
  }
}
