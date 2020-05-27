import 'package:flutter/material.dart';

class CheckBoxBC extends StatefulWidget {
  @override
  _CheckBoxBCState createState() => _CheckBoxBCState();
}

class _CheckBoxBCState extends State<CheckBoxBC> {
  Map<String, bool> values = {
    'Thermometer': false,
    'Blood Pressure': false,
    'Water': false,
    'Proper Sleep': false,
    'Weight Managemet': false,
    'Caffein': false,
    'Food': false,
    'Caffein': false,
    'Caffein': false,
    'Caffein': false,
    'Caffein': false,
    'Caffein': false,
  };

  var tempArray = [];

  getCheckBoxItem() {
    values.forEach((key, value) {
      if (value == true) {
        tempArray.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(tempArray);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    tempArray.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: values.keys.map((String key) {
          return new CheckboxListTile(
            title: new Text(key),
            value: values[key],
            activeColor: Colors.pink,
            checkColor: Colors.white,
            onChanged: (bool value) {
              setState(() {
                values[key] = value;
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
