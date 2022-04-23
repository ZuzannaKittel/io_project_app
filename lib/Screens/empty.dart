import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
void changeType(String type) {
  tp = type;
}

void changeDiflvl(double lvl) {
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

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

int weightValue = 65;
int heightValue = 170;
bool male = false;
bool fmale = true;

var now = DateTime.now().toUtc().add(Duration(hours: 2));

String date = DateFormat('yyyy-MM-dd – kk:mm').format(now);

void setData(int _height, int _weight, String sex) async {
  //liczenie BNI jeszcze nie dobre

  await FirebaseFirestore.instance
      .collection("test")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({'BMI': BMI, 'level ': diffLvl, 'Sex': sex, 'Difficulty': multp});
}

void addData(int _height, int _weight, String type) async {
  await FirebaseFirestore.instance
      .collection('test')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set({
    'height ' + date: _height,
    'weight ' + date: _weight,
    'type ' + date: type,
  }, SetOptions(merge: true)).then((value) {});
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Your Preferences"),
      bottomNavigationBar: const BottomNavBar(),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            height: MediaQuery.of(context).size.height,
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
                if (male) ChooseBodyTypeMan() else ChooseBodyTypeWomen(),
                const SizedBox(
                  height: 20,
                ),
                /* Text(
                  "Choose your body type",
                  textAlign: TextAlign
                      .left, /*style: TextStyle(color: kBackgroundColor)*/
                ),
                 SliderBodyType(),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text("Man"),
                        Checkbox(
                          activeColor: neonBlue,
                          //hoverColor: kLightOrangeColor,
                          //mouseCursor: kLightOrangeColor,
                          //shape: RoundRangeSliderThumbShape,
                          value: male,
                          onChanged: (bool? value) {
                            setState(() {
                              male = value!;
                              fmale = !value;
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Woman"),
                        Checkbox(
                          activeColor: neonBlue,
                          value: fmale,
                          onChanged: (bool? value) {
                            setState(() {
                              male = !value!;
                              fmale = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text("Select difficulty level", textAlign: TextAlign.left),
                SliderLevel(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text('Weight'),
                        NumberPicker(
                            minValue: 20,
                            maxValue: 150,
                            value: weightValue,
                            onChanged: (value) => setState(() {
                                  weightValue = value;
                                })),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Height'),
                        NumberPicker(
                            minValue: 120,
                            maxValue: 220,
                            value: heightValue,
                            onChanged: (value) => setState(() {
                                  heightValue = value;
                                })),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                    text: "Submit",
                    onClicked: () {
                      String sex;
                      if (male) {
                        sex = 'Male';
                      } else {
                        sex = 'Female';
                      }
                      bmi(heightValue, weightValue);
                      setMultiplier(diffLvl, BMI, sex, tp);
                      addData(heightValue, weightValue, tp);
                      setData(heightValue, weightValue, sex);
                    }),
              ],
            )),
      ),
    );
  }
}
