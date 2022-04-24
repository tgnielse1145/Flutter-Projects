import 'dart:io' show Platform;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:uguard_app/models/configMaps.dart';

class PushNotificationController with ChangeNotifier {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  DatabaseReference usersRef =
      FirebaseDatabase.instance.reference().child("users");
      
  Future initialize(context) async
  {

    firebaseMessaging.requestPermission();
   // firebaseMessaging.subscribeToTopic('chat');
    //replaced the.configure onMessage configure method
    //FirebaseMessaging.onMessage.listen((message) {
      if(Platform.isAndroid){
     //  print("here is the onMessage " + message.toString());
      return;
      }
      else{
      //  print("here is the onMessage on ios " + message.data.toString());
      return;
      }
      
    //
    // });
     //replaced onLaunch and onResume
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
     //  print("here is the onMessageOpenedApp " + message.data.toString());

     //  return;
    //  });
    //use FirebaseMessaging.onMessageOpenedApp as a replacement for
    ///onLaunch and onResume
    ///use firebasemessaging.onMessage as replacement for onMessage
  //  firebaseMessaging.
   // FirebaseMessagingService
    // firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     retrieveRideRequestInfo(getRideRequestId(message), context);
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     retrieveRideRequestInfo(getRideRequestId(message), context);
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     retrieveRideRequestInfo(getRideRequestId(message), context);
    //   },
    // );
  }
//get the token so that you can send a notification
  Future<String?> getToken() async {
    String? token = await firebaseMessaging.getToken();
    print('here is the token '+ token!);

     Map<String, dynamic> payload = <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'conversationModel': 'hello world',
            
           
          };

          await sendNotification(token, 'hello', 'hi', payload);
    return token;
  }
  sendNotification(String token, String title, String body,
    Map<String, dynamic>? payload) async {
  await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$SERVER_KEY',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{'body': body, 'title': title},
        'priority': 'high',
        'data': payload ?? <String, dynamic>{},
        'to': token
      },
    ),
  );
}
}
