//import 'package:doctor_here/model/user.dart';
import 'package:doctor_here/screens/Register/ask.dart';
import 'package:doctor_here/screens/doctorHome.dart';
import 'package:doctor_here/screens/patientHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:doctor_here/services/auth.dart';
import 'dart:async';
import 'package:doctor_here/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_button/sign_button.dart';

Future<Null> logininfo(String uid, String type) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString('uid', uid);
  prefs.setBool('isloggedin', true);
  prefs.setString('type', type);
}

/// This Widget is the main application widget.
class SignIn extends StatelessWidget {
  static const String _title = 'Doctor Here';
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  // ignore: missing_return
  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          //Navigator.of(context).pop();

          UserCredential result = await _auth.signInWithCredential(credential);

          User user = result.user;
          User us = _auth.currentUser;
          var check = await userTypeCheck();
          if (user != null) {
            // ignore: unrelated_type_equality_checks
            if (check == 'doctor') {
              getUid();
              logininfo(us.uid, "doctor");
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => DrHome()));
              // ignore: unrelated_type_equality_checks
            } else if (check == "patient") {
              getUid();
              logininfo(us.uid, "patient");
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => PtHome()));
              // ignore: unrelated_type_equality_checks
            } else if (check == "no") {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Ask()));
            }
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (FirebaseAuthException exception) {
          Fluttertoast.showToast(
              msg: 'Verification Failed',
              backgroundColor: Colors.black,
              textColor: Colors.red,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG);
          print(
              "$exception verification failed ${exception.code}. Message: ${exception.message}");
          AlertDialog(title: Text("Invalid verification code"));
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Enter OTP: "),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId, smsCode: code);
                        User us = _auth.currentUser;
                        UserCredential result =
                            await _auth.signInWithCredential(credential);

                        User user = result.user;
                        var check = userTypeCheck();
                        if (user != null) {
                          // ignore: unrelated_type_equality_checks
                          if (check == "no") {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Ask()));
                            // ignore: unrelated_type_equality_checks
                          } else if (check == "patient") {
                            logininfo(us.uid, "patient");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PtHome()));
                            // ignore: unrelated_type_equality_checks
                          } else if (check == "doctor") {
                            logininfo(us.uid, "doctor");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DrHome()));
                          }
                        } else {
                          print("Error");
                          AlertDialog(title: Text("Invalid verification code"));
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          Fluttertoast.showToast(
              msg: 'Auto code retieval failed',
              backgroundColor: Colors.black,
              textColor: Colors.red,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG);
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: GradientAppBar(
          gradient:
              LinearGradient(colors: [Colors.blue[900], Colors.blue[500]]),
          title: Text('Doctor Here'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                  width: 300,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                    controller: _phoneController,
                  )),
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
                  onPressed: () {
                    print(_phoneController.text);
                    final phone = _phoneController.text.trim();

                    loginUser(phone, context);
                  },
                ),
              ),
              SizedBox(
                height: 60,
              ),
              SignInButton(
                buttonType: ButtonType.google,
                btnColor: Colors.white,
                btnTextColor: Colors.black,
                buttonSize: ButtonSize.large,
                onPressed: () {
                  signInWithGoogle().whenComplete(() async {
                    bool signin = await signInWithGoogle();
                    //print(signin);
                    FirebaseAuth _auth = FirebaseAuth.instance;
                    User us = _auth.currentUser;
                    var check = await userTypeCheck();
                    if (signin) {
                      //print(check);
                      // ignore: unrelated_type_equality_checks
                      if (check == "no") {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Ask()));
                        //print("3");
                        // ignore: unrelated_type_equality_checks
                      } else if (check == "patient") {
                        getUid();
                        logininfo(us.uid, 'patient');
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => PtHome()));
                        //print("2");
                      } else if (check == "doctor") {
                        getUid();
                        logininfo(us.uid, 'doctor');
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => DrHome()));
                        //print("1");
                      }
                    }
                  });
                },
              ),
            ],
          )),
        ),
      ),
    );
  }
}
