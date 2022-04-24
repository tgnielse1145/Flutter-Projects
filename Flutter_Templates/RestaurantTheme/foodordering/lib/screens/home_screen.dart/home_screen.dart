import 'package:flutter/material.dart';
import 'package:foodordering/animations/bounce.dart';
import 'package:foodordering/animations/fade_in.dart';
import 'package:foodordering/utils/assets/images.dart';
import 'package:foodordering/utils/constants/string_names.dart';
import 'package:foodordering/utils/screen_ratio/screen_ratio.dart';
import 'package:foodordering/utils/themes/theme.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key key,
  }) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> cards = [
    [
      Images.BITMAP,
      StringNames.RESTAURANT,
      StringNames.REGION,
      (Icons.star),
      "4.5",
      "20-30 Min",
      "(345)"
    ],
    [
      Images.BITMAP2,
      StringNames.RESTAURANT1,
      StringNames.REGION,
      (Icons.star),
      "4.5",
      "20-30 Min",
      "(355)"
    ],
    [
      Images.BITMAP1,
      StringNames.RESTAURANT2,
      StringNames.REGION,
      (Icons.star),
      "4.4",
      "25-30 Min",
      "(320)"
    ],
    [
      Images.BITMAP3,
      StringNames.RESTAURANT3,
      StringNames.REGION,
      (Icons.star),
      "4.1",
      "10-20 Min",
      "(315)"
    ],
    [
      Images.BITMAP4,
      StringNames.RESTAURANT4,
      StringNames.REGION,
      (Icons.star),
      "4.4",
      "20-30 Min",
      "(355)"
    ]
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Themes.greenColor,
              expandedHeight: 200.0,
              floating: true,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  centerTitle: true,
                  background: Image.asset(
                    Images.PROMOTION,
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: ScreenRatio.widthRatio * 12,
                  right: ScreenRatio.widthRatio * 12,
                  top: ScreenRatio.heightRatio * 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringNames.YOUR_LOCATION,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                              color: Themes.blackColor),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              StringNames.BTM_2ND_STAGE,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Themes.primaryColor),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 24,
                              color: Themes.primaryColor,
                            )
                          ],
                        )
                      ]),
                  Icon(
                    Icons.more_vert,
                    size: 20,
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: cards.length,
                    itemBuilder: (BuildContext context, int index) => FadeIn(
                        index + .0,
                        Container(
                          margin: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                      color: Colors.white,
                                    ),
                                    height: ScreenRatio.heightRatio * 80,
                                    width: ScreenRatio.widthRatio * 120,
                                    child: Bounce(
                                        Image.asset(
                                          cards[index][0],
                                          fit: BoxFit.cover,
                                        ),
                                        3.0)),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 12),
                                  height: ScreenRatio.heightRatio * 80,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        cards[index][1],
                                        style: TextStyle(
                                            // backgroundColor: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Themes.blackColor),
                                      ),
                                      Text(
                                        cards[index][2],
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            color: Themes.greyColor),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(
                                                cards[index][3],
                                                color: Themes.primaryColor,
                                              ),
                                              Text(
                                                cards[index][4],
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Themes.greyColor),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  cards[index][6],
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Themes.greyColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            cards[index][5],
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                color: Themes.blackColor),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ))))
          ],
        ),
      )),
    );
  }
}

Widget build(BuildContext context) {
  return Scaffold(
    body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("Collapsing Toolbar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Image.network(
                  "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                  fit: BoxFit.cover,
                )),
          ),
        ];
      },
      body: Center(
        child: Text("Sample Text"),
      ),
    ),
  );
}
