import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:io_project/Login_Pages/LoginPage.dart';
import 'package:io_project/constants.dart';
import 'package:io_project/widget/buttons_widget.dart';
import 'package:io_project/widget/slider.dart';
import 'package:numberpicker/numberpicker.dart';

import '../Login_Pages/registration.dart';
import '../widget/appbar_widget.dart';
import '../widget/bottom_nav_bar.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

int weightValue = 65;
int heightValue = 170;
bool male = false;
bool fmale = false;

DateTime now = new DateTime.now();
DateTime date = new DateTime(now.year, now.month, now.day);

String Date = DateFormat('yyyy-MM-dd – kk:mm').format(now);

void setData(int _height, int _weight) async {
  double BMI; //liczenie BNI jeszcze nie dobre
  BMI = ((_weight) / (_height) * (_height));
  await FirebaseFirestore.instance
      .collection("test")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set({
    'height': _height,
    'weight': _weight,
    'BMI': BMI,
  });
}

void addData(int _height, int _weight) async {
  await FirebaseFirestore.instance
      .collection('test')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set({'height ' + Date: _height, 'weight ' + Date: _weight},
          SetOptions(merge: true)).then((value) {
    //Do your stuff.
  });
}

Future<void> uploadingData(
    String _productName, String _productPrice, bool _isFavorite) async {
  await FirebaseFirestore.instance.collection("products").add({
    'productName': _productName,
    'productPrice': _productPrice,
    'isFavourite': _isFavorite,
  });
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
                Image.asset("assets/images/body-types.png"),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Choose your body type",
                  textAlign: TextAlign
                      .left, /*style: TextStyle(color: kBackgroundColor)*/
                ),
                SliderBodyType(),
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
                SizedBox(
                  height: 20,
                ),
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
                SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                    text: "Submit",
                    onClicked: () {
                      //setData(heightValue as int, weightValue as int);
                      addData(heightValue as int, weightValue as int);
                    }),
              ],
            )),
      ),
    );
  }
}
