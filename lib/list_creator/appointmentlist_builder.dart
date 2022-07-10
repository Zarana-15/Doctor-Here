import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'Appointment_tile.dart';
import 'package:doctor_here/model/appointment.dart';

class AppointmentList extends StatefulWidget {
  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  @override
  Widget build(BuildContext context) {
    final appointment = Provider.of<List<Appointment>>(context) ?? [];

    return ListView.builder(
      itemCount: appointment.length,
      itemBuilder: (BuildContext context, int index) {
        if (appointment.length != 0) {
          //print(index);
          return AppointmentTile(appointment: appointment[index]);
        } else {
          return Container();//Text("No Appointments Today ");
        }
      },
    );
  }
}
