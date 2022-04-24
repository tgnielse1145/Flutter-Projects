import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodordering/common_widgets/text_input.dart';
import 'package:foodordering/utils/constants/string_names.dart';
import 'package:foodordering/utils/screen_ratio/screen_ratio.dart';
import 'package:foodordering/utils/themes/theme.dart';

class CouponsOffers extends StatelessWidget {
  TextEditingController couponText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: Themes.canvasColor,
        title: Text(
          StringNames.COUPONS_OFFERS,
          style: TextStyle(color: Themes.blackColor),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Divider(
            color: Themes.greyColor,
          ),
          Container(
            margin: EdgeInsets.only(
                left: ScreenRatio.widthRatio * 12,
                right: ScreenRatio.widthRatio * 12),
            padding: EdgeInsets.only(left: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      right: ScreenRatio.widthRatio * 12,
                    ),
                    padding: EdgeInsets.only(left: 0),
                    child: InputField(
                      margin: false,
                      border: false,
                      hint: StringNames.ENTER_COUPON_CODE,
                      protected: false,
                      // controller: searchText,
                    ),
                  ),
                ),
                Container(
                  height: ScreenRatio.widthRatio * 30,
                  width: ScreenRatio.widthRatio * 106,
                  margin: EdgeInsets.only(right: 5),
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 2.0, color: Themes.greyColor),
                  ),
                  child: Center(
                    child: Text(StringNames.APPLY,
                        style: TextStyle(color: Colors.black87, fontSize: 13)),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Themes.greyColor,
          ),
          Container(
            color: Colors.grey[200],
            width: ScreenRatio.screenWidth,
            padding: EdgeInsets.all(10),
            child: Text(
              StringNames.APPLY_CUPPON,
              style: const TextStyle(
                  fontSize: 16.0,
                  color: Themes.blackColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            child: Container(
              height: ScreenRatio.heightRatio * 80,
              margin: EdgeInsets.only(
                  left: ScreenRatio.widthRatio * 12,
                  right: ScreenRatio.widthRatio * 12),
              padding: EdgeInsets.only(left: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                              right: ScreenRatio.widthRatio * 12,
                              top: ScreenRatio.widthRatio * 12,
                            ),
                            padding: EdgeInsets.only(left: 0),
                            child: Text(
                              StringNames.NEW10,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Themes.blackColor),
                            )),
                        Container(
                            margin: EdgeInsets.only(
                              right: ScreenRatio.widthRatio * 12,
                              bottom: ScreenRatio.widthRatio * 12,
                            ),
                            padding: EdgeInsets.only(left: 0),
                            child: Text(
                              StringNames.GET_10_PERCENT_DISCOUNT,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Themes.greyColor),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: ScreenRatio.widthRatio * 30,
                    width: ScreenRatio.widthRatio * 106,
                    margin: EdgeInsets.only(right: 5),
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 2.0, color: Themes.greyColor),
                    ),
                    child: Center(
                      child: Text(StringNames.APPLY,
                          style:
                              TextStyle(color: Colors.black87, fontSize: 13)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            child: Container(
              height: ScreenRatio.heightRatio * 80,
              margin: EdgeInsets.only(
                  left: ScreenRatio.widthRatio * 12,
                  right: ScreenRatio.widthRatio * 12),
              padding: EdgeInsets.only(left: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                              right: ScreenRatio.widthRatio * 12,
                              top: ScreenRatio.widthRatio * 12,
                            ),
                            padding: EdgeInsets.only(left: 0),
                            child: Text(
                              StringNames.RJCH15,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Themes.blackColor),
                            )),
                        Container(
                            margin: EdgeInsets.only(
                              right: ScreenRatio.widthRatio * 12,
                              bottom: ScreenRatio.widthRatio * 12,
                            ),
                            padding: EdgeInsets.only(left: 0),
                            child: Text(
                              StringNames.GET_15_PERCENT_DISCOUNT,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Themes.greyColor),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: ScreenRatio.widthRatio * 30,
                    width: ScreenRatio.widthRatio * 106,
                    margin: EdgeInsets.only(right: 5),
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 2.0, color: Themes.greyColor),
                    ),
                    child: Center(
                      child: Text(StringNames.APPLY,
                          style:
                              TextStyle(color: Colors.black87, fontSize: 13)),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
