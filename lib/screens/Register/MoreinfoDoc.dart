import 'package:doctor_here/model/user.dart';
import 'package:doctor_here/screens/doctorHome.dart';
import 'package:doctor_here/screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:doctor_here/services/database.dart';

class MoreInfoDoc extends StatefulWidget {
  @override
  _MoreInfoDocState createState() => _MoreInfoDocState();
}

class _MoreInfoDocState extends State<MoreInfoDoc> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _clinicName = TextEditingController();
  final _specialty = TextEditingController();
  final _clinicAddress = TextEditingController();
  final _pincode = TextEditingController();
  //final _clinicTimings = TextEditingController();

  TimeOfDay time;
  var hr, min, mod;
  String t1 = "Select time", t2 = "Select time";
  @override
  void initState() {
    super.initState();
    time = TimeOfDay.now();

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
  }

  _pickTime() async {
    String a;
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
    a = "$hr:$min $mod";
    return a;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: GradientAppBar(
        gradient: LinearGradient(colors: [Colors.blue[900], Colors.blue[500]]),
        title: Text('More Info'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                Text(
                  'Doctor Info',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(labelText: 'Enter Full Name'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: 'Enter Contact No.'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _specialty,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(labelText: 'Enter Specialty'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _clinicName,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(labelText: 'Enter Clinic Name'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _clinicAddress,
                  keyboardType: TextInputType.multiline,
                  decoration:
                      InputDecoration(labelText: 'Enter Clinic Address'),
                ),
                SizedBox(height: 20.0),
                Text("Enter Clinic Timing:"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text(t1),
                      color: Colors.grey,
                      onPressed: () async {
                        t1 = await _pickTime();
                      },
                    ),
                    Text(" - "),
                    FlatButton(
                      child: Text(t2),
                      color: Colors.grey,
                      onPressed: () async {
                        t2 = await _pickTime();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _pincode,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(labelText: 'Enter Clinic Pincode'),
                ),
                SizedBox(
                  height: 40,
                ),
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
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      if (_nameController.text != null &&
                          _phoneController.text != null &&
                          _specialty.text != null &&
                          _clinicName.text != null &&
                          _clinicAddress.text != null &&
                          _pincode.text != null) {
                        UserData(name: _nameController.text);
                        FirebaseAuth _auth = FirebaseAuth.instance;
                        User us = _auth.currentUser;
                        await updateUserData(_nameController.text, "doctor")
                            .then((value) async {
                          await updateDocData(
                                  _nameController.text,
                                  _phoneController.text,
                                  _specialty.text,
                                  _clinicName.text,
                                  _clinicAddress.text,
                                  int.parse(_pincode.text),
                                  t1 + " - " + t2)
                              .then((value) {
                            logininfo(us.uid, "doctor");  
                            Fluttertoast.showToast(
                                msg: 'Data Recored. \nStatus:In Review\nAccount will be verified soon...',
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                gravity: ToastGravity.BOTTOM,
                                toastLength: Toast.LENGTH_LONG);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DrHome()));
                          });
                        });
                      }
                      else{
                        Fluttertoast.showToast(
                                msg: 'Please Enter All Details',
                                backgroundColor: Colors.black,
                                textColor: Colors.red,
                                gravity: ToastGravity.BOTTOM,
                                toastLength: Toast.LENGTH_LONG);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
