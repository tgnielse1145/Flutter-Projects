import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/ui_helpers.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mybutton4.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mybuttonfull.dart';
import 'package:flutter_qcabtaxi/ui/widget/mytext.dart';

class PromoView extends StatefulWidget {
  @override
  _PromoViewState createState() => _PromoViewState();
}

class _PromoViewState extends State<PromoView> {
  TextEditingController controller_text = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: PrimaryColor,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  H1(
                    text: "Enter Promo code",
                  ),
                  UIHelper.verticalSpaceSmall,
                  H3(
                      text:
                          "Enter promo code to avail exciting offers &\n discounts on your rides"),
                  SizedBox(
                    height: 80,
                    child: Column(
                      children: <Widget>[
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: controller_text,
                          //style: TextStyle(fontSize: 22),
                          decoration: InputDecoration(
                              hintText: "Enter code here",
                              hintStyle: TextStyle(color: Colors.grey),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0)),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            MyButton4(
              caption: "APPLY PROMO CODE",
              onPressed: () => Navigator.pop(context),
            ),
            Container(
              width: double.infinity,
              color: SecondaryColor,
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  UIHelper.verticalSpaceMedium,
                  H1(
                    text: "Share referral code",
                  ),
                  UIHelper.verticalSpaceMedium,
                  H3(
                    text:
                        "Share your referal code with your friends & family\nand get \$10.00 on first ride booked by them",
                  ),
                  UIHelper.verticalSpaceMedium,
                  H3(
                    text: "Your referral code (Tap to copy)",
                  ),
                  UIHelper.verticalSpaceSmall,
                  Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF222222),
                        border: Border.all(
                            color: Colors.white, // set border color
                            width: 1.0), // set border width
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                      child: H1(
                        text: "QM21410",
                      )),
                  UIHelper.verticalSpaceMedium
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FlatButton(
                color: Colors.black,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.fromLTRB(24, 18, 24, 18),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "SHARE CODE",
                  style: TextStyle(fontSize: 20.0, color: PrimaryColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
