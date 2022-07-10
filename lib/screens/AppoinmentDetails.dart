import 'package:doctor_here/model/appointment.dart';
import 'package:doctor_here/screens/chat.dart';
import 'package:doctor_here/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class AppointmentDetails extends StatelessWidget {
  final Appointment appointment;

  AppointmentDetails({this.appointment});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                            peerId: appointment.ptuid,
                            peerName: appointment.name)));
              },
            ),
          ],
        ),
        body: MyCustomForm(appointment: appointment),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  final Appointment appointment;
  MyCustomForm({this.appointment});
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  TextEditingController _diagnosisController, _historyController;

  @override
  void initState() {
    super.initState();
    _diagnosisController =
        new TextEditingController(text: widget.appointment.diagnosis + "\n");
    _historyController = new TextEditingController(
        text: widget.appointment.patientHistory + "\n");
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text("Diagnosis"),
                    subtitle: Text(widget.appointment.diagnosis),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.green,
                              size: 30.0,
                            ),
                            const Text('EDIT'),
                          ],
                        ),
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Container(
                                  height: 600,
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  color: Colors.grey,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Text('Edit Diagnosis'),
                                        SafeArea(
                                            child: Center(
                                                child: Container(
                                                    width: 320,
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: TextField(
                                                      minLines: 7,
                                                      maxLines: 10,
                                                      autocorrect: true,
                                                      controller:
                                                          _diagnosisController,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'Type Text Here...',
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey),
                                                        filled: true,
                                                        fillColor:
                                                            Colors.white70,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12.0)),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .red,
                                                                  width: 2),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10.0)),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .red),
                                                        ),
                                                      ),
                                                    )))),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              child: const Text('Submit'),
                                              onPressed: () {
                                                String diag =
                                                    _diagnosisController.text;
                                                updateDiagnosis(
                                                    diag,
                                                    widget.appointment.id,
                                                    widget.appointment.ptuid);
                                                Fluttertoast.showToast(
                                                    msg: 'Updated',
                                                    backgroundColor:
                                                        Colors.white,
                                                    textColor: Colors.black);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            ElevatedButton(
                                              child: const Text('Cancel'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text("Patient History"),
                    subtitle: Text(widget.appointment.patientHistory),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.green,
                              size: 30.0,
                            ),
                            const Text('EDIT'),
                          ],
                        ),
                        onPressed: () {
                          _historyController.value = TextEditingValue(
                              text: widget.appointment.patientHistory);
                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Container(
                                  height: 600,
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  color: Colors.grey,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Text('Edit Patient History'),
                                        SafeArea(
                                            child: Center(
                                                child: Container(
                                                    width: 320,
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: TextField(
                                                      minLines: 7,
                                                      maxLines: 10,
                                                      autocorrect: true,
                                                      controller:
                                                          _historyController,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'Type Text Here...',
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey),
                                                        filled: true,
                                                        fillColor:
                                                            Colors.white70,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12.0)),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .red,
                                                                  width: 2),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10.0)),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .red),
                                                        ),
                                                      ),
                                                    )))),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              child: const Text('Submit'),
                                              onPressed: () {
                                                String history =
                                                    _historyController.text;
                                                updatePatientHistory(
                                                    history,
                                                    widget.appointment.id,
                                                    widget.appointment.ptuid);
                                                Fluttertoast.showToast(
                                                    msg: 'Updated',
                                                    backgroundColor:
                                                        Colors.white,
                                                    textColor: Colors.black);
                                                widget.appointment
                                                    .patientHistory = history;
                                                Navigator.pop(context);
                                              },
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            ElevatedButton(
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                _historyController.value =
                                                    TextEditingValue(
                                                        text: widget.appointment
                                                            .patientHistory);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
