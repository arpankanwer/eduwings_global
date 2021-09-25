import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../provider/appProvider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(milliseconds: 500),
        () => Provider.of<AppProvider>(context, listen: false)
                .isLogggedIn()
                .then((isLogged) {
              if (isLogged == null || isLogged == 0) {
                Navigator.of(context).pushReplacementNamed('/login');
              } else {
                Navigator.of(context).pushReplacementNamed('/homePage');
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/splashScreen.png')),
    );
  }
}
