import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/core/constants/app_contstants.dart';
import 'package:flutter_qcabtaxi/core/utils/device_utils.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';
import 'package:flutter_qcabtaxi/ui/shared/ui_helpers.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/myavatar.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mybutton4.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mybuttonfull.dart';
import 'package:flutter_qcabtaxi/ui/widget/mytext.dart';

class ProfileView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<ProfileView> {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: H1(
                          text: "Profile",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: H3(
                          text: "Your account details",
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
                            hintText: "+84939170707",
                            hintStyle: TextStyle(color: Colors.white),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 16.0)),
                      ),
                      UIHelper.verticalSpaceMedium,
                      H2(
                        text: "Full name",
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: controller_phone,
                        style: TextStyle(fontSize: 32),
                        decoration: InputDecoration(
                            hintText: "Karen Hamilton",
                            hintStyle: TextStyle(color: Colors.white),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 16.0)),
                      ),
                      UIHelper.verticalSpaceMedium,
                      H2(
                        text: "Email address",
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: controller_email,
                        style: TextStyle(fontSize: 32, color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "karenhamilton@gmail.com",
                            hintStyle: TextStyle(color: Colors.white),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 16.0)),
                      ),
                      UIHelper.verticalSpaceLarge
                    ],
                  ),
                ),
                //Spacer(),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: myheight - 45,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MyAvatar(
                      imgurl: 'https://i.pravatar.cc/250?img=16',
                    ),
                    UIHelper.horizontalSpaceSmall,
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: PrimaryColor,
                            size: 36,
                          ),
                          onPressed: () =>
                              showModalBottomSheet_chonanh(context),
                        ),
                        UIHelper.verticalSpaceSmall,
                        H3(
                          text: "Change picture",
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MyButton4(
                caption: "UPDATE INFO",
                onPressed: () => Navigator.pop(context),
              )
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
