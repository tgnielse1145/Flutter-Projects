import 'dart:io';
import 'package:chat_app/views/profile/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/views/animation/animation_screen.dart';
import 'package:chat_app/views/home/home_screen.dart';
import 'package:chat_app/views/signup/signup_screen.dart';
import 'package:chat_app/views/login/login_screen.dart';

class MenuDrawer extends StatefulWidget {
  static const routeName = '/menu-drawer';
  @override
  _MenuDrawer createState() => _MenuDrawer();
}

class _MenuDrawer extends State<MenuDrawer> {
  File? _profilePic;
  bool isLoaded = false;

  
   @override
  Widget build(BuildContext context) {
 
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
              title: Text("Chat App"),             
              automaticallyImplyLeading: false,
          ),
          Divider(),
           ListTile(
            leading: isLoaded==false?  Image.asset('assets/images/user_icon.png', height: 65.0, width: 65.0):ListTile(leading: Image.file(_profilePic!,width: 65,height: 65,),),
            title:Text('User Profile'),
            onTap:(){
               Navigator.of(context).pushNamed(UserProfileScreen.routeName);
            }
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              }),
              Divider(),
           ListTile(
              leading: Icon(Icons.verified_user_outlined),
              title: Text('Sign Up'),
              onTap: () {
                Navigator.of(context).pushNamed(SignUpScreen.routeName);
              }),
                Divider(),
          ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Contacts'),
              onTap: () {
                //Navigator.of(context).pushNamed(UserContactsScreen.routeName);
              }),
                Divider(),
          ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chats'),
              onTap: () {
                //Navigator.of(context).pushNamed(UserContactsScreen.routeName);
              }),
              Divider(),
              ListTile(
              leading: Icon(Icons.animation),
              title: Text('Animation'),
              onTap: () {
                Navigator.of(context).pushNamed(AnimationScreen.routeName);
              }),
               Divider(),
          ListTile(
              leading: Icon(Icons.login),
              title: Text('Login'),
              onTap: () {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              }),
               Divider(),
          ListTile(
              leading: Icon(Icons.exit_to_app),              
              title: Text('Logout'),
              onTap: () {
                Navigator.of(context).pop(); //close the drawer
                ///the below function simply calls the home route, in other words
                ///by just passing / into pushReplacementNamed it will navigate back
                ///to the main.dart file this insures that the consumer will run
                ///run again anytime we press logout
                Navigator.of(context).pushReplacementNamed('/');
                //Provider.of<Auth>(context, listen: false).logout();
                //Navigator.of(context).pushReplacementNamed('/');
              }),
        ]));
  }
}