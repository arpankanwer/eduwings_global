import 'package:eduwings_global/classes/user.dart';
import 'package:eduwings_global/provider/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final changePasswordForm = GlobalKey<FormState>();
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
      isLogged: '',
      otp: '');

  bool isChange = false;
  bool newPasswordObscureText = true;
  bool confirmPasswordObscureText = true;

  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

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

    newPasswordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return PlatformScaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: PlatformAppBar(
        title: Text(
          'Change Password',
        ),
        material: (_, __) => MaterialAppBarData(centerTitle: true),
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
                              key: changePasswordForm,
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
                                    ShaderMask(
                                      shaderCallback: (bounds) {
                                        return LinearGradient(colors: [
                                          Color.fromRGBO(97, 6, 165, 1.0),
                                          Color.fromRGBO(45, 160, 240, 1.0)
                                        ]).createShader(
                                            Offset.zero & bounds.size);
                                      },
                                      child: Text('Change Your Password',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Exo2',
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
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
                                      child:
                                          newPasswordField(context, mediaQuery),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Container(
                                      child: confirmPasswordField(
                                          context, mediaQuery),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.02,
                                    ),
                                    Container(
                                        child: CupertinoButton(
                                      disabledColor: Colors.white,
                                      color: platformThemeData(
                                        context,
                                        material: (data) => data.primaryColor,
                                        cupertino: (data) => data.primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      onPressed: isChange == true
                                          ? null
                                          : () {
                                              if (!changePasswordForm
                                                  .currentState!
                                                  .validate()) {
                                                return;
                                              }
                                              changePasswordForm.currentState!
                                                  .save();
                                              setState(() {
                                                isChange = true;
                                              });

                                              Provider.of<LoginProvider>(
                                                      context,
                                                      listen: false)
                                                  .changePassword(
                                                user.ein,
                                                newPassword.text,
                                              )
                                                  .then((value) {
                                                setState(() {
                                                  isChange = false;
                                                });
                                                if (value.statusCode == 200) {
                                                  if (Provider.of<LoginProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .changePasswordResponse[
                                                          'success'] ==
                                                      1) {
                                                    changePasswordForm
                                                        .currentState
                                                        ?.reset();

                                                    Navigator.of(context)
                                                        .pushReplacementNamed(
                                                            '/login');
                                                    Provider.of<LoginProvider>(
                                                            context,
                                                            listen: false)
                                                        .successDialog(
                                                            context,
                                                            Provider.of<LoginProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .changePasswordResponse[
                                                                'message'],
                                                            mediaQuery);
                                                  } else {
                                                    Provider.of<LoginProvider>(
                                                            context,
                                                            listen: false)
                                                        .errorDialog(
                                                            context,
                                                            Provider.of<LoginProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .changePasswordResponse[
                                                                'message'],
                                                            mediaQuery);
                                                  }
                                                } else {
                                                  setState(() {
                                                    isChange = false;
                                                  });
                                                  Provider.of<LoginProvider>(
                                                          context,
                                                          listen: false)
                                                      .errorDialog(
                                                          context,
                                                          'Something went Wrong',
                                                          mediaQuery);
                                                  throw Exception(
                                                      'Failed to Connect');
                                                }
                                              });
                                            },
                                      child: isChange == false
                                          ? Text(
                                              'Reset',
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
                                    )),
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

  PlatformTextFormField newPasswordField(context, mediaQuery) {
    return PlatformTextFormField(
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
        placeholder: 'Enter New Password *',
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
                newPasswordObscureText = !newPasswordObscureText;
              });
            },
            child: Icon(
              newPasswordObscureText
                  ? CupertinoIcons.eye_slash_fill
                  : CupertinoIcons.eye_fill,
              semanticLabel:
                  newPasswordObscureText ? 'Show Password' : 'Hide Password',
            ),
          ),
          hintText: 'Enter New Password *',
          labelText: 'Enter New Password *',
        ),
      ),
    );
  }

  PlatformTextFormField confirmPasswordField(context, mediaQuery) {
    return PlatformTextFormField(
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
        placeholder: 'Confirm Password *',
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
                confirmPasswordObscureText = !confirmPasswordObscureText;
              });
            },
            child: Icon(
              confirmPasswordObscureText
                  ? CupertinoIcons.eye_slash_fill
                  : CupertinoIcons.eye_fill,
              semanticLabel: confirmPasswordObscureText
                  ? 'Show Password'
                  : 'Hide Password',
            ),
          ),
          hintText: 'Confirm Password *',
          labelText: 'Confirm Password *',
        ),
      ),
    );
  }
}
