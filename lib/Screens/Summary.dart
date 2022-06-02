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

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder:
        (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      return FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("Summary")
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .get(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) {
              return const Text("Error");
            }
            if (snapshot.connectionState == ConnectionState.done) {
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
                          itemCount: numberOfArrays,
                          itemExtent: 400,
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          physics: PageScrollPhysics(),
                          itemBuilder: (BuildContext context, int i) {
                            var workoutTime =
                                snapshot.data?.get('${listOfDays![1]}');
                            print(workoutTime[4].substring(18));
                            final List<ChartData> chartData = [
                              ChartData(
                                  listOfDays![1],
                                  int.parse(workoutTime[4].substring(
                                      18))), //tutaj probowalam, zeby sie chociaz dla jednego dnia wyswietlal sie dobyr czas treningu; ale mam problem z konwersja string na int; ide spac pa
                              ChartData('Tue', 30),
                              ChartData('Wed', 0),
                              ChartData('Thu', 25),
                              ChartData('Fri', 45),
                              ChartData('Sat', 0),
                              ChartData('Sun', 30)
                            ];

                            return SfCartesianChart(
                              title:
                                  ChartTitle(text: listOFweeks?[i] as String),
                              primaryXAxis: CategoryAxis(),
                              series: <ChartSeries<ChartData, dynamic>>[
                                ColumnSeries<ChartData, String>(
                                    dataSource: chartData,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y)
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
