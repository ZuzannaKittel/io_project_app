import 'package:flutter/material.dart';
import 'package:io_project/constants.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          onPrimary: Colors.white,
          primary: Color(0xFFC7B8F5),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: Text(text),
        onPressed: onClicked,
      );
}

class TimerButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const TimerButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          onPrimary: Colors.white,
          primary: Color(0xFF817DC0),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: Text(text,
            style: const TextStyle(fontSize: 18, fontFamily: "Cairo")),
        onPressed: onClicked,
      );
}

class SmallButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;

  const SmallButtonWidget({
    Key? key,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(CircleBorder()),
          padding: MaterialStateProperty.all(EdgeInsets.all(20)),
          backgroundColor:
              MaterialStateProperty.all(kLightOrangeColor), // <-- Button color
          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.pressed))
              return kActiveIconColor; // <-- Splash color
          }),
        ),
        /* style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          onPrimary: Colors.white,
          primary: kLightOrangeColor,
          padding: EdgeInsets.all(20),
        ),*/
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
        ),
        onPressed: onClicked,
      );
}
