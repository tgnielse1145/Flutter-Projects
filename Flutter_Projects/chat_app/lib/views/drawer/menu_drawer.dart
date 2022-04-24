import 'dart:io';
import 'package:chat_app/views/profile/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:chat_app/views/animation/animation_screen.dart';
import 'package:chat_app/views/home/home_screen.dart';
import 'package:chat_app/views/signup/signup_screen.dart';
import 'package:chat_app/views/login/login_screen.dart';
import 'package:chat_app/views/logout/logout_screen.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/views/map/map_screen.dart';
import 'package:chat_app/views/password/reset_password_screen.dart';

final usersReference = FirebaseFirestore.instance.collection(USERS);

class MenuDrawer extends StatefulWidget {
  static const routeName = '/menu-drawer';
  @override
  _MenuDrawer createState() => _MenuDrawer();
}

class _MenuDrawer extends State<MenuDrawer> {
  File? _profilePic;
  bool isLoaded = false;
  User? user;
getProfilePic(){
  if(auth.FirebaseAuth.instance.currentUser!=null){
      String? _id = auth.FirebaseAuth.instance.currentUser!.uid;
      return FutureBuilder<DocumentSnapshot>(
     future: usersReference.doc(_id).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          user = User.fromDocument(snapshot.data!);
      _profilePic=File(user!.profilePic!);
      if(_profilePic!=null){
        isLoaded=true;
      }
        
      return ListTile(
        tileColor: Colors.black,
        contentPadding: EdgeInsets.fromLTRB(10.0, 0, 0.0, 0),
        leading:CircleAvatar(
          //radius:45,
          backgroundColor: Colors.transparent,
          child:ClipOval(
            child: SizedBox(
              width: 45,
              height:45,
              child: isLoaded == false
              ? Image.asset('assets/images/user_icon.png',
                  //height: 65.0, 
                  //width: 65.0,
                  color: Colors.white,
                  )
              : 
                  Image.file(
                    _profilePic!,
                  //  width: 65,
                   // height: 65,
                    fit: BoxFit.cover,
                    alignment: Alignment.centerLeft,
                    
                  )      ),
          )
        ),
          // leading: ClipOval(child: isLoaded == false
          //     ? Image.asset('assets/images/user_icon.png',
          //         height: 65.0, width: 65.0,color: Colors.white,)
          //     : 
          //         Image.file(
          //           _profilePic!,
          //           width: 65,
          //           height: 65,
          //           fit: BoxFit.contain,
                    
          //         ),
          //         //clipper: MyClip(),
          // ),
          title: Text('User Profile',
          style: TextStyle(
            fontFamily: 'ChanceryCursive',
            fontSize: 35,
            color: Colors.white
          ),),
          onTap: () {
            Navigator.of(context).pushNamed(UserProfileScreen.routeName);
          }

      );
        });
  }
  return ListTile( tileColor: Colors.black,
        contentPadding: EdgeInsets.fromLTRB(10.0, 0, 0.0, 0),
        leading:CircleAvatar(
          //radius:45,
          backgroundColor: Colors.transparent,
          child:ClipOval(
            child: SizedBox(
              width: 45,
              height:45,
              child: 
               Image.asset('assets/images/user_icon.png',
                  //height: 65.0, 
                  //width: 65.0,
                  color: Colors.white,
                  )
                 ),
          )
        ),
          // leading: ClipOval(child: isLoaded == false
          //     ? Image.asset('assets/images/user_icon.png',
          //         height: 65.0, width: 65.0,color: Colors.white,)
          //     : 
          //         Image.file(
          //           _profilePic!,
          //           width: 65,
          //           height: 65,
          //           fit: BoxFit.contain,
                    
          //         ),
          //         //clipper: MyClip(),
          // ),
          title: Text('User Profile',
          style: TextStyle(
            fontFamily: 'ChanceryCursive',
            fontSize: 35,
            color: Colors.white
          ),),
          onTap: () {
            Navigator.of(context).pushNamed(UserProfileScreen.routeName);
          }
);
}
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: <Widget>[
      AppBar(
        title: Text("Chat App",
        style: TextStyle(
          fontFamily: 'HelloKetta',
          fontSize: 55,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          
        )),
        automaticallyImplyLeading: false,
      ),
      Divider(),
      getProfilePic(),
      // ListTile(
      //   tileColor: Colors.black,
      //     leading: isLoaded == false
      //         ? Image.asset('assets/images/user_icon.png',
      //             height: 65.0, width: 65.0,color: Colors.white,)
      //         : ListTile(
      //             leading: Image.file(
      //               _profilePic!,
      //               width: 65,
      //               height: 65,
      //             ),
      //           ),
      //     title: Text('User Profile',
      //     style: TextStyle(
      //       fontFamily: 'ChanceryCursive',
      //       fontSize: 35,
      //       color: Colors.white
      //     ),),
      //     onTap: () {
      //       Navigator.of(context).pushNamed(UserProfileScreen.routeName);
      //     }),
      Divider(),
      ListTile(
          leading: Icon(Icons.home,
          color: Colors.white,),
          tileColor: Colors.black,
          title: Text('Home',
          style: TextStyle(
            fontFamily: 'ChanceryCursive',
            fontSize: 30,
            color: Colors.white
          )),
          onTap: () {
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          }),
      Divider(),
      ListTile(
          leading: Icon(Icons.app_registration_rounded,
          color: Colors.white),
          tileColor: Colors.black,
          title: Text('Sign Up',
          style: TextStyle(
             fontFamily: 'ChanceryCursive',
            fontSize: 30,
            color: Colors.white
          )),
          onTap: () {
            Navigator.of(context).pushNamed(SignUpScreen.routeName);
          }),
      // Divider(),
      // ListTile(
      //     leading: Icon(Icons.contacts),
      //     title: Text('Contacts'),
      //     onTap: () {
      //       //Navigator.of(context).pushNamed(UserContactsScreen.routeName);
      //     }),
      // Divider(),
      // ListTile(
      //     leading: Icon(Icons.chat),
      //     title: Text('Chats'),
      //     onTap: () {
      //       //Navigator.of(context).pushNamed(UserContactsScreen.routeName);
      //     }),
      Divider(),
      ListTile(
          leading: Icon(Icons.animation,
          color: Colors.white),
          tileColor: Colors.black,
          title: Text('Animation',
          style: TextStyle(
             fontFamily: 'ChanceryCursive',
            fontSize: 30,
            color: Colors.white
          )),
          onTap: () {
            Navigator.of(context).pushNamed(AnimationScreen.routeName);
          }),
          Divider(),
       // Divider(),
      ListTile(
          leading: Icon(Icons.password,
          color: Colors.white),
          tileColor: Colors.black,
          title: Text('Map Screen',
          style:TextStyle(
            fontFamily: 'ChanceryCursive',
            fontSize: 30,
            color: Colors.white
          )),
          onTap: () {
            Navigator.of(context).pushNamed(MapScreen.routeName);
          }),
      Divider(),
      ListTile(
          leading: Icon(Icons.login,
          color: Colors.white),
          tileColor: Colors.black,
          title: Text('Login',
          style: TextStyle(
             fontFamily: 'ChanceryCursive',
            fontSize: 30,
            color: Colors.white
          )),
          onTap: () {
            Navigator.of(context).pushNamed(LoginScreen.routeName);
          }),
      Divider(),
       // Divider(),
      ListTile(
          leading: Icon(Icons.password,
          color: Colors.white),
          tileColor: Colors.black,
          title: Text('Reset Password',
          style:TextStyle(
            fontFamily: 'ChanceryCursive',
            fontSize: 30,
            color: Colors.white
          )),
          onTap: () {
            Navigator.of(context).pushNamed(ResetPasswordScreen.routeName);
          }),
          Divider(),
      ListTile(
          leading: Icon(Icons.exit_to_app,
          color: Colors.white,),
          tileColor: Colors.black,
          title: Text('Logout',
          style: TextStyle(
             fontFamily: 'ChanceryCursive',
            fontSize: 30,
            color: Colors.white
          )),
          onTap: () {
             Navigator.of(context).pushNamed(LogoutScreen.routeName);

          //   Navigator.of(context).pop(); //close the drawer
          //   ///the below function simply calls the home route, in other words
          //   ///by just passing / into pushReplacementNamed it will navigate back
          //   ///to the main.dart file this insures that the consumer will run
          //   ///run again anytime we press logout
          //   Navigator.of(context).pushReplacementNamed('/');
          //  final _auth =auth.FirebaseAuth.instance;
          //  _auth.signOut();
            
            //Provider.of<Auth>(context, listen: false).logout();
            //Navigator.of(context).pushReplacementNamed('/');
          }),
    ]));
  }
}
