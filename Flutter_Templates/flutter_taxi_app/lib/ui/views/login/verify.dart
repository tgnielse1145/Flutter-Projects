import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/core/constants/app_contstants.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/ui_helpers.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mybutton.dart';
import 'package:flutter_qcabtaxi/ui/widget/mytext.dart';

class VerifyView extends StatefulWidget {
  @override
  _VerifyViewState createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
  final TextEditingController controller_phone = new TextEditingController();

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
            padding: const EdgeInsets.only(left: 24),
            child: H1(
              text: "Enter \nverification code",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: H3(
              text: "Enter code we've sent to given number",
            ),
          ),
          UIHelper.verticalSpaceMedium,
          Expanded(
            child: Container(
              padding: EdgeInsets.all(24),
              color: SecondaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  H2(
                    text: "Enter 6 digits verification code",
                  ),
                  TextField(
                    keyboardType:  TextInputType.number,
                    controller: controller_phone,
                    style: TextStyle(fontSize: 32, color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "6 digits",
                        //hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 16.0)),
                  ),
                ],
              ),
            ),
          ),
          //Spacer(),
          Row(
            children: <Widget>[
              Expanded(
                child: MyButton(
                  caption: "NOT RECEIVED",
                  main: false,
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: MyButton(
                  caption: "CONTINUE",
                  main: true,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, RoutePaths.Home);
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
