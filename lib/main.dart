//import 'package:doctor_here/login.dart';
//import 'package:doctor_here/screens/Register/MoreinfoDoc.dart';
//import 'package:doctor_here/screens/Register/ask.dart';
import 'package:doctor_here/screens/signin.dart';
import 'package:doctor_here/screens/patientHome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doctor_here/screens/doctorHome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  final g = GetStorage();
  g.write('pincode', 400000);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var type,
      isLoggedIn = (prefs.getBool('isloggedin') == null)
          ? false
          : prefs.getBool('isloggedin');
  (prefs.containsKey('type')) ? type = prefs.getString('type') : type = null;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: isLoggedIn
        ? (type == 'doctor')
            ? DrHome()
            : PtHome()
        : SignIn(),
  ));
}

/*
void main() => runApp(MyApp());

var type, isloggedin, uid;

Future<SharedPreferences> instance() async {
  return await Future.delayed(Duration(seconds: 500));;
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  MyAppState createState() => MyAppState();
}

void initState() {
  //super.initState();
  instance();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:  instance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> prefs) {
          if (prefs.hasData) {
            var x = prefs.data;
            if (x.getBool('isloggedin')) {
              if (x.getString('type') == 'doctor') {
                return MaterialApp(home: DrHome());
              } else
                return MaterialApp(home: PtHome());
            }
          }

          return MaterialApp(home: SignIn());
        });
  }
}
*/
