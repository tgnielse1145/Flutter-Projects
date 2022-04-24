import 'package:cached_network_image/cached_network_image.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/core/utils/device_utils.dart';
import 'package:flutter_qcabtaxi/core/viewmodel/map_model.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';
import 'package:flutter_qcabtaxi/ui/shared/ui_helpers.dart';
import 'package:flutter_qcabtaxi/ui/widget/fromto.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mybuttonfull.dart';
import 'package:flutter_qcabtaxi/ui/widget/mytext.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'onway.dart';

class Rating extends StatefulWidget {
  final MapModel model;

  const Rating({Key key, this.model}) : super(key: key);

  @override
  _RatingState createState() => _RatingState(model);
}

class _RatingState extends State<Rating> {
  final MapModel model;
  TextEditingController controller_text = new TextEditingController();

  _RatingState(this.model);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: Container(
          //padding: EdgeInsets.all(16),
          color: SecondaryColor,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () => widget.model.reset(),
                          icon: Icon(
                            Icons.arrow_back,
                            color: PrimaryColor,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 80,
                              height: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24.0),
                                child: SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: CachedNetworkImage(
                                    imageUrl: 'https://i.pravatar.cc/250?img=12',
                                    placeholder: (context, url) =>
                                        new CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        new Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                            UIHelper.verticalSpaceSmall,
                            Text(
                              "George Smith",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                            UIHelper.verticalSpaceSmall,
                            Text(
                              "Hyundai WagonR",
                              style: H3style,
                            ),
                            Text(
                              "DL 1 ZA 5887",
                              style: normalStyle,
                            )
                          ],
                        ),
                        UIHelper.horizontalSpaceMedium,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            H3(
                              text: "Ride fare",
                            ),
                            Text(
                              "40.00 \$",
                              style: TextStyle(
                                  color: PrimaryColor,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 45,
                            ),
                            Item1(
                              title: "Payment via",
                              icon: Icons.account_balance_wallet,
                              value: "Wallet",
                            ),
                          ],
                        )
                      ],
                    ),
                    UIHelper.verticalSpaceMedium,
                    Column(
                      children: <Widget>[
                        ListTile(
                          title: H3(
                            text: "Ride info",
                          ),
                          trailing: Text(
                            "8 km (12 min)",
                            style: normalStyle,
                          ),
                        ),
                        UIHelper.verticalSpaceSmall,
                        FromTo(),
                      ],
                    ),
                    UIHelper.verticalSpaceMedium,
                    FDottedLine(
                      color: Colors.grey.shade700,
                      width: DeviceUtils.getScaledWidth(context, 8 / 10),
                    ),
                    UIHelper.verticalSpaceSmall,
                    Column(
                      children: <Widget>[
                        H3(
                          text: "Rate your ride",
                        ),
                        UIHelper.verticalSpaceMedium,
                        RatingBar(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: PrimaryColor,
                            size: 50,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        UIHelper.verticalSpaceMedium,
                        SizedBox(
                          height: 80,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: controller_text,
                            //style: TextStyle(fontSize: 22),
                            decoration: InputDecoration(
                                hintText: "Add a comments (optional)",
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0)),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: FlatButton(
                  color: PrimaryColor,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.fromLTRB(24, 18, 24, 18),
                  onPressed: () {
                    model.reset();
                  },
                  child: Text(
                    "Pay & Sumbit Review",
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
