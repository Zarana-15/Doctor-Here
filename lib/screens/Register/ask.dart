import 'package:doctor_here/model/user.dart';
import 'package:doctor_here/screens/Register/MoreinfoDoc.dart';
import 'package:doctor_here/screens/Register/MoreinfoPat.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class Ask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: GradientAppBar(
          gradient:
              LinearGradient(colors: [Colors.blue[900], Colors.blue[500]]),
          title: Text('Doctor Here'),
          centerTitle: true,
        ),
        body: MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Text(
            'ARE YOU A DOCTOR?',
            style: TextStyle(
              color: Colors.lightBlue,
              letterSpacing: 2.0,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 100),
          Container(
            width: 500,
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
              child: const Text('Yes',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  )),
              onPressed: () {
                UserData(usertype: "doctor");
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MoreInfoDoc()));
              },
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            width: 500,
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
              child: Text('NO',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  )),
              onPressed: () {
                UserData(usertype: "patient");
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MoreInfoUser()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
