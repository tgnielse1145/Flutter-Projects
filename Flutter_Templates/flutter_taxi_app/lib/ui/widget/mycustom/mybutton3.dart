import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';

class MyButton3 extends StatelessWidget {
  final String caption;
  final GestureTapCallback onPressed;

  const MyButton3({Key key, this.caption, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlatButton(
        color: Colors.black,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 18),
        onPressed: onPressed,
        child: Text(
          caption,
          style: TextStyle(fontSize: 20.0, color: PrimaryColor),
        ),
      ),
    );
  }
}
