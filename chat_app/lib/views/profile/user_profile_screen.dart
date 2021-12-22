import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/views/drawer/menu_drawer.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/provider/firebase_util.dart';
import 'package:chat_app/constants.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/user-profile-screen';
  
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  User? user;
 
  final _form = GlobalKey<FormState>();
  String? _name, _email, _phone;
    static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // DocumentSnapshot<Map<String, dynamic>> userDocument =
  //       await firestore.collection(USERS).doc(uid).get();
  //   if (userDocument.exists) {
  //     return User.fromJson(userDocument.data() ?? {});
  //   } else {
  //     return null;
  //   }
//final _auth = auth.FirebaseAuth.instance;//.currentUser;
// User? authResult=_auth.currentUser;
Future hasFinishedLoading()async{
String? _id = auth.FirebaseAuth.instance.currentUser!.uid;
print('_id = '+ _id);
 user = await FirebaseUtil.getCurrentUser(_id);
 
 if(user==null){
   print('user is null');
 }
 else{
   _name=user!.name;
   _email=user!.email;
   _phone=user!.phone;
   print('user is not null ' + user!.phone!);
   print('user.name '+ _name!);
   
 }
 
}
@override
void initState(){
 // super.initState();
  hasFinishedLoading();
  super.initState();
}
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
       appBar: AppBar(
          title: const Text('User Profile'),
          actions: <Widget>[
            //IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () {})
          ],
        ),

      drawer: MenuDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
          child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only( left: 8.0, top: 32, right: 8, bottom: 8),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      TextFormField(
                     //  decoration:  InputDecoration(labelText:  user!.name),
                      )
                    ],
                  )
                )

              ]
            )
          )
        )
      )
    );
  }
}