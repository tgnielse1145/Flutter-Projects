
import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';

class MyButtonFull extends StatelessWidget {
  final String caption;
  final GestureTapCallback onPressed;

  const MyButtonFull({Key key, this.caption, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
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
    );
  }
}
