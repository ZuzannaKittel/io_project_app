import 'package:flutter/material.dart';

class ExButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ExButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        onPrimary: Colors.white,
        primary: const Color(0xFFF5CEB8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        fixedSize: const Size(420, 100),
      ),
      onPressed: onClicked,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              20,
            ),
          ),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(text,
              style: const TextStyle(fontSize: 24, fontFamily: "Cairo")),
        ),
      ));
}
