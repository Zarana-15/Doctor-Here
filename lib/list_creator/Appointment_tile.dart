import 'package:doctor_here/screens/AppoinmentDetails.dart';
//import 'package:doctor_here/screens/doctorSettings.dart';
import 'package:flutter/material.dart';
import 'package:doctor_here/model/appointment.dart';
import 'package:intl/intl.dart';

class AppointmentTile extends StatelessWidget {
  final Appointment appointment;
  AppointmentTile({this.appointment});
  @override
  Widget build(BuildContext context) {
    var date = appointment.date;
    var name = appointment.name.toUpperCase().split(" ");
    var n = '';
    try {
      n = name[0].substring(0, 1) + name[1].substring(0, 1);
    } catch (Exception) {
      n = name[0].substring(0, 1);
    }
    var now = DateTime.now();
    String today = DateFormat('dd/MM/yyyy').format(now);
    if (date == today) {
      return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.blueGrey,
              child: Text(n, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
            ),
            title:
                Text(appointment.name, style: TextStyle(color: Colors.black)),
            subtitle: Text('Time: ' + appointment.time + ' Date:' + date,
                style: TextStyle(color: Colors.black)),
            onTap: () {
              print("${appointment.name}");
              Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentDetails(appointment: appointment)));
            },
          ),
        ),
      );
    } else {
      return Container(
        width: 1,
        height: 1,
      );
    }
  }
}
