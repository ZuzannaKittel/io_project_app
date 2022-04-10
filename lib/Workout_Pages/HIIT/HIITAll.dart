import 'package:flutter/material.dart';
import 'package:io_project/widget/appbar_widget.dart';
import 'package:io_project/Workout_Pages/build_ex.dart';
import 'package:io_project/widget/exercise_button_widget.dart';

import 'hTrainingA.dart';

class HIITAll extends StatefulWidget {
  const HIITAll({Key? key}) : super(key: key);

  @override
  State<HIITAll> createState() => _HIITAllState();
}

class _HIITAllState extends State<HIITAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, "HIIT Workouts"),
        body: ListView(
            physics: const BouncingScrollPhysics(),
            addAutomaticKeepAlives: true,
            children: [
              Padding(
                  padding: EdgeInsets.all(12.0),
                  child: ExButtonWidget(
                    text: 'b',
                    onClicked: () {
                      /*Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen()),
                      );*/
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ExButtonWidget(
                    text: 'Trening A',
                    onClicked: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => hTrainingAPage()),
                      );
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ExButtonWidget(
                    text: 'x',
                    onClicked: () {},
                  )),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ExButtonWidget(
                    text: 'x',
                    onClicked: () {},
                  )),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ExButtonWidget(
                    text: 'x',
                    onClicked: () {},
                  )),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ExButtonWidget(
                    text: 'x',
                    onClicked: () {},
                  )),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ExButtonWidget(
                    text: 'x',
                    onClicked: () {},
                  )),
            ]));
  }
}
