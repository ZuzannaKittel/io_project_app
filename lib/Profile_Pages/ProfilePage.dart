import 'package:flutter/material.dart';
import 'package:io_project/Screens/Preferences.dart';
import 'package:io_project/model/user.dart';
import 'package:io_project/utils/user_preferences.dart';
import 'package:io_project/widget/appbar_widget.dart';
import 'package:io_project/widget/bottom_nav_bar.dart';
import 'package:io_project/widget/buttons_widget.dart';
import 'package:io_project/widget/numbers_widget.dart';
import 'package:io_project/widget/profile_widget.dart';
import 'package:io_project/Profile_Pages/EditProfile.dart';
import 'package:io_project/Screens/Preferences.dart';

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

    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: size.height * 0.1),
          ProfileWidget(
            imagePath: user.getImage(),
            onClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const EditProfile()),
              );
            },
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          const NumbersWidget(),
          const SizedBox(height: 48),
          buildAbout(user),
        ],
      ),
    );
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

  Widget buildAbout(Users user) => Container(
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
              user.getAbt(),
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
