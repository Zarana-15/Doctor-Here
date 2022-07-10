import 'package:flutter/material.dart';
import 'package:doctor_here/model/clinic.dart';
import 'package:doctor_here/screens/clinicDetails.dart';
//import 'package:intl/intl.dart';

class ClinicTile extends StatelessWidget {
  final Clinic clinic;
  ClinicTile({this.clinic});
  @override
  Widget build(BuildContext context) {
    var name = clinic.drname.toUpperCase().split(" ");
    var n = '';
    try {
      n = name[0].substring(0, 1) + name[1].substring(0, 1);
    } catch (Exception) {
      n = name[0].substring(0, 1);
    }
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          isThreeLine: true,
          //dense: true,
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.blueGrey,
            child: Text(n,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          title: Text("Dr. "+clinic.drname.toUpperCase() + "- " + clinic.clinicname,
              style: TextStyle(color: Colors.black)),
          subtitle: Text(
              'Speciality: ${clinic.speciality}\nAddress: ${clinic.address}',
              style: TextStyle(color: Colors.black)),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ClinicDetails(
                        clinic.drname,
                        clinic.clinicname,
                        clinic.address,
                        clinic.speciality,
                        clinic.phone,
                        clinic.pincode,
                        clinic.timing,
                        clinic.druid)));
          },
        ),
      ),
    );
  }
}
