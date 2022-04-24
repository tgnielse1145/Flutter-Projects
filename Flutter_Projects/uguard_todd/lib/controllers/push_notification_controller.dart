// import 'dart:io' show Platform;
// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:uguard_app/models/configMaps.dart';
// import 'package:uguard_app/controllers/push_notifications_provider.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class PushNotificationController with ChangeNotifier {
//   PushNotificationsProvider? pushProvider;
//   final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//   DatabaseReference usersRef =
//       FirebaseDatabase.instance.reference().child("users");
      
 
   
//   @override
//   void initState(){
//     super.initState();
//     authProvider = context.read<AuthProvider>();
//    // homeProvider = context.read<HomeProvider>();
//    ///homeProvider= push_notificiations_provider
//    pushProvider = context.read<PushNotificationsProvider>();

//     if(authProvider.getUserFirebaseId()?.isNotEmpty==true){
//       currentUserId=authProvider.getUserFirebaseId()!;
//     }else{
//       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder :(context)=>LoginPage()), (Route<dynamic>route) => false);
//     }
//     registerNotification();
//     configureLocalNotification();
//     listScrollController.addListener(scrollListener);
//   }
//   @override
//   void dispose(){
//     super.dispose();
//     btnClearController.close();
//   }
//   void registerNotification(){
//     firebaseMessaging.requestPermission();

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if(message.notification != null){

//       }
//       return;
//      });
//      firebaseMessaging.getToken().then((token){
//        if(token!=null){
//        //  homeProvider.updateDataFirestore(FirestoreConstants.pathUserCollection, currentUserId,{'pushToken':token});
//          pushProvider.updateDataFirestore(FirestoreConstants.pathUserCollection, currentUserId, {'pushToken':token});
//        }
//      }).catchError((error){
//         Fluttertoast.showToast(msg:error.message.toString());
//      });
//   }
//   // void registerNotification(){
//   //   firebaseMessaging.requestPermission();
//   //   FirebaseMessaging.onMessage.listen((RemoteMessage message){
//   //     if(message.notification!=null){
//   //         showNotification(message.notification!);
//   //     }
//   //     return;
//   //   });
//   //   firebaseMessaging.getToken().then((token){
//   //      if(token!=null){
//   //        homeProvider.updateDataFirestore(FirestoreConstants.pathUserCollection, currentUserId,{'pushToken':token});
//   //      }
//   //    }).catchError((error){
//   //       Fluttertoast.showToast(msg:error.message.toString());
//   //    });

//   // }
//   void configureLocalNotification(){
//     AndroidInitializationSettings initializationAndroidSettings=AndroidInitializationSettings("message_icon");
//     InitializationSettings initializationSettings=InitializationSettings(
//       android: initializationAndroidSettings,

//     );
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//   void showNotification(RemoteNotification remoteNotification)async{
//     AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
//       "com.example.uguard_app",
//       "uguard app",
//       playSound: true,
//       enableVibration: true,
//       importance: Importance.max,
//       priority: Priority.max,
//     );

//     NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails );
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       remoteNotification.title,
//       remoteNotification.body,
//       notificationDetails,
//       payload :null
//     );
//   }
// //get the token so that you can send a notification
//   Future<String?> getToken() async {
//     String token = '';
// //     firebaseMessaging.getToken().then((value) {
// //       print("Here is the token " + value!);
// //       usersRef.child(currentfirebaseUser!).child("token").set(value);
// //       token = value;
// //     });
// //  //await Provider.of<UserController>(context, listen: false)
// //        // .getUserFireBaseId();
// //     //usersRef.child(currentfirebaseUser!).child(currentfirebaseUserId!).child("token").set(token);
// //     firebaseMessaging.subscribeToTopic("allcontacts");
// //     firebaseMessaging.subscribeToTopic("allusers");

//     return token;
//   }
// }
