import 'dart:convert';

import 'package:eduwings_global/provider/profileProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    return Scaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Eduwings Global',
        ),
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
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
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
                                      child: mobileNoField(context),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Container(
                                      child: passwordField(context),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Container(
                                      width: mediaQuery.width * 0.3,
                                      height: mediaQuery.width * 0.11,
                                      child: ElevatedButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        onPressed: () {
                                          if (!loginForm.currentState!
                                              .validate()) {
                                            return;
                                          }
                                          loginForm.currentState!.save();
                                          setState(() {
                                            isLogin = true;
                                          });
                                          Provider.of<LoginProvider>(context,
                                                  listen: false)
                                              .login(mobNo.text, password.text)
                                              .then(
                                            (response) {
                                              setState(() {
                                                isLogin = false;
                                              });
                                              if (response.statusCode == 200) {
                                                var userData =
                                                    json.decode(response.body);
                                                if (userData.length == 0) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          'Invalid Mobile No. or Password'),
                                                      backgroundColor:
                                                          Colors.red,
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
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1,
                                              )
                                            : Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
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

  TextFormField mobileNoField(context) {
    return TextFormField(
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
          return "Mobile No. can't be Empty";
        }
        // if (value.length != 10) {
        //   return "Mobile No. must be 10 digits";
        // }
        return null;
      },
      style: Theme.of(context).textTheme.headline3,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.phone,
          color: Theme.of(context).primaryColor,
        ),
        hintText: 'Enter Mobile No. *',
        labelText: 'Enter Mobile No. *',
      ),
    );
  }

  TextFormField passwordField(context) {
    return TextFormField(
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
      style: Theme.of(context).textTheme.headline3,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Theme.of(context).primaryColor,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            _obscureText = !_obscureText;
          },
          child: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            semanticLabel: _obscureText ? 'Show Password' : 'Hide Password',
          ),
        ),
        hintText: 'Enter Password *',
        labelText: 'Enter Password *',
      ),
    );
  }
}
