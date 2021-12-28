import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/views/drawer/menu_drawer.dart';
import 'package:chat_app/models/user.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const routeName='/reset-password-screen';
  const ResetPasswordScreen({ Key? key }) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  User? user;
  final _form = GlobalKey<FormState>();
  final _auth = auth.FirebaseAuth.instance;

  resetPassword(){
     String? _id = auth.FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder<DocumentSnapshot>(
        // future:  FirebaseUtil.getCurrentUser(_id),
        future: usersReference.doc(_id).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          user = User.fromDocument(snapshot.data!);
         // _image = File(user!.profilePic!);
    _auth.sendPasswordResetEmail(email: user!.email!);
    return SingleChildScrollView(
      child:Container(
       margin: EdgeInsets.only(left: 16.0, right: 16, bottom: 16),

      )
    );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.save),
          //   onPressed: (){},
          // )
        ]
      ),
      drawer: MenuDrawer(),
      body:SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Form(
            key: _form,
            child:Column(
              children:<Widget>[
                Padding(
                  padding: const EdgeInsets.all(10)
                  ),
                  resetPassword(),
                  Container(
                    alignment: Alignment.center,
           
               child: Text('Reset password email has been sent!',
               
               style: TextStyle(
                 fontFamily: 'Lato',
                 fontSize: 30,
                 color: Colors.black,                 
               )),
               
              ),
                  
              ]
            )
          )
        )
      )
    );
  }
}