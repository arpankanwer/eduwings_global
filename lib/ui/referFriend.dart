import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import '../classes/user.dart';

import '../provider/login.dart';

class ReferFriend extends StatefulWidget {
  final bool fromDrawer;
  const ReferFriend({Key? key, required this.fromDrawer}) : super(key: key);
  @override
  _ReferFriendState createState() => _ReferFriendState();
}

class _ReferFriendState extends State<ReferFriend> {
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
      isLogged: '');

  @override
  void initState() {
    super.initState();
    Provider.of<LoginProvider>(context, listen: false)
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
      // resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Refer Friend',
        ),
        leading: widget.fromDrawer == true
            ? IconButton(
                icon: Icon(CupertinoIcons.line_horizontal_3_decrease),
                onPressed: () => ZoomDrawer.of(context)!.toggle(),
              )
            : IconButton(
                icon: Icon(CupertinoIcons.back),
                onPressed: () => Navigator.of(context).pop(),
              ),
      ),
      body: Container(
        height: mediaQuery.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0),
            topLeft: Radius.circular(40.0),
          ),
          color: Colors.grey[300],
        ),
        child: Padding(
          padding: EdgeInsets.all(mediaQuery.height * 0.01),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: mediaQuery.height * 0.01),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: mediaQuery.width * 0.04),
                          child: Column(
                            children: [
                              SizedBox(
                                height: mediaQuery.height * 0.03,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
