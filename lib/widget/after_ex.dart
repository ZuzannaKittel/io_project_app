import 'package:flutter/material.dart';
import 'package:io_project/constants.dart';

class AfterEx extends StatelessWidget {
  // final String text;
  //final VoidCallback onClicked;

  const AfterEx({
    Key? key,
    //required this.text,
    //required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: AlertDialog(
          title: const Text('Submit',
              style: TextStyle(fontSize: 18, fontFamily: "Cairo")),
          content: const Text('Your preferences have been saved correctly',
              style: TextStyle(fontSize: 18, fontFamily: "Cairo")),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
