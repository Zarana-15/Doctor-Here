import 'package:doctor_here/screens/AppoinmentDetails.dart';
//import 'package:doctor_here/screens/chat.dart';
//import 'package:doctor_here/services/database.dart';
import 'package:flutter/material.dart';
import 'package:doctor_here/model/appointment.dart';
//import 'package:intl/intl.dart';

class PatientLogTile extends StatelessWidget {
  final Appointment patientlog;
  PatientLogTile({this.patientlog});

  @override
  Widget build(BuildContext context) {
    var date = patientlog.date;
    var name = patientlog.name.split(" ");
    //var ptuid =  getPatUid(patientlog.name).toString();
    var n = '';
    try {
      try {
        n = name[0].substring(0, 1) + name[1].substring(0, 1);
      } catch (Exception) {
        n = name[0].substring(0, 1);
      }
    } catch (Exception) {}

    //var now = DateTime.now();
    //String today = DateFormat('dd/MM/yyyy').format(now);
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.blueGrey,
            child: Text(n,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          title: Text(patientlog.name, style: TextStyle(color: Colors.black)),
          subtitle: Text('Time: ' + patientlog.time + ' Date:' + date,
              style: TextStyle(color: Colors.black)),
          onTap: () {
            print("${patientlog.name}");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AppointmentDetails(appointment: patientlog)));
          },
        ),
      ),
    );
  }
}
