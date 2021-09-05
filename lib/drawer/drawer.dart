import 'package:eduwings_global/provider/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/drawerItem.dart';

class DrawerItems {
  static const dashBoard =
      DrawerItem(title: 'My DashBoard', icon: Icons.dashboard);
  static const profile =
      DrawerItem(title: 'Profile', icon: Icons.account_circle_outlined);
  static const applicationStatus =
      DrawerItem(title: 'Application Status', icon: Icons.star_outline_sharp);
  static const notifications =
      DrawerItem(title: 'Notifications', icon: Icons.notification_important);
  static const callCounselor =
      DrawerItem(title: 'Counselor Support', icon: Icons.call);
  static const resetPassword =
      DrawerItem(title: 'Reset Password', icon: Icons.password);
  static const aboutEduwings =
      DrawerItem(title: 'About Eduwings', icon: Icons.info);

  static const allDrawerItems = <DrawerItem>[
    dashBoard,
    profile,
    applicationStatus,
    notifications,
    callCounselor,
    resetPassword,
    aboutEduwings
  ];
}

class DrawerPage extends StatefulWidget {
  final DrawerItem currentOption;
  final ValueChanged<DrawerItem> onSelectedItem;
  const DrawerPage(
      {Key? key, required this.currentOption, required this.onSelectedItem})
      : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Spacer(),

          ...DrawerItems.allDrawerItems.map(buildDrawerItems).toList(),
          // Spacer(flex: 2),
          // SizedBox(
          //   height: mediaQuery.height * 0.2,
          // ),
          ListTile(
            selectedTileColor: Colors.black26,
            // selected: widget.currentOption == item,
            leading: Icon(Icons.logout_outlined, color: Colors.white),
            title: Text('Logout', style: TextStyle(color: Colors.white)),
            onTap: () {
              Provider.of<LoginProvider>(context, listen: false).logout().then(
                  (value) =>
                      Navigator.of(context).pushReplacementNamed('/login'));
            },
          ),
          //   Padding(
          //     padding: EdgeInsets.only(left: mediaQuery.width * 0.2),
          //     child: ElevatedButton(
          //       style: TextButton.styleFrom(
          //           backgroundColor: Theme.of(context).primaryColor,
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(20))),
          //       onPressed: () async {
          //         Provider.of<LoginProvider>(context, listen: false)
          //             .logout()
          //             .then((value) =>
          //                 Navigator.of(context).pushReplacementNamed('/login'));
          //       },
          //       child: Text(
          //         'Logout',
          //         style: Theme.of(context).textTheme.headline1,
          //       ),
          //     ),
          //   ),
        ],
      )),
    );
  }

  Widget buildDrawerItems(DrawerItem item) {
    return ListTile(
      selectedTileColor: Colors.black26,
      selected: widget.currentOption == item,
      leading: Icon(item.icon, color: Colors.white),
      title: Text(item.title, style: TextStyle(color: Colors.white)),
      onTap: () {
        widget.onSelectedItem(item);
      },
    );
  }
}
