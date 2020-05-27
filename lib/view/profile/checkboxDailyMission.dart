import 'package:fit_app/entities/daily_mission.dart';
import 'package:flutter/material.dart';

class CheckBoxDailyMission extends StatefulWidget {
  final List<DailyMission> data;

  const CheckBoxDailyMission(this.data, {Key key}) : super(key: key);

  @override
  _CheckBoxDailyMissionState createState() => _CheckBoxDailyMissionState();
}

class _CheckBoxDailyMissionState extends State<CheckBoxDailyMission> {
  Map<String, bool> values = {
    '8000 Langkah': false,
    'Minum 8 Gelas': false,
    'Sarapan': false,
    'Tidur siang': false,
    'Sahur': false,
    'Buka Puasa': false,
  };
  // Clear array after use.

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
            activeColor: Colors.black,
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
