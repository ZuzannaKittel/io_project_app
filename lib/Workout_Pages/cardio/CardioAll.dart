import 'package:flutter/material.dart';
import 'package:io_project/widget/appbar_widget.dart';
import 'package:io_project/Workout_Pages/build_ex.dart';
import 'package:io_project/widget/exercise_button_widget.dart';
import '../../widget/bottom_nav_bar.dart';
import 'cTrainingA.dart';

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
        bottomNavigationBar: const BottomNavBar(),
        body: ListView(
            physics: const BouncingScrollPhysics(),
            addAutomaticKeepAlives: true,
            children: [
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ExButtonWidget(
                    text: 'Running',
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
                            builder: (context) => const cTrainingAPage()),
                      );
                    },
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
