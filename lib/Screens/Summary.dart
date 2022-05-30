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

final List<ChartData> chartData = [
  ChartData('Mon', 0),
  ChartData('Tue', 30),
  ChartData('Wed', 0),
  ChartData('Thu', 25),
  ChartData('Fri', 45),
  ChartData('Sat', 0),
  ChartData('Sun', 30)
];

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder:
        (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      return Scaffold(
        bottomNavigationBar: const BottomNavBar(),
        appBar: buildAppBar(context, "Summary"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries<ChartData, dynamic>>[
                  ColumnSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y)
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
