import 'package:flutter/material.dart';
import 'package:io_project/Screens/PersonalDataPage.dart';

class SliderLevel extends StatefulWidget {
  SliderLevel({Key? key}) : super(key: key);

  @override
  State<SliderLevel> createState() => _SliderLevelState();
}

String LevelDesc(double value) {
  if (value < 2) {
    return "Very Easy";
  } else if (value < 4) {
    return "Easy";
  } else if (value >= 4 && value < 6) {
    return "Medium";
  } else if (value < 8) {
    return "Hard";
  } else {
    return "Hardcore";
  }
}

class _SliderLevelState extends State<SliderLevel> {
  double _currentLevel = 5;

  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: Color(0xFF817DC0),
      min: 0,
      max: 10,
      divisions: 100,
      value: _currentLevel,
      label: LevelDesc(_currentLevel),
      onChanged: (double value) {
        setState(() {
          _currentLevel = value;
          changeDiflvl(value);
        });
      },
    );
  }
}

class SliderBodyType extends StatefulWidget {
  SliderBodyType({Key? key}) : super(key: key);

  @override
  State<SliderBodyType> createState() => _SliderBodyTypeState();
}

String BodyTypeDesc(double value) {
  if (value < 1) {
    return "Slim";
  } else if (value >= 1 && value < 2) {
    return "Medium";
  } else {
    return "Fat";
  }
}

class _SliderBodyTypeState extends State<SliderBodyType> {
  double _currentBodyType = 1;

  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: Color(0xFF817DC0),
      min: 0,
      max: 3,
      divisions: 100,
      value: _currentBodyType,
      label: BodyTypeDesc(_currentBodyType),
      onChanged: (double value) {
        setState(() {
          _currentBodyType = value;
        });
      },
    );
  }
}
