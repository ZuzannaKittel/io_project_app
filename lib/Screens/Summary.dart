import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../widget/appbar_widget.dart';
import '../widget/bottom_nav_bar.dart';

class Summary extends StatefulWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}

int minutes = 0;
void secondsToMinutes(double s) async {
  minutes = (s * (1 / 60)).toInt as int;
}

String getDay(int index) {
  if (index == 0) {
    return "Mon";
  } else if (index == 1) {
    return "Tue";
  } else if (index == 2) {
    return "Wed";
  } else if (index == 3) {
    return "Thu";
  } else if (index == 4) {
    return 'Fri';
  } else if (index == 5) {
    return 'Sat';
  } else {
    return 'Sun';
  }
}

Map daysOfWorkout = {};
List<String>? listOfKeys;
Map mainMap = {};
void setDataList() async {
  int counter = 0;
  var keysFromFirestore = await FirebaseFirestore.instance
      .collection("SummaryWeeks")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get();

  listOfKeys = keysFromFirestore.data()?.keys.toList();

  daysOfWorkout.forEach((key, value) {
    if (value) {
      counter++;
    }
  });
  for (int i = 0; i < listOfKeys!.length; i++) {
    List<ChartData> dane = [];
    for (int j = 0; j < 7; j++) {
      if (keysFromFirestore.get(listOfKeys![i])[getDay(j)] != null) {
        dane.add(ChartData(
            getDay(j), keysFromFirestore.get(listOfKeys![i])[getDay(j)]));
      } else {
        dane.add(ChartData(getDay(j), 0));
      }
    }
    mainMap[i] = dane;
  }
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("UsersPref")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snap) {
          if (snap.connectionState == ConnectionState.done) {
            for (int i = 0; i < 7; i++) {
              if (snap.data?.get('workouts amount')[i]) {
                daysOfWorkout[getDay(i)] = true;
              } else {
                daysOfWorkout[getDay(i)] = false;
              }
            }
          }
          return FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("Summary")
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                      snapshot) {
                if (snapshot.hasError) {
                  return const Text("Error");
                }
                setDataList();
                if (snapshot.connectionState == ConnectionState.done &&
                    listOfKeys?.isNotEmpty == true) {
                  setDataList();
                  var weeks = snapshot.data?.data()?.keys;
                  var numberOfArrays = snapshot.data?.data()?.length;
                  var listOFweeks = weeks?.toList();
                  var days = snapshot.data?.data()?.keys;
                  var listOfDays = days?.toList();
                  return Scaffold(
                    bottomNavigationBar: const BottomNavBar(),
                    appBar: buildAppBar(context, "Summary"),
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 400,
                            child: ListView.builder(
                              itemCount: listOfKeys?.length,
                              itemExtent: 400,
                              reverse: true,
                              scrollDirection: Axis.horizontal,
                              physics: PageScrollPhysics(),
                              itemBuilder: (BuildContext context, int i) {
                                var workoutTime =
                                    snapshot.data?.get('${listOfDays![1]}');
                                print(workoutTime[4].substring(18));
                                final List<ChartData> chartData = [
                                  ChartData('Mon', 30),
                                  ChartData('Tue', 30),
                                  ChartData('Wed', 0),
                                  ChartData('Thu', 25),
                                  ChartData('Fri', 45),
                                  ChartData('Sat', 0),
                                  ChartData('Sun', 30)
                                ];

                                return SfCartesianChart(
                                  title: ChartTitle(
                                      text: listOfKeys?[i] as String),
                                  primaryXAxis: CategoryAxis(),
                                  series: <ChartSeries<ChartData, dynamic>>[
                                    ColumnSeries<ChartData, String>(
                                        dataSource: mainMap[i],
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y)
                                  ],
                                );
                              },
                            )),
                      ],
                    ),
                  );
                } else {
                  return Scaffold();
                }
              });
        });
  }
}
