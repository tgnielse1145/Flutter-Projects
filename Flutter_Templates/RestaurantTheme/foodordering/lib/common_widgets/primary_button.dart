import 'package:flutter/material.dart';
import 'package:foodordering/utils/screen_ratio/screen_ratio.dart';
import 'package:foodordering/utils/themes/theme.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton(
      this.onPressedFunc, this.buttontext, this.color, this.buttonWidth);
  final GestureTapCallback onPressedFunc;
  final String buttontext;
  final double buttonWidth;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressedFunc,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      textColor: Themes.canvasColor,
      child: Container(
        alignment: Alignment.center,
        width: buttonWidth,
        height: ScreenRatio.heightRatio * 50,
        child: Text(
          buttontext,
          style: TextStyle(fontSize: 18, letterSpacing: 1, wordSpacing: 1),
        ),
      ),
    );
  }
}
