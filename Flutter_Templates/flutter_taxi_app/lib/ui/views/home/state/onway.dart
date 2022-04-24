import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/core/viewmodel/map_model.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';
import 'package:flutter_qcabtaxi/ui/shared/ui_helpers.dart';
import 'package:flutter_qcabtaxi/ui/widget/fromto.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mycontainer.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mycontainer2.dart';
import 'package:flutter_qcabtaxi/ui/widget/mytext.dart';

class OnWay extends StatefulWidget {
  final MapModel model;

  const OnWay({Key key, this.model}) : super(key: key);

  @override
  _OnWayState createState() => _OnWayState(model);
}

class _OnWayState extends State<OnWay> {
  final MapModel model;
  bool show = false;

  _OnWayState(this.model);

  Widget _buildshow() {
    return Column(
      children: <Widget>[
        MyContainer2(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
            child: _buildDriver(),
          ),
        ),
        UIHelper.verticalSpaceSmall,
        MyContainer2(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
          ),
        ),
        UIHelper.verticalSpaceSmall,
        MyContainer2(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Item1(
                  title: "Payment",
                  icon: Icons.account_balance_wallet,
                  value: "Wallet",
                ),
                Item1(
                  title: "Ride for",
                  icon: Icons.person,
                  value: "1 Person",
                ),
                Item1(
                  title: "Ride type",
                  icon: Icons.directions_car,
                  value: "Private",
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Btn1(
                caption: "Call Now",
                icon: Icons.call,
                onPressed: () {},
              ),
              Btn1(
                caption: "Cancel",
                icon: Icons.clear,
                onPressed: () {},
              ),
              Btn1(
                caption: "Less",
                icon: Icons.keyboard_arrow_down,
                onPressed: () {
                  setState(() {
                    show = false;
                  });
                },
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildDriver() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
              ),
            ),
            UIHelper.horizontalSpaceSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
          ],
        ),
        Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                  width: 60,
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "4.0",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.lightGreenAccent,
                          size: 16,
                        )
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Arriving in",
              style: H3style,
            ),
            Text(
              "4 min",
              style: normalStyle,
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () => model.reset(),
                icon: Icon(
                  Icons.arrow_back,
                  color: PrimaryColor,
                ),
              ),
            )
          ],
        ),
        Spacer(),
        show
            ? _buildshow()
            : MyContainer(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      UIHelper.verticalSpaceSmall,
                      _buildDriver(),
                      UIHelper.verticalSpaceMedium,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Btn1(
                            caption: "Call Now",
                            icon: Icons.call,
                            onPressed: () {},
                          ),
                          Btn1(
                            caption: "Cancel",
                            icon: Icons.clear,
                            onPressed: () {
                              model.go_rating(); //just demo
                            },
                          ),
                          Btn1(
                            caption: "More",
                            icon: Icons.keyboard_arrow_up,
                            onPressed: () {
                              setState(() {
                                show = true;
                              });
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}

class Btn1 extends StatelessWidget {
  final String caption;
  final IconData icon;
  final GestureTapCallback onPressed;

  const Btn1({Key key, this.caption, this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.0),
      child: Container(
          color: Colors.black,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: FlatButton.icon(
                  onPressed: onPressed,
                  icon: Icon(
                    icon,
                    color: PrimaryColor,
                  ),
                  label: Text(
                    caption,
                    style: TextStyle(color: Colors.white),
                  )))),
    );
  }
}

class Item1 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const Item1({Key key, this.title, this.value, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        H3(
          text: title,
        ),
        UIHelper.verticalSpaceSmall,
        Row(
          children: <Widget>[
            Icon(icon, color: PrimaryColor),
            UIHelper.horizontalSpaceSmall,
            Text(
              value,
              style: normalStyle,
            ),
          ],
        )
      ],
    );
  }
}
