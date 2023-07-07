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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Light Control',
          style: AppTheme.myGlobalTextStyle,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF7a6bbc),
          ),
          tooltip: 'Home',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(title: "HOME AUTOMATION"),
              ),
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 100.0,
            height: 200.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/lights.jpeg",
                  height: 150.0,
                  width: 100.0,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 18.0),
                Text(
                  "Lights",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF7a6bbc),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
