import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../classes/user.dart';

import '../provider/login.dart';

class CounselorSupport extends StatefulWidget {
  final bool fromDrawer;
  const CounselorSupport({Key? key, required this.fromDrawer})
      : super(key: key);
  @override
  _CounselorSupportState createState() => _CounselorSupportState();
}

class _CounselorSupportState extends State<CounselorSupport> {
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
          'My Counselor',
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://eu.ui-avatars.com/api/?name=${user.counselorName}&background=2f855a&color=fff"),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(70.0),
                                      border: Border.all(
                                        color: Colors.yellowAccent,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: mediaQuery.height * 0.02,
                                  ),
                                  Text(
                                    user.counselorName,
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  SizedBox(
                                    height: mediaQuery.height * 0.04,
                                  ),
                                  Container(
                                    width: mediaQuery.width * 0.3,
                                    height: mediaQuery.width * 0.11,
                                    child: ElevatedButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      onPressed: () {
                                        launch('tel:${user.counselorMobNo}');
                                      },
                                      child: Text(
                                        'Call',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: mediaQuery.height * 0.02,
                                  ),
                                  Container(
                                    // width: mediaQuery.width * 0.3,
                                    height: mediaQuery.width * 0.11,
                                    child: ElevatedButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      onPressed: () {
                                        Provider.of<LoginProvider>(context,
                                                listen: false)
                                            .openWhatsapp(
                                                context, user.counselorMobNo);
                                      },
                                      child: Text(
                                        'Whatsapp',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Text(user.counselorMobNo),
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
