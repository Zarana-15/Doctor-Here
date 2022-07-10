import 'package:doctor_here/model/user.dart';
import 'package:doctor_here/screens/patientHome.dart';
import 'package:doctor_here/screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:doctor_here/services/database.dart';

class MoreInfoUser extends StatefulWidget {
  @override
  _MoreInfoUserState createState() => _MoreInfoUserState();
}

class _MoreInfoUserState extends State<MoreInfoUser> {
  String name = '';
  final _nameController = TextEditingController();
  var phoneno;
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: GradientAppBar(
        gradient: LinearGradient(colors: [Colors.blue[900], Colors.blue[500]]),
        title: Text('More Info'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'Patient Info',
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
                  decoration: InputDecoration(labelText: 'Enter Phone number'),
                ),
                SizedBox(
                  height: 80,
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
                      UserData(name: _nameController.text);
                      FirebaseAuth _auth = FirebaseAuth.instance;
                      User us =  _auth.currentUser;
                      await updateUserData(_nameController.text, "patient")
                          .then((value) async {
                        await updatePatData(
                          _nameController.text,
                          _phoneController.text,
                        ).then((value) {
                          logininfo(us.uid, "patient");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PtHome()));
                        });
                      });
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
