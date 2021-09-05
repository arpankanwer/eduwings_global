import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class CounselorSupport extends StatefulWidget {
  const CounselorSupport({Key? key}) : super(key: key);

  @override
  _CounselorSupportState createState() => _CounselorSupportState();
}

class _CounselorSupportState extends State<CounselorSupport> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Your Counselor',
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
                    child: Column(children: [
                      SizedBox(
                        width: mediaQuery.width,
                      )
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
