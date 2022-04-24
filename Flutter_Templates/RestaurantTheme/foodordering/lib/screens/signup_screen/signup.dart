import 'package:flutter/material.dart';
import 'package:foodordering/common_widgets/primary_button.dart';
import 'package:foodordering/common_widgets/text_input.dart';
import 'package:foodordering/services/validation.dart';
import 'package:foodordering/utils/constants/route_names.dart';
import 'package:foodordering/utils/constants/string_names.dart';
import 'package:foodordering/utils/screen_ratio/screen_ratio.dart';
import 'package:foodordering/utils/themes/theme.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FocusNode textSecondFocusNode = new FocusNode();
  FocusNode textThirdFocusNode = new FocusNode();
  FocusNode textFourthFocusNode = new FocusNode();
  FocusNode textFifthFocusNode = new FocusNode();
  final TextEditingController _username = new TextEditingController();
  final TextEditingController _mobile = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool autoValidate = false;
  Validations validations = new Validations();
  void _handleSignIn() {
    final FormState form = formKey.currentState;
    setState(() {
      autoValidate = true;
    });
    if (!form.validate()) {
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      Navigator.pushReplacementNamed(context, Routes.BOTTOMTAB);
    }
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      duration: new Duration(milliseconds: 700),
      backgroundColor: new Color.fromRGBO(107, 85, 153, 1.0),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(
                    left: 12, top: ScreenRatio.heightRatio * 18),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.SPLASH);
                  },
                  child: Icon(Icons.arrow_back),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: ScreenRatio.heightRatio * 10),
                child: Column(
                  children: [
                    Text(
                      StringNames.SIGN_UP,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          letterSpacing: 4),
                    ),
                    SizedBox(
                      height: ScreenRatio.heightRatio * 4,
                    ),
                    Text(
                      StringNames.NICE_TO_MEET_YOU,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          letterSpacing: .2),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: ScreenRatio.heightRatio * 20, left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: PrimaryButton(() => {}, StringNames.FACEBOOK,
                          Themes.primaryColor, ScreenRatio.widthRatio * 136),
                    ),
                    SizedBox(
                      width: ScreenRatio.widthRatio * 12,
                    ),
                    Expanded(
                      child: PrimaryButton(() => {}, StringNames.GOOGLE,
                          Colors.red, ScreenRatio.widthRatio * 136),
                    ),
                    SizedBox(
                      width: ScreenRatio.widthRatio * 12,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenRatio.heightRatio * 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Divider(
                      color: Colors.black,
                      height: 10,
                      thickness: .5,
                      indent: 30,
                      endIndent: 30,
                    ),
                  ),
                  Expanded(
                    // flex: 1,
                    child: Text(
                      StringNames.USE_EMAIL,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Divider(
                      color: Colors.black,
                      height: 10,
                      thickness: .5,
                      indent: 25,
                      endIndent: 30,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: ScreenRatio.heightRatio * 18),
                child: Form(
                    key: formKey,
                    child: Column(children: [
                      InputField(
                          margin: true,
                          border: true,
                          node: textSecondFocusNode,
                          nextnode: textThirdFocusNode,
                          hint: 'Your Name',
                          protected: false,
                          type: TextInputType.emailAddress,
                          controller: _username,
                          validate: validations.validateName),
                      SizedBox(
                        height: ScreenRatio.heightRatio * 10,
                      ),
                      InputField(
                          margin: true,
                          border: true,
                          node: textThirdFocusNode,
                          nextnode: textFourthFocusNode,
                          hint: 'Mobile Number',
                          protected: false,
                          type: TextInputType.number,
                          controller: _mobile,
                          validate: validations.validateMobile),
                      SizedBox(
                        height: ScreenRatio.heightRatio * 10,
                      ),
                      InputField(
                          margin: true,
                          border: true,
                          node: textFourthFocusNode,
                          nextnode: textFifthFocusNode,
                          hint: 'Email',
                          protected: false,
                          type: TextInputType.emailAddress,
                          controller: _email,
                          validate: validations.validateEmail),
                      SizedBox(
                        height: ScreenRatio.heightRatio * 10,
                      ),
                      InputField(
                        margin: true,
                        border: true,
                        node: textFifthFocusNode,
                        icon: "password",
                        hint: 'Password',
                        protected: true,
                        controller: _password,
                        validate: validations.validatePassword,
                      ),
                    ])),
              ),
              SizedBox(
                height: ScreenRatio.heightRatio * 20,
              ),
              PrimaryButton(() => {_handleSignIn()}, StringNames.SIGN_UP_LINK,
                  Themes.primaryColor, ScreenRatio.widthRatio * 322),
              SizedBox(
                height: ScreenRatio.heightRatio * 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.LOGIN);
                },
                child: Text(
                  StringNames.SIGN_IN,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,
                      letterSpacing: .2),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
