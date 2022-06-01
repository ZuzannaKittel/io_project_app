import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:io_project/widget/appbar_widget.dart';
import 'package:io_project/widget/bottom_nav_bar.dart';

import '../constants.dart';
import '../widget/buttons_widget.dart';

class NoWorkout extends StatefulWidget {
  const NoWorkout({Key? key}) : super(key: key);

  @override
  State<NoWorkout> createState() => _NoWorkoutState();
}

class _NoWorkoutState extends State<NoWorkout> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, "No Workout"),
      bottomNavigationBar: const BottomNavBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        //height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              mBackgroundColor,
              Color(0xFF817DC0),
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  const Text("There is no workout for today!",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 22)),
                  const SizedBox(height: 5),
                  const Text("Enjoy your free time.",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 22)),
                  const SizedBox(height: 20),
                  ButtonWidget(
                      text: 'Okay',
                      onClicked: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
