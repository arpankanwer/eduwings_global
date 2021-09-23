import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../classes/user.dart';

import '../provider/login.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final createAccountForm = GlobalKey<FormState>();
  late FixedExtentScrollController qualificationController;
  late FixedExtentScrollController purposeController;
  int qualificationIndex = 0;
  int purposeIndex = 0;
  bool isRegister = false;

  final qualificationList = [
    '12th',
    'Diploma',
    'Graduate',
    'Post Graduate',
    'Others',
  ];
  final purposeList = [
    'Study Visa',
    'PR',
    'Tourist Visa',
    'Business Visa',
    'Others',
  ];

  final TextEditingController fullName = TextEditingController();
  final TextEditingController mobNo = TextEditingController();
  final TextEditingController qualification = TextEditingController();
  final TextEditingController ielts = TextEditingController();
  final TextEditingController purpose = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode mobNoFocusNode = FocusNode();
  FocusNode qualificationFocusNode = FocusNode();
  FocusNode ieltsFocusNode = FocusNode();
  FocusNode purposeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    qualificationController =
        FixedExtentScrollController(initialItem: qualificationIndex);
    purposeController = FixedExtentScrollController(initialItem: purposeIndex);
  }

  @override
  void dispose() {
    super.dispose();
    qualificationController.dispose();
    purposeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return PlatformScaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      appBar: PlatformAppBar(
        title: Text(
          'Registration Form',
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
                          Form(
                            key: createAccountForm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: mediaQuery.width * 0.04),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: mediaQuery.height * 0.03,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Have you registed already? "),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushReplacementNamed('/login');
                                        },
                                        child: Text(
                                          "Login Here",
                                          style: TextStyle(
                                              color: Colors.deepOrange),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: mediaQuery.height * 0.03,
                                  ),
                                  Container(
                                    child: fullNameField(context, mediaQuery),
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
                                            if (!createAccountForm.currentState!
                                                .validate()) {
                                              return;
                                            }
                                            createAccountForm.currentState!
                                                .save();
                                            setState(() {
                                              isRegister = true;
                                            });
                                            // Provider.of<LoginProvider>(context,
                                            //         listen: false)
                                            //     .login(mobNo.text, password.text)
                                            //     .then(
                                            //   (response) {
                                            //     setState(() {
                                            //       isRegister = false;
                                            //     });
                                            //     if (response.statusCode == 200) {
                                            //       var userData =
                                            //           json.decode(response.body);
                                            //       if (userData.length == 0) {
                                            //         // ScaffoldMessenger.of(
                                            //         //         context)
                                            //         //     .showSnackBar(
                                            //         //   SnackBar(
                                            //         //     content: Text(
                                            //         //         'Invalid Mobile No. or Password'),
                                            //         //     backgroundColor:
                                            //         //         Colors.red,
                                            //         //   ),
                                            //         // );
                                            //         showDialog(
                                            //           useSafeArea: true,
                                            //           barrierDismissible: false,
                                            //           context: context,
                                            //           builder: (BuildContext
                                            //                   context) =>
                                            //               CupertinoAlertDialog(
                                            //             title: Text(
                                            //                 "Wrong Credentials"),
                                            //             content: Text(
                                            //                 "Invalid EIN or Password"),
                                            //             actions: [
                                            //               CupertinoDialogAction(
                                            //                 onPressed: () =>
                                            //                     Navigator.of(
                                            //                             context)
                                            //                         .pop(),
                                            //                 child: Text(
                                            //                   "Close",
                                            //                   style: TextStyle(
                                            //                       color:
                                            //                           Colors.red),
                                            //                 ),
                                            //               ),
                                            //             ],
                                            //           ),
                                            //         );
                                            //       } else {
                                            //         Provider.of<LoginProvider>(
                                            //                 context,
                                            //                 listen: false)
                                            //             .setSharedData(
                                            //                 userData[0])
                                            //             .then((value) => Navigator
                                            //                     .of(context)
                                            //                 .pushReplacementNamed(
                                            //                     '/homePage'));
                                            //       }
                                            //     } else {
                                            //       throw Exception(
                                            //           'Failed to Connect');
                                            //     }
                                            // },
                                            // );
                                          },
                                    child: isRegister == false
                                        ? Text(
                                            'Register',
                                            style: platformThemeData(
                                              context,
                                              material: (data) =>
                                                  data.textTheme.headline4,
                                              cupertino: (data) => data
                                                  .textTheme.navTitleTextStyle,
                                            ),
                                          )
                                        : Center(
                                            child: CupertinoActivityIndicator(),
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
    );
  }

  PlatformTextFormField fullNameField(context, mediaQuery) {
    return PlatformTextFormField(
      focusNode: fullNameFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(mobNoFocusNode),
      onSaved: (String? value) {
        value = fullName.text;
      },
      onChanged: (String? value) {
        value = fullName.text;
      },
      controller: fullName,
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

  PlatformTextFormField mobNoField(context, mediaQuery) {
    return PlatformTextFormField(
      focusNode: mobNoFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(ieltsFocusNode),
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
}
