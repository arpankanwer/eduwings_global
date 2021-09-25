import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../classes/drawerItem.dart';
import '../classes/user.dart';

import '../provider/appProvider.dart';

class DrawerItems {
  static const dashBoard = DrawerItem(
      title: 'My DashBoard', icon: CupertinoIcons.person_alt_circle_fill);
  static const profile =
      DrawerItem(title: 'Profile', icon: CupertinoIcons.profile_circled);
  static const applicationStatus = DrawerItem(
      title: 'Application Status', icon: CupertinoIcons.star_circle_fill);
  static const notifications =
      DrawerItem(title: 'Notifications', icon: CupertinoIcons.bell_circle_fill);
  static const callCounselor = DrawerItem(
      title: 'Counselor Support', icon: CupertinoIcons.phone_circle_fill);
  static const resetPassword =
      DrawerItem(title: 'Reset Password', icon: CupertinoIcons.lock_circle_fill);
  static const aboutEduwings = DrawerItem(
      title: 'About Eduwings', icon: CupertinoIcons.info_circle_fill);

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
  User user = User(
      ein: '',
      studentName: '',
      fName: '',
      lName: '',
      email: '',
      countryName: '',
      stateName: '',
      cityName: '',
      passport: '',
      dob: '',
      gender: '',
      address: '',
      profileImage: '',
      mobNo: '',
      counselorName: '',
      counselorMobNo: '',
      formId: '',
      isLogged: '',otp:'');

  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false)
        .getSharedData()
        .then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Container(
        color: Colors.indigo,
        width: mediaQuery.width * 0.7,
        child: SafeArea(
            child: Container(
          height: mediaQuery.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: mediaQuery.height * 0.05,
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: mediaQuery.width * 0.1),
                      child: Container(
                        width: 130.0,
                        height: 130.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://eduwingserp.com/AppFiles/images/" +
                                    user.profileImage),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(70.0),
                          border: Border.all(
                            color: Colors.yellowAccent,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaQuery.height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: mediaQuery.width * 0.1),
                      child: Text(
                        user.studentName,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: mediaQuery.height * 0.03,
                ),
                ...DrawerItems.allDrawerItems.map(buildDrawerItems).toList(),
                ListTile(
                  selectedTileColor: Colors.black26,
                  // selected: widget.currentOption == item,
                  leading: Icon(CupertinoIcons.exclamationmark_octagon_fill, color: Colors.white),
                  title: Text('Logout', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Provider.of<AppProvider>(context, listen: false)
                        .logout()
                        .then((value) => Navigator.of(context)
                            .pushReplacementNamed('/login'));
                  },
                ),
              ],
            ),
          ),
        )),
      ),
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
