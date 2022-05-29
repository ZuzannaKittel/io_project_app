import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Summary extends StatefulWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}

final List<ChartData> chartData = [
  ChartData(1, 35),
  ChartData(2, 23),
  ChartData(3, 34),
  ChartData(4, 25),
  ChartData(5, 40)
];

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder:
        (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      return Scaffold(
        body: SfCartesianChart(
          series: <ChartSeries<ChartData, int>>[
            ColumnSeries<ChartData, int>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y)
          ],
        ),
      );
    });
  }
}
