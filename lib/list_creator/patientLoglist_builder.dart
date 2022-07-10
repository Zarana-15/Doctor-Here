import 'package:doctor_here/list_creator/patientLog_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:doctor_here/model/appointment.dart';

class PatientLogList extends StatefulWidget {
  @override
  _PatientLogListState createState() => _PatientLogListState();
}

class _PatientLogListState extends State<PatientLogList> {
  @override
  Widget build(BuildContext context) {
    final appointment = Provider.of<List<Appointment>>(context) ?? [];

    return ListView.builder(
      itemCount: appointment.length,
      itemBuilder: (BuildContext context, int index) {
        return PatientLogTile(patientlog: appointment[index]);
      },
    );
  }
}
