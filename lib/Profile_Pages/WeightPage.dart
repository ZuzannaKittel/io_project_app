import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:io_project/widget/appbar_widget.dart';

import '../widget/bottom_nav_bar.dart';

List<dynamic>? list;

class WeightPage extends StatefulWidget {
  const WeightPage({Key? key}) : super(key: key);

  @override
  _WeightPageState createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  final dane = FirebaseFirestore.instance
      .collection("Weights")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get()
      .then((value) => {list = value["array"]});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: buildAppBar(context, "Weight History"),
      bottomNavigationBar: const BottomNavBar(),
      body: ListView.builder(
          itemCount: list?.length,
          itemBuilder: (BuildContext ctxt, int index) {
            if (list?.length == 0) {
              return Text("Brak danych");
            } else {
              return Text(list?[index]);
            }
          }));
}
