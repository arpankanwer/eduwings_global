import 'dart:convert';

import 'package:eduwings_global/ui/forgotPassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../provider/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginForm = GlobalKey<FormState>();

  bool isLogin = false;
  bool _obscureText = true;

  final TextEditingController mobNo = TextEditingController();
  final TextEditingController password = TextEditingController();

  FocusNode mobNoFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    mobNoFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(
          'Eduwings Global',
        ),
        material: (_, __) => MaterialAppBarData(centerTitle: true),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
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
                        children: [
                          SizedBox(
                            height: mediaQuery.height * 0.01,
                          ),
                          SingleChildScrollView(
                            child: Form(
                              key: loginForm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mediaQuery.width * 0.04),
                                // color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Text(
                                      'Student Login',
                                      style: platformThemeData(
                                        context,
                                        material: (data) =>
                                            data.textTheme.subtitle2,
                                        cupertino: (data) =>
                                            data.textTheme.tabLabelTextStyle,
                                      ),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Container(
                                      child: einField(context, mediaQuery),
                                    ),
                                    // Padding(
                                    //   padding: EdgeInsets.only(
                                    //       left: mediaQuery.width * 0.1,
                                    //       right: mediaQuery.width * 0.01),
                                    //   child: Divider(
                                    //     color: Colors.black45,
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Material(
                                      child: Container(
                                        child:
                                            passwordField(context, mediaQuery),
                                      ),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed("/forgotPassword");
                                        },
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "Forgot Password?",
                                              style: platformThemeData(
                                                context,
                                                material: (data) =>
                                                    data.textTheme.headline3,
                                                cupertino: (data) => data
                                                    .textTheme
                                                    .tabLabelTextStyle,
                                              ),
                                            ))),
                                    SizedBox(
                                      height: mediaQuery.height * 0.02,
                                    ),
                                    Container(
                                      // height: mediaQuery.height * 0.2,
                                      // width: mediaQuery.width * 0.5,
                                      child: CupertinoButton(
                                        disabledColor: Colors.white,
                                        color: platformThemeData(
                                          context,
                                          material: (data) => data.primaryColor,
                                          cupertino: (data) =>
                                              data.primaryColor,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        onPressed: isLogin == true
                                            ? null
                                            : () {
                                                if (!loginForm.currentState!
                                                    .validate()) {
                                                  return;
                                                }
                                                loginForm.currentState!.save();
                                                setState(() {
                                                  isLogin = true;
                                                });
                                                Provider.of<LoginProvider>(
                                                        context,
                                                        listen: false)
                                                    .login(mobNo.text,
                                                        password.text)
                                                    .then(
                                                  (response) {
                                                    setState(() {
                                                      isLogin = false;
                                                    });
                                                    if (response.statusCode ==
                                                        200) {
                                                      var userData =
                                                          json.decode(
                                                              response.body);
                                                      if (userData.length ==
                                                          0) {
                                                        // ScaffoldMessenger.of(
                                                        //         context)
                                                        //     .showSnackBar(
                                                        //   SnackBar(
                                                        //     content: Text(
                                                        //         'Invalid Mobile No. or Password'),
                                                        //     backgroundColor:
                                                        //         Colors.red,
                                                        //   ),
                                                        // );
                                                        showDialog(
                                                          useSafeArea: true,
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              CupertinoAlertDialog(
                                                            title: Text(
                                                                "Wrong Credentials"),
                                                            content: Text(
                                                                "Invalid EIN or Password"),
                                                            actions: [
                                                              CupertinoDialogAction(
                                                                onPressed: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(),
                                                                child: Text(
                                                                  "Close",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      } else {
                                                        Provider.of<LoginProvider>(
                                                                context,
                                                                listen: false)
                                                            .setSharedData(
                                                                userData[0])
                                                            .then((value) => Navigator
                                                                    .of(context)
                                                                .pushReplacementNamed(
                                                                    '/homePage'));
                                                      }
                                                    } else {
                                                      throw Exception(
                                                          'Failed to Connect');
                                                    }
                                                  },
                                                );
                                              },
                                        child: isLogin == false
                                            ? Text(
                                                'Login',
                                                style: platformThemeData(
                                                  context,
                                                  material: (data) =>
                                                      data.textTheme.headline4,
                                                  cupertino: (data) => data
                                                      .textTheme
                                                      .navTitleTextStyle,
                                                ),
                                              )
                                            : Center(
                                                child:
                                                    CupertinoActivityIndicator(),
                                              ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.03,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Don't have an account? "),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    '/createAccount');
                                          },
                                          child: Text(
                                            "Create your account.",
                                            style: TextStyle(
                                                color: Colors.deepOrange),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PlatformTextFormField einField(context, mediaQuery) {
    return PlatformTextFormField(
      focusNode: mobNoFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(passwordFocusNode),
      onSaved: (String? value) {
        value = mobNo.text;
      },
      onChanged: (String? value) {
        value = mobNo.text;
      },
      controller: mobNo,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value?.isEmpty == true || value == null) {
          return "EIN can't be Empty";
        }
        return null;
      },
      style: platformThemeData(
        context,
        material: (data) => data.textTheme.headline3,
        cupertino: (data) => data.textTheme.actionTextStyle,
      ),
      cupertino: (_, __) => CupertinoTextFormFieldData(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        placeholder: 'Enter EIN *',
        prefix: Row(
          children: [
            Icon(
              CupertinoIcons.number_circle_fill,
              color: CupertinoTheme.of(context).primaryColor,
            ),
            SizedBox(
              width: mediaQuery.width * 0.02,
            ),
          ],
        ),
      ),
      material: (_, __) => MaterialTextFormFieldData(
        decoration: InputDecoration(
          prefixIcon: Icon(
            CupertinoIcons.number_circle_fill,
            color: Theme.of(context).primaryColor,
          ),
          hintText: 'Enter EIN *',
          labelText: 'Enter EIN *',
        ),
      ),
    );
  }

  PlatformTextFormField passwordField(context, mediaQuery) {
    return PlatformTextFormField(
      focusNode: passwordFocusNode,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
      onSaved: (String? value) {
        value = password.text;
      },
      controller: password,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.length < 7) return 'Enter Minimum 7 Letters Password';
      },
      obscureText: _obscureText,
      style: platformThemeData(
        context,
        material: (data) => data.textTheme.headline3,
        cupertino: (data) => data.textTheme.actionTextStyle,
      ),
      cupertino: (_, __) => CupertinoTextFormFieldData(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        placeholder: 'Enter Password *',
        prefix: Row(
          children: [
            Icon(
              CupertinoIcons.lock_fill,
              color: CupertinoTheme.of(context).primaryColor,
            ),
            SizedBox(
              width: mediaQuery.width * 0.02,
            ),
          ],
        ),
      ),
      material: (_, __) => MaterialTextFormFieldData(
        decoration: InputDecoration(
          prefixIcon: Icon(
            CupertinoIcons.lock_fill,
            color: Theme.of(context).primaryColor,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText
                  ? CupertinoIcons.eye_slash_fill
                  : CupertinoIcons.eye_fill,
              semanticLabel: _obscureText ? 'Show Password' : 'Hide Password',
            ),
          ),
          hintText: 'Enter Password *',
          labelText: 'Enter Password *',
        ),
      ),
    );
  }

  // TextFormField passwordField(context, mediaQuery) {
  //   return TextFormField(
  //     focusNode: passwordFocusNode,
  //     textInputAction: TextInputAction.done,
  //     onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
  //     onSaved: (String? value) {
  //       value = password.text;
  //     },
  //     controller: password,
  //     keyboardType: TextInputType.text,
  //     validator: (value) {
  //       if (value!.length < 7) return 'Enter Minimum 7 Letters Password';
  //     },
  //     obscureText: _obscureText,
  //     style: platformThemeData(
  //       context,
  //       material: (data) => data.textTheme.headline3,
  //       cupertino: (data) => data.textTheme.actionTextStyle,
  //     ),
  //     // decoration: Theme.of(context).inputDecoration,
  //     decoration: InputDecoration(
  //       // isDense: Theme.of(context).inputDecorationTheme.isDense,
  //       // labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
  //       // hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
  //       // border: Theme.of(context).inputDecorationTheme.border,
  //       // focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
  //       // enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
  //       // errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
  //       prefixIcon: Icon(
  //         CupertinoIcons.lock_fill,
  //         color: Theme.of(context).primaryColor,
  //       ),
  //       suffixIcon: GestureDetector(
  //         onTap: () {
  //           setState(() {
  //             _obscureText = !_obscureText;
  //           });
  //         },
  //         child: Icon(
  //           _obscureText
  //               ? CupertinoIcons.eye_slash_fill
  //               : CupertinoIcons.eye_fill,
  //           semanticLabel: _obscureText ? 'Show Password' : 'Hide Password',
  //         ),
  //       ),
  //       hintText: 'Enter Password *',
  //       labelText: 'Enter Password *',
  //     ),
  //   );
  // }

}
