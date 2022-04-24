import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';
import 'package:flutter_qcabtaxi/ui/shared/ui_helpers.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mybutton4.dart';
import 'package:flutter_qcabtaxi/ui/widget/mytext.dart';

class ContactView extends StatefulWidget {
  @override
  _ContactViewState createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  TextEditingController controller_text = new TextEditingController();
  TextEditingController controller_text2 = new TextEditingController();

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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  H1(
                    text: "Contact us",
                  ),
                  UIHelper.verticalSpaceSmall,
                  H3(text: "Let us know your issue & feedbacks"),
                ],
              ),
            ),
            UIHelper.verticalSpaceMedium,
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Color(0xFF141414),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.call,
                            color: PrimaryColor,
                          ),
                          label: Text(
                            "CALL US",
                            style: normalStylePrimary,
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: PrimaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.mail,
                            color: Colors.black,
                          ),
                          label: Text(
                            "MAIL US",
                            style: normalStyle.copyWith(color: Colors.black),
                          )),
                    ),
                  ),
                )
              ],
            ),
            Container(
              color: SecondaryColor,
              padding: EdgeInsets.all(16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  H1(
                    text: "Write us",
                  ),
                  UIHelper.verticalSpaceSmall,
                  H3(text: "Describe us your issue"),
                  UIHelper.verticalSpaceMedium,
                  H3(text: "Your Email Address"),
                  SizedBox(
                    height: 80,
                    child: Column(
                      children: <Widget>[
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: controller_text,
                          //style: TextStyle(fontSize: 22),
                          decoration: InputDecoration(
                              hintText: "Ente ryour email",
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
                  UIHelper.verticalSpaceSmall,
                  H3(text: "Describe your issue or feedback"),
                  SizedBox(
                    height: 80,
                    child: Column(
                      children: <Widget>[
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: controller_text2,
                          //style: TextStyle(fontSize: 22),
                          decoration: InputDecoration(
                              hintText: "Write your message",
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
              caption: "SUBMIT",
              onPressed: () => Navigator.pop(context),
            )
          ],
        ));
  }
}
