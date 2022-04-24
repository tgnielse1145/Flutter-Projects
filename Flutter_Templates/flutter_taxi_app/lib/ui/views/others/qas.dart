import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_qcabtaxi/core/constants/mockdata.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';
import 'package:flutter_qcabtaxi/ui/shared/ui_helpers.dart';
import 'package:flutter_qcabtaxi/ui/widget/mytext.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/custom_expansion_tile.dart' as custom;

class QasView extends StatelessWidget {
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
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  H1(
                    text: "FAQs",
                  ),
                  UIHelper.verticalSpaceSmall,
                  H3(text: "Read FQAs solution"),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: qas.length,
                itemBuilder: (context, index) {
                  return Item(
                    title: qas[index]['title'],
                    sub: qas[index]['sub'],
                  );
                }),
          )
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String title;
  final String sub;
  final String answer;

  const Item({Key key, this.title, this.sub, this.answer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SecondaryColor,
      child: Column(
        children: <Widget>[
          ExpansionTile(
              key: GlobalKey(),
              title: Text(
                title,
                style: normalStyle,
              ),
              subtitle: H3(
                text: sub,
              ),
              children: <Widget>[
                new ListTile(
                    title: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
                  style: TextStyle(color: Colors.white),
                ))
              ]),
        ],
      ),
    );
  }
}
