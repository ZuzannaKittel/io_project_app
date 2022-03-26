import 'package:flutter/material.dart';
import 'package:io_project/widget/appbar_widget.dart';
import 'package:io_project/Workout_Pages/build_ex.dart';
import 'package:io_project/widget/excercise_button_widget.dart';

class CardioAll extends StatefulWidget {
  const CardioAll({Key? key}) : super(key: key);

  @override
  State<CardioAll> createState() => _CardioAllState();
}

class _CardioAllState extends State<CardioAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, "Cardio Workouts"),
        body: ListView(
            physics: const BouncingScrollPhysics(),
            addAutomaticKeepAlives: true,
            children: [
              Padding(
                  padding: EdgeInsets.all(12.0),
                  child: ExButtonWidget(
                    text: 'Running',
                    onClicked: () {},
                  )),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ExButtonWidget(
                    text: 'Running',
                    onClicked: () {},
                  )),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ExButtonWidget(
                    text: 'Running',
                    onClicked: () {},
                  )),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ExButtonWidget(
                    text: 'Running',
                    onClicked: () {},
                  )),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ExButtonWidget(
                    text: 'Running',
                    onClicked: () {},
                  )),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ExButtonWidget(
                    text: 'Running',
                    onClicked: () {},
                  )),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ExButtonWidget(
                    text: 'Running',
                    onClicked: () {},
                  )),
            ]));
  }
}