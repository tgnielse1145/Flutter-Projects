import 'package:flutter/material.dart';
import 'package:uguard_app/controllers/push_notification_controller.dart';
import 'package:uguard_app/controllers/push_notification_controller.dart';
import 'package:provider/provider.dart';
class NotificationScreen extends StatefulWidget{
  static const routeName= '/notification-screen';

  @override
  _NotificationScreenState createState()=>_NotificationScreenState();

}
class _NotificationScreenState extends State<NotificationScreen>{
  @override 
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text('notifications'),
        actions: <Widget>[

        ]
        
      ),
      body:SingleChildScrollView(
        child: Column(
          children:<Widget> [
            Container(),
            ElevatedButton(
              onPressed:(){ Provider.of<PushNotificationController>(context, listen:false).getToken(); 
              },
              child: Text('notification'))
          ],),)
    );

  }
}