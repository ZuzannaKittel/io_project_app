import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../widget/appbar_widget.dart';

class ExDescription extends StatefulWidget {
  const ExDescription({Key? key}) : super(key: key);

  @override
  _ExDescriptionState createState() => _ExDescriptionState();
}

class _ExDescriptionState extends State<ExDescription> {
  late String exDescription;

  Future<void> getExDescription(String ex) async {
    await FirebaseFirestore.instance
        .collection("workouts")
        .doc(ex)
        .get()
        .then((value) => {exDescription = value['tip']});
  }

  String stringGetExDescription() {
    getExDescription("Jumping Jacks");
    return exDescription;
  }

  //funckja wywlujaca poyzsza i zwracajaca string exDscirpiton i wtedy wywolywac te funckje  w Text

  @override
  Widget build(BuildContext context) {
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

  /*
  Future<String> getExDescription(String ex) async {
    String exDescription;
    await FirebaseFirestore.instance
        .collection("about")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => {ex = value['tip']});
    return exDescription;
  }
  */
}
