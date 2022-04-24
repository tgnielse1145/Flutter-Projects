import 'package:flutter/material.dart';
import 'package:foodordering/scoped_model/profile_scopedmodel.dart';
import 'package:foodordering/screens/profile/edit_profile.dart';
import 'package:foodordering/utils/assets/images.dart';
import 'package:foodordering/utils/constants/route_names.dart';
import 'package:foodordering/utils/constants/string_names.dart';
import 'package:foodordering/utils/screen_ratio/screen_ratio.dart';
import 'package:foodordering/utils/themes/theme.dart';
import 'package:scoped_model/scoped_model.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ScopedModel<ProfileScopedModel>(
      model: profileScopedModel,
      child: ScopedModelDescendant<ProfileScopedModel>(
          builder: (context, child, model) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                StringNames.PROFILE,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Themes.blackColor),
              ),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.white,
                  onPressed: () {
                    profileScopedModel.editProfile();
                  },
                  child: Text(
                    profileScopedModel.edit
                        ? StringNames.EDIT
                        : StringNames.DONE,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Themes.blackColor),
                  ),
                  shape:
                      CircleBorder(side: BorderSide(color: Colors.transparent)),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height),
                child: profileScopedModel.edit
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Hero(
                              tag: StringNames.PROFILE_PIC,
                              child: Container(
                                height: 120,
                                width: 120,
                                margin: EdgeInsets.only(
                                    top: ScreenRatio.heightRatio * 20,
                                    bottom: ScreenRatio.heightRatio * 20),
                                child: CircleAvatar(
                                    radius: ScreenRatio.screenWidth * 100,
                                    backgroundImage:
                                        AssetImage(Images.PROFILE_PIC)),
                              ),
                            ),
                          ),
                          Text(
                            StringNames.NAME,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Themes.blackColor),
                          ),
                          SizedBox(
                            height: ScreenRatio.heightRatio * 40,
                          ),
                          Divider(
                            endIndent: 30,
                            indent: 30,
                            color: Themes.greyColor,
                          ),
                          SizedBox(
                            height: ScreenRatio.heightRatio * 30,
                          ),
                          Text(
                            StringNames.EMAIL,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Themes.greenColor),
                          ),
                          SizedBox(
                            height: ScreenRatio.heightRatio * 5,
                          ),
                          Text(
                            StringNames.EMAIL_VALUE,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Themes.blackColor),
                          ),
                          SizedBox(
                            height: ScreenRatio.heightRatio * 30,
                          ),
                          Text(
                            StringNames.PHONE,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Themes.greenColor),
                          ),
                          SizedBox(
                            height: ScreenRatio.heightRatio * 5,
                          ),
                          Text(
                            StringNames.PHONE_NO,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Themes.blackColor),
                          ),
                          SizedBox(
                            height: ScreenRatio.heightRatio * 30,
                          ),
                          Divider(
                            endIndent: 30,
                            indent: 30,
                            color: Themes.greyColor,
                          ),
                          SizedBox(
                            height: ScreenRatio.heightRatio * 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  Routes.SPLASH,
                                  (Route<dynamic> route) => false);
                            },
                            child: Text(
                              StringNames.LOGOUT,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Themes.redColor),
                            ),
                          ),
                        ],
                      )
                    : EditProfile(),
              ),
            ));
      }),
    ));
  }
}
