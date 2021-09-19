import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../drawer/drawer.dart';

import '../ui/aboutEduwings.dart';
import '../ui/counselor.dart';
import '../ui/profilePage.dart';
import '../ui/resetPassword.dart';

import '../classes/drawerItem.dart';

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
      angle: -1,
      showShadow: true,
      backgroundColor: Colors.orangeAccent,
      slideWidth: mediaQuery.width * 0.7,
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
        return Profile(fromDrawer: true);
      case DrawerItems.applicationStatus:
        return DashBoardPage();
      case DrawerItems.notifications:
        return DashBoardPage();
      case DrawerItems.callCounselor:
        return CounselorSupport(fromDrawer: true);
      case DrawerItems.resetPassword:
        return ResetPassword();
      case DrawerItems.aboutEduwings:
        return AboutEduwings(fromDrawer: true);
    }
    return Container();
  }
}
