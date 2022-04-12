import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:io_project/constants.dart';
import 'package:io_project/widget/appbar_widget.dart';
import 'dart:ui';

String exDescription = '';

// ignore: camel_case_types
class buildExDesc extends StatelessWidget {
  late String exName;
  buildExDesc({Key? key, required this.exName}) : super(key: key);

  void getExDescription(String name) async {
    await FirebaseFirestore.instance
        .collection("workouts")
        .doc(name)
        .get()
        .then((value) => {exDescription = value['tip']});
  }

  @override
  Widget build(BuildContext context) {
    getExDescription(exName);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, "Exercise Description"),
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 320,
              color: kBlueLightColor,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              child:
                  ListView(physics: const BouncingScrollPhysics(), children: [
                /*Text('ExDescription',
                    style: Theme.of(context).textTheme.headline6),*/
                Image.asset("assets/images/jj.png"),
                //stringGetExDescription(),
                Text(
                  exDescription,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ]),
            ),
          )),
    );
  }
}
