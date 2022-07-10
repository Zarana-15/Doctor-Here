import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'Clinic_tile.dart';
import 'package:doctor_here/model/clinic.dart';

class ClinicList extends StatefulWidget {
  @override
  _ClinicListState createState() => _ClinicListState();
}

class _ClinicListState extends State<ClinicList> {
  @override
  Widget build(BuildContext context) {
    final clinics = Provider.of<List<Clinic>>(context) ?? [];
    return ListView.builder(
      itemCount: clinics.length,
      itemBuilder: (BuildContext context, int index) {
        return ClinicTile(clinic: clinics[index]);
      },
    );
  }
}
