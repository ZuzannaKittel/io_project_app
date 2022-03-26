import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, String content) {
  //final icon = CupertinoIcons.moon_stars;

  return AppBar(
    leading: const BackButton(),
    backgroundColor: const Color(0xFF817DC0),
    elevation: 0,
    /*  IconButton(
    actions: [
        icon: Icon(icon),
        onPressed: () {},
      ),
    ],*/
    title: Text(content, style: TextStyle(fontSize: 24, fontFamily: "Cairo")),
  );
}
