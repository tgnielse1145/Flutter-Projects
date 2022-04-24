import 'package:flutter/material.dart';
import 'package:flutter_qcabtaxi/core/constants/mockdata.dart';
import 'package:flutter_qcabtaxi/core/utils/device_utils.dart';
import 'package:flutter_qcabtaxi/core/viewmodel/map_model.dart';
import 'package:flutter_qcabtaxi/ui/shared/app_colors.dart';
import 'package:flutter_qcabtaxi/ui/shared/text_styles.dart';
import 'package:flutter_qcabtaxi/ui/shared/ui_helpers.dart';
import 'package:flutter_qcabtaxi/ui/widget/mycustom/mybutton3.dart';
import 'package:flutter_qcabtaxi/ui/widget/mytext.dart';

class Book extends StatefulWidget {
  final MapModel model;

  const Book({Key key, this.model}) : super(key: key);

  @override
  _BookState createState() => _BookState(model);
}

class _BookState extends State<Book> {
  final MapModel model;
  int select_car = 0;

  _BookState(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UIHelper.verticalSpaceMedium,
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () => model.reset(),
                icon: Icon(
                  Icons.arrow_back,
                  color: PrimaryColor,
                ),
              ),
            )
          ],
        ),
        Spacer(),
        SizedBox(
          height: DeviceUtils.getScaledWidth(context, 2 / 3) - 30,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cars.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      select_car = index;
                    });
                  },
                  child: Stack(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                                width:
                                    DeviceUtils.getScaledWidth(context, 1 / 3),
                                height:
                                    DeviceUtils.getScaledWidth(context, 3 / 7),
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: select_car == index
                                      ? PrimaryColor
                                      : SecondaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      cars[index]["name"],
                                      style: normalStyle,
                                    ),
                                    Text("US\$${cars[index]["price"]}",
                                        style: TextStyle(color: Dark)),
                                  ],
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: Image.asset(cars[index]["img"]),
                        width: DeviceUtils.getScaledWidth(context, 1 / 3),
                        height: DeviceUtils.getScaledWidth(context, 3 / 7),
                      ),
                    ],
                  ),
                );
              }),
        ),
        MyButton3(
          caption: "RIDE NOW",
          onPressed: () {
            model.go_waiting();
          },
        )
      ],
    );
  }
}
