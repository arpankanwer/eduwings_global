// import 'package:flutter/material.dart';

// Widget a() {
//   return Scaffold(
//     // resizeToAvoidBottomInset: true,
//     backgroundColor: Theme.of(context).primaryColor,
//     appBar: AppBar(
//       centerTitle: true,
//       title: Text(
//         'Your Profile',
//       ),
//       leading: IconButton(
//         icon: Icon(Icons.sort_outlined),
//         onPressed: () => ZoomDrawer.of(context)!.toggle(),
//       ),
//     ),
//     body: Container(
//       height: mediaQuery.height,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(40.0),
//           topLeft: Radius.circular(40.0),
//         ),
//         color: Colors.grey[300],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(mediaQuery.height * 0.01),
//         child: Column(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.only(top: mediaQuery.height * 0.01),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(30))),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: mediaQuery.width * 0.04),
//                           // color: Colors.white,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               SizedBox(
//                                 height: mediaQuery.height * 0.01,
//                               ),
//                               Text(
//                                 'Reset Your Password',
//                                 style: Theme.of(context).textTheme.subtitle2,
//                               ),
//                               SizedBox(
//                                 height: mediaQuery.height * 0.01,
//                               ),
//                               Divider(
//                                 color: Colors.black,
//                               ),
//                               SizedBox(
//                                 height: mediaQuery.height * 0.01,
//                               ),
//                               Container(
//                                 child: oldPasswordField(context),
//                               ),
//                               SizedBox(
//                                 height: mediaQuery.height * 0.01,
//                               ),
//                               Container(
//                                 child: newPasswordField(context),
//                               ),
//                               SizedBox(
//                                 height: mediaQuery.height * 0.01,
//                               ),
//                               Container(
//                                 child: confirmPasswordField(context),
//                               ),
//                               SizedBox(
//                                 height: mediaQuery.height * 0.01,
//                               ),
//                               Container(
//                                 width: mediaQuery.width * 0.3,
//                                 height: mediaQuery.width * 0.11,
//                                 child: ElevatedButton(
//                                   style: TextButton.styleFrom(
//                                       backgroundColor:
//                                           Theme.of(context).primaryColor,
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(20))),
//                                   onPressed: isReset == true
//                                       ? null
//                                       : () {
//                                           if (!resetPasswordForm.currentState!
//                                               .validate()) {
//                                             return;
//                                           }
//                                           resetPasswordForm.currentState!
//                                               .save();
//                                           setState(() {
//                                             isReset = true;
//                                           });
//                                           setState(() {
//                                             isReset = false;
//                                           });
//                                           // Provider.of<LoginProvider>(context,
//                                           //         listen: false)
//                                           //     .login(mobNo.text, password.text)
//                                           //     .then(
//                                           //   (response) {
//                                           //     setState(() {
//                                           //       isLogin = false;
//                                           //     });
//                                           //     if (response.statusCode == 200) {
//                                           //       var userData =
//                                           //           json.decode(response.body);
//                                           //       if (userData.length == 0) {
//                                           //         ScaffoldMessenger.of(context)
//                                           //             .showSnackBar(
//                                           //           SnackBar(
//                                           //             content: Text(
//                                           //                 'Invalid Mobile No. or Password'),
//                                           //             backgroundColor:
//                                           //                 Colors.red,
//                                           //           ),
//                                           //         );
//                                           //       } else {
//                                           //         Provider.of<LoginProvider>(
//                                           //                 context,
//                                           //                 listen: false)
//                                           //             .setSharedData(
//                                           //                 userData[0])
//                                           //             .then((value) => Navigator
//                                           //                     .of(context)
//                                           //                 .pushReplacementNamed(
//                                           //                     '/homePage'));
//                                           //       }
//                                           //     } else {
//                                           //       throw Exception(
//                                           //           'Failed to Connect');
//                                           //     }
//                                           //   },
//                                           // );
//                                         },
//                                   child: isReset == false
//                                       ? Text(
//                                           'Reset ',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .headline1,
//                                         )
//                                       : Center(
//                                           child: CircularProgressIndicator(),
//                                         ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: mediaQuery.height * 0.01,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
