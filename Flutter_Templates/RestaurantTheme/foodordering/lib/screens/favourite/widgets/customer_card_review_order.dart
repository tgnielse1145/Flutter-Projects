import 'package:flutter/material.dart';
import 'package:foodordering/common_widgets/radio_button.dart';
import 'package:foodordering/screens/favourite/widgets/data.dart';
import 'package:foodordering/utils/screen_ratio/screen_ratio.dart';
import 'package:foodordering/utils/themes/theme.dart';

class CustomCardReviewOrder extends StatefulWidget {
  final List<CartItems> itemList;

  CustomCardReviewOrder({this.itemList});

  @override
  CustomCardReviewOrderState createState() =>
      CustomCardReviewOrderState(itemList: itemList);
}

class CustomCardReviewOrderState extends State<CustomCardReviewOrder> {
  final List<CartItems> itemList;

  CustomCardReviewOrderState({this.itemList});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: itemList.map((CartItems itemData) {
      return Container(
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
        color: Colors.white,
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          title: CustomRadioButton(
            icon: true,
            title: itemData.name,
            onTap: () => {},
            color: true,
          ),
          trailing: Container(
            width: ScreenRatio.widthRatio * 148.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: ScreenRatio.widthRatio * 30,
                  width: ScreenRatio.widthRatio * 106,
                  margin: EdgeInsets.only(right: 5),
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 1.0, color: Themes.greenColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          color: Colors.black,
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.remove,
                            color: Themes.greenColor,
                            size: 16.0,
                          ),
                          onPressed: () {
                            setState(() {
                              if (itemData.quantity > 0) {
                                itemData.quantity--;
                              }
                            });
                          }),
                      Text('0' + itemData.quantity.toString(),
                          style:
                              TextStyle(color: Colors.black87, fontSize: 13)),
                      IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.add,
                            color: Themes.greenColor,
                            size: 16.0,
                          ),
                          onPressed: () {
                            setState(() {
                              itemData.quantity++;
                            });
                          }),
                    ],
                  ),
                ),
                Text(
                  '\$ ' + itemData.amount.toString(),
                  style: TextStyle(color: Colors.black87, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList());
  }
}
