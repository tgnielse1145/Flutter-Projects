import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:chat_app/views/drawer/menu_drawer.dart';

class LogoutScreen extends StatefulWidget {
  static const routeName='/logout-screen';
  const LogoutScreen({ Key? key }) : super(key: key);

  @override
  _LogoutScreenState createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  final _auth = auth.FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout')
      ),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10)
              ),
              ElevatedButton(
                child: Text('Logout'),
                onPressed: (){
                   Navigator.of(context).pop(); //close the drawer
            ///the below function simply calls the home route, in other words
            ///by just passing / into pushReplacementNamed it will navigate back
            ///to the main.dart file this insures that the consumer will run
            ///run again anytime we press logout
            Navigator.of(context).pushReplacementNamed('/');
           final _auth =auth.FirebaseAuth.instance;
           _auth.signOut();

                },
              )
            ]
          )
        )
      )
    );
  }
}