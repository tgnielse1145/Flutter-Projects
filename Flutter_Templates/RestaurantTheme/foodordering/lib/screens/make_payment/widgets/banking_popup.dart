import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodordering/scoped_model/payment_scopedmodal.dart';
import 'package:foodordering/utils/assets/images.dart';
import 'package:foodordering/utils/constants/route_names.dart';
import 'package:foodordering/utils/constants/string_names.dart';
import 'package:foodordering/utils/screen_ratio/screen_ratio.dart';
import 'package:foodordering/utils/themes/theme.dart';

class PaymentPopUp extends StatefulWidget {
  @override
  _PaymentPopUpState createState() => _PaymentPopUpState();
}

class _PaymentPopUpState extends State<PaymentPopUp> {
  int _radioValue = 1;
  double _height = 160 * ScreenRatio.heightRatio;
  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: paymentScopedModel.value,
      child: Scaffold(
        backgroundColor: Themes.transparentColor,
        body: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.clear),
                  color: Themes.greenColor,
                  iconSize: 35.0 * ScreenRatio.widthRatio,
                  onPressed: () {
                    paymentScopedModel.changedValue();
                    paymentScopedModel.changeOpacity();
                    // paymentScopedModel.value = true;
                    // paymentScopedModel.opacity = 1;
                    // setState(() {});
                  },
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20.0 * ScreenRatio.heightRatio,
                left: 20 * ScreenRatio.widthRatio,
                right: 20 * ScreenRatio.widthRatio,
              ),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15.0 * ScreenRatio.widthRatio),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text(
                              StringNames.PAYPAL,
                              style: TextStyle(
                                fontSize: 15 * ScreenRatio.widthRatio,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                Images.PAYPAL,
                                width: 43 * ScreenRatio.widthRatio,
                                height: 11 * ScreenRatio.heightRatio,
                              ),
                            ),
                          ),
                          Container(
                            child: Radio(
                              groupValue: _radioValue,
                              onChanged: (value) {
                                _radioValue = value;
                                _height = 0;
                                setState(() {});
                              },
                              value: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15.0 * ScreenRatio.widthRatio),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            StringNames.DEBIT_CREDIT_CARD,
                            style: TextStyle(
                              fontSize: 15 * ScreenRatio.widthRatio,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: 10 * ScreenRatio.widthRatio),
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                Images.VISA_LOGO,
                                width: 25 * ScreenRatio.widthRatio,
                                height: 8 * ScreenRatio.heightRatio,
                              ),
                            ),
                          ),
                          Container(
                            child: Image.asset(
                              Images.MASTERO,
                              width: 25 * ScreenRatio.widthRatio,
                              height: 16 * ScreenRatio.heightRatio,
                            ),
                          ),
                          Container(
                            child: Radio(
                              groupValue: _radioValue,
                              onChanged: (value) {
                                _radioValue = value;
                                _height = 160 * ScreenRatio.heightRatio;
                                setState(() {});
                              },
                              value: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: _height,
                      padding: EdgeInsets.symmetric(
                          horizontal: 15 * ScreenRatio.widthRatio),
                      color: Color(0x22979797),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                              autovalidate: true,
                              style: TextStyle(
                                  fontSize: 15 * ScreenRatio.widthRatio,
                                  color: Colors.black),
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: StringNames.CARD_NUMBER,
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                contentPadding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 10.0,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 25,
                              bottom: 15,
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      right: 10.0 * ScreenRatio.widthRatio),
                                  child: Text(StringNames.EXPIRY),
                                ),
                                Flexible(
                                  child: TextFormField(
                                    inputFormatters: <TextInputFormatter>[
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    keyboardType: TextInputType.datetime,
                                    style: TextStyle(
                                        fontSize: 15 * ScreenRatio.widthRatio,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      contentPadding: EdgeInsets.all(0),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 10 * ScreenRatio.widthRatio,
                                    right: 10 * ScreenRatio.widthRatio,
                                  ),
                                  child: Text(StringNames.CVV),
                                ),
                                Flexible(
                                  child: TextField(
                                    inputFormatters: <TextInputFormatter>[
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontSize: 15 * ScreenRatio.widthRatio,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      contentPadding: EdgeInsets.all(0),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 30 * ScreenRatio.widthRatio),
                                  child: Icon(
                                    Icons.info_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15 * ScreenRatio.widthRatio),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            StringNames.INTERNET_BANKING,
                            style: TextStyle(
                              fontSize: 15 * ScreenRatio.widthRatio,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                Images.MASTERODARK,
                              ),
                            ),
                          ),
                          Radio(
                            groupValue: _radioValue,
                            onChanged: (value) {
                              _radioValue = value;
                              _height = 0;
                              setState(() {});
                            },
                            value: 2,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        15 * ScreenRatio.widthRatio,
                        15 * ScreenRatio.heightRatio,
                        15 * ScreenRatio.widthRatio,
                        25 * ScreenRatio.heightRatio,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 46.0 * ScreenRatio.heightRatio,
                      child: RaisedButton(
                        child: Text(
                          StringNames.PAY,
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Themes.greenColor,
                        onPressed: () {
                          paymentScopedModel.changeOpacity();
                          paymentScopedModel.changedValue();
                          Navigator.pushNamed(context, Routes.BOTTOMTAB);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
