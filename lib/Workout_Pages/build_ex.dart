import 'package:flutter/material.dart';

class BuildExe extends StatefulWidget {
  const BuildExe({Key? key}) : super(key: key);

  @override
  State<BuildExe> createState() => _BuildExeState();
}

class _BuildExeState extends State<BuildExe> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 0.95,
        color: Colors.white,
      ),
    );
  }
}
