import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foodordering/animations/bounce.dart';
import 'package:foodordering/common_widgets/primary_button.dart';
import 'package:foodordering/common_widgets/text_input.dart';
import 'package:foodordering/services/validation.dart';
import 'package:foodordering/utils/constants/route_names.dart';
import 'package:foodordering/utils/constants/string_names.dart';
import 'package:foodordering/utils/screen_ratio/screen_ratio.dart';
import 'package:foodordering/utils/themes/theme.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode textSecondFocusNode = new FocusNode();
  FocusNode textThirdFocusNode = new FocusNode();
  final TextEditingController _username = new TextEditingController();
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
    timeDilation = 1;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(
                    left: 12, top: ScreenRatio.heightRatio * 24),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.SPLASH);
                  },
                  child: Icon(Icons.arrow_back),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: ScreenRatio.heightRatio * 48),
                child: Column(
                  children: [
                    Text(
                      StringNames.SIGN_IN,
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
                      StringNames.GOOD_TO_SEE,
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
                margin: EdgeInsets.only(top: ScreenRatio.heightRatio * 80),
                child: Form(
                    key: formKey,
                    child: Column(children: [
                      InputField(
                          margin: true,
                          border: true,
                          node: textSecondFocusNode,
                          nextnode: textThirdFocusNode,
                          hint: 'Your Email',
                          protected: false,
                          type: TextInputType.emailAddress,
                          controller: _username,
                          validate: validations.validateEmail),
                      SizedBox(
                        height: ScreenRatio.heightRatio * 10,
                      ),
                      InputField(
                        margin: true,
                        border: true,
                        node: textThirdFocusNode,
                        icon: "password",
                        hint: 'Password',
                        protected: true,
                        controller: _password,
                        validate: validations.validatePassword,
                      ),
                    ])),
              ),
              SizedBox(
                height: ScreenRatio.heightRatio * 60,
              ),
              PrimaryButton(() => {_handleSignIn()}, StringNames.SIGN_IN,
                  Themes.primaryColor, ScreenRatio.widthRatio * 300),
              SizedBox(
                height: ScreenRatio.heightRatio * 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.SIGNUP);
                },
                child: Text(
                  StringNames.CREATE_ACCOUNT,
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
