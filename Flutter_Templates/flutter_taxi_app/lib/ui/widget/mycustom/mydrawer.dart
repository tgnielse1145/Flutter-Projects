import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/core/constants/app_contstants.dart';
import 'package:flutter_qcabtaxi/core/utils/device_utils.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';
import 'package:flutter_qcabtaxi/ui/shared/ui_helpers.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/myavatar.dart';
import 'package:flutter_qcabtaxi/ui/widget/mytext.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  //final UserObj userObj;
  const MyDrawer({Key key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: SecondaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              //padding: EdgeInsets.all(16),
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UIHelper.verticalSpaceMedium,
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: PrimaryColor,
                        size: 40,
                      )),
                  UIHelper.verticalSpaceSmall,
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        MyAvatar(
                          imgurl: 'https://i.pravatar.cc/250?img=16',
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Karen Hamilton",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            UIHelper.verticalSpaceSmall,
                            H3(
                              text: "+1 654 3210",
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  UIHelper.verticalSpaceSmall,
                ],
              ),
            ),
           /* MenuItem(
              icon: Icons.home,
              text: "Home",
              onPressed: () {
                Navigator.pop(context);
              },
            ),*/
            MenuItem(
              icon: Icons.perm_contact_calendar,
              text: "My Profile",
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RoutePaths.Profile);
              },
            ),
            MenuItem(
              icon: Icons.location_on,
              text: "My Address",
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RoutePaths.Place);
              },
            ),
            MenuItem(
              icon: Icons.directions_car,
              text: "My Ride",
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RoutePaths.Myride);
              },
            ),
            MenuItem(
              icon: Icons.account_balance_wallet,
              text: "Wallet",
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RoutePaths.Payment);
              },
            ),
            MenuItem(
              icon: Icons.card_giftcard,
              text: "Promo Code",
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RoutePaths.Promo);
              },
            ),
            MenuItem(
              icon: Icons.question_answer,
              text: "FAQs",
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RoutePaths.Qas);
              },
            ),
            MenuItem(
              icon: Icons.mail,
              text: "Contacts Us",
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RoutePaths.Contact);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final GestureTapCallback onPressed;
  final IconData icon;
  final String text;

  const MenuItem({Key key, this.onPressed, this.icon, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ListTile(
        leading: Icon(
          icon,
          color: PrimaryColor,
        ),
        title: Text(
          text,
          style: menuStyle,
        ),
      ),
    );
  }
}
