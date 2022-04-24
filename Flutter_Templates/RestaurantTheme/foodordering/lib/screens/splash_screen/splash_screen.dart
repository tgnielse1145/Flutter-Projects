import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodordering/animations/bounce.dart';
import 'package:foodordering/common_widgets/primary_button.dart';
import 'package:foodordering/utils/assets/images.dart';
import 'package:foodordering/utils/constants/route_names.dart';
import 'package:foodordering/utils/constants/string_names.dart';
import 'package:foodordering/utils/screen_ratio/screen_ratio.dart';
import 'package:foodordering/utils/themes/theme.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenRatio.setScreenRatio(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image(
              image: AssetImage(Images.BACKGROUND),
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Bounce(Image.asset(Images.LOGO), 10.0),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            StringNames.APP_NAME,
                            style: TextStyle(
                                letterSpacing: 2,
                                fontWeight: FontWeight.w800,
                                fontSize: 30,
                                color: Colors.white),
                          )),
                      Text(
                        StringNames.APP_NAME_SUBTEXT,
                        style: TextStyle(
                            letterSpacing: .2,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: Colors.white),
                      )
                    ],
                  )),
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PrimaryButton(
                          () => {
                                Navigator.pushReplacementNamed(
                                    context, Routes.LOGIN)
                              },
                          StringNames.SIGN_IN,
                          Themes.primaryColor,
                          ScreenRatio.widthRatio * 300),
                      SizedBox(height: ScreenRatio.heightRatio * 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            StringNames.DONT_HAVE_ACCOUNT,
                            style: TextStyle(
                                fontSize: 14,
                                color: Themes.canvasColor,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: ScreenRatio.widthRatio * 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.SIGNUP);
                            },
                            child: Text(
                              StringNames.CLICK_HERE,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Themes.primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: ScreenRatio.heightRatio * 40,
                      )
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
