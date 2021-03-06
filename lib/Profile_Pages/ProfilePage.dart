import 'package:flutter/material.dart';
import 'package:io_project/Profile_Pages/WeightPage.dart';
import 'package:io_project/Screens/Preferences.dart';
import 'package:io_project/model/user.dart';
import 'package:io_project/utils/user_preferences.dart';
import 'package:io_project/widget/appbar_widget.dart';
import 'package:io_project/widget/bottom_nav_bar.dart';
import 'package:io_project/widget/buttons_widget.dart';
import 'package:io_project/widget/numbers_widget.dart';
import 'package:io_project/widget/profile_widget.dart';
import 'package:io_project/Profile_Pages/EditProfile.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Users user = UserPreferences.myUser;

    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("UsersPref")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              bottomNavigationBar: const BottomNavBar(),
              body: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(height: size.height * 0.05),
                  ProfileWidget(
                    imagePath: user.getImage(),
                    onClicked: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const EditProfile()),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  buildName(user),
                  const SizedBox(height: 24),
                  Center(child: buildUpgradeButton()),
                  const SizedBox(height: 24),
                  NumbersWidget(
                    weight: snapshot.data?.get('weight').toString(),
                    height: snapshot.data?.get('height') as int,
                    bmi: snapshot.data?.get('BMI') as double,
                  ),
                  const SizedBox(height: 48),
                  buildAbout(snapshot.data?.get('about')),
                  const SizedBox(height: 24),
                  Center(child: buildWeightButton()),
                ],
              ),
            );
          } else {
            return Scaffold(
              bottomNavigationBar: const BottomNavBar(),
              body: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ProfileWidget(
                    imagePath: user.getImage(),
                    onClicked: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const EditProfile()),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  buildName(user),
                  const SizedBox(height: 24),
                  Center(child: buildUpgradeButton()),
                  const SizedBox(height: 24),
                  NumbersWidget(
                    weight: '1',
                    height: 1,
                    bmi: 1,
                  ),
                  const SizedBox(height: 48),
                  buildAbout("Loading"),
                ],
              ),
            );
          }
        });
  }

  Widget buildName(Users user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Preferences',
        onClicked: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Preferences()),
          );
        },
      );

  Widget buildAbout(String about) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              about,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  Widget buildWeightButton() => ButtonWidget(
        text: 'Your weight',
        onClicked: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const WeightPage()),
          );
        },
      );
}
