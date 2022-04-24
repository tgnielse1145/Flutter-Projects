import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/core/constants/mockdata.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';
import 'package:flutter_qcabtaxi/ui/shared/ui_helpers.dart';
import 'package:flutter_qcabtaxi/ui/widget/mytext.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:provider/provider.dart';

class FavoriteView extends KFDrawerContent {
  @override
  _SelectDesPageState createState() {
    return _SelectDesPageState();
  }
}

class _SelectDesPageState extends State<FavoriteView> {
  void initState() {
    super.initState();
  }

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
        actions: <Widget>[
          IconButton(
            //onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.add,
              color: PrimaryColor,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: H1(
              text: "My Places",
            ),
          ),
          UIHelper.verticalSpaceMedium,
          Expanded(
            child: ListView.builder(
              itemCount: plases.length,
              itemBuilder: (context, index) {
                return Itemplace(name: plases[index]['name'], address: plases[index]['address'], type: plases[index]['place'],);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Itemplace extends StatelessWidget {
  final String name;
  final String address;
  final int type;

  const Itemplace({Key key, this.name, this.address, this.type}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        color: SecondaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(Icons.location_on, color: PrimaryColor,),
            title: Text(name, style: normalStyle,),
            subtitle: Text(address, style: H3style,),
          ),
        ),
      ),
    );
  }
}

