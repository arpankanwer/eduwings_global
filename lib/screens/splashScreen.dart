import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../provider/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<LoginProvider>(context, listen: false)
        .isLogggedIn()
        .then((isLogged) {
      if (isLogged == null || isLogged == 0) {
        Navigator.of(context).pushReplacementNamed('/login');
      } else {
        Navigator.of(context).pushReplacementNamed('/homePage');
        // Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/splashScreen.png')),
    );
  }
}
