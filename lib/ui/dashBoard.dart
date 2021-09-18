import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
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
                                      
                                      viewportFraction: 0.8,
                                      initialPage: 0,
                                      enlargeCenterPage: true,
                                      enlargeStrategy:
                                          CenterPageEnlargeStrategy.height,
                                      enableInfiniteScroll: true,
                                      height: 200,
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
              Center(child: CircularProgressIndicator()),
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
