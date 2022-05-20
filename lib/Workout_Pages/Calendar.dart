import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:io_project/constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../widget/appbar_widget.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

var array;

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("UsersPref")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            array = snapshot.data?.get('workouts amount');
            return Scaffold(
              appBar: buildAppBar(context, "Calendar"),
              body: SfCalendar(
                view: CalendarView.week,
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
      DateTime(today.year, today.month, today.day, 8, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 6));
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
