import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:io_project/utils/user_preferences.dart';
import 'package:io_project/widget/appbar_widget.dart';

import '../constants.dart';
import '../widget/bottom_nav_bar.dart';

List<dynamic>? list;

class WeightPage extends StatefulWidget {
  const WeightPage({Key? key}) : super(key: key);

  @override
  _WeightPageState createState() => _WeightPageState();
}

List<dynamic>? testKgs;

void splitToTwoArrays(List<dynamic> sth) {
  for (int i = 0; i < sth.length; i++) {
    testKgs![i] = sth[i].substring(0, 3);
    print(sth[i].substring(0, 3));
    print(testKgs?[i]);
  }
}

class _WeightsData {
  _WeightsData(this.xValue, this.yValue);

  final int xValue;
  final int yValue;
}

class _WeightPageState extends State<WeightPage> {
  /*final dane = FirebaseFirestore.instance
      .collection("Weights")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get()
      .then((value) => {list = value["array"]});*/
  List<_WeightsData> chartData = <_WeightsData>[];
  List<int> xValues = [1, 2, 3, 4, 5];
  List<int> yValues = [35, 28, 34, 32, 40];
  String calkiemDlugiString = ' ';
  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("Weights")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          list = snapshot.data?.get("array");
          for (int i = 0; i < list!.length; i++) {
            calkiemDlugiString = calkiemDlugiString + list![i] + '\n';
          }
          return Scaffold(
              appBar: buildAppBar(context, "Weight History"),
              bottomNavigationBar: const BottomNavBar(),
              body: SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 40),
                      height: 800,
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
                          Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                  child: Text(calkiemDlugiString,
                                      style: const TextStyle(
                                          fontFamily: 'Cairo', fontSize: 18)))),
                        ],
                      ))));
        } else {
          return Scaffold(
            appBar: buildAppBar(context, "Weight History"),
            bottomNavigationBar: const BottomNavBar(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Loading")],
            ),
          );
        }
      });
}
