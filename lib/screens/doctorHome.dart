import 'package:doctor_here/list_creator/appointmentlist_builder.dart';
import 'package:doctor_here/list_creator/patientLoglist_builder.dart';
import 'package:doctor_here/model/appointment.dart';
import 'package:doctor_here/screens/DocCreateAppointment.dart';
import 'package:doctor_here/screens/doctorSettings.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:doctor_here/services/database.dart';

class DrHome extends StatefulWidget {
  final Function toggleView;
  final Appointment appointment;
  DrHome({this.toggleView, this.appointment});
  @override
  _MyDrHomePage createState() => _MyDrHomePage(this.appointment);
}

class _MyDrHomePage extends State<DrHome> {
  // ignore: unused_element
  _MyDrHomePage([Appointment appointment]);
  //var date = Appointment().date;
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: StreamProvider<List<Appointment>>.value(
          value: DatabaseService().appointment,
          child: Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: GradientAppBar(
              gradient:
                  LinearGradient(colors: [Colors.blue[900], Colors.blue[500]]),
              title: Text('Doctor Here'),
              centerTitle: true,
              actions: <Widget>[
                // IconButton(
                //   icon: Icon(
                //     Icons.search_outlined,
                //     color: Colors.white,
                //   ),
                //   onPressed: () {
                //     print("search");
                //     //   signOutGoogle();
                //     //   Navigator.pushReplacement(context,
                //     //       MaterialPageRoute(builder: (context) => SignIn()));
                //   },
                // ),
                IconButton(icon: Icon(Icons.settings), onPressed: () {
                  Navigator.push(context,
                           MaterialPageRoute(builder: (context) => DrSetting()));
                })
              ],
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Text("APPOINTMENTS"),
                  ),
                  Tab(
                    child: Text("PATIENTS LOGS"),
                  ),
                  // Tab(
                  //   child: Text("SETTINGS"),
                  // ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                AppointmentList(),
                PatientLogList(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Add your onPressed code here!
                print("new appointment ");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DocCreateAppointment()));
              },
              child: Container(
                width: 60,
                height: 60,
                child: Icon(
                  Icons.add,
                  size: 40,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Colors.blue[500], Colors.blue[900]])),
              ),
            ),
          ),
        ),
      ),
    );
    //),
    //);
  }
}
