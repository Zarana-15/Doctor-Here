import 'package:doctor_here/screens/CreateAppointment.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class ClinicDetails extends StatelessWidget {
  final String drname;
  final String clinicname;
  final String address;
  final String speciality;
  final String phone;
  final int pincode;
  final String timing;
  final String druid;

  ClinicDetails(this.drname, this.clinicname, this.address, this.speciality,
      this.phone, this.pincode, this.timing,this.druid);

  @override
  Widget build(BuildContext context) {
    var x = drname.split(" ");
    var y;
    try {
      y = x[0].substring(0, 1).toUpperCase() +
          x[0].substring(1) +
          " " +
          x[1].substring(0, 1).toUpperCase() +
          x[1].substring(1);
    } catch (Expecption) {
      y = x[0].substring(0, 1).toUpperCase() + x[0].substring(1);
    }

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: GradientAppBar(
          gradient: LinearGradient(colors: [Colors.blue[900], Colors.blue[500]]),
          title: Text('Clinic Details'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'DOCTOR NAME',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Dr. ' + y,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    'SPECIALTY',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    speciality.substring(0, 1).toUpperCase() +
                        speciality.substring(1),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    'CLINIC NAME',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    clinicname.substring(0, 1).toUpperCase() +
                        clinicname.substring(1),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    'CLINIC ADDRESS',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    address,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'CLINIC TIMINGS',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    timing,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue[500], Colors.blue[900]],
                          begin: FractionalOffset.centerLeft,
                          end: FractionalOffset.centerRight,
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0)),
                      ),
                      child: FlatButton(
                        child: Row(
                          children: [
                            Text(
                              'Create Appointment  ',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        onPressed: () {
                          CreateAppointment.drname = drname;
                          CreateAppointment.druid = druid;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateAppointment()));
                        },
                      ),
                    ),
                  ),
                ]),
          ),
        ));
  }
}
