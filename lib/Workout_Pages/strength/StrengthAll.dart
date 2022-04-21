import 'package:flutter/material.dart';
import 'package:io_project/Workout_Pages/strength/sTrainingA.dart';
import 'package:io_project/widget/appbar_widget.dart';
import 'package:io_project/widget/exercise_button_widget.dart';
import '../../widget/bottom_nav_bar.dart';

class StrengthAll extends StatefulWidget {
  const StrengthAll({Key? key}) : super(key: key);

  @override
  State<StrengthAll> createState() => _StrengthAllState();
}

class _StrengthAllState extends State<StrengthAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, "Strength Workouts"),
        bottomNavigationBar: BottomNavBar(),
        body: ListView(
            physics: const BouncingScrollPhysics(),
            addAutomaticKeepAlives: true,
            children: [
              Padding(
                  padding: EdgeInsets.all(12.0),
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
                            builder: (context) => sTrainingAPage()),
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
