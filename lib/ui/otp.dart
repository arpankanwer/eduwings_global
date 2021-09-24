import 'package:eduwings_global/classes/user.dart';
import 'package:eduwings_global/provider/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final otpForm = GlobalKey<FormState>();

  bool isOtp = false;

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

  final TextEditingController otp = TextEditingController();

  FocusNode otpFocusNode = FocusNode();

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
    otpFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(
          'OTP',
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
                              key: otpForm,
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
                                        return LinearGradient(colors: [
                                          Color.fromRGBO(97, 6, 165, 1.0),
                                          Color.fromRGBO(45, 160, 240, 1.0)
                                        ]).createShader(
                                            Offset.zero & bounds.size);
                                      },
                                      child: Text('Enter OTP',
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
                                        child: otpField(context, mediaQuery)),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
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
                                      onPressed: isOtp == true
                                          ? null
                                          : () {
                                              if (!otpForm.currentState!
                                                  .validate()) {
                                                return;
                                              }
                                              otpForm.currentState!.save();
                                              setState(() {
                                                isOtp = true;
                                              });

                                              Provider.of<LoginProvider>(
                                                      context,
                                                      listen: false)
                                                  .checkOtp(
                                                otp.text,
                                              )
                                                  .then((value) {
                                                setState(() {
                                                  isOtp = false;
                                                });
                                                print(value);
                                                if (value) {
                                                  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                          '/changePassword');
                                                } else {
                                                  Provider.of<LoginProvider>(
                                                          context,
                                                          listen: false)
                                                      .errorDialog(
                                                          context,
                                                          'Invalid OTP',
                                                          mediaQuery);
                                                }
                                                // }
                                              });
                                            },
                                      child: isOtp == false
                                          ? Text(
                                              'Submit',
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

  PlatformTextFormField otpField(context, mediaQuery) {
    return PlatformTextFormField(
      focusNode: otpFocusNode,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
      onSaved: (String? value) {
        value = otp.text;
      },
      onChanged: (String? value) {
        value = otp.text;
      },
      controller: otp,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value?.isEmpty == true || value == null) {
          return "OTP can't be Empty";
        } else if (value.length < 6) {
          return 'Invalid OTP';
        } else if (value.length > 6) {
          return "Invalid OTP";
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
        placeholder: 'Enter OTP *',
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
          hintText: 'Enter OTP *',
          labelText: 'Enter OTP *',
        ),
      ),
    );
  }
}
