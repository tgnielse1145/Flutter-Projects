import 'package:flutter/material.dart';
import 'package:foodordering/animations/bounce.dart';
import 'package:foodordering/animations/fade_in.dart';
import 'package:foodordering/common_widgets/radio_button.dart';
import 'package:foodordering/scoped_model/disches_scopedmodel.dart';
import 'package:foodordering/screens/dishes/widgets/item_avaibility_popup.dart';
import 'package:foodordering/screens/dishes/widgets/item_list_popup.dart';
import 'package:foodordering/utils/constants/string_names.dart';
import 'package:foodordering/utils/data/items.dart';
import 'package:foodordering/utils/screen_ratio/screen_ratio.dart';
import 'package:foodordering/utils/themes/theme.dart';
import 'package:scoped_model/scoped_model.dart';

class DISHES extends StatefulWidget {
  final String image;

  const DISHES({Key key, this.image}) : super(key: key);
  @override
  _DISHESState createState() => _DISHESState();
}

class _DISHESState extends State<DISHES> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<DisheScopedModel>(
        model: disheScopedModel,
        child: Scaffold(
          bottomSheet: Container(
            padding: EdgeInsets.only(
                left: ScreenRatio.widthRatio * 18,
                right: ScreenRatio.widthRatio * 18,
                bottom: ScreenRatio.heightRatio * 16),
            width: ScreenRatio.screenWidth,
            height: ScreenRatio.heightRatio * 65,
            color: Themes.greenColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringNames.NUMBER_OF_ITEMS,
                  style: TextStyle(
                      color: Themes.canvasColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                InkWell(
                  onTap: () {
                    showDialogBox();
                  },
                  child: Text(StringNames.VIEW_CART,
                      style: TextStyle(
                          color: Themes.canvasColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                )
              ],
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Hero(
                      tag: widget.image,
                      child: Stack(
                        children: [
                          Container(
                              width: ScreenRatio.screenWidth,
                              child: Bounce(
                                  Image.asset(
                                    widget.image,
                                    fit: BoxFit.cover,
                                  ),
                                  10.0)),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: ScreenRatio.widthRatio * 12,
                                  top: ScreenRatio.heightRatio * 12),
                              child: GestureDetector(
                                child: Icon(Icons.arrow_back_ios,
                                    color: Themes.canvasColor, size: 24),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                Expanded(
                  flex: 2,
                  child: GridView.count(
                    childAspectRatio: 1,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: List.generate(8, (index) {
                      return FadeIn(
                        index + .0,
                        Container(
                          margin: EdgeInsets.only(
                              left: ScreenRatio.widthRatio * 6,
                              right: ScreenRatio.widthRatio * 6,
                              top: ScreenRatio.heightRatio * 9),
                          decoration: BoxDecoration(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Card(
                                  margin: EdgeInsets.all(0),
                                  elevation: 2,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  Items.items[index][0]),
                                              repeat: ImageRepeat.noRepeat,
                                              fit: BoxFit.fill))),
                                ),
                              ),
                              Expanded(
                                child: CustomRadioButton(
                                  icon: true,
                                  title: Items.items[index][3],
                                  onTap: () => {},
                                  color: true,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  Items.items[index][1],
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Themes.greyColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      Items.items[index][2],
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Themes.greyColor),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialogList();
                                      },
                                      child: Container(
                                        width: 60,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            border: Border.all(
                                                color: Themes.greyColor,
                                                width: 2)),
                                        child: Center(
                                          child: Text(
                                            StringNames.ADD,
                                            style: TextStyle(
                                                color: Themes.greenColor,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void addNumbers() {}

  void showDialogBox() {
    showDialog<Null>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return ItemAvaibilityPopUp();
      },
    );
  }

  void showDialogList() {
    showDialog<Null>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return ItemListPopUp();
      },
    );
  }
}
