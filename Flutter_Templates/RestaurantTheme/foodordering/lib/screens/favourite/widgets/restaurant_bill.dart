import 'package:flutter/material.dart';

import '../../../utils/constants/string_names.dart';
import '../../../utils/screen_ratio/screen_ratio.dart';
import '../../../utils/themes/theme.dart';

class RestaurantBill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 10.0, top: 10),
            child: Text(
              StringNames.RESTAURANT_BILL,
              style: TextStyle(
                  fontSize: 16,
                  color: Themes.blackColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  StringNames.ITEM_TOTAL,
                  style:
                      const TextStyle(fontSize: 16.0, color: Themes.greyColor),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      const Text(
                        '\$ 880',
                        style: const TextStyle(color: Themes.greyColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  StringNames.PACKAGING_CHARGES,
                  style:
                      const TextStyle(fontSize: 16.0, color: Themes.greyColor),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      const Text(
                        '\$ 20',
                        style: const TextStyle(color: Themes.greyColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  StringNames.GST,
                  style:
                      const TextStyle(fontSize: 16.0, color: Themes.greyColor),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      const Text(
                        '\$ 200',
                        style: const TextStyle(color: Themes.greyColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          new SizedBox(
            height: 1.0,
            child: new Center(
              child: new Container(
                margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                height: 1.0,
                color: Themes.greyColor,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding:
                EdgeInsets.only(top: 20.0, bottom: 20, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  StringNames.DELIVERY_CHARGES,
                  style:
                      const TextStyle(fontSize: 15.0, color: Themes.greyColor),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      const Text(
                        '\$ 20',
                        style: const TextStyle(color: Themes.greyColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          new SizedBox(
            height: 1.0,
            child: new Center(
              child: new Container(
                margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                height: 1.0,
                color: Themes.greyColor,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 10, bottom: 10),
            padding:
                EdgeInsets.only(top: 20.0, bottom: 20, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  StringNames.TO_PAY,
                  style: const TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      const Text(
                        '\$ 1120',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[200],
            width: ScreenRatio.screenWidth,
            padding: EdgeInsets.all(10),
            child: Text(
              StringNames.YOU_HAVE_SAVED,
              style: const TextStyle(
                  fontSize: 16.0,
                  color: Themes.greenColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
