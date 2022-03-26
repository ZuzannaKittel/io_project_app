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
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          onPrimary: Colors.white,
          primary: Color(0xFFF5CEB8),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          fixedSize: const Size(420, 80),
        ),
        child: Text(text,
            style: const TextStyle(fontSize: 24, fontFamily: "Cairo")),
        onPressed: onClicked,
      );
}
