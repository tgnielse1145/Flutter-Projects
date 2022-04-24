import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/core/constants/app_contstants.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';
import 'package:flutter_qcabtaxi/ui/shared/ui_helpers.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mybutton.dart';
import 'package:flutter_qcabtaxi/ui/widget/mytext.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController controller_phone = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UIHelper.verticalSpaceMedium,
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: H1(
              text: "Enter your \nregistered \nphone number",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: H3(
              text: "Sign in with your phone number",
            ),
          ),
          UIHelper.verticalSpaceMedium,
          Expanded(
            child: Container(
              padding: EdgeInsets.all(24),
              color: SecondaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UIHelper.verticalSpaceMedium,
                  H2(
                    text: "Enter your phone number",
                  ),
                  TextField(
                    keyboardType:  TextInputType.number,
                    controller: controller_phone,
                    style: TextStyle(fontSize: 32, color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Enter your phone number",
                        //hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 16.0)),
                  ),

                ],
              ),
            ),
          ),
          //Spacer(),
          Row(
            children: <Widget>[
              Expanded(
                child: MyButton(
                  caption: "NEW USER ?",
                  main: false,
                  onPressed: () {
                    Navigator.pushNamed(context, RoutePaths.Signup);
                  },
                ),
              ),
              Expanded(
                child: MyButton(
                  caption: "SIGN IN",
                  main: true,
                  onPressed: () {
                    Navigator.pushNamed(context, RoutePaths.Verify);
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
