import 'package:flutter/material.dart';
import 'package:io_project/widget/appbar_widget.dart';
import 'package:io_project/Workout_Pages/build_ex.dart';
import 'package:io_project/widget/exercise_button_widget.dart';
import 'Meditation.dart';

class OtherAll extends StatefulWidget {
  const OtherAll({Key? key}) : super(key: key);

  @override
  State<OtherAll> createState() => _CardioAllState();
}

class _CardioAllState extends State<OtherAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, "Other Workouts"),
        body: ListView(
            physics: const BouncingScrollPhysics(),
            addAutomaticKeepAlives: true,
            children: [
              Padding(
                  padding: EdgeInsets.all(12.0),
                  child: ExButtonWidget(
                    text: 'Meditation',
                    onClicked: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen()),
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
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ExButtonWidget(
                    text: 'x',
                    onClicked: () {},
                  )),
            ]));
  }
}
