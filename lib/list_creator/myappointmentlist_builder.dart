import 'package:doctor_here/list_creator/MyAppointment_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:doctor_here/model/myappointment.dart';

class MyAppointmentList extends StatefulWidget {
  @override
  _MyAppointmentListState createState() => _MyAppointmentListState();
}

class _MyAppointmentListState extends State<MyAppointmentList> {
  @override
  Widget build(BuildContext context) {
    final myappointment = Provider.of<List<MyAppointment>>(context) ?? [];

    return ListView.builder(
      itemCount: myappointment.length,
      itemBuilder: (BuildContext context, int index) {
        return MyAppointmentTile(myappointment: myappointment[index]);
      },
    );
  }
}
