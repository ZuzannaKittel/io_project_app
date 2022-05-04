import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:io_project/widget/appbar_widget.dart';

import '../widget/bottom_nav_bar.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({Key? key}) : super(key: key);

  @override
  _WeightPageState createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  final Stream<QuerySnapshot> _weightsStream =
      FirebaseFirestore.instance.collection('test').snapshots();
  //.doc(FirebaseAuth.instance.currentUser!.uid);
  //.snapshots();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: buildAppBar(context, "Weight History"),
        bottomNavigationBar: const BottomNavBar(),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          physics: const BouncingScrollPhysics(),
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _weightsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['Sex']),
                      //subtitle: Text(data['BMI'].toString()),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      );
}
