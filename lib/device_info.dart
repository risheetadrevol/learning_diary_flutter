import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class MyDeviceInfo extends StatelessWidget {
  const MyDeviceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ElevatedButton(
              onPressed: () async {
                final deviceInfoPlugin = DeviceInfoPlugin();
                final deviceInfo = await deviceInfoPlugin.deviceInfo;
                final android = deviceInfo as AndroidDeviceInfo;
                print(android.toMap());
              },
              child: Text("Device info")),
        ));
  }
}
