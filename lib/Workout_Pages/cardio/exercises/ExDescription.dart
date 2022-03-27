import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../widget/appbar_widget.dart';

class ExDescription extends StatelessWidget {
  const ExDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, "Exercise Description"),
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 320,
              color: kActiveIconColor,
              child:
                  ListView(physics: const BouncingScrollPhysics(), children: [
                /*Text('ExDescription',
                    style: Theme.of(context).textTheme.headline6),*/
                Image.asset("assets/images/jj.png"),
              ]),
            ),
          )),
    );
  }
}
