import 'package:flutter/material.dart';

import 'biometric_lock.dart';
import 'pattern_lock.dart';
import 'printing_machine.dart';


void main() {
  runApp(const MyApp());
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
        home: const PatternMyLock());
  }
}

