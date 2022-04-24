import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';

class MyButton4 extends StatelessWidget {
  final String caption;
  final GestureTapCallback onPressed;

  const MyButton4({Key key, this.caption, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlatButton(
        color: PrimaryColor,
        textColor: Colors.black,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 18),
        onPressed: onPressed,
        child: Text(
          caption,
          style: BoldStyle,
        ),
      ),
    );
  }
}
