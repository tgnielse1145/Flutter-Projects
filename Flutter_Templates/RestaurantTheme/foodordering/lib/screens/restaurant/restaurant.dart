import 'package:flutter/material.dart';
import 'package:foodordering/animations/bounce.dart';
import 'package:foodordering/common_widgets/text_input.dart';
import 'package:foodordering/screens/dishes/dishes.dart';
import 'package:foodordering/services/validation.dart';
import 'package:foodordering/utils/assets/images.dart';
import 'package:foodordering/utils/constants/string_names.dart';
import 'package:foodordering/utils/screen_ratio/screen_ratio.dart';
import 'package:foodordering/utils/themes/theme.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class Restaurant extends StatefulWidget {
  Restaurant({Key key}) : super(key: key);
  @override
  _RestaurantState createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  Validations validations = new Validations();
  List<dynamic> pictures = [
    [Images.SOUTH_INDIAN, StringNames.SOUTH_INDIAN],
    [Images.NORTH_INDIAN, StringNames.NORTH_INDIAN],
    [Images.CHINESE, StringNames.CHINESES],
    [Images.PIZZA, StringNames.PIZZA],
    [Images.BURGER, StringNames.BURGER],
    [Images.DESERTS, StringNames.DESSERTS],
    [Images.NOODLES, StringNames.NOODLES],
    [Images.HOTDOG, StringNames.HOTDOG]
  ];
  TextEditingController searchText;
  @override
  Widget build(BuildContext context) {
    timeDilation = 2.5;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: ScreenRatio.widthRatio * 12,
                  right: ScreenRatio.widthRatio * 12,
                  top: ScreenRatio.heightRatio * 12),
              child: Row(
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.search,
                      size: 22,
                      color: Themes.blackColor,
                    ),
                  ),
                  Expanded(
                    child: InputField(
                      margin: true,
                      border: false,
                      hint: StringNames.SEARCH,
                      protected: false,
                      controller: searchText,
                      validate: validations.validatePassword,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: ScreenRatio.widthRatio * 12,
                  top: ScreenRatio.heightRatio * 4),
              child: Text(
                StringNames.TOP_SEARCHES,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Themes.greyColor),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                    left: ScreenRatio.widthRatio * 6,
                    right: ScreenRatio.widthRatio * 6,
                    top: ScreenRatio.heightRatio * 12),
                child: GridView.count(
                  childAspectRatio: 1,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(8, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DISHES(
                              image: pictures[index][0],
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: pictures[index][0],
                        child: Bounce(
                            ClipRRect(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: ScreenRatio.widthRatio * 6,
                                    right: ScreenRatio.widthRatio * 6,
                                    top: ScreenRatio.heightRatio * 9),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: AssetImage(pictures[index][0]),
                                        repeat: ImageRepeat.noRepeat,
                                        fit: BoxFit.fill)),
                                child: Center(
                                    child: Material(
                                  type: MaterialType.transparency,
                                  child: (Text(
                                    pictures[index][1],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Themes.appBarColor),
                                  )),
                                )),
                              ),
                            ),
                            4.0),
                      ),
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
