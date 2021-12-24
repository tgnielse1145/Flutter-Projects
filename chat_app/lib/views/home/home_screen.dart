import 'package:flutter/material.dart';
import 'package:chat_app/views/drawer/menu_drawer.dart';

class HomeScreen extends StatefulWidget{
  static const routeName='/home-screen';

  @override
  _HomeScreenState createState()=>_HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{
final _form = GlobalKey<FormState>();
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
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Image.asset("assets/images/unicornMain.png",
                fit:BoxFit.contain),
                ),
                Container(
                  child: Text("Fart Jones Chat_App",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'HelloKetta',
                    fontSize: 45,
                    fontStyle: FontStyle.italic,
                    

                  ),)
                )
              
            ]
          )
        ),
   // floatingActionButton: FooterDrawer(),
       // bottomNavigationBar: FooterDrawer(),
    );
  }
}