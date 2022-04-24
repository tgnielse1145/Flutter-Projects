import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FromTo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.location_on,
                color: PrimaryColor,
                size: 20,
              ),
              title: Text(
                "14 Đường B16, Hưng Lợi, Cần Thơ ",
                style: normalStyle,
              ),
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.locationArrow,
                color: PrimaryColor,
                size: 14,
              ),
              title: Text(
                "315 Đường Nguyễn Văn Linh, Cần Thơ",
                style: normalStyle,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 40),
          child: FDottedLine(
            color: Colors.white,
            height: 30.0,
          ),
        )
      ],
    );
  }
}
