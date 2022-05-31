import 'dart:math';
import 'dart:ui';

import 'buildExercise.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:io_project/Workout_Pages/buildExerciseReps.dart';
import 'package:io_project/constants.dart';

import '../widget/appbar_widget.dart';
import '../widget/bottom_nav_bar.dart';
import '../widget/exercise.dart';

double timeOfWorkout = 0;
int amountOfReps = 0;

class builderOfTraining extends StatefulWidget {
  late String trType;
  builderOfTraining({Key? key, required this.trType}) : super(key: key);

  @override
  State<builderOfTraining> createState() => _builderOfTrainingState();
}

class _builderOfTrainingState extends State<builderOfTraining> {
  String exDescription = '';
  late String element1 = ' ';
  late String element2 = ' ';
  late String element3 = ' ';
  late String element4 = ' ';
  late String element5 = ' ';
  late String element6 = ' ';

  void getData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection(widget.trType).get();
    final list = snapshot.docs.map((doc) => doc.id).toList();
    print(list);
    final _random = Random();
    final List<int> randomPicker =
        List<int>.generate((list.length - 1), (i) => i + 1)..shuffle();
    element1 = list[randomPicker.removeLast()];
    element2 = list[randomPicker.removeLast()];
    element3 = list[randomPicker.removeLast()];
    element4 = list[randomPicker.removeLast()];
    element5 = list[randomPicker.removeLast()];
    element6 = list[randomPicker.removeLast()];
    print(element1);
    print(element2);
    print(element3);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    //getData();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trening A",
            style: TextStyle(fontSize: 22, fontFamily: "Cairo")),
        leading: const BackButton(),
        backgroundColor: kBlueLightColor,
        elevation: 0,
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .35,
            decoration: const BoxDecoration(
              color: kBlueLightColor,
              image: DecorationImage(
                image: AssetImage("assets/images/trainingA.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      "Training",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "20 MIN Course",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: size.width * .6, // it just take 60% of total width
                      child: const Text(
                        "A cardio workout increases blood flow and acts as a filter system. It brings nutrients like oxygen, protein, and iron to the muscles that you've been training and helps them recover faster.",
                      ),
                    ),
                    SizedBox(
                      width: size.width * .6,
                      height: 50, // it just take the 50% width
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: <Widget>[
                        Exercise(
                          exerciseName: element1,
                          exerciseNum: 1,
                          //isDone: getState(),
                          press: () {
                            if (widget.trType == 'Cardio') {
                              licznik = 0;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => buildExercise(
                                        exName: element1,
                                        trType: widget.trType,
                                        isFinal: false)),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => buildExerciseReps(
                                        exName: element1,
                                        trType: widget.trType,
                                        isFinal: false)),
                              );
                            }
                          },
                          isDone: false,
                        ),
                        Exercise(
                          exerciseName: element2,
                          exerciseNum: 2,
                          isDone: false,
                          press: () {
                            if (widget.trType == 'Cardio') {
                              licznik = 0;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => buildExercise(
                                        exName: element2,
                                        trType: widget.trType,
                                        isFinal: false)),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => buildExerciseReps(
                                        exName: element2,
                                        trType: widget.trType,
                                        isFinal: false)),
                              );
                            }
                          },
                        ),
                        Exercise(
                          exerciseName: element3,
                          exerciseNum: 3,
                          press: () {
                            if (widget.trType == 'Cardio') {
                              licznik = 0;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => buildExercise(
                                        exName: element3,
                                        trType: widget.trType,
                                        isFinal: false)),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => buildExerciseReps(
                                        exName: element3,
                                        trType: widget.trType,
                                        isFinal: false)),
                              );
                            }
                          },
                        ),
                        Exercise(
                          exerciseName: element4,
                          exerciseNum: 4,
                          press: () {
                            if (widget.trType == 'Cardio') {
                              licznik = 0;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => buildExercise(
                                        exName: element4,
                                        trType: widget.trType,
                                        isFinal: false)),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => buildExerciseReps(
                                        exName: element4,
                                        trType: widget.trType,
                                        isFinal: false)),
                              );
                            }
                          },
                        ),
                        Exercise(
                          exerciseName: element5,
                          exerciseNum: 5,
                          press: () {
                            if (widget.trType == 'Cardio') {
                              licznik = 0;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => buildExercise(
                                        exName: element5,
                                        trType: widget.trType,
                                        isFinal: false)),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => buildExerciseReps(
                                        exName: element5,
                                        trType: widget.trType,
                                        isFinal: false)),
                              );
                            }
                          },
                        ),
                        Exercise(
                          exerciseName: element6,
                          exerciseNum: 6,
                          press: () {
                            if (widget.trType == 'Cardio') {
                              licznik = 0;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => buildExercise(
                                        exName: element6,
                                        trType: widget.trType,
                                        isFinal: true)),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => buildExerciseReps(
                                        exName: element6,
                                        trType: widget.trType,
                                        isFinal: true)),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Text('Error 404');
  }
}
