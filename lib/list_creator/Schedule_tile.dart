import 'package:doctor_here/model/schedule.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleTile extends StatelessWidget {
  final Schedule schedule;
  ScheduleTile({this.schedule});
  @override
  Widget build(BuildContext context) {
    var date = schedule.date;

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
              child: Icon(Icons.person,color: Colors.white,),
            ),
            title: Text('Time: ' + schedule.time + ' Date:' + date,
                style: TextStyle(color: Colors.black)),
            subtitle: Text('Appointment Booked',
                style: TextStyle(color: Colors.black)),
            onTap: () {
              print("${schedule.name}");
            },
          ),
        ),
      );
    } else {
      return Container(
        width: 0,
        height: 0,
      );
    }
  }
}
