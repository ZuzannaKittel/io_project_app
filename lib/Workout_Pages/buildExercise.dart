import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:io_project/Workout_Pages/cardio/cTrainingA.dart';
import 'package:io_project/Workout_Pages/buildExDescription.dart';
import 'package:io_project/widget/buttons_widget.dart';
import 'package:io_project/constants.dart';

double multiplier = 1;

class buildExercise extends StatefulWidget {
  final String exName;
  final String imagePath;

  late bool isDone;

  //final String nextExName;

  buildExercise({
    Key? key,
    required this.exName,
    required this.imagePath,
    required this.isDone,
  }) : super(key: key);
  @override
  _buildExerciseState createState() => _buildExerciseState();
}

void getDifficulty() async {
  await FirebaseFirestore.instance
      .collection("test")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) => {multiplier = value['difficulty']});
}

var duration = 60;
late String name;
late int licznik = 0;

class _buildExerciseState extends State<buildExercise> {
  late bool isCompleted = false;
  //int licznik = 0;

  @override
  Widget build(BuildContext context) {
    getDifficulty();
    print(multiplier);
    var size = MediaQuery.of(context).size;
    if (licznik == 0) {
      return FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("workouts")
              .doc(widget.exName)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              name = snapshot.data?.get('name');
              duration = snapshot.data?.get('duration');
              licznik = 1;
              Scaffold(
                appBar: AppBar(
                  title: Text(name,
                      style:
                          const TextStyle(fontSize: 24, fontFamily: "Cairo")),
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
                          image: AssetImage(
                              "assets/images/undraw_pilates_gpdb.png"),
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
                            Image.asset(widget.imagePath),
                            const SizedBox(height: 20),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BuildTimer(),
                                  const SizedBox(height: 10),
                                  BuildButtons(),
                                ],
                              ),
                            ),
                            if (isCompleted == true && seconds != maxSeconds)
                              //const Text("Done?"),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: SmallButtonWidget(
                                  onClicked: () {
                                    licznik = 0;
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const cTrainingAPage()),
                                    );
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
            return const Text('Error');
          });
    } else {
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
                  image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
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
                                builder: (context) => BuilderOfDescription(
                                      exName: widget.exName,
                                    ));
                          },
                          child: SvgPicture.asset("assets/icons/menu.svg"),
                        ),
                      ),
                    ),
                    Image.asset(widget.imagePath),
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BuildTimer(),
                          const SizedBox(height: 10),
                          BuildButtons(),
                        ],
                      ),
                    ),
                    if (isCompleted == true && seconds != maxSeconds)
                      //const Text("Done?"),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SmallButtonWidget(
                          onClicked: () {
                            licznik = 0;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const cTrainingAPage()),
                            );
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
  }

  int seconds = (duration * multiplier).round();
  int maxSeconds = (duration * multiplier).round();

  Timer? timer;
  //XDDD

  //late bool isDone;

  void resetTimer() => setState(() => seconds = maxSeconds);

  void StartTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        StopTimer(reset: false);
      }
    });
  }

  void StopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    timer?.cancel();

    setState(() => timer?.cancel());
  }

  Widget BuildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    isCompleted = seconds == maxSeconds || seconds == 0;

    if (isCompleted == true) {
      widget.isDone = true;
    }
    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimerButtonWidget(
                text: isRunning ? "Pause" : "Resume",
                onClicked: () {
                  if (isRunning) {
                    StopTimer(reset: false);
                  } else {
                    StartTimer(reset: false);
                  }
                },
              ),
              const SizedBox(
                width: 10,
              ),
              TimerButtonWidget(
                text: "Cancel",
                onClicked: () {
                  StopTimer();
                },
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimerButtonWidget(
                text: "Start",
                onClicked: () {
                  StartTimer();
                },
              ),
              const SizedBox(
                width: 10,
              ),
              /*TimerButtonWidget(
                text: "Next",
                onClicked: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => BackAndForthSquats()),
                  );
                },
              ),
              */
            ],
          );
  }

  Widget BuildTimer() => SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: seconds / maxSeconds,
              strokeWidth: 8,
              valueColor: const AlwaysStoppedAnimation(Color(0xFFC7B8F5)),
            ),
            Center(child: BuildTime()),
          ],
        ),
      );

  Widget BuildTime() {
    return Text('$seconds',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 40,
        ));
  }
}
