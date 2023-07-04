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
