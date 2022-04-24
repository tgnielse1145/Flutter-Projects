import 'package:flutter/material.dart';
import 'package:foodordering/utils/themes/theme.dart';

class CustomRadioButton extends StatefulWidget {
  final String title;
  final GestureTapCallback onTap;
  final bool color;
  final bool icon;

  const CustomRadioButton(
      {Key key, this.title, this.onTap, this.color, this.icon})
      : super(key: key);
  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    double size = 10.0;

    return new InkResponse(
      onTap: widget.onTap,
      child: Row(
        children: [
          GestureDetector(
              onTap: widget.onTap,
              child: widget.icon
                  ? Container(
                      margin: EdgeInsets.only(right: 20),
                      width: size,
                      height: size,
                      decoration: new BoxDecoration(
                        color: widget.color
                            ? Themes.greenColor
                            : Themes.canvasColor,
                        shape: BoxShape.circle,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(right: 20, bottom: 10),
                      width: size,
                      height: size,
                      child: Icon(
                        Icons.check,
                        color: widget.color
                            ? Themes.greenColor
                            : Themes.canvasColor,
                      ),
                    )),
          Text(
            widget.title,
            style: TextStyle(
                fontSize: 16,
                color: Themes.blackColor,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
