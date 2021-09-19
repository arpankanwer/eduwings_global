import 'dart:convert';

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
  var resetResponse;

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
        isLogged: prefs.getString('isLogged').toString());
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
}
