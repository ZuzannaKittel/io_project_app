import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../widget/appbar_widget.dart';
import '../widget/bottom_nav_bar.dart';

List<dynamic>? list;
String getDay(int index) {
  if (index == 0) {
    return "Monday";
  } else if (index == 1) {
    return "Tuesday";
  } else if (index == 2) {
    return "Wednesday";
  } else if (index == 3) {
    return "Thursday";
  } else if (index == 4) {
    return 'Friday';
  } else if (index == 5) {
    return 'Saturday';
  } else {
    return 'Sunday';
  }
}

/*
void setWorkout() async {
  List<String>? workoutArray = [];
  List<String>? typeArray = [];
  int counter = 0; // [GM,LW,IC]
  await FirebaseFirestore.instance
      .collection("UsersPref")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get()
      .then((value) async {
    if (value.get('gain muscles')) {
      typeArray.add('Strength');
    }
    if (value.get('loose weight')) {
      typeArray.add('HIIT');
    }
    if (value.get('improve condition')) {
      typeArray.add('Cardio');
    }

    for (int i = 0; i < 7; i++) {
      if (value.get('workouts amount')[i] == true) {
        workoutArray.add(typeArray[counter]);
        counter++;
        if (counter == typeArray.length) {
          counter = 0;
        }
      }
    }
    await FirebaseFirestore.instance
        .collection("Workout")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({'Week': workoutArray});
  });
}

List<dynamic>? workouts;
void getWorkout() async {
  await FirebaseFirestore.instance
      .collection("Workout")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get()
      .then((value) => {workouts = value.get('Week')});
}

List<bool>? isDone = [false, false, false, false, false, false, false];
//Ustawianie warytosci true or false zgodnie z baza
void setData(DocumentSnapshot<Map<String, dynamic>> value) {
  isDone?[0] = value.get('Monday');
  isDone?[1] = value.get('Tuesday');
  isDone?[2] = value.get('Wednesday');
  isDone?[3] = value.get('Thursday');
  isDone?[4] = value.get('Friday');
  isDone?[5] = value.get('Saturday');
  isDone?[6] = value.get('Sunday');
}

//Sprawdzanie czy baza istnieje
void checkIfDatabase() async {
  bool ok = false;
  FirebaseFirestore.instance
      .collection("Week")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get()
      .then((value) {
    value.exists ? ok = true : ok = false;
    if (ok) {
      setData(value);
    } else {
      createDatabase();
    }
  });
}

void createDatabase() {
  final snapshot = FirebaseFirestore.instance
      .collection("Week")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .set({
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false,
    'Sunday': false,
  });
}
*/
List<dynamic>? workouts;
List<bool>? isDone = [false, false, false, false, false, false, false];

class WeeklyTraining extends StatefulWidget {
  const WeeklyTraining({Key? key}) : super(key: key);

  @override
  State<WeeklyTraining> createState() => _WeeklyTrainingState();
}

class _WeeklyTrainingState extends State<WeeklyTraining> {
  int counter = -1;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("Workout")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            workouts = snapshot.data?.get('Week');
            return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("UsersPref")
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    list = snapshot.data?.get('workouts amount');
                    return Scaffold(
                      bottomNavigationBar: const BottomNavBar(),
                      appBar: buildAppBar(context, "This week"),
                      body: Stack(children: <Widget>[
                        Container(
                          height: size.height * .30,
                          decoration: const BoxDecoration(
                            color: kBlueLightColor,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                                /*margin: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 40.0),
                                    */
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 20),
                                Expanded(
                                    child: ListView.builder(
                                        itemCount: list?.length,
                                        itemBuilder:
                                            (BuildContext ctxt, int index) {
                                          if (list?.length != 0) {
                                            if (list?[index] == true) {
                                              counter++;
                                              return Day(
                                                day: getDay(index),
                                                isTrue: list?[index],
                                                m_isDone: isDone?[index],
                                                text: workouts?[counter],
                                              );
                                            }
                                          } else {
                                            return Center(
                                                child: const Text('Brak Danych',
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontSize: 20)));
                                          }
                                          return Day(
                                            day: getDay(index),
                                            isTrue: list?[index],
                                            m_isDone: isDone?[index],
                                            text: 'None',
                                          );
                                        }))
                              ],
                            ))),
                      ]),
                    );
                  } else {
                    return Scaffold(
                      bottomNavigationBar: const BottomNavBar(),
                      appBar: buildAppBar(context, "This week"),
                      body: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 40),
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
                      ),
                    );
                  }
                });
          } else {
            return Text('');
          }
        });
  }
}

class Day extends StatelessWidget {
  final bool isTrue;
  final bool? m_isDone;
  final String day;
  final String text;
  Day(
      {Key? key,
      required this.day,
      required this.isTrue,
      this.m_isDone,
      required this.text})
      : super(key: key);

  Widget icon = Icon(Icons.radio_button_unchecked);
  Color? col = neonBlue;
  @override
  Widget build(BuildContext context) {
    if (m_isDone == true) {
      icon = Icon(Icons.check_circle_outline);
      col = neonGreen;
    }
    if (isTrue == true) {
      return Column(
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                onPrimary: kShadowColor,
                primary: col,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
              onPressed: () {},
              child: Container(
                //margin: const EdgeInsets.all(10.0),
                //color: color,
                width: 300,
                height: 50,

                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      icon,
                      Text(
                        text,
                        style:
                            const TextStyle(fontSize: 18, fontFamily: "Cairo"),
                      ),
                      Text(
                        day,
                        style:
                            const TextStyle(fontSize: 20, fontFamily: "Cairo"),
                      )
                    ],
                  ),
                ),
              )),
          const SizedBox(
            height: 10,
          )
        ],
      );
    } else {
      return Column(
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                onPrimary: kShadowColor,
                primary: kBlueColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
              onPressed: () {},
              child: Container(
                //margin: const EdgeInsets.all(10.0),
                //color: color,
                width: 300,
                height: 50,

                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      icon,
                      Text(
                        'Break',
                        style:
                            const TextStyle(fontSize: 18, fontFamily: "Cairo"),
                      ),
                      Text(
                        day,
                        style:
                            const TextStyle(fontSize: 20, fontFamily: "Cairo"),
                      )
                    ],
                  ),
                ),
              )),
          const SizedBox(
            height: 10,
          )
        ],
      );
    }
  }
}
