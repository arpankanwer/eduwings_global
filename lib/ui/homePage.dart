import 'package:eduwings_global/classes/drawerItem.dart';
import 'package:eduwings_global/ui/aboutEduwings.dart';
import 'package:eduwings_global/ui/counselor.dart';
import 'package:eduwings_global/ui/profilePage.dart';
import 'package:eduwings_global/ui/resetPassword.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../provider/login.dart';

import '../classes/user.dart';

import '../drawer/drawer.dart';

import 'dashBoard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DrawerItem currentOption = DrawerItems.dashBoard;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return ZoomDrawer(
      borderRadius: 40,
      angle: -3,
      showShadow: true,
      backgroundColor: Colors.orangeAccent,
      // slideWidth: mediaQuery.width,
      style: DrawerStyle.Style1,
      mainScreen: getScreen(),
      menuScreen: Builder(
        builder: (context) => DrawerPage(
          currentOption: currentOption,
          onSelectedItem: (item) {
            setState(() {
              currentOption = item;
            });
            ZoomDrawer.of(context)!.close();
          },
        ),
      ),
    );
  }

  Widget getScreen() {
    switch (currentOption) {
      case DrawerItems.dashBoard:
        return DashBoardPage();
      case DrawerItems.profile:
        return Profile();
      case DrawerItems.applicationStatus:
        return DashBoardPage();
      case DrawerItems.notifications:
        return DashBoardPage();
      case DrawerItems.callCounselor:
        return CounselorSupport();
      case DrawerItems.resetPassword:
        return ResetPassword();
      case DrawerItems.aboutEduwings:
        return AboutEduwings();
    }
    return Container();
  }
}
