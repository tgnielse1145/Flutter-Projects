import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/core/constants/app_contstants.dart';
import 'package:flutter_qcabtaxi/core/utils/device_utils.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';
import 'package:flutter_qcabtaxi/ui/shared/ui_helpers.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mybutton4.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mybuttonfull.dart';
import 'package:flutter_qcabtaxi/ui/widget/mytext.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController controller_phone = new TextEditingController();
  final TextEditingController controller_name = new TextEditingController();
  final TextEditingController controller_email = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var myheight = DeviceUtils.getScaledHeight(context, 1 / 4);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: PrimaryColor,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: H1(
                              text: "Sign up now",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: H3(
                              text: "Enter request information",
                            ),
                          ),
                        ],
                      ),
                      height: myheight,
                    ),
                    Container(
                      padding: EdgeInsets.all(24),
                      color: SecondaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          UIHelper.verticalSpaceMedium,
                          H2(
                            text: "Phone number",
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: controller_phone,
                            style: TextStyle(fontSize: 32, color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Phone number",
                                //hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0)),
                          ),
                          UIHelper.verticalSpaceMedium,
                          H2(
                            text: "Full name",
                          ),
                          TextField(
                            controller: controller_name,
                            style: TextStyle(fontSize: 32, color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Full name",
                                //hintStyle: TextStyle(color: Colors),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0)),
                          ),
                          UIHelper.verticalSpaceMedium,
                          H2(
                            text: "Email address",
                          ),
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: controller_email,
                            style: TextStyle(fontSize: 32, color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Email address",
                                //hintStyle: TextStyle(color: Colors.white),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0)),
                          ),
                          UIHelper.verticalSpaceLarge
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: myheight - 45,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Dark,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: IconButton(
                            onPressed: () =>
                                showModalBottomSheet_chonanh(context),
                            icon: Icon(
                              Icons.camera_alt,
                              size: 32,
                              color: PrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MyButton4(
                  caption: "SIGN UP",
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, RoutePaths.Home);
                  }),
            ],
          )
        ],
      ),
    );
  }

  void showModalBottomSheet_chonanh(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: SecondaryColor,
            child: new Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Color(0xFF141414),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlatButton.icon(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                  Icons.folder,
                                  color: PrimaryColor,
                                ),
                                label: Text(
                                  "FOLDER",
                                  style: normalStylePrimary,
                                )),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: PrimaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlatButton.icon(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                ),
                                label: Text(
                                  "CAMERA",
                                  style:
                                      normalStyle.copyWith(color: Colors.black),
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
