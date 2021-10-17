import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';

import '../provider/appProvider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final forgotPasswordForm = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  bool isForgot = false;

  final TextEditingController ein = TextEditingController();
  final TextEditingController mobNo = TextEditingController();
  final TextEditingController dob = TextEditingController();

  FocusNode einFocusNode = FocusNode();
  FocusNode mobNoFocusNode = FocusNode();
  FocusNode dobFocusNode = FocusNode();

  Future _selectDate(BuildContext context, mediaQuery) async {
    return await showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                ),
                color: Colors.grey[300],
              ),
              height: mediaQuery.height * 0.4,
              // color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoButton(
                        // color: Theme.of(context).primaryColor,
                        child: Text('Done'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Divider(
                    height: 0,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: mediaQuery.height * 0.3,
                    child: CupertinoDatePicker(
                      maximumDate: DateTime.now().add(Duration(seconds: 1)),
                      minimumYear: DateTime.now().year - 40,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (DateTime dateTime) {
                        selectedDate = dateTime;
                        dob.value = TextEditingValue(
                          text: DateFormat('dd/MM/yyyy')
                              .format(DateTime.parse(
                                  "${dateTime.toLocal()}".split(' ')[0]))
                              .toString(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(
          'Forgot Password',
        ),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
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
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Form(
                              key: forgotPasswordForm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mediaQuery.width * 0.04),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: mediaQuery.height * 0.03,
                                    ),
                                    ShaderMask(
                                      shaderCallback: (bounds) {
                                        return LinearGradient(colors: const [
                                          Color.fromRGBO(97, 6, 165, 1.0),
                                          Color.fromRGBO(45, 160, 240, 1.0)
                                        ]).createShader(
                                            Offset.zero & bounds.size);
                                      },
                                      child: Text('Forgot Password',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Exo2',
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.02,
                                    ),
                                    CircleAvatar(
                                      maxRadius: 42,
                                      child: Image.asset(
                                          "assets/icons/imgforgot.png"),
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.03,
                                    ),
                                    Container(
                                        child: einField(context, mediaQuery)),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Container(
                                        child: mobNoField(context, mediaQuery)),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          _selectDate(context, mediaQuery),
                                      child: AbsorbPointer(
                                        child: dobField(context, mediaQuery),
                                      ),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.02,
                                    ),
                                    CupertinoButton(
                                      disabledColor: Colors.white,
                                      color: platformThemeData(
                                        context,
                                        material: (data) => data.primaryColor,
                                        cupertino: (data) => data.primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      onPressed: isForgot == true
                                          ? null
                                          : () {
                                              if (!forgotPasswordForm
                                                  .currentState!
                                                  .validate()) {
                                                return;
                                              }
                                              forgotPasswordForm.currentState!
                                                  .save();
                                              setState(() {
                                                isForgot = true;
                                              });

                                              Provider.of<AppProvider>(context,
                                                      listen: false)
                                                  .forgotPassword(
                                                ein.text,
                                                mobNo.text,
                                                dob.text,
                                              )
                                                  .then((value) {
                                                setState(() {
                                                  isForgot = false;
                                                });
                                                if (value.statusCode == 200) {
                                                  if (Provider.of<AppProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .forgotResponse[
                                                          'success'] ==
                                                      1) {
                                                    forgotPasswordForm
                                                        .currentState
                                                        ?.reset();
                                                    Provider.of<AppProvider>(
                                                            context,
                                                            listen: false)
                                                        .saveOtp(int.parse(Provider
                                                                    .of<AppProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                .forgotResponse[
                                                            'message']));
                                                    Navigator.of(context)
                                                        .pushNamedAndRemoveUntil(
                                                            '/otp',
                                                            (Route<dynamic>
                                                                    route) =>
                                                                false);
                                                  } else {
                                                    Provider.of<AppProvider>(
                                                            context,
                                                            listen: false)
                                                        .errorDialog(
                                                            context,
                                                            Provider.of<AppProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .forgotResponse[
                                                                'message'],
                                                            mediaQuery);
                                                  }
                                                } else {
                                                  setState(() {
                                                    isForgot = false;
                                                  });
                                                  Provider.of<AppProvider>(
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
                                      child: isForgot == false
                                          ? Text(
                                              'Forgot',
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
                                    SizedBox(
                                      height: mediaQuery.height * 0.02,
                                    ),
                                  ],
                                ),
                              ),
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
      ),
    );
  }

  PlatformTextFormField einField(context, mediaQuery) {
    return PlatformTextFormField(
      focusNode: einFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(mobNoFocusNode),
      onSaved: (String? value) {
        value = ein.text;
      },
      onChanged: (String? value) {
        value = ein.text;
      },
      controller: ein,
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
              // size: 40,
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

  PlatformTextFormField mobNoField(context, mediaQuery) {
    return PlatformTextFormField(
      focusNode: mobNoFocusNode,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
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
        } else if (value.length < 10) {
          return 'Invalid Mobile Number';
        } else if (value.length > 10) {
          return "Invalid Mobile Number";
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
        placeholder: 'Enter Mobile No. *',
        prefix: Row(
          children: [
            Icon(
              CupertinoIcons.phone_fill,
              color: CupertinoTheme.of(context).primaryColor,
              // size: 40,
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
            CupertinoIcons.phone_fill,
            color: Theme.of(context).primaryColor,
          ),
          hintText: 'Enter Mobile No. *',
          labelText: 'Enter Mobile No. *',
        ),
      ),
    );
  }

  PlatformTextFormField dobField(context, mediaQuery) {
    return PlatformTextFormField(
      focusNode: dobFocusNode,
      readOnly: true,
      onSaved: (String? value) {
        value = dob.text;
      },
      onChanged: (String? value) {
        value = dob.text;
      },
      controller: dob,
      validator: (value) {
        if (value?.isEmpty == true || value == null) {
          return "Dob can't be Empty";
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
        placeholder: 'Date of Birth *',
        prefix: Row(
          children: [
            Icon(
              CupertinoIcons.f_cursive_circle_fill,
              color: CupertinoTheme.of(context).primaryColor,
              // size: 40,
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
            CupertinoIcons.star_fill,
            // color: Colors.red,
          ),
          hintText: 'Date of Birth *',
          labelText: 'Date of Birth *',
        ),
      ),
    );
  }
}
