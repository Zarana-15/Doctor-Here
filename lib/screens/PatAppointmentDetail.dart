import 'package:doctor_here/model/myappointment.dart';
import 'package:doctor_here/screens/chat.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class PatAppointmentDetails extends StatelessWidget {
  final MyAppointment appointment;

  PatAppointmentDetails(this.appointment);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: GradientAppBar(
          gradient:
              LinearGradient(colors: [Colors.blue[900], Colors.blue[500]]),
          title: Text('Appointment Details'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.chat),
              onPressed: () {
                print("search");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Chat(
                            peerId: appointment.druid,
                            peerName: "Dr. " + appointment.drname)));
              },
            ),
          ],
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
                    'Dr. ' + appointment.drname,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    'PATIENT NAME',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    appointment.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    'APPOINTMENT DATE',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    appointment.date + " " + appointment.time,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    'DOCTOR\'S DIAGNOSIS',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    appointment.diagnosis,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'PATIENT HISTORY',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    appointment.patientHistory,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 50.0),
                ]),
          ),
        ));
  }
}
