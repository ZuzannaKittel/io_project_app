import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:io_project/constants.dart';
import 'package:io_project/menu_page.dart';
import 'package:io_project/profile_page.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BottomNavItem(
            title: "Profile",
            svgScr: "assets/icons/calendar.svg", press: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
          ),
          BottomNavItem(
            title: "Workout",
            svgScr: "assets/icons/gym.svg",
            isActive: true, press: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MenuPage()),
            );  },
          ),
          BottomNavItem(
            title: "Settings",
            svgScr: "assets/icons/Settings.svg", press: () {  },
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String svgScr;
  final String title;
  final VoidCallback press;
  final bool isActive;
  const BottomNavItem({
    Key? key,
    required this.svgScr,
    required this.title,
    required this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SvgPicture.asset(
            svgScr,
            color: isActive ? kActiveIconColor : kTextColor,
          ),
          Text(
            title,
            style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
          ),
        ],
      ),
    );
  }
}