import 'package:doctor_here/list_creator/ScheduleList_builder.dart';
import 'package:doctor_here/model/schedule.dart';
import 'package:doctor_here/services/database.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';

class ScheduleAppointment extends StatefulWidget {
  @override
  _ScheduleAppointmentPage createState() => _ScheduleAppointmentPage();
}

class _ScheduleAppointmentPage extends State<ScheduleAppointment> {
  Widget build(BuildContext context) {

    return StreamProvider<List<Schedule>>.value(
        value: DatabaseService().schedule,
        child: Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: GradientAppBar(
              gradient:
                  LinearGradient(colors: [Colors.blue[900], Colors.blue[500]]),
              title: Text('Appointment Availability'),
              centerTitle: true,
            ),
            body: ScheduleList()));
  }
}
