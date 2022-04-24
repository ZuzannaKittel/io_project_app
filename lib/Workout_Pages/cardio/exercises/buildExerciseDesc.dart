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
              height: 600,
              /*
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    //Color(0xFF817DC0),
                    Colors.grey,
                  ],
                ),
              ),
              */
              color: Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child:
                  ListView(physics: const BouncingScrollPhysics(), children: [
                /*Text('ExDescription',
                    style: Theme.of(context).textTheme.headline6),*/
                const SizedBox(
                  height: 20,
                ),
                Text("Jesli dane sie nie zaladowaly - odswiez strone",
                    textAlign: TextAlign.left),
                const SizedBox(
                  height: 50,
                ),
                //Image.asset("assets/images/jj.png"),
                //stringGetExDescription(),
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    exDescription,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        fontFamily: "Cairo"),
                  ),
                ),
              ]),
            ),
          )),
    );
  }
}
