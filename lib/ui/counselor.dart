// import 'dart:html';

import 'dart:io';

import 'package:eduwings_global/classes/user.dart';
import 'package:eduwings_global/provider/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CounselorSupport extends StatefulWidget {
  const CounselorSupport({Key? key}) : super(key: key);

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

  openWhatsapp(counselorMobNo) async {
    var whatsappAndroid =
        "whatsapp://send?phone=+91" + counselorMobNo + "&text=hi";
    var whatappIos =
        "https://wa.me/+91${counselorMobNo}?text=${Uri.parse("hi")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappIos)) {
        await launch(whatappIos, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Whatsapp not Installed"),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappAndroid)) {
        await launch(whatsappAndroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Whatsapp not Installed"),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

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
        leading: IconButton(
          icon: Icon(Icons.sort_outlined),
          onPressed: () => ZoomDrawer.of(context)!.toggle(),
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
                                        openWhatsapp(user.counselorMobNo);
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
