import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:io_project/constants.dart';
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
  final double y;
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
  var keysFromFirestore = await FirebaseFirestore.instance
      .collection("SummaryWeeks")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get();
//Zapisanie do listy naglowkow z bazy danych
  listOfKeys = keysFromFirestore.data()?.keys.toList();
/*Niepotrzebny kod (zakladamy, ze osoba moze cwiczyc w inne dni niz wybrane)
  daysOfWorkout.forEach((key, value) {
    if (value) {
      counter++;
    }
  });*/
  //Pętla od 0 do liczby wpisanych treningow w bazie danych
  if (listOfKeys != null) {
    for (int i = 0; i < listOfKeys!.length; i++) {
      List<ChartData> dane = [];
      //Wpisywanie danych do Listy tymczasowej zgodnie z dniami tygodnia
      for (int j = 0; j < 7; j++) {
        if (keysFromFirestore.get(listOfKeys![i])[getDay(j)] != null) {
          dane.add(ChartData(getDay(j),
              (keysFromFirestore.get(listOfKeys![i])[getDay(j)]).toDouble()));
        } else {
          dane.add(ChartData(getDay(j), 0));
        }
      }
      //Zapisywanie Listy w mapie <int,List>
      mainMap[i] = dane;
    }
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
                                return SfCartesianChart(
                                  title: ChartTitle(
                                      text:
                                          'Week beginning: ${listOfKeys?[i] as String}'),
                                  primaryXAxis: CategoryAxis(),
                                  primaryYAxis: NumericAxis(
                                      title: AxisTitle(
                                          text: 'min',
                                          textStyle: const TextStyle(
                                              fontStyle: FontStyle.italic))),
                                  series: <ChartSeries<ChartData, dynamic>>[
                                    ColumnSeries<ChartData, String>(
                                        color: neonGreen,
                                        yAxisName: 'min',
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
                  return Scaffold(
                    bottomNavigationBar: const BottomNavBar(),
                    appBar: buildAppBar(context, "Summary"),
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 400,
                            child: ListView.builder(
                              itemCount: 1,
                              itemExtent: 400,
                              reverse: true,
                              scrollDirection: Axis.horizontal,
                              physics: PageScrollPhysics(),
                              itemBuilder: (BuildContext context, int i) {
                                final List<ChartData> chartData = [
                                  ChartData('Mon', 0),
                                  ChartData('Tue', 0),
                                  ChartData('Wed', 0),
                                  ChartData('Thu', 0),
                                  ChartData('Fri', 0),
                                  ChartData('Sat', 0),
                                  ChartData('Sun', 0)
                                ];

                                return SfCartesianChart(
                                  title: ChartTitle(text: 'Brak Treningow'),
                                  primaryXAxis: CategoryAxis(),
                                  series: <ChartSeries<ChartData, dynamic>>[
                                    ColumnSeries<ChartData, String>(
                                        dataSource: chartData,
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
                }
              });
        });
  }
}
