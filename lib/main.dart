import 'package:eduwings_global/ui/changePassword.dart';
import 'package:eduwings_global/ui/otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'provider/theme.dart';
import 'screens/splashScreen.dart';

import 'provider/login.dart';
import 'provider/profileProvider.dart';

import 'ui/loginScreen.dart';
import 'ui/homePage.dart';
import 'ui/aboutEduwings.dart';
import 'ui/counselor.dart';
import 'ui/referFriend.dart';
import 'ui/profilePage.dart';
import 'ui/resetPassword.dart';
import 'ui/createAccount.dart';
import 'ui/forgotPassword.dart';

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
      child: PlatformProvider(
        settings: PlatformSettingsData(
            iosUsesMaterialWidgets: true,
            platformStyle: PlatformStyleData(android: PlatformStyle.Material)),
        builder: (context) => PlatformApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          title: 'Eduwings Global',
          material: (_, __) => MaterialAppData(
            theme: MyThemes.materialTheme,
            initialRoute: '/',
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case '/':
                  return CupertinoPageRoute(
                      builder: (_) => SplashScreen(), settings: settings);
                case '/login':
                  return CupertinoPageRoute(
                      builder: (_) => LoginScreen(), settings: settings);
                case '/homePage':
                  return CupertinoPageRoute(
                      builder: (_) => HomePage(), settings: settings);
                case '/profilePage':
                  return CupertinoPageRoute(
                      builder: (_) => Profile(fromDrawer: false),
                      settings: settings);
                case '/callCounselor':
                  return CupertinoPageRoute(
                      builder: (_) => CounselorSupport(fromDrawer: false),
                      settings: settings);
                case '/resetPassword':
                  return CupertinoPageRoute(
                      builder: (_) => ResetPassword(), settings: settings);
                case '/aboutEduwings':
                  return CupertinoPageRoute(
                      builder: (_) => AboutEduwings(fromDrawer: false),
                      settings: settings);
                case '/referFriend':
                  return CupertinoPageRoute(
                      builder: (_) => ReferFriend(fromDrawer: false),
                      settings: settings);
                case '/createAccount':
                  return CupertinoPageRoute(
                      builder: (_) => CreateAccount(), settings: settings);
                case '/forgotPassword':
                  return CupertinoPageRoute(
                      builder: (_) => ForgotPassword(), settings: settings);
                case '/otp':
                  return CupertinoPageRoute(
                      builder: (_) => Otp(), settings: settings);
                case '/changePassword':
                  return CupertinoPageRoute(
                      builder: (_) => ChangePassword(), settings: settings);
              }
            },
            // routes: {
            //   '/': (context) => SplashScreen(),
            //   '/login': (context) => LoginScreen(),
            //   '/homePage': (context) => HomePage(),
            //   '/profilePage': (context) => Profile(fromDrawer: false),
            //   '/callCounselor': (context) => CounselorSupport(fromDrawer: false),
            //   '/resetPassword': (context) => ResetPassword(),
            //   '/aboutEduwings': (context) => AboutEduwings(fromDrawer: false),
            //   '/referFriend': (context) => ReferFriend(fromDrawer: false),
            //   '/createAccount': (context) => CreateAccount(),
            //   '/forgotPassword': (context) => ForgotPassword(),
            // },
          ),
          cupertino: (_, __) => CupertinoAppData(
            theme: MyThemes.cupertinoTheme,
            initialRoute: '/',
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case '/':
                  return CupertinoPageRoute(
                      builder: (_) => SplashScreen(), settings: settings);
                case '/login':
                  return CupertinoPageRoute(
                      builder: (_) => LoginScreen(), settings: settings);
                case '/homePage':
                  return CupertinoPageRoute(
                      builder: (_) => HomePage(), settings: settings);
                case '/profilePage':
                  return CupertinoPageRoute(
                      builder: (_) => Profile(fromDrawer: false),
                      settings: settings);
                case '/callCounselor':
                  return CupertinoPageRoute(
                      builder: (_) => CounselorSupport(fromDrawer: false),
                      settings: settings);
                case '/resetPassword':
                  return CupertinoPageRoute(
                      builder: (_) => ResetPassword(), settings: settings);
                case '/aboutEduwings':
                  return CupertinoPageRoute(
                      builder: (_) => AboutEduwings(fromDrawer: false),
                      settings: settings);
                case '/referFriend':
                  return CupertinoPageRoute(
                      builder: (_) => ReferFriend(fromDrawer: false),
                      settings: settings);
                case '/createAccount':
                  return CupertinoPageRoute(
                      builder: (_) => CreateAccount(), settings: settings);
                case '/forgotPassword':
                  return CupertinoPageRoute(
                      builder: (_) => ForgotPassword(), settings: settings);
              }
            },
          ),
        ),
      ),
    );
  }
}
