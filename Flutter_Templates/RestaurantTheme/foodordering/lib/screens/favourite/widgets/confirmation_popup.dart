import 'package:flutter/material.dart';
import 'package:foodordering/scoped_model/delivery_location_scopedmodel.dart';
import 'package:foodordering/utils/constants/string_names.dart';
import 'package:foodordering/utils/themes/theme.dart';

class ItemAvaibilityPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(
        StringNames.ARE_YOU_SURE,
        textAlign: TextAlign.center,
        style: TextStyle(
            // fontSize: 16,
            color: Themes.blackColor,
            fontWeight: FontWeight.w500),
      ),
      actions: <Widget>[
        Container(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: FlatButton(
                  padding: const EdgeInsets.all(8.0),
                  textColor: Themes.blueColor,
                  color: Themes.canvasColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text(
                    StringNames.CANCEL,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  padding: const EdgeInsets.all(8.0),
                  textColor: Themes.redColor,
                  color: Themes.canvasColor,
                  onPressed: () {
                    deliveryLocation.removeCoupon();
                    Navigator.of(context).pop();
                  },
                  child: new Text(
                    StringNames.REMOVE,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
