import 'package:flutter/material.dart';
import 'package:foodordering/common_widgets/radio_button.dart';
import 'package:foodordering/scoped_model/disches_scopedmodel.dart';
import 'package:foodordering/utils/screen_ratio/screen_ratio.dart';
import 'package:foodordering/utils/themes/theme.dart';
import 'package:scoped_model/scoped_model.dart';

class ItemListPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<DisheScopedModel>(
        model: disheScopedModel,
        child: ScopedModelDescendant<DisheScopedModel>(
            builder: (context, child, disheScopedModel) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            elevation: 4,
            content: Container(
                height: ScreenRatio.heightRatio * 230,
                child: Column(
                    children: disheScopedModel.item.map((e) {
                  return Container(
                    margin: EdgeInsets.only(
                        top: ScreenRatio.heightRatio * 4.0,
                        bottom: ScreenRatio.heightRatio * 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRadioButton(
                          icon: false,
                          title: e[0],
                          onTap: () {
                            e[2] = !e[2];
                            disheScopedModel.colorStatus(e[0]);
                          },
                          color: e[2] ? true : false,
                        ),
                        Text(
                          e[1],
                          style: TextStyle(
                              color: Themes.blackColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              letterSpacing: 1,
                              wordSpacing: 1),
                        )
                      ],
                    ),
                  );
                }).toList())),
          );
        }));
  }
}
