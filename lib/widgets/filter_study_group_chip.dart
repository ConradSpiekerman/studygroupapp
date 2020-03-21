import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/study_groups.dart';

class FilterChipWidget extends StatefulWidget {
  final String chipName;
  final isSelected;

  FilterChipWidget({Key key, @required this.chipName, @required this.isSelected}) : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  @override
  Widget build(BuildContext context) {  
  final studyGroupsContainer = Provider.of<StudyGroups>(context, listen: false);
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(
          color: Theme.of(context).accentColor,
          fontSize: 16.0,
          fontWeight: FontWeight.bold),
      selected: widget.isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          if(isSelected){
             studyGroupsContainer.addSubject(widget.chipName);
          }
          else 
             studyGroupsContainer.removeSubject(widget.chipName);
          print(widget.chipName);
        });
      },
      selectedColor: Color(0xffeadffd),
    );
  }
}
