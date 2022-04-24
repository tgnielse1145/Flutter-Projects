import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uguard_app/constants.dart';
import 'package:uguard_app/model/user.dart';
import 'package:uguard_app/services/helper.dart';
import 'package:uguard_app/ui/auth/authentication_bloc.dart';
import 'package:uguard_app/ui/auth/welcome/welcome_screen.dart';
import 'package:uguard_app/ui/contact/contact_screen.dart';
import 'package:uguard_app/ui/dependent/dependent_screen.dart';
import 'package:uguard_app/ui/profile/profile_screen.dart';
import 'package:uguard_app/ui/search/search_screen.dart';
import 'package:uguard_app/ui/map/map_screen.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late User user;
  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
    user = widget.user;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (_selectedIndex) {
      case 0:
        break;
      case 1:
        push(context, DependentScreen(user: user));
        break;
      case 2:
        push(context, SearchScreen(user: user));
        break;
      case 3:
        push(context, ContactScreen(user: user));
        break;
      case 4:
        push(context, ProfileScreen(user: user));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.authState == AuthState.unauthenticated) {
          pushAndRemoveUntil(context, const WelcomeScreen(), false);
        }
      },
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            //padding: EdgeInsets.zero,
            children: <Widget>[
              AppBar(
                title: const Text('Menu'),
                automaticallyImplyLeading: false,
                backgroundColor: const Color(COLOR_PRIMARY),
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.grey),
                ),
                leading: Transform.rotate(
                    angle: pi / 1,
                    child: const Icon(Icons.logout, color: Colors.grey)),
                onTap: () {
                  context.read<AuthenticationBloc>().add(LogoutEvent());
                },
              ),
              const Divider(),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(COLOR_PRIMARY),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
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
                label: 'Respondents'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box_outlined), label: 'Profile'),
          ],
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  user.profilePictureURL == ''
                      ? CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.grey.shade400,
                          child: ClipOval(
                            child: SizedBox(
                              width: 70,
                              height: 70,
                              child: Image.asset(
                                'assets/images/placeholder.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : displayCircleImage(user.profilePictureURL, 80, false),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                    child: Text(
                      user.fullName(),
                      style: const TextStyle(
                        color: Color(COLOR_PRIMARY),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text('Get Location'),
                    
                  color: Colors.red,
                  onPressed: (){  push(context, MapScreen(user: user));
},)
                  /*,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(user.email),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(user.userID),
                  ),*/
                ],
              ),
            )),
      ),
    );
  }
}
