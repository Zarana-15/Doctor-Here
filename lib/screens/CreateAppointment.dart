//import 'dart:async';
import 'package:doctor_here/screens/scheduleAppointment.dart';
import 'package:doctor_here/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class CreateAppointment extends StatefulWidget {
  static String drname;
  static String timing;
  static String druid;
  @override
  _CreateAppointmentState createState() => _CreateAppointmentState();
}

class _CreateAppointmentState extends State<CreateAppointment> {
  final _nameController = TextEditingController();
  final _remarkController = TextEditingController();

  DateTime pickedDate;
  TimeOfDay time;
  var hr, min, mod, day, month;
  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();

    if (pickedDate.day < 10) {
      day = "0${pickedDate.day}";
    } else {
      day = "${pickedDate.day}";
    }

    if (time.hour >= 12) {
      hr = time.hour - 11;
      mod = "PM";
    } else if (time.hour == 0) {
      hr = 12;
      mod = "AM";
    } else {
      hr = time.hour;
      mod = "AM";
    }

    if (time.minute < 10) {
      min = "0${time.minute}";
    } else {
      min = "${time.minute}";
    }

    if (pickedDate.month < 10) {
      month = "0${pickedDate.month}";
    } else {
      month = "${pickedDate.month}";
    }
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 2),
      initialDate: pickedDate,
    );
    if (date != null)
      setState(() {
        pickedDate = date;
      });

    if (pickedDate.day < 10) {
      day = "0${pickedDate.day}";
    } else {
      day = "${pickedDate.day}";
    }

    if (pickedDate.month < 10) {
      month = "0${pickedDate.month}";
    } else {
      month = "${pickedDate.month}";
    }
  }

  _pickTime() async {
    TimeOfDay t = await showTimePicker(context: context, initialTime: time);
    if (t != null)
      setState(() {
        time = t;
      });
    if (time.hour >= 12) {
      hr = time.hour - 12;
      mod = "PM";
    } else if (time.hour == 0) {
      hr = 12;
      mod = "AM";
    } else {
      hr = time.hour;
      mod = "AM";
    }

    if (hr == 0) {
      hr = 12;
    }

    if (time.minute < 10) {
      min = "0${time.minute}";
    } else {
      min = "${time.minute}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: GradientAppBar(
          gradient:
              LinearGradient(colors: [Colors.blue[900], Colors.blue[500]]),
          title: Text('Create Appointment'),
          centerTitle: true,
        ),
        body: Builder(builder: (BuildContext contxt) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 50.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration:
                          InputDecoration(labelText: 'Enter Patient Name'),
                    ),
                    SizedBox(height: 20.0),
                    Container(
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
                        child: Text('Check Appointments',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          getDocUid(CreateAppointment.drname);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScheduleAppointment()));
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ListTile(
                      title:
                          Text("Select Date: $day/$month/${pickedDate.year}"),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      onTap: _pickDate,
                    ),
                    SizedBox(height: 20.0),
                    ListTile(
                      title: Text("Select Time: $hr:$min " + mod),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      onTap: _pickTime,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _remarkController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(labelText: 'Remarks'),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                          child: Text(
                            'Create',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            if (_nameController.text != null) {
                              updateAppointmentData(
                                  _nameController.text,
                                  "$hr:$min $mod",
                                  "$day/$month/${pickedDate.year}",
                                  CreateAppointment.drname,
                                  CreateAppointment.druid);

                              updateMyAppointment(
                                  _nameController.text,
                                  "$hr:$min $mod",
                                  "$day/$month/${pickedDate.year}",
                                  CreateAppointment.drname,
                                  CreateAppointment.druid);

                              Fluttertoast.showToast(
                                  msg: 'Appointment Booked',
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  gravity: ToastGravity.BOTTOM,
                                  toastLength: Toast.LENGTH_LONG);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              /*Scaffold.of(contxt).showSnackBar(SnackBar(
                                content: Text('Appointment Booked!'),
                                duration: Duration(seconds: 3),
                              ));

                              Timer(Duration(seconds: 3), () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });*/
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
