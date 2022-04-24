import 'package:flutter/material.dart';
import 'package:uguard_app/constants.dart';
import 'package:uguard_app/services/helper.dart';
import 'package:uguard_app/ui/contact/contact_screen.dart';
import 'package:uguard_app/ui/dependent/dependent_screen.dart';
import 'package:uguard_app/ui/home/home_screen.dart';
import 'package:uguard_app/ui/search/search_screen.dart';
import 'package:uguard_app/model/user.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State createState() => _NavbarState();
}

class _NavbarState extends State<NavbarWidget> {
  int _selectedIndex = 0;
  late User user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (_selectedIndex) {
      case 0:
        pushReplacement(context, HomeScreen(user: user));
        break;
      case 1:
        pushReplacement(context, DependentScreen(user: user));
        break;
      case 2:
        pushReplacement(context, SearchScreen(user: user));
        break;
      case 3:
        pushReplacement(context, ContactScreen(user: user));
        break;
      case 4:
        pushReplacement(context, SearchScreen(user: user));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      unselectedFontSize: 10,
      selectedFontSize: 10,
      selectedIconTheme:
          const IconThemeData(color: Color(COLOR_PRIMARY), size: 35),
      selectedItemColor: const Color(COLOR_PRIMARY),
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedIconTheme: const IconThemeData(
        color: Colors.grey,
      ),
      unselectedItemColor: Colors.grey,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings_rounded),
            label: 'Dependents'),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_outlined),
            label: 'Emergency'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined), label: 'Profile'),
      ],
    );
  }
}
