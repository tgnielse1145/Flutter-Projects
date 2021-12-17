import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/views/drawer/menu_drawer.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/user-profile-screen';
  
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
       appBar: AppBar(
          title: const Text('User Profile'),
          actions: <Widget>[
            //IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () {})
          ],
        ),

      drawer: MenuDrawer(),
    );
  }
}