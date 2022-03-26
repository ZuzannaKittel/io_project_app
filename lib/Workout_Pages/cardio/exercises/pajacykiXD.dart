import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:io_project/widget/bottom_nav_bar.dart';
import 'package:io_project/widget/button_widget.dart';
import 'package:io_project/constants.dart';

class JumpingJacks extends StatefulWidget {
  @override
  _JumpingJacksState createState() => _JumpingJacksState();
}

class _JumpingJacksState extends State<JumpingJacks> {
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;

  void resetTimer() => setState(() => seconds = maxSeconds);

  void StartTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        StopTimer(reset: false);
      }
    });
  }

  void StopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    timer?.cancel();

    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .95,
            decoration: const BoxDecoration(
              color: mBackgroundColor,
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF2BEA1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/icons/menu.svg"),
                    ),
                  ),
                  Text(
                    "Jumping Jacks",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  //SearchBar(),
                  /*Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .55,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[Image.asset("assets/images/jj.png")],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text("obrazek byle jaki na razie",
                        style:
                            const TextStyle(fontSize: 24, fontFamily: "Cairo")),
                  ),
                  */
                  const SizedBox(height: 40),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BuildTimer(),
                        const SizedBox(height: 80),
                        BuildButtons(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget BuildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimerButtonWidget(
                text: isRunning ? "Pause" : "Resume",
                onClicked: () {
                  if (isRunning) {
                    StopTimer(reset: false);
                  } else {
                    StartTimer(reset: false);
                  }
                },
              ),
              TimerButtonWidget(
                text: "Cancel",
                onClicked: () {
                  StopTimer();
                },
              ),
            ],
          )
        : TimerButtonWidget(
            text: "Start",
            onClicked: () {
              StartTimer();
            },
          );
  }

  Widget BuildTimer() => SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: seconds / maxSeconds,
              strokeWidth: 8,
              valueColor: AlwaysStoppedAnimation(Color(0xFFC7B8F5)),
            ),
            Center(child: BuildTime()),
          ],
        ),
      );

  Widget BuildTime() {
    return Text('$seconds',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 80,
        ));
  }
}
