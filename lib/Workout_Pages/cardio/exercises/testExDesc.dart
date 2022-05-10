import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../widget/appbar_widget.dart';

class BuilderOfDescription extends StatefulWidget {
  late String exName;
  BuilderOfDescription({Key? key, required this.exName}) : super(key: key);

  @override
  State<BuilderOfDescription> createState() => _BuilderOfDescriptionState();
}

class _BuilderOfDescriptionState extends State<BuilderOfDescription> {
  String exDescription = '';

  @override
  Widget build(BuildContext context) {
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
            String data = snapshot.data?.get('tip');
            return Scaffold(
              appBar: buildAppBar(context, "Exercise Description"),
              backgroundColor: Colors.transparent,
              body: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 600,
                      color: Colors.grey.shade200,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            /*Text('ExDescription',
                    style: Theme.of(context).textTheme.headline6),*/
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
                                data,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    fontFamily: "Cairo"),
                              ),
                            ),
                          ]),
                    ),
                  )),
            );
          }
          return Text('Error 404');
        });
  }
}
