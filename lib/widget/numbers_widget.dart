import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NumbersWidget extends StatefulWidget {
  const NumbersWidget({Key? key}) : super(key: key);

  @override
  State<NumbersWidget> createState() => _NumbersWidgetState();
}

double height = 0;
double weight = 0;
double BMI = 0;

void getB() async {
  await FirebaseFirestore.instance
      .collection("test")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) => {BMI = value['BMI']});
  if (BMI == 0) {
    BMI = 00;
  }
}

double getBMI() {
  getB();
  return BMI;
}

void getH() async {
  await FirebaseFirestore.instance
      .collection("test")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) => {height = value['height']});
  if (height == 0) {
    height = 00;
  }
}

double getHeight() {
  getH();
  return height;
}

class _NumbersWidgetState extends State<NumbersWidget> {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, '4.8', 'Ranking'),
          buildDivider(),
          buildButton(context, height.toString(), 'Height'),
          buildDivider(),
          buildButton(context, BMI.toString(), 'BMI'),
        ],
      );
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {
          height = getHeight();
          BMI = getBMI();
          print(height);
          print(BMI);
        },
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
