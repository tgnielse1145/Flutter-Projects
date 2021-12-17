import 'package:flutter/material.dart';
import 'package:chat_app/views/drawer/menu_drawer.dart';

class HomeScreen extends StatefulWidget{
  static const routeName='/home-screen';

  @override
  _HomeScreenState createState()=>_HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: const Text('Home'),
          actions: <Widget>[
            //IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () {})
          ],
        ),
        drawer: MenuDrawer(),
        body: SingleChildScrollView(
        )
    );
  }
}