import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';

class MyButton extends StatelessWidget {
  final String caption;
  final GestureTapCallback onPressed;
  final bool main;

  MyButton({Key key, this.caption, this.onPressed, this.main})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return main
        ? FlatButton(
            color: Colors.black,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.fromLTRB(24, 18, 24, 18),
            onPressed: onPressed,
            child: Text(
              caption,
              style: TextStyle(fontSize: 20.0, color: PrimaryColor),
            ),
          )
        : FlatButton(
            /*shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0)),*/
            color: PrimaryColor,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.fromLTRB(24, 18, 24, 18),
            //splashColor: Basic,
            onPressed: onPressed,
            child: Text(
              caption,
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          );
  }
}

