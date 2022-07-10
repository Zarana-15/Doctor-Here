import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final TextEditingController txt = new TextEditingController();

  void dispose() {
    super.dispose();
    txt.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(
          gradient:
              LinearGradient(colors: [Colors.blue[900], Colors.blue[500]]),
          title: Text('Location'),
          centerTitle: true,
        ),
        body: ProgressHUD(
          child: Builder(
            builder: (context) => Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: txt,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Enter Pincode:'),
                    ),
                  ),
                  ElevatedButton(
                    child: Text("Submit"),
                    style: ButtonStyle(),
                    onPressed: (txt.text != null)
                        ? () {
                            final pin = GetStorage();
                            pin.write('pincode', int.parse(txt.text));
                            Fluttertoast.showToast(
                                msg: 'Location found',
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                gravity: ToastGravity.BOTTOM,
                                toastLength: Toast.LENGTH_LONG);
                          }
                        : null,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () async {
                          final progress = ProgressHUD.of(context);
                          progress?.show();
                          int x = await getlocation();
                          if (x != 0) {
                            txt.clear();
                            txt.text = x.toString();
                            Fluttertoast.showToast(
                                msg: 'Location found',
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                gravity: ToastGravity.BOTTOM,
                                toastLength: Toast.LENGTH_LONG);
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    'Could not find Location. Try typing pincode',
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                gravity: ToastGravity.BOTTOM,
                                toastLength: Toast.LENGTH_LONG);
                          }
                          progress?.dismiss();
                        },
                        child: Row(
                          children: [
                            Text("Get Current Location"),
                            Icon(Icons.my_location),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

Future<int> getlocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Fluttertoast.showToast(
          msg: 'Location permissions are denied',
          backgroundColor: Colors.black,
          textColor: Colors.red,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG);
    }
  }

  if (permission == LocationPermission.deniedForever) {
    Fluttertoast.showToast(
        msg:
            'Location permissions are permanently denied, we cannot request permissions.',
        backgroundColor: Colors.black,
        textColor: Colors.red,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG);
  }
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Fluttertoast.showToast(
        msg: 'Location services are disabled.',
        backgroundColor: Colors.black,
        textColor: Colors.red,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG);
  }

  Position loc = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true);

  try {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(loc.latitude, loc.longitude);

    Placemark place = placemarks[0];
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.setInt("pincode", int.parse(place.postalCode));
    // ignore: await_only_futures
    final pin = GetStorage();
    pin.write('pincode', int.parse(place.postalCode));
    return int.parse(place.postalCode);
  } catch (e) {
    print(e);
    return 0;
  }
}
