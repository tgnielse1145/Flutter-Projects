import 'package:flutter/material.dart';
import 'package:foodordering/utils/fonts/fonts.dart';

class Themes {
  static ThemeData get defaultTheme {
    return ThemeData(
      primarySwatch: Themes.primaryColor,
      appBarTheme: AppBarTheme(
        color: Themes.canvasColor,
        elevation: 15.0,
      ),
      scaffoldBackgroundColor: Themes.canvasColor,
      fontFamily: Fonts.defaultFont,
    );
  }

  static const Color primaryColor = Color(0xff44A521);
  static const Color redColor = Colors.red;
  static const Color greenColor = Colors.green;
  static const Color blueColor = Colors.blue;
  static const Color greyColor = Color(0xffA9A9A9);
  static const Color appBarColor = Colors.white;
  static const Color canvasColor = Colors.white;
  static const Color backgroundColor = Color(0xff313131);
  static const Color test_textColor = Color(0xff4E98F4);
  static const Color buttonColor = Color(0xff007AFF);
  static const Color buttontextColor = Colors.white;
  static const Color listItemsInFactcheck = Color(0xff848484);
  static const Color cardColor = Color(0xffF0F7FF);
  static const Color textColor = Colors.blue;
  static const Color factRelevant = Color(0xffB1AFAF);
  static const Color tipForFact = Color(0xff7F91A2);
  static const Color blackColor = Colors.black;
  static const Color borderColor = Color(0xffECECEC);
  static const Color tiptextColor = Color(0xff848484);
  static const Color seeAllbutton = Color(0xff006BE1);
  static const Color yesButton = Color(0xffC3C3C3);
  static const Color circleAvatar = Color(0xffBFD8F7);
  static const Color aboutTextColor = Color(0xff3F3F3F);
  static const Color transparentColor = Colors.transparent;
}
