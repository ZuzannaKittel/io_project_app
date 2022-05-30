import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:io_project/constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../widget/appbar_widget.dart';

int timeOfWorkout = 18;
List<dynamic>? list;

void getData() async {
  final data = await FirebaseFirestore.instance
      .collection('UsersPref')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();
  Map<String, dynamic>? map = data.data();

  timeOfWorkout = map?['time of workout'];

  print(timeOfWorkout);
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

var array;

class _CalendarPageState extends State<CalendarPage> {
  String calkiemDlugiString = ' ';
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("Weights")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            list = snapshot.data?.get("array");
            return Scaffold(
              appBar: buildAppBar(context, "Calendar"),
              body: SfCalendar(
                view: CalendarView.month,
                monthViewSettings: const MonthViewSettings(
                    showAgenda: true,
                    agendaStyle: AgendaStyle(
                      backgroundColor: kBackgroundColor,
                      appointmentTextStyle: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: kTextColor),
                      dateTextStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                      dayTextStyle: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    )),
                firstDayOfWeek: 1,
                dataSource: MeetingDataSource(getAppointments()),
              ),
            );
          }
          return Scaffold(
            appBar: buildAppBar(context, "Calendar"),
          );
        });
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, timeOfWorkout, 0, 0);
  final DateTime endTime = startTime.add(const Duration(minutes: 30));
  List<String> daysArray = ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'];
  String selection = '';
  for (int i = 0; i < 7; i++) {
    if (array[i] == true) {
      selection += daysArray[i].toString() + ',';
    }
  }
  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Workout',
      color: kLightOrangeColor,
      recurrenceRule: 'FREQ=WEEKLY;BYDAY=$selection',
      isAllDay: false));
  print(selection);
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

//ponizej test
/*
List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  final DateTime idk = startTime.add(const Duration(minutes: 30));
  List<dynamic>? dates;
  List<dynamic>? kgs; //kilograms
  int j = 0;
  int k = 0;
  int poStringuList = 0;
  int poStringuDates = 0;
  int poStringuKgs = 0;

  for (int i = 0; i < list!.length; i++) {
    while (list![i][poStringuList + 1] != ',') {
      kgs![k][poStringuKgs] = list![i][poStringuList];
      poStringuKgs++;
      poStringuList++;
    }
    poStringuList = poStringuList + 2;
    while (list![i]) {
      dates![j][poStringuDates] = list![i];
      poStringuDates++;
      poStringuList++;
    }

    k++;
    j++;
    //meetings.add(Meeting(list![i], startTime, endTime, neonBlue, false));
  }
  print(kgs);
  print(kgs!.length);
  print('test');
  for (int k = 0; k < kgs!.length; k++) {
    meetings.add(Meeting(kgs[k], startTime, idk, neonBlue, false));
    j++;
  }
  meetings.add(Meeting(
      'Conference', startTime, endTime, const Color(0xFF0F8644), false));

  return meetings;
}

class MeetingDataSource2 extends CalendarDataSource {
  MeetingDataSource2(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
*/
