import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:io_project/Workout_Pages/TrainingSummary.dart';
import 'package:io_project/Workout_Pages/buildTraining.dart';
import 'package:io_project/Workout_Pages/cardio/cTrainingA.dart';
import 'package:io_project/Workout_Pages/buildExDescription.dart';
import 'package:io_project/widget/buttons_widget.dart';
import 'package:io_project/constants.dart';

import '../widget/appbar_widget.dart';
import '../widget/bottom_nav_bar.dart';

double multiplier = 1;

// ignore: camel_case_types
class buildExerciseReps extends StatefulWidget {
  final String exName;
  final String trType;
  final bool isFinal; //if exercise is the last one of the training

  const buildExerciseReps(
      {Key? key,
      required this.exName,
      required this.trType,
      required this.isFinal})
      : super(key: key);
  @override
  _buildExerciseRepsState createState() => _buildExerciseRepsState();
}

var duration = 60;
var reps = 12;
var sets = 3;
late String name;

class _buildExerciseRepsState extends State<buildExerciseReps> {
  late bool isCompleted = false;
  //int licznik = 0;

  void getDifficulty() async {
    await FirebaseFirestore.instance
        .collection("UsersPref")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => {multiplier = value['difficulty']});
  }
/*
  void amountOfReps() async {

  }
  */

  @override
  void initState() {
    super.initState();
    getDifficulty();
  }

  @override
  Widget build(BuildContext context) {
    //getDifficulty();
    var size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection(widget.trType)
            .doc(widget.exName)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            name = snapshot.data?.get('name');
            reps = snapshot.data?.get('reps');
            sets = snapshot.data?.get('sets');
            return Scaffold(
              appBar: AppBar(
                title: Text(name,
                    style: const TextStyle(fontSize: 24, fontFamily: "Cairo")),
                leading: const BackButton(),
                backgroundColor: mBackgroundColor,
                elevation: 0,
              ),
              body: Stack(
                children: <Widget>[
                  Container(
                    // Here the height of the container is 45% of our total height
                    height: size.height * .95,
                    decoration: const BoxDecoration(
                      color: mBackgroundColor,
                      image: DecorationImage(
                        alignment: Alignment.centerLeft,
                        image:
                            AssetImage("assets/images/undraw_pilates_gpdb.png"),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView(
                        //Column
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        physics: const BouncingScrollPhysics(),
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              alignment: Alignment.center,
                              height: 52,
                              width: 52,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF2BEA1),
                                shape: BoxShape.circle,
                              ),
                              //SvgPicture.asset("assets/icons/menu.svg")
                              child: GestureDetector(
                                onTap: () {
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) =>
                                          BuilderOfDescription(
                                            exName: widget.exName,
                                          ));
                                },
                                child:
                                    SvgPicture.asset("assets/icons/menu.svg"),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Image.asset("assets/images/${widget.exName}.gif"),
                          const SizedBox(height: 20),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Text("Amount of reps: ${reps}",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 18)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Text("Amount of sets: ${sets}",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 18)),
                                        ],
                                      ),
                                    ),

                                    // BuildButtons(),
                                  ],
                                ),
                                const SizedBox(width: 20),
                                ButtonWidget(
                                    text: 'Done',
                                    onClicked: () {
                                      amountOfReps =
                                          amountOfReps + (reps * sets);
                                      setState(() {
                                        isCompleted = true;
                                      });
                                      print(amountOfReps);
                                    }),
                              ],
                            ),
                          ),
                          if (widget.isFinal == true && isCompleted == true)
                            //const Text("Done?"),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: SmallButtonWidget(
                                onClicked: () {
                                  print('test widget.isFinal');
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => TrainingSummary(
                                            trainingName: 'Training A',
                                            trainingType: widget.trType)),
                                  );
                                },
                              ),
                            )
                          else if (isCompleted == true)
                            //const Text("Done?"),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: SmallButtonWidget(
                                onClicked: () {
                                  Navigator.pop(context);
                                },
                              ),
                            )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Scaffold(
              appBar: buildAppBar(context, "Ex builder"),
              bottomNavigationBar: const BottomNavBar(),
              body: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                              child: const Text('Loading',
                                  style: TextStyle(
                                      fontFamily: 'Cairo', fontSize: 20)))),
                    ],
                  )));
        });
  }
}
