import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/core/app_strings.dart';

class LoginPage extends StatelessWidget{

  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    getDeviceInfo();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(AppStrings.appName,
            style: TextStyle(fontSize: 20),
          ),
          TextField(
            controller: emailController,
            autofillHints: [AppStrings.emailHint],
          ),
          TextField(
            controller: phoneController,
            autofillHints: [AppStrings.emailHint],
          ),
          TextButton(
            onPressed: , 
            child: Text(AppStrings.login)
          ),
        ],
      ),
    );
  }

  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Device: ${androidInfo.model}'); // Model of the device
      print('Brand: ${androidInfo.brand}'); // Brand of the device
      print('Android version: ${androidInfo.version.release}'); // Android version
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Device: ${iosInfo.utsname.machine}'); // Model of the device
      print('System name: ${iosInfo.systemName}'); // iOS system name
      print('System version: ${iosInfo.systemVersion}'); // iOS system version
    }
  }
}