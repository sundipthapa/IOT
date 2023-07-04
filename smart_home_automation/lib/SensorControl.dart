// import 'package:flutter/material.dart';
//
// class SensorControlPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sensor Control'),
//       ),
//       body: Center(
//         child: Text('This is the Sensor Control Page'),
//       ),
//     );
//   }
// }
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:home_automation_system/services/firebase_cloud_messiging_service.dart';
import 'package:home_automation_system/services/notification_services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import 'NotificationCount.dart';
import 'apptheme.dart';
import 'main.dart';

class SensorControl extends StatefulWidget {
  const SensorControl({Key? key}) : super(key: key);

  @override
  State<SensorControl> createState() => _SensorControlState();
}
class _SensorControlState extends State<SensorControl> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late DatabaseReference _databaseReference;
  double humidity = 0.0;
  double temperature = 0.0;
  int gas = 0;
  int flame = 0;
  double soil = 0.0;

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.reference();
    _listenToSensorValues();
    _configureFirebaseMessaging();
  }

  void _listenToSensorValues() {
    _databaseReference
        .child('SensorData')
        .child('humidity')
        .onValue
        .listen((event) {
      final humidityValue = event.snapshot.value as double?;
      if (humidityValue != null) {
        setState(() {
          humidity = humidityValue / 100.0;
        });
        print('Humidity: $humidity');
      }
    });
    _databaseReference
        .child('SensorData')
        .child('temperature')
        .onValue
        .listen((event) {
      final temperatureValue = event.snapshot.value as double?;
      if (temperatureValue != null) {
        setState(() {
          temperature = temperatureValue / 100.0;
        });
      }
    });

    _databaseReference
        .child('SensorData')
        .child('gasSensor')
        .onValue
        .listen((event) {
      final gasValue = event.snapshot.value as int?;
      if (gasValue != null) {
        setState(() {
          // gas = ((gasValue - 100) / (300 - 100)) * 100.0;
          gas = gasValue;
        });
        print('GasValue: $gas');
        if (gas >= 500) {
          // Send push notification
          _sendPushNotification("gas");
        }
      }
    });


    _databaseReference
        .child('SensorData')
        .child('soilMoisture')
        .onValue
        .listen((event) {
      final moistureValue = event.snapshot.value as double?;
      if (moistureValue != null) {
        setState(() {
          soil = moistureValue / 100.0;
        });
      }
    });
  }

  void _configureFirebaseMessaging() {
    _firebaseMessaging.requestPermission();
    _firebaseMessaging.getToken().then((token) {
      print('FCM Token: $token');
      // Send this token to your server to associate it with the device
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground notification messages here
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }

      NotificationService.displayFcm(
          notification: message.notification!, buildContext: context);
      // print('Foreground Notification Received: ${message.notification?.title}');
    });

    Future<void> _sendPushNotification(String alertType) async {
      String? token = await _firebaseMessaging.getToken();
      String title = '';
      String body = '';

      if (alertType == 'gas') {
        title = 'Gas Alert';
        body = 'Gas value is 0';
      } else if (alertType == 'flame') {
        title = 'Flame Alert';
        body = 'Flame value is 0';
      }

      await FCMService.sendPushMessage(
        token,
        {},
        {
          'title': title,
          'body': body,
        },
      );

      final notificationCount =
      Provider.of<NotificationCount>(context, listen: false);
      // Update the notification count
      notificationCount.updateCount(notificationCount.count + 1);
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
          'SENSORS CONTROL',
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
      builder: (context) =>
      MyHomePage(title: "HOME AUTOMATION")),
      );
      },
      )),