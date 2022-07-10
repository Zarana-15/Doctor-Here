import 'package:flutter/material.dart';
import 'package:doctor_here/model/pharmacies.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:intl/intl.dart';

class PharmaciesTile extends StatelessWidget {
  final Pharmacies pharmacies;
  PharmaciesTile({this.pharmacies});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.lightGreen,
            child: Icon(
              Icons.local_hospital,
              size: 45,
              color: Colors.red,
            ),
          ),
          title: Text(pharmacies.name, style: TextStyle(color: Colors.black)),
          subtitle: Text(
              'Address ${pharmacies.address}. Phone no. ${pharmacies.phone}',
              style: TextStyle(color: Colors.black)),
          isThreeLine: true,
          onTap: () {
            String no = "tel:0" + pharmacies.phone.toString();
            launch(no);
          },
        ),
      ),
    );
  }
}
