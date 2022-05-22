import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:io_project/Login_Pages/LoginPage.dart';
import 'package:io_project/constants.dart';
import 'package:io_project/widget/buttons_widget.dart';
import 'package:io_project/widget/ch_bdy_tp.dart';
import 'package:io_project/widget/choose_bdy_tp_wm.dart';
import 'package:io_project/widget/slider.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:math';
import '../Login_Pages/registration.dart';
import '../widget/appbar_widget.dart';
import '../widget/bottom_nav_bar.dart';

String tp = 'avg';
double? diffLvl = 5;
double? multp;
double? BMI;

int workoutsAmount = 2;
int weightValue = 65;
int heightValue = 170;
bool male = false;
bool fmale = true;
bool gainMuscles = false;
bool looseWeight = false;
bool improveCondition = true;
bool mon = false;
bool tue = false;
bool wed = false;
bool thur = false;
bool fri = false;
bool sat = false;
bool sun = false;

void changeDiflvlPref(double lvl) {
  diffLvl = lvl;
}

void bmi(int _height, int _weight) {
  BMI = ((_weight) / ((_height) * (_height))) * 10000;
  BMI = ((BMI! * pow(10.0, 2)).roundToDouble() / pow(10.0, 2));
}

void setMultiplier(double? diffLvl, double? bmi, String sex, String type) {
  double bmiScale = 0.5;
  if (bmi! > 18.5 && bmi < 29 && type == 'average' || type == 'muscular') {
    bmiScale = 1;
  }
  if (sex == "Male") {
    multp = (diffLvl! / 10) + bmiScale;
  } else if (sex == 'Female') {
    multp = (diffLvl! / 15) + bmiScale;
  }
  multp = ((multp! * pow(10.0, 2)).roundToDouble() / pow(10.0, 2));
}

void getData() async {
  final data = await FirebaseFirestore.instance
      .collection('UsersPref')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();
  Map<String, dynamic>? map = data.data();
  weightValue = map?['weight'];
  heightValue = map?['height'];
  if (map?['sex'] == "Male") {
    male = true;
    fmale = false;
  } else {
    male = false;
    fmale = true;
  }

  gainMuscles = map?['gain muscles'];
  looseWeight = map?['loose weight'];
  improveCondition = map?['improve condition'];
  mon = map?['workouts amount'][0];
  tue = map?['workouts amount'][1];
  wed = map?['workouts amount'][2];
  thur = map?['workouts amount'][3];
  fri = map?['workouts amount'][4];
  sat = map?['workouts amount'][5];
  sun = map?['workouts amount'][6];

  diffLvl = map?['level'];
  multp = map?['difficulty'];

  print(diffLvl);
}

class Preferences extends StatefulWidget {
  const Preferences({Key? key}) : super(key: key);

  @override
  State<Preferences> createState() => PreferencesState();
}

//int workoutsAmount = 2;

var now = DateTime.now().toUtc().add(const Duration(hours: 2));

String date = DateFormat('yyyy-MM-dd').format(now);

void setDataTest() async {
  print(diffLvl);
  await FirebaseFirestore.instance
      .collection("UsersPref")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({
    'level': diffLvl,
    'difficulty': multp,
    'workouts amount': [mon, tue, wed, thur, fri, sat, sun],
    'gain muscles': gainMuscles,
    'loose weight': looseWeight,
    'improve condition': improveCondition,
  });
}

void addData(int _weight) async {
  await FirebaseFirestore.instance
      .collection('Weights')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({
    'array': FieldValue.arrayUnion(['$_weight kg, $date'])
  });
}

class PreferencesState extends State<Preferences> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, "Your Preferences"),
      bottomNavigationBar: const BottomNavBar(),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                const SizedBox(
                  height: 20,
                ),
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
                      const Text("Select difficulty level",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 18)),
                      SliderLevelPref(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text("Select when you want to exercise",
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 18)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Checkbox(
                                activeColor: neonGreen,
                                //hoverColor: kLightOrangeColor,
                                //mouseCursor: kLightOrangeColor,
                                //shape: RoundRangeSliderThumbShape,
                                value: mon,
                                onChanged: (bool? value) {
                                  setState(() {
                                    mon = value!;
                                  });
                                },
                              ),
                              const Text("Mon"),
                            ],
                          ),
                          Column(
                            children: [
                              Checkbox(
                                activeColor: neonGreen,
                                //hoverColor: kLightOrangeColor,
                                //mouseCursor: kLightOrangeColor,
                                //shape: RoundRangeSliderThumbShape,
                                value: tue,
                                onChanged: (bool? value) {
                                  setState(() {
                                    tue = value!;
                                  });
                                },
                              ),
                              const Text("Tue"),
                            ],
                          ),
                          Column(
                            children: [
                              Checkbox(
                                activeColor: neonGreen,
                                //hoverColor: kLightOrangeColor,
                                //mouseCursor: kLightOrangeColor,
                                //shape: RoundRangeSliderThumbShape,
                                value: wed,
                                onChanged: (bool? value) {
                                  setState(() {
                                    wed = value!;
                                  });
                                },
                              ),
                              const Text("Wed"),
                            ],
                          ),
                          Column(
                            children: [
                              Checkbox(
                                activeColor: neonGreen,
                                //hoverColor: kLightOrangeColor,
                                //mouseCursor: kLightOrangeColor,
                                //shape: RoundRangeSliderThumbShape,
                                value: thur,
                                onChanged: (bool? value) {
                                  setState(() {
                                    thur = value!;
                                  });
                                },
                              ),
                              const Text("Thur"),
                            ],
                          ),
                          Column(
                            children: [
                              Checkbox(
                                activeColor: neonGreen,
                                //hoverColor: kLightOrangeColor,
                                //mouseCursor: kLightOrangeColor,
                                //shape: RoundRangeSliderThumbShape,
                                value: fri,
                                onChanged: (bool? value) {
                                  setState(() {
                                    fri = value!;
                                  });
                                },
                              ),
                              const Text("Fri"),
                            ],
                          ),
                          Column(
                            children: [
                              Checkbox(
                                activeColor: neonGreen,
                                //hoverColor: kLightOrangeColor,
                                //mouseCursor: kLightOrangeColor,
                                //shape: RoundRangeSliderThumbShape,
                                value: sat,
                                onChanged: (bool? value) {
                                  setState(() {
                                    sat = value!;
                                  });
                                },
                              ),
                              const Text("Sat"),
                            ],
                          ),
                          Column(
                            children: [
                              Checkbox(
                                activeColor: neonGreen,
                                //hoverColor: kLightOrangeColor,
                                //mouseCursor: kLightOrangeColor,
                                //shape: RoundRangeSliderThumbShape,
                                value: sun,
                                onChanged: (bool? value) {
                                  setState(() {
                                    sun = value!;
                                  });
                                },
                              ),
                              const Text("Sun"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                      const Text("What do you want to achieve?",
                          style: const TextStyle(
                              fontFamily: 'Cairo', fontSize: 18)),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text("Gain Muscles"),
                              Checkbox(
                                activeColor: neonGreen,
                                //hoverColor: kLightOrangeColor,
                                //mouseCursor: kLightOrangeColor,
                                //shape: RoundRangeSliderThumbShape,
                                value: gainMuscles,
                                onChanged: (bool? value) {
                                  setState(() {
                                    gainMuscles = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text("Loose Weight"),
                              Checkbox(
                                activeColor: neonGreen,
                                value: looseWeight,
                                onChanged: (bool? value) {
                                  setState(() {
                                    looseWeight = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text("Better Condition"),
                              Checkbox(
                                activeColor: neonGreen,
                                value: improveCondition,
                                onChanged: (bool? value) {
                                  setState(() {
                                    improveCondition = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                    text: "Submit",
                    onClicked: () {
                      //const Text('tescior');
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          contentPadding: const EdgeInsets.all(30),
                          title: const Text('Submit',
                              style:
                                  TextStyle(fontSize: 18, fontFamily: "Cairo")),
                          content: const Text(
                              'Your preferences have been saved correctly',
                              style:
                                  TextStyle(fontSize: 18, fontFamily: "Cairo")),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo',
                                      fontSize: 18)),
                            ),
                          ],
                        ),
                      );
                      String sex;
                      if (male) {
                        sex = 'Male';
                      } else {
                        sex = 'Female';
                      }
                      setState(() {
                        bmi(heightValue, weightValue);
                        setMultiplier(diffLvl, BMI, sex, tp);
                        setDataTest();
                      });
                    }),
              ],
            )),
      ),
    );
  }
}
