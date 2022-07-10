import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'Ambulance_tile.dart';
import 'package:doctor_here/model/ambulance.dart';

class AmbulanceList extends StatefulWidget {
  @override
  _AmbulanceListState createState() => _AmbulanceListState();
}

class _AmbulanceListState extends State<AmbulanceList> {
  @override
  Widget build(BuildContext context) {
    final ambulances = Provider.of<List<Ambulance>>(context) ?? [];
    return ListView.builder(
      itemCount: ambulances.length,
      itemBuilder: (BuildContext context, int index) {
        return AmbulanceTile(ambulance: ambulances[index]);
      },
    );
  }
}
