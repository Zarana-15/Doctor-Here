import 'package:flutter/material.dart';
import 'package:doctor_here/model/ambulance.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:intl/intl.dart';

class AmbulanceTile extends StatelessWidget {
  final Ambulance ambulance;
  AmbulanceTile({this.ambulance});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.lightGreen[500],
            child: Icon(
              Icons.local_hotel,
              color: Colors.red,
            ),
          ),
          title: Text(ambulance.name, style: TextStyle(color: Colors.black)),
          subtitle: Text('Phone No. ${ambulance.phone}',
              style: TextStyle(color: Colors.black)),
          onTap: () {
            String no = "tel:0" + ambulance.phone.toString();
            launch(no);
          },
        ),
      ),
    );
  }
}
