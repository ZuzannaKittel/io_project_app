import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:io_project/utils/user_preferences.dart';
import 'package:io_project/widget/appbar_widget.dart';

import '../constants.dart';
import '../widget/bottom_nav_bar.dart';

import 'package:flutter/services.dart';

import '../widget/buttons_widget.dart';

List<dynamic>? list;

class WeightPage extends StatefulWidget {
  const WeightPage({Key? key}) : super(key: key);

  @override
  _WeightPageState createState() => _WeightPageState();
}

List<dynamic>? testKgs;

void splitToTwoArrays(List<dynamic> sth) {
  for (int i = 0; i < sth.length; i++) {
    testKgs![i] = sth[i].substring(0, 3);
    print(sth[i].substring(0, 3));
    print(testKgs?[i]);
  }
}

class _WeightsData {
  _WeightsData(this.xValue, this.yValue);

  final int xValue;
  final int yValue;
}

int newWeight = 76;

var now = DateTime.now().toUtc().add(const Duration(hours: 2));

String date = ' ';
DateTime dateee = now;

void addWeight(double _weight) async {
  await FirebaseFirestore.instance
      .collection('Weights')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({
    'array': FieldValue.arrayUnion(['$_weight kg, $date'])
  });
}

void deleteWeight(String toDelete) async {
  await FirebaseFirestore.instance
      .collection('Weights')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({
    'array': FieldValue.arrayRemove([toDelete])
  }).whenComplete(() {
    print('Field Deleted');
  });
}

void updateWeightUserPref(double _weight) async {
  await FirebaseFirestore.instance
      .collection("UsersPref")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({
    if (now.compareTo(dateee) <= 0) 'weight': _weight,
  });
}

class _WeightPageState extends State<WeightPage> {
  /*final dane = FirebaseFirestore.instance
      .collection("Weights")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get()
      .then((value) => {list = value["array"]});*/
  List<_WeightsData> chartData = <_WeightsData>[];
  List<int> xValues = [1, 2, 3, 4, 5];
  List<int> yValues = [35, 28, 34, 32, 40];
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  String calkiemDlugiString = ' ';

  //late DateTime dateee;

  void setDate() async {
    date = DateFormat('yyyy-MM-dd').format(dateee);
  }

  String getText() {
    if (date == ' ') {
      return 'Select Date';
    } else {
      return date;
    }
  }

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    //if (newDate == null) return;

    setState(() => dateee = newDate!);
  }

  Widget build(BuildContext context) => FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("Weights")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          list = snapshot.data?.get("array");
          for (int i = 0; i < list!.length; i++) {
            calkiemDlugiString = calkiemDlugiString + list![i] + '\n';
          }
          return Scaffold(
              appBar: buildAppBar(context, "Weight History"),
              bottomNavigationBar: const BottomNavBar(),
              body: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  height: 1000,
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
                      Expanded(
                        child: Scrollbar(
                          isAlwaysShown: true,
                          interactive: true,
                          child: ListView.builder(
                              itemCount: list?.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                if (list?.length == 0) {
                                  return Text("Brak danych");
                                } else {
                                  return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                15,
                                              ),
                                            ),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                          width: 250,
                                          child: Text(list?[index],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Cairo',
                                                  fontSize: 18)),
                                        ),
                                        //SizedBox(width: 50),
                                        DeleteButtonWidget(onClicked: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: const Text('Alert',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: "Cairo")),
                                              content: const Text(
                                                  'Do you really want to delete this record?',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: "Cairo")),
                                              actions: <Widget>[
                                                Center(
                                                  child: Row(
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              deleteWeight(
                                                                  list?[index]);
                                                            });
                                                          },
                                                          child: const Text(
                                                              'yes',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      'Cairo',
                                                                  fontSize:
                                                                      16))),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'OK'),
                                                        child: const Text('no',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Cairo',
                                                                fontSize: 16)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ]);
                                }
                              }),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
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
                                const Text("Select date",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: 'Cairo', fontSize: 18)),
                                ButtonWidget(
                                    text: getText(),
                                    onClicked: () {
                                      setDate();
                                      pickDate(context);
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: myController,
                            decoration: InputDecoration(
                                labelText: "Enter your weight",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            maxLines: 1,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ButtonWidget(
                          text: "Submit",
                          onClicked: () {
                            //const Text('tescior');
                            if (date == ' ') {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  contentPadding: const EdgeInsets.all(30),
                                  title: const Text('Submit',
                                      style: TextStyle(
                                          fontSize: 18, fontFamily: "Cairo")),
                                  content: const Text('Please select a date',
                                      style: TextStyle(
                                          fontSize: 18, fontFamily: "Cairo")),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Cairo',
                                              fontSize: 18)),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  contentPadding: const EdgeInsets.all(30),
                                  title: const Text('Submit',
                                      style: TextStyle(
                                          fontSize: 18, fontFamily: "Cairo")),
                                  content: const Text(
                                      'A date has been selected correctly',
                                      style: TextStyle(
                                          fontSize: 18, fontFamily: "Cairo")),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Cairo',
                                              fontSize: 18)),
                                    ),
                                  ],
                                ),
                              );
                              print(myController.text);
                              setState(() {
                                addWeight(double.parse(myController.text));
                                updateWeightUserPref(
                                    double.parse(myController.text));
                              });
                            }
                            //deleteWeight();
                          }),
                    ],
                  )));
        } else {
          return Scaffold(
              appBar: buildAppBar(context, "Weight History"),
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
        }
      });
}

/* Text(calkiemDlugiString,
                                      style: const TextStyle(
                                          fontFamily: 'Cairo', fontSize: 18)))*/