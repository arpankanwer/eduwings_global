import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../classes/user.dart';

import '../provider/login.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int activeIndex = 0;
  final imageController = CarouselController();
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

  final urlImages = [
    "https://eduwingserp.com/Api/v1/mobile/images/sliders/slider1.jpg",
    "https://eduwingserp.com/Api/v1/mobile/images/sliders/slider2.jpg",
    "https://eduwingserp.com/Api/v1/mobile/images/sliders/slider3.jpg",
    "https://eduwingserp.com/Api/v1/mobile/images/sliders/slider4.jpg",
    "https://eduwingserp.com/Api/v1/mobile/images/sliders/slider5.jpg",
  ];

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
    return PlatformScaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: PlatformAppBar(
        material: (_, __) => MaterialAppBarData(centerTitle: true),
        // centerTitle: true,
        title: Text(
          'Welcome ${user.fName}',
        ),
        leading: IconButton(
          icon: Icon(CupertinoIcons.line_horizontal_3_decrease),
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
                              children: [
                                SizedBox(
                                  height: mediaQuery.height * 0.02,
                                ),
                                Container(
                                  child: CarouselSlider.builder(
                                    carouselController: imageController,
                                    itemCount: urlImages.length,
                                    options: CarouselOptions(
                                      viewportFraction: 0.89,
                                      initialPage: 0,
                                      enlargeCenterPage: true,
                                      enlargeStrategy:
                                          CenterPageEnlargeStrategy.height,
                                      enableInfiniteScroll: true,
                                      height: mediaQuery.height * 0.2,
                                      autoPlay: true,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          activeIndex = index;
                                        });
                                      },
                                    ),
                                    itemBuilder: (context, index, realIndex) {
                                      final urlImage = urlImages[index];
                                      return buildImage(urlImage, index);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: mediaQuery.height * 0.01,
                                ),
                                buildIndicator(),
                                SizedBox(
                                  height: mediaQuery.height * 0.02,
                                ),
                                Container(
                                  child: Text(
                                    "Menu",
                                    textAlign: TextAlign.justify,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                                SizedBox(
                                  height: mediaQuery.height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed('/profilePage');
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              minWidth: 25,
                                              minHeight: 25,
                                              maxWidth: 45,
                                              maxHeight: 45,
                                            ),
                                            child: Image.asset(
                                                "assets/icons/consent.png",
                                                fit: BoxFit.cover),
                                          ),
                                          SizedBox(
                                            height: mediaQuery.height * 0.01,
                                          ),
                                          Text(
                                            "My Profile",
                                            style: TextStyle(
                                              letterSpacing: 0.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
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
                                                "assets/icons/calendar.png",
                                                fit: BoxFit.cover),
                                          ),
                                          SizedBox(
                                            height: mediaQuery.height * 0.01,
                                          ),
                                          Text(
                                            "Appointment",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                    //  Refer Friend Sections
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed('/referFriend');
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
                                                "assets/icons/bracelet.png",
                                                fit: BoxFit.cover),
                                          ),
                                          SizedBox(
                                            height: mediaQuery.height * 0.01,
                                          ),
                                          Text(
                                            "Refer Friend",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                    //  Application Status Sections
                                    InkWell(
                                      onTap: () {},
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
                                                "assets/icons/aircraft.png",
                                                fit: BoxFit.cover),
                                          ),
                                          SizedBox(
                                            height: mediaQuery.height * 0.01,
                                          ),
                                          Text(
                                            "Application\nStatus",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: mediaQuery.height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    // Notifications Sections
                                    InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: <Widget>[
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              minWidth: 25,
                                              minHeight: 25,
                                              maxWidth: 45,
                                              maxHeight: 45,
                                            ),
                                            child: Image.asset(
                                                "assets/icons/nP.png",
                                                fit: BoxFit.cover),
                                          ),
                                          SizedBox(
                                            height: mediaQuery.height * 0.01,
                                          ),
                                          Text(
                                            "Notifications",
                                            style: TextStyle(
                                              letterSpacing: 0.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Call Counselor Sections
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed('/callCounselor');
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
                                                "assets/icons/headset.png",
                                                fit: BoxFit.cover),
                                          ),
                                          SizedBox(
                                            height: mediaQuery.height * 0.01,
                                          ),
                                          Text(
                                            "Call\nCounselor",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                    // Whatsapp Counselor Sections
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed('/callCounselor');
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
                                                "assets/icons/whatsappcounselor.png",
                                                fit: BoxFit.cover),
                                          ),
                                          SizedBox(
                                            height: mediaQuery.height * 0.01,
                                          ),
                                          Text(
                                            "Whatsapp\nCounselor",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                    // Complaints and Suggestions Sections
                                    InkWell(
                                      onTap: () {},
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
                                                "assets/icons/satisfaction.png",
                                                fit: BoxFit.cover),
                                          ),
                                          SizedBox(
                                            height: mediaQuery.height * 0.01,
                                          ),
                                          Text(
                                            "Complaints &\nSuggestions",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: mediaQuery.height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    //  Sections
                                    // Coding for empty Sections Starts Here
                                    InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: <Widget>[
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              minWidth: 25,
                                              minHeight: 25,
                                              maxWidth: 40,
                                              maxHeight: 40,
                                            ),
//                        child: Image.asset("assets/icons/icnfb.png",
//                            fit: BoxFit.cover),
                                          ),
                                          SizedBox(
                                            height: mediaQuery.height * 0.01,
                                          ),
//                      new Text("")
                                        ],
                                      ),
                                    ),
                                    // Coding for empty Sections Ends Here
                                    InkWell(
                                      onTap: () {
                                        // Function Calling From #SocialMediaLinks.dart# File
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
                                                "assets/icons/chatting.png",
                                                fit: BoxFit.cover),
                                          ),
                                          SizedBox(
                                            height: mediaQuery.height * 0.01,
                                          ),
                                          Text("Testimonial")
                                        ],
                                      ),
                                    ),
                                    // Coding for Testimonial Sections Ends Here
                                    // Coding for Ielts Section Starts Here
                                    InkWell(
                                      onTap: () {},
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
                                                "assets/icons/ielts.png",
                                                fit: BoxFit.cover),
                                          ),
                                          SizedBox(
                                            height: mediaQuery.height * 0.01,
                                          ),
                                          Text("IELTS")
                                        ],
                                      ),
                                    ),
                                    // Coding for Ielts Sections Ends Here
                                    // Coding for empty Sections Starts Here
                                    InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: <Widget>[
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              minWidth: 25,
                                              minHeight: 25,
                                              maxWidth: 40,
                                              maxHeight: 40,
                                            ),
//                        child: Image.asset("assets/icons/icnfb.png",
//                            fit: BoxFit.cover),
                                          ),
                                          SizedBox(
                                            height: mediaQuery.height * 0.01,
                                          ),
//                      new Text("")
                                        ],
                                      ),
                                    ),
                                    // Coding for empty Sections Ends Here
                                  ],
                                ),
                                // Row no.3 For First Four Menu Items Ends Here!
                                SizedBox(
                                  height: mediaQuery.height * 0.02,
                                ),
                                // Row no.4 For First Four Menu Items Starts Here!
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    // Website Sections
                                    InkWell(
                                      onTap: () {
                                        Provider.of<LoginProvider>(context,
                                                listen: false)
                                            .websiteUrl(); // Function Calling From #SocialMediaLinks.dart# File
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
                                    // Facebook Sections
                                    InkWell(
                                      onTap: () {
                                        Provider.of<LoginProvider>(context,
                                                listen: false)
                                            .facebookUrl(); // Function Calling From #SocialMediaLinks.dart# File
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
                                    // Instagram Section
                                    InkWell(
                                      onTap: () {
                                        Provider.of<LoginProvider>(context,
                                                listen: false)
                                            .instagramUrl(); // Fuctions Calling From #SocialMediaLinks.dart# File
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
                                    // About Section
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed('/aboutEduwings');
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
                                          Text(
                                            "About\nEduwings",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // Row no.4 For First Four Menu Items Ends Here!
                                // Coding For Divider Section Starts Here !
                                SizedBox(
                                  height: mediaQuery.height * 0.01,
                                ),
                                // Coding For Divider Section Ends Here !
                                // Coding For News&Higglights Section Starts Here !

                                // Coding For News&Higglights Section Ends Here !
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: new Text(
                                              "News & Highlights",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Image.asset(
                                          "assets/images/news.jpg",
                                          height: 150,
                                        ),
                                      ],
                                    ),
//              SizedBox(height: 200, child: Swipers()),
                                  ),
                                ) // Calling For Swiper Function Which is Defined at Last Here !
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

  Widget buildImage(String urlImage, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          placeholder: (context, url) =>
              Center(child: CupertinoActivityIndicator()),
          imageUrl: urlImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: urlImages.length,
      onDotClicked: (index) => imageController.animateToPage(index),
      effect: WormEffect(
          activeDotColor: Colors.red,
          dotWidth: 20,
          dotHeight: 14,
          dotColor: Colors.black12),
    );
  }
}
