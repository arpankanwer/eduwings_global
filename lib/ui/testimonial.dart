import 'dart:async';
import 'dart:convert';

import 'package:eduwings_global/classes/testimonial.dart';
import 'package:eduwings_global/provider/appProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Testimonial extends StatefulWidget {
  const Testimonial({Key? key}) : super(key: key);

  @override
  _TestimonialState createState() => _TestimonialState();
}

class _TestimonialState extends State<Testimonial> {
  StreamController testimonialController = StreamController();
  bool isTestimonial = true;

  List<Testimonials> testimonialList = [];

  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false)
        .fetchTestimonals()
        .then((value) {
      setState(() {
        testimonialList = value;
        isTestimonial = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Testimonial'),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        material: (_, __) => MaterialAppBarData(centerTitle: true),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: mediaQuery.height * 0.02,
                                ),
                                isTestimonial == false
                                    ? Container(
                                        height: mediaQuery.height * 0.8,
                                        child: ListView.builder(
                                          itemCount: testimonialList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            print(testimonialList);
                                            return Column(
                                              children: <Widget>[
                                                Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  elevation: 7.0,
                                                  child: ListTile(
                                                    onTap: () {},
                                                    contentPadding:
                                                        EdgeInsets.all(10.0),
                                                    title: Text(
                                                      testimonialList[index]
                                                          .stuName,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    subtitle: Container(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(testimonialList[
                                                                      index]
                                                                  .countryName +
                                                              ' - ' +
                                                              testimonialList[
                                                                      index]
                                                                  .collegeName +
                                                              ", " +
                                                              testimonialList[
                                                                      index]
                                                                  .countryName),
                                                          Text(testimonialList[
                                                                  index]
                                                              .remarks),
                                                        ],
                                                      ),
                                                    ),
                                                    leading: Container(
                                                      height:
                                                          mediaQuery.height *
                                                              0.2,
                                                      width: mediaQuery.width *
                                                          0.2,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child:
                                                            CachedNetworkImage(
                                                          placeholder: (context,
                                                                  url) =>
                                                              Center(
                                                                  child:
                                                                      CupertinoActivityIndicator()),
                                                          imageUrl: testimonialList[
                                                                  index]
                                                              .testimonialImage,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
//                                                     leading: Container(
//                                                       height: 140,
//                                                       width: 100,
//                                                       child: FadeInImage
//                                                           .assetNetwork(
//                                                         placeholder:
//                                                             'assets/icons/loader.gif',
//                                                         image: testimonialList[
//                                                                 index]
//                                                             .testimonialImage,
//                                                         fit: BoxFit.cover,
//                                                       ),
// //
//                                                     ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      )
                                    : Center(
                                        child: CupertinoActivityIndicator(),
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
