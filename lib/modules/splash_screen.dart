import 'dart:async';

import 'package:flutter/material.dart';
import 'package:x_tracker_map/modules/home_screen.dart';
import 'package:x_tracker_map/modules/login_screen.dart';
import 'package:x_tracker_map/shared/methods.dart';
import '../shared/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then(
      (value) {
        navigateToAndFinish(
          widget: loginBefore! ? HomeScreen() : LoginScreen(),
          context: context,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/images/splash.png',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
