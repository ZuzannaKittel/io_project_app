import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:io_project/Screens/Summary.dart';
import 'package:io_project/Screens/weeklyTraining.dart';
import 'package:io_project/Workout_Pages/MainWorkout.dart';
import 'package:io_project/Workout_Pages/buildTraining.dart';
import 'package:io_project/Workout_Pages/calendar.dart';
import 'package:io_project/widget/bottom_nav_bar.dart';
import 'package:io_project/widget/category_card.dart';
import 'package:io_project/constants.dart';
import 'package:io_project/Workout_Pages/MainWorkout.dart';
//void main() => runApp(MyApp());

class MenuPage extends StatelessWidget {
  // This widget is the root of your application.
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
      home: _MenuPage(),
    );
  }
}

class _MenuPage extends StatelessWidget {
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
                        color: Color(0xFFF2BEA1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/icons/menu.svg"),
                    ),
                  ),
                  Text(
                    "Good Morning!",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontWeight: FontWeight.w900),
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
                          title: "Workout",
                          svgSrc: "assets/images/workout-min.jpg",
                          press: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const Home_workout()),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "Week",
                          svgSrc: "assets/images/week-min.jpg",
                          press: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const WeeklyTraining()),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "Calendar",
                          svgSrc: "assets/images/calendar-min.jpg",
                          press: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const CalendarPage()),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "Summary",
                          svgSrc: "assets/images/summary-min.jpg",
                          press: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Summary()),
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
