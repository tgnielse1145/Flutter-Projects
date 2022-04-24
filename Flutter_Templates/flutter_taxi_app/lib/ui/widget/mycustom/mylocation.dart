import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/core/viewmodel/map_model.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';

class MyLocation extends StatelessWidget {
  final MapModel model;

  const MyLocation({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
        child: Container(
          color: Colors.white10,
          child: IconButton(
            icon: Icon(
              Icons.near_me,
              color: PrimaryColor,
              //size: 32,
            ),
            onPressed: model.onMyLocationFabClicked,
          ),
        ),
      ),
    ]);
  }
}
