import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uguard_app/controllers/auth.dart';
import 'package:uguard_app/views/contact/user_contacts_screen.dart';
import 'package:uguard_app/views/user/user_overview_screen.dart';
import 'package:uguard_app/views/notification/notification_screen.dart';
//import 'package:uguard_app/views/user/user_overview_screen.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
              // leading:Icon(Icons.person),
              leading: Image.asset(
                'assets/images/user_icon.png',
                height: 65.0,
                width: 65.0,
              ),
              title: Text('User Profile'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserOverviewScreen.routeName);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Contacts'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserContactsScreen.routeName);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                Navigator.of(context).pop(); //close the drawer
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
                //Navigator.of(context).pushReplacementNamed('/');
              }),
          Divider(),
          ListTile(
            title: Text('send notification test'),
            leading: Icon(Icons.notification_add),
            onTap: () {
              Navigator.of(context).pushNamed(NotificationScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
