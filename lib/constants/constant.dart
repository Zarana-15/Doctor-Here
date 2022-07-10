import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  // contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 2),
  ),
);

class Constants {
  static const String Location = 'Location';
  static const String Notifications = 'Notifications';
  static const String Settings = 'Settings';

  static const List<String> choices = <String>[
    Location,
    // Notifications,
    Settings
  ];
}
