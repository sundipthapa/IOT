import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:home_automation_system/main.dart';
import 'apptheme.dart';

import 'package:flutter/material.dart';
import 'package:home_automation_system/main.dart';

import 'apptheme.dart';

class LightControlPage extends StatefulWidget {
  @override
  State<LightControlPage> createState() => _LightControlPageState();
}

class _LightControlPageState extends State<LightControlPage> {
  bool kitchenLightOn = false;
  bool bedroomLightOn = false;
  bool meetingLightOn = false;
  String kitchenLight = 'OFF';
  String bedroomLight = 'OFF';
  String meetingLight = 'OFF';

  void sendKitchenLightStatusToFirebase(String status) {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child('LightControl')
        .child('KitchenLightStatus');
    databaseReference.set(status);
  }

  void sendMeetingLightSatusToFirebase(String status) {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child('LightControl')
        .child('MeetingLightStatus');
    databaseReference.set(status);
  }
}
