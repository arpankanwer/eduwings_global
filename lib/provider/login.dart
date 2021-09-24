import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../classes/user.dart';

class LoginProvider with ChangeNotifier {
  String urlBase = "https://eduwingserp.com/Api/v1/mobile/";
  String apiKey = "ZUthbndlckluZGlhTHVkaGlhbmE=";
  String loginServerApi = "CheckUsernamePassword.php";
  String resetPasswordApi = "resetPassword.php";
  String leadFormServerApi = "setLeadForm.php";
  String forgotPasswordApi = "forgotPasswordSendOTP.php";
  String forgotPasswordSubmitOtpApi = "forgotPasswordSubmitOTP.php";
  var resetResponse;
  var referResponse;
  var forgotResponse;
  var changePasswordResponse;

  final qualificationList = [
    '12th',
    'Diploma',
    'Graduate',
    'Post Graduate',
    'Others',
  ];
  final purposeList = [
    'Study Visa',
    'PR',
    'Tourist Visa',
    'Business Visa',
    'Others',
  ];
  final genderList = [
    'Male',
    'Female',
    'Other',
  ];

  Future setSharedData(userData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('ein', userData['app_id']);
    prefs.setString('studentName', userData['fname'] + " " + userData['lname']);
    prefs.setString('fName', userData['fname']);
    prefs.setString('lName', userData['lname']);
    prefs.setString('email', userData['emailid']);
    prefs.setString('countryName', userData['country_name']);
    prefs.setString('stateName', userData['state_name']);
    prefs.setString('cityName', userData['city_name']);
    prefs.setString('passport', userData['passnumber']);
    prefs.setString('dob', userData['dob']);
    prefs.setString('gender', userData['gender']);
    prefs.setString('address', userData['paddress']);
    prefs.setString('profileImage', userData['form_imagename']);
    prefs.setString('mobNo', userData['mobile_no']);
    prefs.setString('counselorName', userData['user_fname']);
    prefs.setString('counselorMobNo', userData['user_mobile']);
    prefs.setString('formId', userData['form_id']);
    prefs.setString('isLogged', "1");
  }

  Future isLogggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('isLogged') ?? 0;
  }

  Future<User> getSharedData() async {
    final prefs = await SharedPreferences.getInstance();

    return User(
        ein: prefs.getString('ein').toString(),
        studentName: prefs.getString('fName').toString() +
            " " +
            prefs.getString('lName').toString(),
        fName: prefs.getString('fName').toString(),
        lName: prefs.getString('lName').toString(),
        email: prefs.getString('email').toString(),
        countryName: prefs.getString('countryName').toString(),
        stateName: prefs.getString('stateName').toString(),
        cityName: prefs.getString('cityName').toString(),
        passport: prefs.getString('passport').toString(),
        dob: prefs.getString('dob').toString(),
        gender: prefs.getString('gender').toString(),
        address: prefs.getString('address').toString(),
        profileImage: prefs.getString('profileImage').toString(),
        mobNo: prefs.getString('mobNo').toString(),
        counselorName: prefs.getString('counselorName').toString(),
        counselorMobNo: prefs.getString('counselorMobNo').toString(),
        formId: prefs.getString('formId').toString(),
        isLogged: prefs.getString('isLogged').toString(),
        otp: prefs.getString('otp').toString());
  }

  Future resetPassword(formId, oldPassword, newPassword) async {
    final response =
        await http.post(Uri.parse('$urlBase' + '$resetPasswordApi'), headers: {
      'APIKEY': '$apiKey'
    }, body: {
      "formid": '$formId',
      "oldpassword": '$oldPassword',
      "newpassword": '$newPassword',
    });
    resetResponse = json.decode(response.body);
    return response;
  }

  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future login(mobNo, password) async {
    final response =
        await http.post(Uri.parse('$urlBase' + '$loginServerApi'), headers: {
      'APIKEY': '$apiKey'
    }, body: {
      "khatanaam": mobNo,
      "khatacode": password,
    });
    return response;
  }

  Future forgotPassword(ein, mobNo, dob) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('ein', ein.toString());
    final dobDate = dob.split('/');
    final finalDobDate = "${dobDate[2]}"
        "-"
        "${dobDate[1]}"
        "-"
        "${dobDate[0]}";
    final response =
        await http.post(Uri.parse('$urlBase' + '$forgotPasswordApi'), headers: {
      'APIKEY': '$apiKey'
    }, body: {
      "appid": ein,
      "mobileno": mobNo,
      "dob": finalDobDate,
    });
    forgotResponse = json.decode(response.body);
    return response;
  }

  Future saveOtp(otp) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('otp', otp.toString());
  }

  Future checkOtp(otp) async {
    final prefs = await SharedPreferences.getInstance();
    final serverOtp = prefs.getString('otp').toString();
    print(serverOtp);
    return serverOtp == otp;
  }

  Future changePassword(ein, newwPassword) async {
    final response = await http
        .post(Uri.parse('$urlBase' + '$forgotPasswordSubmitOtpApi'), headers: {
      'APIKEY': '$apiKey'
    }, body: {
      "ein": ein,
      "newpassword": newwPassword,
    });
    changePasswordResponse = json.decode(response.body);
    return response;
  }

  Future referFriend(stuFName, stuLName, stuMobNo, stuWhatsappMobNo, stuEmail,
      stuGender, stuQualification, stuIelts, stuPurpose, formID) async {
    final response =
        await http.post(Uri.parse('$urlBase' + '$leadFormServerApi'), headers: {
      'APIKEY': '$apiKey'
    }, body: {
      "stdfName": stuFName,
      "stdlName": stuLName,
      "stdMobileNo": stuMobNo,
      "stdWhatsappNo": stuWhatsappMobNo,
      "stdEmail": stuEmail,
      "stdGender": stuGender,
      "stdQualification": stuQualification,
      "stdIelts": stuIelts,
      "stdPurpose": stuPurpose,
      "cDate": null,
      "source": 'StudentApp',
      "reference": formID,
    });
    referResponse = json.decode(response.body);
    return response;
  }

  openWhatsapp(context, counselorMobNo) async {
    var whatsappAndroid =
        "whatsapp://send?phone=+91" + counselorMobNo + "&text=Hi";
    var whatappIos =
        "https://wa.me/+91${counselorMobNo}?text=${Uri.parse("Hi")}";
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

  websiteUrl() async {
    const url = 'https://www.eduwingsglobal.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  facebookUrl() async {
    const url = 'https://www.facebook.com/EduwingsGlobal/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  instagramUrl() async {
    const url = 'https://instagram.com/eduwingsglobal';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  successDialog(context, message, mediaQuery) {
    return showDialog(
      useSafeArea: true,
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Column(
          children: [
            Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.green),
              child: Icon(
                Icons.done_outline,
                color: Colors.white,
                size: 30,
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.01,
            ),
            Text("Success"),
          ],
        ),
        content: Text(
          message.toString(),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "OK",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  errorDialog(context, message, mediaQuery) {
    return showDialog(
      useSafeArea: true,
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Column(
          children: [
            Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              child: Icon(
                Icons.error_outline_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.01,
            ),
            Text("Please Try Again"),
          ],
        ),
        content: Text(
          message.toString(),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "OK",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
