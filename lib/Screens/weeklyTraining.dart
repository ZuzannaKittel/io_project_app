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

class WeeklyTraining extends StatefulWidget {
  const WeeklyTraining({Key? key}) : super(key: key);

  @override
  State<WeeklyTraining> createState() => _WeeklyTrainingState();
}

class _WeeklyTrainingState extends State<WeeklyTraining> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("UsersPref")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            list = snapshot.data?.get('workouts amount');
            return Scaffold(
              bottomNavigationBar: const BottomNavBar(),
              appBar: buildAppBar(context, "This week"),
              body: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: list?.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              if (list?.length != 0) {
                                if (list?[index] == true) {
                                  return Day(
                                      day: getDay(index), isTrue: list?[index]);
                                }
                              } else {
                                return Text("Brak Danych");
                              }
                              return Day(
                                  day: getDay(index), isTrue: list?[index]);
                              ;
                            }))
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              bottomNavigationBar: const BottomNavBar(),
              appBar: buildAppBar(context, "This week"),
              body: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
  }
}

class Day extends StatelessWidget {
  final bool isTrue;
  final String day;
  const Day({Key? key, required this.day, required this.isTrue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isTrue == true) {
      return Column(
        children: [
          Container(
            color: Colors.blue[200],
            width: 300,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day,
                  style: const TextStyle(fontSize: 18, fontFamily: "Cairo"),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      );
    } else {
      return Column(
        children: [
          Container(
            color: Colors.red[300],
            width: 300,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day,
                  style: const TextStyle(fontSize: 18, fontFamily: "Cairo"),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      );
    }
  }
}
