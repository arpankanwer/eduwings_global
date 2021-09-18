import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import '../classes/user.dart';

import '../provider/login.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final resetPasswordForm = GlobalKey<FormState>();

  bool isReset = false;
  bool oldPasswordObscureText = true;
  bool newPasswordObscureText = true;
  bool confirmPasswordObscureText = true;

  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  FocusNode oldPasswordFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

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

  successDialog(message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        title: SizedBox(
          height: 40,
          width: 40,
          child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.green),
            child: Icon(
              Icons.done_outline,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        content: Container(
            child: Text(
          message.toString(),
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        )),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "OK",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  errorDialog(message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        title: SizedBox(
          height: 40,
          width: 40,
          child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.red),
            child: Icon(
              Icons.error_outline_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        content: Container(
            child: Text(
          message.toString(),
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        )),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // widget.tabController.animateTo(0);
            },
            child: Text(
              "OK",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

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
  void dispose() {
    super.dispose();

    oldPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
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
          'Reset Password',
        ),
        leading: IconButton(
          icon: Icon(CupertinoIcons.line_horizontal_3_decrease),
          onPressed: () => ZoomDrawer.of(context)!.toggle(),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        // onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
                              key: resetPasswordForm,
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
                                      'Reset Your Password',
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
                                      child: oldPasswordField(context),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Container(
                                      child: newPasswordField(context),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Container(
                                      child: confirmPasswordField(context),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.02,
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
                                        onPressed: isReset == true
                                            ? null
                                            : () {
                                                if (!resetPasswordForm
                                                    .currentState!
                                                    .validate()) {
                                                  return;
                                                }
                                                resetPasswordForm.currentState!
                                                    .save();
                                                setState(() {
                                                  isReset = true;
                                                });
                                                Provider.of<LoginProvider>(
                                                        context,
                                                        listen: false)
                                                    .resetPassword(
                                                        user.formId,
                                                        oldPassword.text,
                                                        newPassword.text)
                                                    .then((value) {
                                                  setState(() {
                                                    isReset = false;
                                                  });
                                                  if (value.statusCode == 200) {
                                                    if (Provider.of<LoginProvider>(
                                                                    context,
                                                                    listen: false)
                                                                .resetResponse[
                                                            'success'] ==
                                                        1) {
                                                      Provider.of<LoginProvider>(
                                                              context,
                                                              listen: false)
                                                          .logout()
                                                          .then((value) {
                                                        Navigator.of(context)
                                                            .pushReplacementNamed(
                                                                '/login');
                                                        successDialog(Provider.of<
                                                                        LoginProvider>(
                                                                    context,
                                                                    listen: false)
                                                                .resetResponse[
                                                            'message']);
                                                      });
                                                    } else {
                                                      errorDialog(Provider.of<
                                                                      LoginProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .resetResponse[
                                                          'message']);
                                                    }
                                                  } else {
                                                    setState(() {
                                                      isReset = false;
                                                    });
                                                    errorDialog(
                                                        'Something went Wrong');
                                                    throw Exception(
                                                        'Failed to Connect');
                                                  }
                                                });
                                              },
                                        child: isReset == false
                                            ? Text(
                                                'Reset ',
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

  TextFormField oldPasswordField(context) {
    return TextFormField(
      focusNode: oldPasswordFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(newPasswordFocusNode),
      onSaved: (String? value) {
        value = oldPassword.text;
      },
      controller: oldPassword,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.length < 7) return 'Enter Minimum 7 Letters Password';
      },
      obscureText: oldPasswordObscureText,
      style: Theme.of(context).textTheme.headline3,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Theme.of(context).primaryColor,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            oldPasswordObscureText = !oldPasswordObscureText;
          },
          child: Icon(
            oldPasswordObscureText ? Icons.visibility_off : Icons.visibility,
            semanticLabel:
                oldPasswordObscureText ? 'Show Password' : 'Hide Password',
          ),
        ),
        hintText: 'Enter Old Password *',
        labelText: 'Enter Old Password *',
      ),
    );
  }

  TextFormField newPasswordField(context) {
    return TextFormField(
      focusNode: newPasswordFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(confirmPasswordFocusNode),
      onSaved: (String? value) {
        value = newPassword.text;
      },
      controller: newPassword,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.length < 7) return 'Enter Minimum 7 Letters Password';
      },
      obscureText: newPasswordObscureText,
      style: Theme.of(context).textTheme.headline3,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Theme.of(context).primaryColor,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            newPasswordObscureText = !newPasswordObscureText;
          },
          child: Icon(
            newPasswordObscureText ? Icons.visibility_off : Icons.visibility,
            semanticLabel:
                newPasswordObscureText ? 'Show Password' : 'Hide Password',
          ),
        ),
        hintText: 'Enter New Password *',
        labelText: 'Enter New Password *',
      ),
    );
  }

  TextFormField confirmPasswordField(context) {
    return TextFormField(
      focusNode: confirmPasswordFocusNode,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
      onSaved: (String? value) {
        value = confirmPassword.text;
      },
      controller: confirmPassword,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.length < 7) return 'Enter Minimum 7 Letters Password';
        if (value != newPassword.text) return "Password doesn't match";
      },
      obscureText: confirmPasswordObscureText,
      style: Theme.of(context).textTheme.headline3,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Theme.of(context).primaryColor,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            confirmPasswordObscureText = !confirmPasswordObscureText;
          },
          child: Icon(
            confirmPasswordObscureText
                ? Icons.visibility_off
                : Icons.visibility,
            semanticLabel:
                confirmPasswordObscureText ? 'Show Password' : 'Hide Password',
          ),
        ),
        hintText: 'Confirm Password *',
        labelText: 'Confirm Password *',
      ),
    );
  }
}
