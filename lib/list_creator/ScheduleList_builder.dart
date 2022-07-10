import 'package:doctor_here/list_creator/Schedule_tile.dart';
import 'package:doctor_here/model/schedule.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ScheduleList extends StatefulWidget {
  @override
  _ScheduleListState createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  @override
  Widget build(BuildContext context) {
    final schedule = Provider.of<List<Schedule>>(context) ?? [];
    
    return ListView.builder(
      itemCount: schedule.length,
      itemBuilder: (BuildContext context, int index) {
        print(schedule.length);
        if (schedule.length != 0) {
          //print(index);
          return ScheduleTile(schedule: schedule[index]);
        } else {
          return Container();
        }
      },
    );
  }
}
