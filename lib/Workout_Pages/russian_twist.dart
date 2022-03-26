import 'package:flutter/material.dart';
import 'package:io_project/widget/appbar_widget.dart';
import 'build_ex.dart';

class RusianTwist extends StatefulWidget {
  const RusianTwist({Key? key}) : super(key: key);

  @override
  State<RusianTwist> createState() => _RusianTwistState();
}

class _RusianTwistState extends State<RusianTwist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Russian Twist"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildExe(),
          ],
        ),
      ),
    );
  }
}
