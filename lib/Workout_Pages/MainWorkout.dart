import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:io_project/Workout_Pages/other/OtherAll.dart';
import 'package:io_project/Workout_Pages/strength/StrengthAll.dart';
import 'package:io_project/widget/bottom_nav_bar.dart';
import 'package:io_project/widget/category_card.dart';
import 'package:io_project/constants.dart';
import 'HIIT/HIITAll.dart';
import 'cardio/CardioAll.dart';
import 'other/OtherAll.dart';

class Home_workout extends StatefulWidget {
  const Home_workout({Key? key}) : super(key: key);

  @override
  State<Home_workout> createState() => _Home_workoutState();
}

class _Home_workoutState extends State<Home_workout> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu Page',
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      home: _WorkoutPage(),
    );
  }
}

class _WorkoutPage extends StatelessWidget {
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
            height: size.height * .45,
            decoration: const BoxDecoration(
              color: Color(0xFFF5CEB8),
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
                        color: Color.fromARGB(255, 242, 216, 161),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/icons/menu.svg"),
                    ),
                  ),
                  Text(
                    "No pain\nno gain!",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  //SearchBar(),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CategoryCard(
                          //TODO: changing images depending on user's sex
                          title: "STRENGTH",
                          svgSrc: "assets/images/strength.png",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const StrengthAll(),
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "CARDIO",
                          svgSrc: "assets/images/cardio.png",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CardioAll(),
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "HIIT",
                          svgSrc: "assets/images/HIIT.png",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HIITAll(),
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "OTHER",
                          svgSrc: "assets/images/other.png",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OtherAll(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
