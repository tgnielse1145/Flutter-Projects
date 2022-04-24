import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:foodordering/animations/bounce.dart';
import 'package:foodordering/screens/favourite/favourite.dart';
import 'package:foodordering/screens/home_screen.dart/home_screen.dart';
import 'package:foodordering/screens/profile/profile.dart';
import 'package:foodordering/screens/restaurant/restaurant.dart';
import 'package:foodordering/utils/themes/theme.dart';

class BottomTab extends StatefulWidget {
  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int _selectedIndex = 0;

  List<Widget> pages;
  OverlayEntry overlayEntry;
  PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();

    pages = [
      HomeScreen(
        key: PageStorageKey('Page1'),
      ),
      Restaurant(
        key: PageStorageKey('Page2'),
      ),
      Favourite(
        key: PageStorageKey('Page3'),
      ),
      Profile(key: PageStorageKey("Page4"))
    ];
  }

  Widget _bottomNavigationBar(int selectedIndex) => CurvedNavigationBar(
          onTap: (int index) {
            setState(() => _selectedIndex = index);
          },
          index: selectedIndex,
          backgroundColor: Themes.transparentColor,
          color: Themes.greenColor,
          buttonBackgroundColor: Themes.greenColor,
          height: 60,
          animationDuration: Duration(
            milliseconds: 50,
          ),
          animationCurve: Curves.bounceOut,
          items: <Widget>[
            Icon(Icons.home, size: 30, color: Themes.canvasColor),
            Icon(Icons.restaurant, size: 30, color: Themes.canvasColor),
            Icon(Icons.add_shopping_cart, size: 30, color: Themes.canvasColor),
            Icon(Icons.person, size: 30, color: Themes.canvasColor),
          ]);

  // Widget _bottomNavigationBar(int selectedIndex) =>
  // BottomNavigationBar(
  //         onTap: (int index) {
  //           setState(() => _selectedIndex = index);
  //         },
  //         currentIndex: selectedIndex,
  //         items: <BottomNavigationBarItem>[
  //           BottomNavigationBarItem(
  //               icon: Icon(
  //                 Icons.home,
  //                 color: Themes.primaryColor,
  //               ),
  //               title: Text("data")),
  //           BottomNavigationBarItem(
  //               icon: Icon(
  //                 Icons.restaurant,
  //                 color: Themes.primaryColor,
  //               ),
  //               title: Text("data")),
  //           BottomNavigationBarItem(
  //               icon: Icon(
  //                 Icons.add_shopping_cart,
  //                 color: Themes.primaryColor,
  //               ),
  //               title: Text("data")),
  //           BottomNavigationBarItem(
  //               icon: Icon(
  //                 Icons.person,
  //                 color: Themes.primaryColor,
  //               ),
  //               title: Text("data"))
  //         ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}
