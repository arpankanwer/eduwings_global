import 'dart:convert';

import 'package:eduwings_global/classes/user.dart';
import 'package:eduwings_global/provider/login.dart';
import 'package:eduwings_global/provider/profileProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isEducationLoader = true;
  bool educationExpanded = true;

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
  List<dynamic> educationList = [];
  @override
  void initState() {
    super.initState();

    Provider.of<LoginProvider>(context, listen: false)
        .getSharedData()
        .then((value) {
      setState(() {
        user = value;
      });
      Provider.of<ProfileProvider>(context, listen: false)
          .getEducationDetail(user.formId)
          .then((response) {
        print(response.body);
        if (response.statusCode == 200) {
          setState(() {
            educationList = json.decode(response.body);
            isEducationLoader = false;
          });
        } else {
          throw Exception('Failed to load');
        }
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
          'Your Profile',
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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: mediaQuery.width * 0.04),
                            // color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: mediaQuery.height * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                        height: mediaQuery.height * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Personal Detail',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: mediaQuery.height * 0.01,
                                      ),
                                      DataTable(
                                        headingRowHeight:
                                            mediaQuery.height * 0.01,
                                        dataRowHeight: mediaQuery.height * 0.05,
                                        columns: [
                                          DataColumn(
                                              label: Expanded(
                                            child: Text(
                                              '',
                                              softWrap: true,
                                            ),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            '',
                                          )),
                                        ],
                                        rows: [
                                          if (user.ein.isNotEmpty)
                                            DataRow(cells: [
                                              DataCell(Text('EIN')),
                                              DataCell(Text(
                                                user.ein,
                                                overflow: TextOverflow.visible,
                                                softWrap: true,
                                              ))
                                            ]),
                                          if (user.fName.isNotEmpty)
                                            DataRow(cells: [
                                              DataCell(Text('First Name')),
                                              DataCell(Text(
                                                user.fName,
                                                overflow: TextOverflow.visible,
                                                softWrap: true,
                                              ))
                                            ]),
                                          if (user.lName.isNotEmpty)
                                            DataRow(cells: [
                                              DataCell(Text('Last Name')),
                                              DataCell(Text(user.lName,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  softWrap: true))
                                            ]),
                                          if (user.email.isNotEmpty)
                                            DataRow(cells: [
                                              DataCell(Text('Email Id')),
                                              DataCell(
                                                Text(user.email),
                                              )
                                            ]),
                                          if (user.mobNo.isNotEmpty)
                                            DataRow(cells: [
                                              DataCell(Text('Mobile No.')),
                                              DataCell(Text(user.mobNo,
                                                  softWrap: true))
                                            ]),
                                          if (user.dob.isNotEmpty)
                                            DataRow(cells: [
                                              DataCell(Text('D.O.B')),
                                              DataCell(Text(user.dob,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  softWrap: true))
                                            ]),
                                          if (user.gender.isNotEmpty)
                                            DataRow(cells: [
                                              DataCell(Text('Gender')),
                                              DataCell(Text(
                                                user.gender,
                                                overflow: TextOverflow.visible,
                                                softWrap: true,
                                              ))
                                            ]),
                                          if (user.passport.isNotEmpty)
                                            DataRow(cells: [
                                              DataCell(Text('Passport No.')),
                                              DataCell(Text(user.passport,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  softWrap: true))
                                            ]),
                                        ],
                                      ),
                                      SizedBox(
                                        height: mediaQuery.height * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Address Detail',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: mediaQuery.height * 0.01,
                                      ),
                                      DataTable(
                                        headingRowHeight:
                                            mediaQuery.height * 0.01,
                                        dataRowHeight: mediaQuery.height * 0.05,
                                        columns: [
                                          DataColumn(
                                              label: Expanded(
                                            child: Text(
                                              '',
                                              softWrap: true,
                                            ),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            '',
                                          )),
                                        ],
                                        rows: [
                                          if (user.address.isNotEmpty)
                                            DataRow(cells: [
                                              DataCell(Text('Address')),
                                              DataCell(Text(
                                                user.address,
                                              ))
                                            ]),
                                          if (user.countryName.isNotEmpty)
                                            DataRow(cells: [
                                              DataCell(Text('Country')),
                                              DataCell(Text(
                                                user.countryName,
                                                overflow: TextOverflow.visible,
                                                softWrap: true,
                                              ))
                                            ]),
                                          if (user.stateName.isNotEmpty)
                                            DataRow(cells: [
                                              DataCell(Text('State')),
                                              DataCell(Text(user.stateName,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  softWrap: true))
                                            ]),
                                          if (user.cityName.isNotEmpty)
                                            DataRow(cells: [
                                              DataCell(Text('City')),
                                              DataCell(Text(user.cityName,
                                                  softWrap: true))
                                            ]),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: mediaQuery.height * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Education Detail',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: mediaQuery.height * 0.01,
                                ),
                                isEducationLoader == true
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: educationList.length,
                                        itemBuilder: (con, index) {
                                          return Card(
                                            margin: EdgeInsets.all(
                                                mediaQuery.height * 0.01),
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0))),
                                            elevation: 5,
                                            child: ExpansionTile(
                                              initiallyExpanded: true,
                                              onExpansionChanged: (value) {
                                                setState(() {
                                                  educationExpanded = value;
                                                });
                                              },
                                              // backgroundColor: Colors.white,
                                              title: Text(
                                                  educationList[index]['Class']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              trailing: educationExpanded ==
                                                      false
                                                  ? Icon(Icons.arrow_drop_down)
                                                  : Icon(Icons.arrow_drop_up,
                                                      color: Colors.black54),
                                              children: <Widget>[
                                                if (educationList[index]
                                                        ['Stream'] !=
                                                    '')
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8,
                                                        right: 8.0,
                                                        bottom: 8),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text("Stream"),
                                                        Spacer(),
                                                        Text(
                                                          educationList[index]
                                                                  ['Stream']
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .visible,
                                                          softWrap: true,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                if (educationList[index]
                                                        ['Subject'] !=
                                                    '')
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8,
                                                        right: 8.0,
                                                        bottom: 8),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text("Subject"),
                                                        Spacer(),
                                                        Text(
                                                            educationList[index]
                                                                    ['Subject']
                                                                .toString())
                                                      ],
                                                    ),
                                                  ),
                                                if (educationList[index]
                                                        ['Institute'] !=
                                                    '')
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8,
                                                        right: 8.0,
                                                        bottom: 8),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text("School/College"),
                                                        Spacer(),
                                                        Text(educationList[
                                                                    index]
                                                                ['Institute']
                                                            .toString())
                                                      ],
                                                    ),
                                                  ),
                                                if (educationList[index]
                                                        ['Board'] !=
                                                    '')
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8,
                                                        right: 8.0,
                                                        bottom: 8),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                            "Board/University"),
                                                        Spacer(),
                                                        Text(
                                                          educationList[index]
                                                                  ['Board']
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .visible,
                                                          softWrap: true,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                if (educationList[index]
                                                        ['FromYear'] !=
                                                    '')
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8,
                                                        right: 8.0,
                                                        bottom: 8),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text("From Year"),
                                                        Spacer(),
                                                        Text(
                                                          educationList[index]
                                                                  ["FromYear"]
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .visible,
                                                          softWrap: true,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                if (educationList[index]
                                                        ['ToYear'] !=
                                                    '')
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8,
                                                        right: 8.0,
                                                        bottom: 8),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text("To Year"),
                                                        Spacer(),
                                                        Text(
                                                          educationList[index]
                                                                  ["ToYear"]
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .visible,
                                                          softWrap: true,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                if (educationList[index]
                                                        ["Percentage"] !=
                                                    '')
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8,
                                                        right: 8.0,
                                                        bottom: 8),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text("%/CGPA"),
                                                        Spacer(),
                                                        Text(
                                                          educationList[index]
                                                                  ["Percentage"]
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .visible,
                                                          softWrap: true,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                SizedBox(
                                  height: mediaQuery.height * 0.01,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
