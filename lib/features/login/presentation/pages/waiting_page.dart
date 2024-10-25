import 'package:flutter/material.dart';
import 'package:mobile_app/core/app_strings.dart';

class WaitingPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(AppStrings.waitingSession),
      ),
    );
  }
}