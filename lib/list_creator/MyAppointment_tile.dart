import 'package:doctor_here/screens/PatAppointmentDetail.dart';
//import 'package:doctor_here/screens/chat.dart';
import 'package:flutter/material.dart';
import 'package:doctor_here/model/myappointment.dart';
//import '../services/database.dart';
//import 'package:intl/intl.dart';

class MyAppointmentTile extends StatelessWidget {
  final MyAppointment myappointment;
  MyAppointmentTile({this.myappointment});
  @override
  Widget build(BuildContext context) {
    var date = myappointment.date;
    var name = myappointment.name.toUpperCase().split(" ");
    var n = '';
    var names = myappointment.name.split(" ");
    var ns = '';
    try {
      try {
        n = name[0].substring(0, 1) + name[1].substring(0, 1);
      } catch (Exception) {
        n = name[0].substring(0, 1);
      }
      try {
        ns = names[0].substring(0, 1).toUpperCase() +
            names[0].substring(1) +
            " " +
            names[1].substring(0, 1).toUpperCase() +
            names[1].substring(1);
      } catch (Exception) {
        ns = names[0].substring(0, 1).toUpperCase() + names[0].substring(1);
      }
    } catch (Exception) {}
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
          title: Text(
              "Dr. " + myappointment.drname.toUpperCase() + "\nPatient:" + ns,
              style: TextStyle(color: Colors.black)),
          subtitle: Text('Time: ' + myappointment.time + ' Date:' + date,
              style: TextStyle(color: Colors.black)),
          onTap: () {
            print("${myappointment.drname}");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PatAppointmentDetails(myappointment)));
          },
        ),
      ),
    );
  }
}
