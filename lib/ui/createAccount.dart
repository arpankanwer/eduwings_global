import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../provider/appProvider.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final createAccountForm = GlobalKey<FormState>();
  late FixedExtentScrollController qualificationController;
  late FixedExtentScrollController purposeController;
  late FixedExtentScrollController genderController;
  int qualificationIndex = 0;
  int purposeIndex = 0;
  int genderIndex = 0;
  bool isRegister = false;

  List qualificationList = [];
  List purposeList = [];
  List genderList = [];

  final TextEditingController reference = TextEditingController();
  final TextEditingController fName = TextEditingController();
  final TextEditingController lName = TextEditingController();
  final TextEditingController mobNo = TextEditingController();
  final TextEditingController whatsappMobNo = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController qualification = TextEditingController();
  final TextEditingController ielts = TextEditingController();
  final TextEditingController purpose = TextEditingController();

  FocusNode referenceFocusNode = FocusNode();
  FocusNode fNameFocusNode = FocusNode();
  FocusNode lNameFocusNode = FocusNode();
  FocusNode mobNoFocusNode = FocusNode();
  FocusNode whatsappMobNoFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode genderFocusNode = FocusNode();
  FocusNode qualificationFocusNode = FocusNode();
  FocusNode ieltsFocusNode = FocusNode();
  FocusNode purposeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    qualificationList =
        Provider.of<AppProvider>(context, listen: false).qualificationList;
    purposeList =
        Provider.of<AppProvider>(context, listen: false).purposeList;
    genderList = Provider.of<AppProvider>(context, listen: false).genderList;

    qualificationController =
        FixedExtentScrollController(initialItem: qualificationIndex);
    purposeController = FixedExtentScrollController(initialItem: purposeIndex);
    genderController = FixedExtentScrollController(initialItem: genderIndex);
  }

  @override
  void dispose() {
    super.dispose();
    reference.dispose();
    fNameFocusNode.dispose();
    lNameFocusNode.dispose();
    mobNoFocusNode.dispose();
    whatsappMobNoFocusNode.dispose();
    emailFocusNode.dispose();
    genderFocusNode.dispose();
    qualificationFocusNode.dispose();
    ieltsFocusNode.dispose();
    qualificationController.dispose();
    purposeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(
          'Registration Form',
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
                              key: createAccountForm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mediaQuery.width * 0.04),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: mediaQuery.height * 0.02,
                                    ),
                                    ShaderMask(
                                      shaderCallback: (bounds) {
                                        return LinearGradient(colors: [
                                          Color.fromRGBO(97, 6, 165, 1.0),
                                          Color.fromRGBO(45, 160, 240, 1.0)
                                        ]).createShader(
                                            Offset.zero & bounds.size);
                                      },
                                      child: Text('Registration Form',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Exo2',
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Have you registed already? ",
                                          style: platformThemeData(context,
                                              material: (data) =>
                                                  data.textTheme.headline3,
                                              cupertino: (data) => data
                                                  .textTheme.actionTextStyle),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushReplacementNamed('/login');
                                          },
                                          child: Text(
                                            "Login Here",
                                            style: platformThemeData(context,
                                                material: (data) => data
                                                    .textTheme.headline3
                                                    ?.copyWith(
                                                        color:
                                                            Colors.deepOrange),
                                                cupertino: (data) => data
                                                    .textTheme.actionTextStyle
                                                    .copyWith(
                                                        color:
                                                            Colors.deepOrange)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.03,
                                    ),
                                    Container(
                                      child: fNameField(context, mediaQuery),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Container(
                                      child: lNameField(context, mediaQuery),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Container(
                                      child: mobNoField(context, mediaQuery),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Container(
                                      child: whatsappMobNoField(
                                          context, mediaQuery),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Container(
                                      child: emailField(context, mediaQuery),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Container(
                                      child: GestureDetector(
                                        onTap: () {
                                          genderController.dispose();
                                          genderController =
                                              FixedExtentScrollController(
                                                  initialItem: genderIndex);
                                          showCupertinoModalPopup(
                                              context: context,
                                              builder: (context) =>
                                                  CupertinoActionSheet(
                                                      actions: [
                                                        genderSheet(mediaQuery,
                                                            genderController)
                                                      ],
                                                      cancelButton:
                                                          CupertinoActionSheetAction(
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(),
                                                              child: Text(
                                                                  'Cancel'))));
                                        },
                                        child: AbsorbPointer(
                                          child:
                                              genderField(context, mediaQuery),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Container(
                                      child: GestureDetector(
                                        onTap: () {
                                          qualificationController.dispose();
                                          qualificationController =
                                              FixedExtentScrollController(
                                                  initialItem:
                                                      qualificationIndex);
                                          showCupertinoModalPopup(
                                              context: context,
                                              builder: (context) =>
                                                  CupertinoActionSheet(
                                                      actions: [
                                                        qualificationSheet(
                                                            mediaQuery,
                                                            qualificationController)
                                                      ],
                                                      cancelButton:
                                                          CupertinoActionSheetAction(
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(),
                                                              child: Text(
                                                                  'Cancel'))));
                                        },
                                        child: AbsorbPointer(
                                          child: qualificationField(
                                              context, mediaQuery),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Container(
                                      child: ieltsField(context, mediaQuery),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.01,
                                    ),
                                    Container(
                                      child: GestureDetector(
                                        onTap: () {
                                          purposeController.dispose();
                                          purposeController =
                                              FixedExtentScrollController(
                                                  initialItem: purposeIndex);

                                          showCupertinoModalPopup(
                                              context: context,
                                              builder: (context) =>
                                                  CupertinoActionSheet(
                                                      actions: [
                                                        purposeSheet(mediaQuery,
                                                            purposeController)
                                                      ],
                                                      cancelButton:
                                                          CupertinoActionSheetAction(
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(),
                                                              child: Text(
                                                                  'Cancel'))));
                                        },
                                        child: AbsorbPointer(
                                          child:
                                              purposeField(context, mediaQuery),
                                        ),
                                      ),
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
                                      onPressed: isRegister == true
                                          ? null
                                          : () {
                                              if (!createAccountForm
                                                  .currentState!
                                                  .validate()) {
                                                return;
                                              }
                                              createAccountForm.currentState!
                                                  .save();
                                              setState(() {
                                                isRegister = true;
                                              });
                                              Provider.of<AppProvider>(
                                                      context,
                                                      listen: false)
                                                  .referFriend(
                                                      fName.text,
                                                      lName.text,
                                                      mobNo.text,
                                                      whatsappMobNo.text,
                                                      email.text,
                                                      gender.text,
                                                      qualification.text,
                                                      ielts.text,
                                                      purpose.text,
                                                      '0')
                                                  .then((value) {
                                                setState(() {
                                                  isRegister = false;
                                                });
                                                if (value.statusCode == 200) {
                                                  if (Provider.of<AppProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .referResponse[
                                                          'success'] ==
                                                      1) {
                                                    createAccountForm
                                                        .currentState
                                                        ?.reset();
                                                    Navigator.of(context)
                                                        .pushReplacementNamed(
                                                            '/login');

                                                    Provider.of<AppProvider>(
                                                            context,
                                                            listen: false)
                                                        .successDialog(
                                                            context,
                                                            Provider.of<AppProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .referResponse[
                                                                'message'],
                                                            mediaQuery);
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
                                                                    .referResponse[
                                                                'message'],
                                                            mediaQuery);
                                                  }
                                                } else {
                                                  setState(() {
                                                    isRegister = false;
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
                                      child: isRegister == false
                                          ? Text(
                                              'Register',
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

  PlatformTextFormField fNameField(context, mediaQuery) {
    return PlatformTextFormField(
      focusNode: fNameFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(lNameFocusNode),
      onSaved: (String? value) {
        value = fName.text;
      },
      onChanged: (String? value) {
        value = fName.text;
      },
      controller: fName,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value?.isEmpty == true || value == null) {
          return "Full Name can't be Empty";
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
        placeholder: 'Enter Full Name *',
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
            CupertinoIcons.f_cursive_circle_fill,
            color: Theme.of(context).primaryColor,
          ),
          hintText: 'Enter Full Name *',
          labelText: 'Enter Full Name *',
        ),
      ),
    );
  }

  PlatformTextFormField lNameField(context, mediaQuery) {
    return PlatformTextFormField(
      focusNode: lNameFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(mobNoFocusNode),
      onSaved: (String? value) {
        value = lName.text;
      },
      onChanged: (String? value) {
        value = lName.text;
      },
      controller: lName,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value?.isEmpty == true || value == null) {
          return "Last Name can't be Empty";
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
        placeholder: 'Enter Last Name *',
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
            CupertinoIcons.f_cursive_circle_fill,
            color: Theme.of(context).primaryColor,
          ),
          hintText: 'Enter Last Name *',
          labelText: 'Enter Last Name *',
        ),
      ),
    );
  }

  PlatformTextFormField mobNoField(context, mediaQuery) {
    return PlatformTextFormField(
      focusNode: mobNoFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(whatsappMobNoFocusNode),
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

  PlatformTextFormField whatsappMobNoField(context, mediaQuery) {
    return PlatformTextFormField(
      focusNode: whatsappMobNoFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(emailFocusNode),
      onSaved: (String? value) {
        value = whatsappMobNo.text;
      },
      onChanged: (String? value) {
        value = whatsappMobNo.text;
      },
      controller: whatsappMobNo,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value?.isEmpty == true || value == null) {
          return "Whatsapp Mobile No. can't be Empty";
        } else if (value.length < 10) {
          return 'Invalid Whatsapp Mobile Number';
        } else if (value.length > 10) {
          return "Invalid Whatsapp Mobile Number";
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
        placeholder: 'Enter Whatsapp Mobile No. *',
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
          hintText: 'Enter Whatsapp Mobile No. *',
          labelText: 'Enter Whatsapp Mobile No. *',
        ),
      ),
    );
  }

  PlatformTextFormField emailField(context, mediaQuery) {
    return PlatformTextFormField(
      focusNode: emailFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(ieltsFocusNode),
      onSaved: (String? value) {
        value = email.text;
      },
      onChanged: (String? value) {
        value = email.text;
      },
      controller: email,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value?.isEmpty == true || value == null) {
          return "Email can't be Empty";
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
        placeholder: 'Enter Email *',
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
            CupertinoIcons.f_cursive_circle_fill,
            color: Theme.of(context).primaryColor,
          ),
          hintText: 'Enter Email *',
          labelText: 'Enter Email *',
        ),
      ),
    );
  }

  PlatformTextFormField genderField(context, mediaQuery) {
    return PlatformTextFormField(
      focusNode: genderFocusNode,
      readOnly: true,
      onSaved: (String? value) {
        value = gender.text;
      },
      onChanged: (String? value) {
        value = gender.text;
      },
      controller: gender,
      validator: (value) {
        if (value?.isEmpty == true || value == null) {
          return "Gender can't be Empty";
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
        placeholder: 'Gender *',
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
          hintText: 'Gender *',
          labelText: 'Gender *',
        ),
      ),
    );
  }

  PlatformTextFormField qualificationField(context, mediaQuery) {
    return PlatformTextFormField(
      focusNode: qualificationFocusNode,
      readOnly: true,
      onSaved: (String? value) {
        value = qualification.text;
      },
      onChanged: (String? value) {
        value = qualification.text;
      },
      controller: qualification,
      validator: (value) {
        if (value?.isEmpty == true || value == null) {
          return "Qualification can't be Empty";
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
        placeholder: 'Qualification *',
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
          hintText: 'Qualification *',
          labelText: 'Qualification *',
        ),
      ),
    );
  }

  PlatformTextFormField ieltsField(context, mediaQuery) {
    return PlatformTextFormField(
      focusNode: ieltsFocusNode,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
      onSaved: (String? value) {
        value = ielts.text;
      },
      onChanged: (String? value) {
        value = ielts.text;
      },
      controller: ielts,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value?.isEmpty == true || value == null) {
          return "Score can't be Empty";
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
        placeholder: 'IELTS/PTE/CELPIP Score *',
        prefix: Row(
          children: [
            Icon(
              CupertinoIcons.sort_up_circle_fill,
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
            CupertinoIcons.sort_up_circle_fill,
            color: Theme.of(context).primaryColor,
          ),
          hintText: 'IELTS/PTE/CELPIP Score *',
          labelText: 'IELTS/PTE/CELPIP Score *',
        ),
      ),
    );
  }

  PlatformTextFormField purposeField(context, mediaQuery) {
    return PlatformTextFormField(
      focusNode: purposeFocusNode,
      readOnly: true,
      onSaved: (String? value) {
        value = purpose.text;
      },
      onChanged: (String? value) {
        value = purpose.text;
      },
      controller: purpose,
      validator: (value) {
        if (value?.isEmpty == true || value == null) {
          return "Purpose can't be Empty";
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
        placeholder: 'Purpose *',
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
          hintText: 'Purpose *',
          labelText: 'Purpose *',
        ),
      ),
    );
  }

  Widget qualificationSheet(mediaQuery, qualificationController) {
    return Container(
      height: mediaQuery.height * 0.25,
      child: StatefulBuilder(
        builder: (context, setState) => CupertinoPicker(
            scrollController: qualificationController,
            itemExtent: 50,
            selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
              background: CupertinoColors.activeBlue.withOpacity(0.2),
            ),
            onSelectedItemChanged: (index) {
              setState(() {
                qualificationIndex = index;
                qualification.text = qualificationList[index];
              });
            },
            children: List.generate(qualificationList.length, (index) {
              final isSelected = qualificationIndex == index;
              final item = qualificationList[index];
              final color = isSelected
                  ? CupertinoColors.activeBlue
                  : CupertinoColors.black;
              return Center(
                child: Text(
                  item,
                  style: TextStyle(color: color),
                ),
              );
            })),
      ),
    );
  }

  Widget purposeSheet(mediaQuery, purposeController) {
    return Container(
      height: mediaQuery.height * 0.25,
      child: StatefulBuilder(
        builder: (context, setState) => CupertinoPicker(
            scrollController: purposeController,
            itemExtent: 50,
            selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
              background: CupertinoColors.activeBlue.withOpacity(0.2),
            ),
            onSelectedItemChanged: (index) {
              setState(() {
                purposeIndex = index;
                purpose.text = purposeList[index];
              });
            },
            children: List.generate(purposeList.length, (index) {
              final isSelected = purposeIndex == index;
              final item = purposeList[index];
              final color = isSelected
                  ? CupertinoColors.activeBlue
                  : CupertinoColors.black;
              return Center(
                child: Text(
                  item,
                  style: TextStyle(color: color),
                ),
              );
            })),
      ),
    );
  }

  Widget genderSheet(mediaQuery, genderController) {
    return Container(
      height: mediaQuery.height * 0.25,
      child: StatefulBuilder(
        builder: (context, setState) => CupertinoPicker(
            scrollController: genderController,
            itemExtent: 50,
            selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
              background: CupertinoColors.activeBlue.withOpacity(0.2),
            ),
            onSelectedItemChanged: (index) {
              setState(() {
                genderIndex = index;
                gender.text = genderList[index];
              });
            },
            children: List.generate(genderList.length, (index) {
              final isSelected = genderIndex == index;
              final item = genderList[index];
              final color = isSelected
                  ? CupertinoColors.activeBlue
                  : CupertinoColors.black;
              return Center(
                child: Text(
                  item,
                  style: TextStyle(color: color),
                ),
              );
            })),
      ),
    );
  }
}
