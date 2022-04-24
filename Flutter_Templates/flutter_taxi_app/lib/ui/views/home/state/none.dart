import 'dart:convert';

import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/core/models/placeobj.dart';
import 'package:flutter_qcabtaxi/core/utils/device_utils.dart';
import 'package:flutter_qcabtaxi/core/viewmodel/map_model.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';
import 'package:flutter_qcabtaxi/ui/shared/ui_helpers.dart';
import 'package:flutter_qcabtaxi/ui/views/place/pickplace.dart';
import 'package:flutter_qcabtaxi/ui/widget/dymmy.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mybutton.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mybutton3.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mylocation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class None extends StatefulWidget {
  final MapModel model;
  final GlobalKey<ScaffoldState> globalKey;

  const None({Key key, this.model, this.globalKey}) : super(key: key);

  @override
  _NoneState createState() => _NoneState(model, globalKey);
}

class _NoneState extends State<None> {
  final MapModel model;
  final GlobalKey<ScaffoldState> globalKey;

  int select_pay = 0;
  bool show_pay = false;
  var payment = ['Wallet', 'Cash'];

  int select_person = 1;
  bool show_person = false;

  _NoneState(this.model, this.globalKey);

  Widget _buildPayment() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(16),
            width: DeviceUtils.getScaledWidth(context, 1 / 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      select_pay = 1;
                      show_pay = false;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        color: select_pay == 0 ? Colors.black : PrimaryColor,
                      ),
                      Text(
                        "Cash",
                        style: BoldStyle.copyWith(
                            color:
                                select_pay == 0 ? Colors.black : PrimaryColor),
                      )
                    ],
                  ),
                ),
                UIHelper.verticalSpaceSmall,
                GestureDetector(
                  onTap: () {
                    setState(() {
                      select_pay = 0;
                      show_pay = false;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.account_balance_wallet,
                          color: select_pay == 1 ? Colors.black : PrimaryColor),
                      Text(
                        "Wallet",
                        style: BoldStyle.copyWith(
                            color:
                                select_pay == 1 ? Colors.black : PrimaryColor),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPerson() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: 160,
              padding: EdgeInsets.only(left: 16),
              width: DeviceUtils.getScaledWidth(context, 1 / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          select_person = index + 1;
                          show_person = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "${index + 1} Person",
                          style: index + 1 == select_person
                              ? BoldStyle.copyWith(color: PrimaryColor)
                              : BoldStyle,
                        ),
                      ),
                    );
                  })),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          UIHelper.verticalSpaceMedium,
          ListTile(
            leading: IconButton(
              onPressed: () {
                globalKey.currentState.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: PrimaryColor,
              ),
            ),
            title: Align(
              alignment: Alignment.center,
              child: Text(
                "BOOK YOUR RIDE",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            trailing: Icon(
              Icons.menu,
              color: Colors.transparent,
            ),
          ),
          //UIHelper.verticalSpaceMedium,
          Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: SecondaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.location_on,
                          color: PrimaryColor,
                          size: 20,
                        ),
                        title: Text(
                          "14 Đường B16, Hưng Lợi, Cần Thơ ",
                          style: normalStyle,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {go_pick_address(model, context)},
                        child: ListTile(
                          leading: Icon(
                            Icons.near_me,
                            size: 20,
                            color: PrimaryColor,
                          ),
                          title: model.destinationPosition == null
                              ? Text(
                                  "Where are you going ?",
                                  style: TextStyle(color: Dark),
                                )
                              : Text(
                                  "315 Đường Nguyễn Văn Linh, Cần Thơ",
                                  style: normalStyle,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 60),
                child: FDottedLine(
                  color: Colors.white,
                  height: 30.0,
                ),
              )
            ],
          ),
          Spacer(),
          show_pay ? _buildPayment() : Dummy(),
          show_person ? _buildPerson() : Dummy(),
          UIHelper.verticalSpaceSmall,
          show_person || show_pay
              ? Dummy()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyLocation(
                    model: model,
                  ),
                ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            color: SecondaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Payment mode",
                      style: normalStyle,
                    ),
                    //UIHelper.horizontalSpaceSmall,
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          show_pay = true;
                        });
                      },
                      child: Text(
                        payment[select_pay],
                        style: normalStylePrimary,
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Passengers",
                      style: normalStyle,
                    ),
                    //UIHelper.horizontalSpaceSmall,
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          show_person = true;
                        });
                      },
                      child: Text(
                        "$select_person person",
                        style: normalStylePrimary,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          MyButton3(
            caption: "CONTINUE",
            onPressed: () {
              if (model.destinationPosition == null) return;
              model.go_book();
            },
          )
        ],
      ),
    );
  }

  Future<void> go_pick_address(MapModel model, BuildContext context) async {
    var result = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new PickAdressView(),
        )) as FarPlaceObj;
    print('result:' + json.encode(result));
    if (result != null) {
      model.selected_destination(result);
    }
  }
}
