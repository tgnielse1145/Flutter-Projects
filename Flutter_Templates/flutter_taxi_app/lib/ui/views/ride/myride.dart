import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/core/constants/mockdata.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';
import 'package:flutter_qcabtaxi/ui/shared/ui_helpers.dart';
import 'package:flutter_qcabtaxi/ui/widget/fromto.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/myavatar2.dart';
import 'package:flutter_qcabtaxi/ui/widget/mytext.dart';

class MyRideView extends StatelessWidget {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: H1(
              text: "My Rides",
            ),
          ),
          UIHelper.verticalSpaceSmall,
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: H3(
              text: "List of rides booked by you",
            ),
          ),
          UIHelper.verticalSpaceMedium,
          Expanded(
            child: ListView.builder(
                itemCount: rides.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                        //padding: EdgeInsets.only(top: 16),
                        color: SecondaryColor,
                        child: Column(
                          children: <Widget>[
                            UIHelper.verticalSpaceSmall,
                            ListTile(
                              leading: MyAvatar2(
                                imgurl: rides[index]['img'],
                              ),
                              title: Text(
                                rides[index]['date'],
                                style: normalStyle,
                              ),
                              subtitle: H3(
                                text: "Honda Civid",
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    rides[index]['price'],
                                    style: normalStylePrimary,
                                  ),
                                  H3(
                                    text: rides[index]['pay'],
                                  )
                                ],
                              ),
                            ),
                            UIHelper.verticalSpaceSmall,
                            Container(
                                color: Color(0xFF202020), child: FromTo()),
                          ],
                        )),
                  );
                }),
          )
        ],
      ),
    );
  }
}
