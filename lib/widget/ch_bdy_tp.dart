import 'package:flutter/material.dart';
import 'package:io_project/Screens/empty.dart';

int type = 1;

class ChooseBodyTypeMan extends StatefulWidget {
  ChooseBodyTypeMan({Key? key}) : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  State<ChooseBodyTypeMan> createState() => _ChooseBodyTypeManState();
}

class _ChooseBodyTypeManState extends State<ChooseBodyTypeMan> {
  late String tp;
  String retType(int t) {
    if (t == 1) {
      return 'Fat';
    } else if (t == 2) {
      return 'Average';
    }
    return 'Muscular';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  type = 1;
                  tp = 'fat';
                  changeType(tp);
                });
              },
              splashColor: Colors.black,
              child: const Image(
                image: AssetImage('assets/images/fat.png'),
                width: 100,
                height: 200,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  type = 2;
                  tp = 'average';
                  changeType(tp);
                });
              },
              splashColor: Colors.black,
              child: const Image(
                image: AssetImage('assets/images/medium.png'),
                width: 100,
                height: 200,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  type = 3;
                  tp = 'muscular';
                  changeType(tp);
                });
              },
              splashColor: Colors.black,
              child: const Image(
                image: AssetImage('assets/images/musc.png'),
                width: 100,
                height: 200,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          retType(type),
          style: const TextStyle(fontFamily: 'cairo', fontSize: 20),
        )
      ],
    );
  }
}
