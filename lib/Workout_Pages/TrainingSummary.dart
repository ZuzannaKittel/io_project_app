import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:io_project/Screens/empty.dart';
import 'package:io_project/Workout_Pages/MainWorkout.dart';
import 'package:io_project/Workout_Pages/buildExercise.dart';
import 'package:io_project/Workout_Pages/cardio/exercises/ButtKicks.dart';
import 'package:io_project/Workout_Pages/cardio/exercises/JoggingInPlace.dart';
import 'package:io_project/Workout_Pages/strength/exercises/Deadlift.dart';
import 'package:io_project/constants.dart';
import 'package:io_project/widget/bottom_nav_bar.dart';
import 'package:io_project/widget/buttons_widget.dart';
import 'package:io_project/widget/search_bar.dart';
import 'package:io_project/Workout_Pages/cardio/exercises/JumpingJacks.dart';
import 'package:io_project/widget/appbar_widget.dart';
import 'package:numberpicker/numberpicker.dart';

import '../widget/slider.dart';

class TrainingSummary extends StatefulWidget {
  final String trainingName;
  final String trainingType;

  const TrainingSummary(
      {Key? key, required this.trainingName, required this.trainingType})
      : super(key: key);

  @override
  State<TrainingSummary> createState() => _TrainingSummaryState();
}

class _TrainingSummaryState extends State<TrainingSummary> {
  late bool issDone = false;
  double difficultyRating = 0;
  double sthRating = 0;
  bool isSubmitClicked = false;

  void addSummaryData() async {
    await FirebaseFirestore.instance
        .collection('summary')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'difficulty rating ' + date: difficultyRating,
      'sth rating ' + date: sthRating,
      'training name ' + date: widget.trainingName,
      'training type ' + date: widget.trainingType,
    }, SetOptions(merge: true)).then((value) {});
  }

  Future<void> addNotes(String n) async {
    await FirebaseFirestore.instance
        .collection("summary")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'notes ' + widget.trainingName + ' ' + date: n,
    }, SetOptions(merge: true)).then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.trainingName,
            style: const TextStyle(fontSize: 22, fontFamily: "Cairo")),
        leading: const BackButton(),
        backgroundColor: kBlueLightColor,
        elevation: 0,
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: const BoxDecoration(
              color: kBlueLightColor,
              image: DecorationImage(
                image: AssetImage("assets/images/People.png"),
                fit: BoxFit.fitHeight,
                alignment: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      "Rate your training",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: size.width * .6,
                      // height: 50, // it just take the 50% width
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Sth',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo',
                                    fontSize: 16)),
                            RatingBar.builder(
                              minRating: 1,
                              itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: kBackgroundColor),
                              onRatingUpdate: (rat) => setState(() {
                                sthRating = rat;
                              }),
                            ),
                            const SizedBox(height: 20),
                            const Text('Difficulty level',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo',
                                    fontSize: 16)),
                            RatingBar.builder(
                              minRating: 1,
                              itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: kBackgroundColor),
                              onRatingUpdate: (rat) => setState(() {
                                difficultyRating = rat;
                              }),
                            ),
                            ButtonWidget(
                                text: 'Submit',
                                onClicked: () {
                                  isSubmitClicked = true;
                                  addSummaryData();
                                  if (difficultyRating == 1 ||
                                      difficultyRating == 5) {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Alert',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Cairo")),
                                        content: const Text(
                                            'Would you like to change trainings difficulty level?',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Cairo")),
                                        actions: <Widget>[
                                          Center(
                                            child: Row(
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const Test()),
                                                      );
                                                    },
                                                    child: const Text('yes',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily: 'Cairo',
                                                            fontSize: 16))),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'OK'),
                                                  child: const Text('no',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: 'Cairo',
                                                          fontSize: 16)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        contentPadding: EdgeInsets.all(30),
                                        title: const Text('Submit',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Cairo")),
                                        content: const Text(
                                            'Your rating has been saved correctly',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Cairo")),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Cairo',
                                                    fontSize: 18)),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                }),
                          ]),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      decoration: InputDecoration(
                          labelText: "Add notes",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                      maxLines: 6,
                      onChanged: (noTes) async {
                        addNotes(noTes);
                      },
                    ),
                    const SizedBox(height: 10),
                    Center(
                        child: ButtonWidget(
                            text: 'End training',
                            onClicked: () {
                              if (difficultyRating == 0 || sthRating == 0) {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Alert',
                                        style: TextStyle(
                                            fontSize: 18, fontFamily: "Cairo")),
                                    content: const Text(
                                        'Are you sure you dont want to rate your training?',
                                        style: TextStyle(
                                            fontSize: 18, fontFamily: "Cairo")),
                                    actions: <Widget>[
                                      Center(
                                        child: Row(
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Home_workout()),
                                                  );
                                                },
                                                child: const Text('yes',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Cairo',
                                                        fontSize: 16))),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text('no',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Cairo',
                                                      fontSize: 16)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                if (isSubmitClicked == false) {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      contentPadding: EdgeInsets.all(30),
                                      title: const Text('Alert',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "Cairo")),
                                      content: const Text(
                                          'Please click submit button',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "Cairo")),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Cairo',
                                                  fontSize: 18)),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Home_workout()),
                                  );
                                }
                              }
                            })),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
