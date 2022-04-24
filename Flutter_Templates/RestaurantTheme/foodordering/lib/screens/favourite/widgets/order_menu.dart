import 'package:flutter/material.dart';

import '../../../common_widgets/text_input.dart';
import '../../../utils/assets/images.dart';
import '../../../utils/constants/string_names.dart';
import '../../../utils/screen_ratio/screen_ratio.dart';
import '../../../utils/themes/theme.dart';
import 'customer_card_review_order.dart';
import 'package:foodordering/screens/favourite/widgets/data.dart';

class OrderMenu extends StatelessWidget {
  TextEditingController searchText;
  final DataListBuilder orderList = DataListBuilder();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        margin: EdgeInsets.only(
            left: ScreenRatio.widthRatio * 12,
            right: ScreenRatio.widthRatio * 12,
            top: ScreenRatio.heightRatio * 12),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: ScreenRatio.heightRatio * 55,
                  width: ScreenRatio.widthRatio * 55,
                  child: Image.asset(Images.HOTDOG),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StringNames.BRITALIAN_KITCHIEN,
                        style: TextStyle(
                            fontSize: 16,
                            color: Themes.blackColor,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1),
                      ),
                      Text(
                        StringNames.BTM_2ND_STAGE,
                        style: TextStyle(
                            fontSize: 14,
                            color: Themes.greyColor,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                )
              ],
            ),
            CustomCardReviewOrder(
              itemList: orderList.itemList,
            ),
            Container(
              margin: EdgeInsets.only(
                  right: ScreenRatio.widthRatio * 12,
                  top: ScreenRatio.heightRatio * 12),
              padding: EdgeInsets.only(left: 0),
              child: InputField(
                margin: false,
                border: false,
                hint: StringNames.ANY_SUGGESTIONS,
                protected: false,
                controller: searchText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
