import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:io_project/constants.dart';
import 'package:io_project/widget/bottom_nav_bar.dart';
import 'package:io_project/widget/search_bar.dart';
import 'package:io_project/Workout_Pages/cardio/exercises/pajacykiXD.dart';

class TrainingAPage extends StatelessWidget {
  const TrainingAPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: const BoxDecoration(
              color: kBlueLightColor,
              image: DecorationImage(
                image: AssetImage("assets/images/trainingA.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      "Training",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 10),
                    const Text(
                      "20 MIN Course",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: size.width * .6, // it just take 60% of total width
                      child: const Text(
                        "A cardio workout increases blood flow and acts as a filter system. It brings nutrients like oxygen, protein, and iron to the muscles that you've been training and helps them recover faster.",
                      ),
                    ),
                    SizedBox(
                      width: size.width * .5, // it just take the 50% width
                      child: SearchBar(),
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: <Widget>[
                        Exercise(
                          exerciseNum: 1,
                          isDone: true,
                          press: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => JumpingJacks()),
                            );
                          },
                        ),
                        Exercise(
                          exerciseNum: 2,
                          press: () {},
                        ),
                        Exercise(
                          exerciseNum: 3,
                          press: () {},
                        ),
                        Exercise(
                          exerciseNum: 4,
                          press: () {},
                        ),
                        Exercise(
                          exerciseNum: 5,
                          press: () {},
                        ),
                        Exercise(
                          exerciseNum: 6,
                          press: () {},
                        ),
                      ],
                    ),
                    /*const SizedBox(height: 20),
                    Text(
                      "Meditation",
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding: EdgeInsets.all(10),
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 17),
                            blurRadius: 23,
                            spreadRadius: -13,
                            color: kShadowColor,
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/Meditation_women_small.svg",
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Basic 2",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                const Text("Start your deepen you practice")
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset("assets/icons/Lock.svg"),
                          ),
                        ],
                      ),
                    )*/
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Exercise extends StatelessWidget {
  final int exerciseNum;
  final bool isDone;
  final VoidCallback press;
  const Exercise({
    Key? key,
    required this.exerciseNum,
    this.isDone = false,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: constraint.maxWidth / 2 -
              10, // constraint.maxWidth provide us the available with for this widget
          // padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 23,
                spreadRadius: -13,
                color: kShadowColor,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: press,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 42,
                      width: 36,
                      decoration: BoxDecoration(
                        color: isDone ? kBlueColor : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: kBlueColor),
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: isDone ? Colors.white : kBlueColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Exercise $exerciseNum",
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
