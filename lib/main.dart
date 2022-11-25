import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';

import 'biometric_lock.dart';
import 'device_info.dart';
import 'pattern_lock.dart';
import 'printing_machine.dart';
import 'ratingbar.dart';
import 'shaker_detection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ShakerDetectorScreen());
  }
}
