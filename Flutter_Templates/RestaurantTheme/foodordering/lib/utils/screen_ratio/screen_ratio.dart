import 'package:flutter/material.dart';

class ScreenRatio {
  static double heightRatio;
  static double widthRatio;
  static double screenHeight;
  static double screenWidth;
  static setScreenRatio(context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    heightRatio = screenHeight / 667;
    widthRatio = screenWidth / 375;
  }
}
