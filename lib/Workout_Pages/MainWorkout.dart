import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:io_project/Workout_Pages/buildTraining.dart';
import 'package:io_project/Workout_Pages/other/OtherAll.dart';
import 'package:io_project/Workout_Pages/strength/StrengthAll.dart';
import 'package:io_project/widget/bottom_nav_bar.dart';
import 'package:io_project/widget/buttons_widget.dart';
import 'package:io_project/widget/category_card.dart';
import 'package:io_project/constants.dart';
import 'HIIT/HIITAll.dart';
import 'cardio/CardioAll.dart';
import 'other/OtherAll.dart';

List<dynamic>? list;
String getDay(int index) {
  if (index == 0) {
    return "Monday";
  } else if (index == 1) {
    return "Tuesday";
  } else if (index == 2) {
    return "Wednesday";
  } else if (index == 3) {
    return "Thursday";
  } else if (index == 4) {
    return 'Friday';
  } else if (index == 5) {
    return 'Saturday';
  } else {
    return 'Sunday';
  }
}

class Home_workout extends StatefulWidget {
  const Home_workout({Key? key}) : super(key: key);

  @override
  State<Home_workout> createState() => _Home_workoutState();
}

var now = DateTime.now().toUtc().add(const Duration(hours: 2));
String dayOfWeek = DateFormat('EEEE').format(now);

String trainingType = 'Cardio';

void getWorkoutForToday() {
//TODO:
//porownac zmienna dayOfWeek, zobaczycc jaki jest dzien tygodnia - jezeli firestore mowi, ze dzisiaj nie jest dzien treningowy to nie mozna wejsc w builder cwiczenia (pozniej sie zrobi ekran na zasadzie "dzisiaj nie cwiczyczysz")
//jezeli jest dobry dzien to szukamy jaki rodzaj treningu przypada na dzis
//ustawiamy zmienna trainingType na odpowiedni rodzaj treningu i wysylamy do buildera Treningu z odpowiednim trType
/* czyli: 
{
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BuilderOfTraining(trType: trainingType),
                              ),
                            );
                          },
*/
}

class _Home_workoutState extends State<Home_workout> {
  @override
  void initState() {
    super.initState();
    getWorkoutForToday();
  }

  @override
  Widget build(BuildContext context) {
    print(dayOfWeek);
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
                  SizedBox(height: size.height * 0.05),
                  Row(
                    children: [
                      /*Text(
                        "No pain\nno gain!",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      */
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Text('Today\'s workout',
                                style: TextStyle(
                                    fontFamily: 'Cairo', fontSize: 18)),
                          ),
                          SmallButtonWidget(
                            onClicked: () {},
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.05),
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
