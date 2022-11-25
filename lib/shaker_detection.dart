import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class ShakerDetectorScreen extends StatefulWidget {
  const ShakerDetectorScreen({super.key});

  @override
  State<ShakerDetectorScreen> createState() => _ShakerDetectorScreenState();
}

class _ShakerDetectorScreenState extends State<ShakerDetectorScreen> {
  ShakeDetector? detector;
  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(onPhoneShake: () {
      print('shaking');
    });
    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBar(
        title: Text(detector!.mShakeCount.toString()),
      ),
    );
  }
}
