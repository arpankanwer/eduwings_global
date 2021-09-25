import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import '../provider/appProvider.dart';

class AboutEduwings extends StatelessWidget {
  final bool fromDrawer;
  const AboutEduwings({Key? key, required this.fromDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('About Eduwings'),
        leading: fromDrawer == true
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                10.0, 20.0, 15.0, 0.0),
                            child: ListTile(
                              leading: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 25,
                                  minHeight: 25,
                                  maxWidth: 400,
                                  maxHeight: 400,
                                ),
                                child: Image.asset("assets/splashScreen.png",
                                    fit: BoxFit.contain),
                              ),
                              title: Column(
                                children: <Widget>[
                                  Text(
                                    "Eduwings Global",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        25.0, 0.0, 25.0, 0.0),
                                    child: Divider(
                                      thickness: 1.0,
                                    ),
                                  ),
                                  new Text(
                                    "Your Future With Trusted Leader",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black26,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                            child: Divider(
                              thickness: 1.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "At Eduwings, our motive is to help you exploit the power of globalization. "
                              "We help aspiring students to secure a chance of honing their skills and knowledge by grabbing the best opportunities."
                              "Our aim is to broaden the reach of the Indian students aspiring to join"
                              " reputed courses, programmes in renowned universities in UK, USA, Canada, Australis, Europe and other foreign countries."
                              " \n\nTo pursue our goal, we offer an extensive range of services designed and developed to "
                              "aid the aspiring Indian students to secure admissions in the desired foreign university.\n\n"
                              "We are a team of professionals that stay abreast with the changes occurring in the education center and job openings abroad. "
                              "With a high turn-over rate, we are proud foreign career and education consultants. ",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                            child: Divider(
                              thickness: 1.0,
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.location_on),
                            title: new Text(
                              "SCO-11, Model Town Extension, Ludhiana, Punjab, India - 141002",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone_android),
                            title: new Text(
                              "0161-4600041, 42, 43 \n 95016-26000",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: new Text(
                              "admissions@eduwingsglobal.com",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .websiteUrl();
                                },
                                child: Column(
                                  children: <Widget>[
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: 25,
                                        minHeight: 25,
                                        maxWidth: 40,
                                        maxHeight: 40,
                                      ),
                                      child: Image.asset(
                                          "assets/icons/aboutus.png",
                                          fit: BoxFit.cover),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Text("Website")
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .facebookUrl();
                                },
                                child: Column(
                                  children: <Widget>[
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: 25,
                                        minHeight: 25,
                                        maxWidth: 40,
                                        maxHeight: 40,
                                      ),
                                      child: Image.asset(
                                          "assets/icons/icnfb.png",
                                          fit: BoxFit.cover),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Text("Facebook")
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .instagramUrl();
                                },
                                child: Column(
                                  children: <Widget>[
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: 25,
                                        minHeight: 25,
                                        maxWidth: 40,
                                        maxHeight: 40,
                                      ),
                                      child: Image.asset(
                                          "assets/icons/icninstagram.png",
                                          fit: BoxFit.cover),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Text("Instagram")
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          )
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
