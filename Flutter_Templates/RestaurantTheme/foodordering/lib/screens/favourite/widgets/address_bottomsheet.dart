import 'package:flutter/material.dart';
import 'package:foodordering/screens/set_delivery_location/set_delivery_location.dart';
import 'package:foodordering/utils/constants/route_names.dart';
import 'package:foodordering/utils/constants/string_names.dart';
import 'package:foodordering/utils/screen_ratio/screen_ratio.dart';
import 'package:foodordering/utils/themes/theme.dart';

class AddressBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(100.0), topLeft: Radius.circular(100.0)),
        color: Colors.white,
      ),
      height: ScreenRatio.heightRatio * 250,
      child: new Wrap(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            height: ScreenRatio.heightRatio * 60,
            padding: EdgeInsets.only(left: ScreenRatio.widthRatio * 12),
            color: Colors.blue[50],
            child: Text(
              StringNames.CHOOSE_DELIVERY_ADDRESS,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 10, bottom: 10, right: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.home_work_outlined,
                      color: Themes.greenColor,
                      size: 50,
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10),
                            child: Text(
                              StringNames.HOME,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Themes.greenColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 10, bottom: 10),
                            child: Text(
                              StringNames.HOME_ADDRESS,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Themes.greyColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          Divider(
            color: Themes.greyColor,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, top: 10, bottom: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.add,
                    color: Themes.blueColor,
                    size: 50,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SetDeliveryLocation(
                                  button: false,
                                )),
                      ).then((value) => Navigator.pop(context));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                      ),
                      child: Text(
                        StringNames.ADD_NEW_ADDRESS,
                        style: TextStyle(
                            fontSize: 15,
                            color: Themes.blueColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Themes.greyColor,
          ),
        ],
      ),
    );
  }
}
