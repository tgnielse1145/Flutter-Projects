import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_listings/constants.dart';
import 'package:flutter_listings/main.dart';
import 'package:flutter_listings/model/User.dart';
import 'package:flutter_listings/services/FirebaseHelper.dart';
import 'package:flutter_listings/services/helper.dart';
import 'package:flutter_listings/ui/addListing/AddListingScreen.dart';
import 'package:flutter_listings/ui/categories/CategoriesScreen.dart';
import 'package:flutter_listings/ui/conversationsScreen/ConversationsScreen.dart';
import 'package:flutter_listings/ui/home/HomeScreen.dart';
import 'package:flutter_listings/ui/mapView/MapViewScreen.dart';
import 'package:flutter_listings/ui/profile/ProfileScreen.dart';
import 'package:flutter_listings/ui/search/SearchScreen.dart';
import 'package:provider/provider.dart';

enum DrawerSelection { Home, Conversations, Categories, Search, Profile }

class ContainerScreen extends StatefulWidget {
  final User user;

  ContainerScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ContainerState createState() {
    return _ContainerState();
  }
}

class _ContainerState extends State<ContainerScreen> {
  late User user;
  DrawerSelection _drawerSelection = DrawerSelection.Home;
  String _appBarTitle = 'Home'.tr();

  int _selectedTapIndex = 0;

  late Widget _currentWidget;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    _currentWidget = HomeScreen();
    FireStoreUtils.firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: user,
      child: Scaffold(
        bottomNavigationBar: Platform.isIOS
            ? BottomNavigationBar(
                currentIndex: _selectedTapIndex,
                onTap: (index) {
                  switch (index) {
                    case 0:
                      {
                        setState(() {
                          _selectedTapIndex = 0;
                          _drawerSelection = DrawerSelection.Home;
                          _appBarTitle = 'Home'.tr();
                          _currentWidget = HomeScreen();
                        });
                        break;
                      }
                    case 1:
                      {
                        setState(() {
                          _selectedTapIndex = 1;
                          _drawerSelection = DrawerSelection.Categories;
                          _appBarTitle = 'Categories'.tr();
                          _currentWidget = CategoriesScreen();
                        });
                        break;
                      }
                    case 2:
                      {
                        setState(() {
                          _selectedTapIndex = 2;
                          _drawerSelection = DrawerSelection.Conversations;
                          _appBarTitle = 'Conversations'.tr();
                          _currentWidget = ConversationsScreen(
                            user: user,
                          );
                        });
                        break;
                      }
                    case 3:
                      {
                        setState(() {
                          _selectedTapIndex = 3;
                          _drawerSelection = DrawerSelection.Search;
                          _appBarTitle = 'Search'.tr();
                          _currentWidget = SearchScreen();
                        });
                        break;
                      }
                  }
                },
                unselectedItemColor: Colors.grey,
                selectedItemColor: Color(COLOR_PRIMARY),
                items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'.tr()),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.category), label: 'Categories'.tr()),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.message), label: 'Conversations'.tr()),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.search), label: 'Search'.tr()),
                  ])
            : null,
        drawer: Platform.isIOS
            ? null
            : Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Consumer<User>(
                      builder: (context, user, _) {
                        return DrawerHeader(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              displayCircleImage(user.profilePictureURL, 75, false),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  user.fullName(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    user.email,
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Color(COLOR_PRIMARY),
                          ),
                        );
                      },
                    ),
                    ListTileTheme(
                      style: ListTileStyle.drawer,
                      selectedColor: Color(COLOR_PRIMARY),
                      child: ListTile(
                        selected: _drawerSelection == DrawerSelection.Home,
                        title: Text('Home'.tr()),
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            _drawerSelection = DrawerSelection.Home;
                            _appBarTitle = 'Home'.tr();
                            _currentWidget = HomeScreen();
                          });
                        },
                        leading: Icon(Icons.home),
                      ),
                    ),
                    ListTileTheme(
                      style: ListTileStyle.drawer,
                      selectedColor: Color(COLOR_PRIMARY),
                      child: ListTile(
                          selected: _drawerSelection == DrawerSelection.Categories,
                          leading: Icon(Icons.category),
                          title: Text('Categories'.tr()),
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              _drawerSelection = DrawerSelection.Categories;
                              _appBarTitle = 'Categories'.tr();
                              _currentWidget = CategoriesScreen();
                            });
                          }),
                    ),
                    ListTileTheme(
                      style: ListTileStyle.drawer,
                      selectedColor: Color(COLOR_PRIMARY),
                      child: ListTile(
                        selected: _drawerSelection == DrawerSelection.Conversations,
                        leading: Icon(Icons.message),
                        title: Text('Conversations'.tr()),
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            _drawerSelection = DrawerSelection.Conversations;
                            _appBarTitle = 'Conversations'.tr();
                            _currentWidget = ConversationsScreen(
                              user: user,
                            );
                          });
                        },
                      ),
                    ),
                    ListTileTheme(
                      style: ListTileStyle.drawer,
                      selectedColor: Color(COLOR_PRIMARY),
                      child: ListTile(
                          selected: _drawerSelection == DrawerSelection.Search,
                          title: Text('Search'.tr()),
                          leading: Icon(Icons.search),
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              _drawerSelection = DrawerSelection.Search;
                              _appBarTitle = 'Search'.tr();
                              _currentWidget = SearchScreen();
                            });
                          }),
                    ),
                    ListTileTheme(
                      style: ListTileStyle.drawer,
                      selectedColor: Color(COLOR_PRIMARY),
                      child: ListTile(
                          selected: _drawerSelection == DrawerSelection.Profile,
                          title: Text('Profile'.tr()),
                          leading: Icon(Icons.account_circle),
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              _drawerSelection = DrawerSelection.Profile;
                              _appBarTitle = 'Profile'.tr();
                              _currentWidget = ProfileScreen(
                                user: MyAppState.currentUser!,
                              );
                            });
                          }),
                    ),
                  ],
                ),
              ),
        appBar: AppBar(
          leading: Platform.isIOS
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfileScreen(user: user)));
                        setState(() {});
                      },
                      child: displayCircleImage(user.profilePictureURL, 2, false)),
                )
              : null,
          actions: [
            if (_currentWidget is HomeScreen)
              IconButton(
                  tooltip: 'Add Listing'.tr(),
                  icon: Icon(
                    Icons.add,
                  ),
                  onPressed: () => push(context, AddListingScreen())),
            if (_currentWidget is HomeScreen)
              IconButton(
                tooltip: 'Map'.tr(),
                icon: Icon(
                  Icons.map,
                ),
                onPressed: () => push(
                  context,
                  MapViewScreen(
                    listings: HomeScreenState.listings,
                    fromHome: true,
                  ),
                ),
              ),
          ],
          title: Text(
            _appBarTitle,
          ),
        ),
        body: _currentWidget,
      ),
    );
  }
}
