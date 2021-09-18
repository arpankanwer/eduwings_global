import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screens/splashScreen.dart';

import 'provider/login.dart';
import 'provider/profileProvider.dart';

import 'ui/loginScreen.dart';
import 'ui/homePage.dart';

void main() => runApp(MyApp());

enum DeviceType { Phone, Tablet }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  DeviceType getDeviceType(context) {
    double ratio =
        MediaQuery.of(context).size.width / MediaQuery.of(context).size.height;
    return (ratio >= 0.74) && (ratio < 1.5)
        ? DeviceType.Tablet
        : DeviceType.Phone;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: LoginProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ProfileProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Eduwings Global',
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            isDense: true,
            labelStyle: TextStyle(
                color: Color.fromRGBO(2, 42, 70, 1),
                fontSize: 17,
                fontWeight: FontWeight.w400),
            hintStyle: TextStyle(
                color: Color.fromRGBO(2, 42, 70, 1),
                fontSize: 17,
                fontWeight: FontWeight.w400),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.green),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.black38),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          brightness: Brightness.light,
          primarySwatch: Colors.green,
          primaryColor: Color.fromRGBO(2, 42, 70, 1),
          errorColor: Colors.red,
          fontFamily: 'RobotoMono',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline1: TextStyle(
                  // for button text
                  fontFamily: 'RobotoMono',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                headline2: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                headline3: TextStyle(
                  // Textfield Text
                  fontFamily: 'RobotoMono',
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                headline4: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 18,
                  color: Colors.white,
                ),
                headline5: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 18,
                  color: Color.fromRGBO(2, 42, 70, 1),
                ),
                headline6: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 17,
                  color: Color.fromRGBO(2, 42, 70, 1),
                ),
                subtitle1: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                subtitle2: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
          appBarTheme: AppBarTheme(
            backgroundColor: Color.fromRGBO(2, 42, 70, 1),
            titleTextStyle: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/homePage': (context) => HomePage(),
        },
      ),
    );
  }
}
