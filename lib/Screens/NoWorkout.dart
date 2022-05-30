import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:io_project/widget/appbar_widget.dart';
import 'package:io_project/widget/bottom_nav_bar.dart';

class NoWorkout extends StatefulWidget {
  const NoWorkout({Key? key}) : super(key: key);

  @override
  State<NoWorkout> createState() => _NoWorkoutState();
}

class _NoWorkoutState extends State<NoWorkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      appBar: buildAppBar(context, "No Workout"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('No workout for today :D')],
      ),
    );
  }
}
