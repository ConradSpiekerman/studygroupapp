import 'package:flutter/material.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Form(
        child: ListView(
          children: <Widget>[
            _buildTitleTextField(),
            _buildSubjectTextField(),
            _buildLocationTextField(),
            _buildDatePicker(),
            _buildTimePicker(),
            _buildDescriptionTextField(),
            RaisedButton(child: Text("submit"),
            color: Colors.deepPurple,
            onPressed: (){
              
            },),
          ],
        ),
      ),
    );
  }
}

Widget _buildTitleTextField() {
  return TextFormField(
    decoration: InputDecoration(labelText: 'Title'),
    onSaved: (String value) {},
  );
}

Widget _buildSubjectTextField() {
  return TextField(
    decoration: InputDecoration(labelText: 'Subject'),

    // onSaved: (String value) {},
  );
}

Widget _buildDatePicker() {
  return TextFormField(
    decoration: InputDecoration(labelText: 'Date'),
    onSaved: (String value) {},
  );
}

Widget _buildTimePicker() {
  return TextFormField(
    keyboardType: TextInputType.datetime,
    decoration: InputDecoration(labelText: 'Time'),
    onSaved: (String value) {},
  );
}

Widget _buildLocationTextField() {
  return TextFormField(
    decoration: InputDecoration(labelText: 'Location'),
    onSaved: (String value) {},
  );
}

Widget _buildDescriptionTextField() {
  return TextFormField(
    maxLines: 4,
    decoration: InputDecoration(labelText: 'Description'),
    onSaved: (String value) {},
  );
}
